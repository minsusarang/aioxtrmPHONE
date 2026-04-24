unit uCDSUtil;

interface

uses Windows, SysUtils, Classes, Db, Bde, DBCommon, DBTables, DBClient,
  DBGrids, DSIntf, Dialogs,variants;

type
  PSummarizeParam = ^TSummarizeParam;
  TSummarizeParam = record
    GroupFields: String;
    SummaryFields: String;        // 필드가 지정되지 않으면 계산가능한 모든 필드...
    DisplayFields: String;
    Expressions: String;          // a=b*c
    ShowSum: Boolean;
    ShowAverage: Boolean;
    SumText: String;
    AvgText: String;
    CallBack: TNotifyEvent;
  end;

procedure cdsCopyFrom( CDS: TClientDataSet; ADataSet: TDataSet );
procedure cdsSummarize( CDS: TClientDataSet; Param: TSummarizeParam );

procedure cdsSort( CDS: TClientDataSet; Column: TColumn; Asc: Boolean = True ); overload;
procedure cdsSort( CDS: TClientDataSet; Column: TColumn; FixedFields: String; Asc: Boolean = True ); overload;

procedure cdsGroupFilter( CDS: TClientDataSet; GroupFields: String; ShowData: Boolean );
procedure cdsClearIndex( CDS: TClientDataSet );

const
  USER_GROUP_FIELD = '__FIELD_GROUP__';
  USER_DEPTH_FIELD = '__FIELD_DEPTH__';
  USER_TYPE_FIELD  = '__FIELD_TYPE__';
  USER_COUNT_FIELD = '__FIELD_COUNT__';

  TOTAL_DEPTH = 256;

implementation

uses
  Provider;

const
  USER_IDX_GROUP = '__IDX_GROUP_INDEX__';
  USER_IDX_SORT = '__IDX_SORT_INDEX__';
  USER_IDX_TEMP = 'TempIndex';

  USER_INDEX_NAMES: array[0..2] of String = ( USER_IDX_GROUP, USER_IDX_SORT , USER_IDX_TEMP );


////////////////////////////////////////////////////////////////////////////////
// Expression

function exprNode( data: Pointer; Offset: Integer ): pCANNode;
begin
  Result := PCANNode( Integer(data) + PCANExpr(data)^.iNodeStart + Offset );
end;

function exprLiteral( data: Pointer; Offset: Integer ): String;
begin
  Result := PChar( Integer(data) + PCANExpr(data)^.iLiteralStart + Offset );
end;

function exprConst( data: Pointer; Offset: Integer; lFieldType: Integer; lFieldSize: Integer ): Variant;
const
  AcceptFieldType = [fldZSTRING, fldDATE, fldBOOL, fldINT16, fldINT32, fldFLOAT, fldBCD, fldTIME, fldTIMESTAMP];
var
  Buffer: array[0..20] of Byte;
begin
  Result := NULL;

  if not lFieldType in AcceptFieldType then
    Exit;

  if lFieldType <> fldZSTRING then
    Move( Pointer(Integer(data) + PCANExpr(data)^.iLiteralStart + Offset)^
      , Buffer , lFieldSize );

  case lFieldType of
    fldZSTRING:
      Result := exprLiteral( data , Offset );
    fldINT16:
      Result := PSmallInt( @Buffer[0] )^;
    fldINT32:
      Result := PLongint( @Buffer[0] )^;
    fldFLOAT:
      Result := PDouble( @Buffer[0] )^;
    fldUINT16:
      Result := PWORD( @Buffer[0] )^;
    fldUINT32:
      Result := PLongWord( @Buffer[0] )^;
  end;
end;

function exprLValue( ds: TDataSet; data: pointer ): TField;
var
  pExpr: PCANExpr;
  pNode: pCANNode;
begin
  pExpr := PCANExpr( data );
  pNode := PCANNode( Integer(data) + pExpr^.iNodeStart );

  Result := nil;

  if (pNode^.canHdr.nodeClass <> Bde.nodeBINARY) or (pNode^.canHdr.canOp <> canASSIGN) then
    Exit;

  pNode := exprNode( data , pNode^.canBinary.iOperand2 ); 
  if ( pNode^.canHdr.nodeClass <> Bde.nodeFIELD ) then
    Exit;

  Result := ds.FieldByName( exprLiteral( data , pNode^.canField.iNameOffset ) );
end;

function exprRValue( ds: TDataSet; data: pointer ): Variant;
var
  pExpr: PCANExpr;
  pNode: pCANNode;

  function NodeValue( pNode: pCANNode ): Variant;
  var
    Field: TField;

    iOper1, iOper2: Variant;
  begin
    case pNode^.canHdr.nodeClass of
      Bde.nodeBINARY:
        begin
          iOper1 := NodeValue( exprNode( data , pNode^.canBinary.iOperand1 ) );
          iOper2 := NodeValue( exprNode( data , pNode^.canBinary.iOperand2 ) );
          case pNode^.canHdr.canOp of
            canADD:
              Result := iOper1 + iOper2;
            canSUB:
              Result := iOper1 - iOper2;
            canMUL:
              Result := iOper1 * iOper2;
            canDIV:
              if iOper2 = 0 then Result := 0 else Result := iOper1 / iOper2;
            canMOD:
              Result := iOper1 mod iOper2;
            else
              Result := NULL;
          end;
        end;
      Bde.nodeFIELD:
        begin
          Field := ds.FieldByName( exprLiteral( data , pNode^.canField.iNameOffset ) ); 
          if Assigned( Field ) then
            Result := Field.Value
          else
            Result := NULL;
        end;
      Bde.nodeCONST:
        Result := exprConst( data , pNode^.canConst.iOffset , pNode^.canConst.iType , pNode^.canConst.iSize ); 
      else
        Result := NULL;
    end;
  end;
  
begin
  pExpr := PCANExpr( data );
  pNode := PCANNode( Integer(data) + pExpr^.iNodeStart );

  Result := NULL;

  if (pNode^.canHdr.nodeClass <> Bde.nodeBINARY) or (pNode^.canHdr.canOp <> canASSIGN) then
    Exit;

  pNode := exprNode( data , pNode^.canBinary.iOperand1 ); 

  Result := NodeValue( pNode );
end;

////////////////////////////////////////////////////////////////////////////////

procedure cdsCopyFieldDefs( destCDS, srcCDS: TClientDataSet);
begin
  with destCDS.FieldDefs do
  begin
    Assign( srcCDS.FieldDefs );
  end;
end;

function cdsFindIndex( CDS: TClientDataSet; AIndexName: String ): TIndexDef;
var
  I: Integer;
begin
  Result := nil;

  CDS.IndexDefs.Update;
  for I := 0 to CDS.IndexDefs.Count-1 do
    if CDS.IndexDefs.Items[I].Name = AIndexName then
    begin
      Result := CDS.IndexDefs[I];
      Exit;
    end;
end;

procedure cdsClearIndex( CDS: TClientDataSet);
var
  I, J: Integer;
begin
  if not CDS.Active then Exit;

  with CDS do
  begin
    IndexDefs.Update;
    IndexName := '';

    for I := 0 to IndexDefs.Count-1 do
      for J := Low(USER_INDEX_NAMES) to High(USER_INDEX_NAMES) do
        if IndexDefs.Items[I].Name = USER_INDEX_NAMES[J] then
        try
          DeleteIndex( USER_INDEX_NAMES[J] );
        except
        end;
  end;
end;

procedure cdsCopyRecords( destCDS, srcCDS: TClientDataSet );
var
  Values: array of Variant;

  OldReadOnly: Boolean;
  
  I: Integer;
begin
  SetLength( Values , srcCDS.FieldCount );

  srcCDS.EnableControls();
  destCDS.DisableControls();
  OldReadOnly := destCDS.ReadOnly;
  destCDS.ReadOnly := False;
  try
    srcCDS.First;
    while not srcCDS.Eof do
    begin
      destCDS.Append;
      
      for I := 0 to destCDS.FieldCount-1 do
        destCDS.Fields[I].Value := srcCDS.FieldByName(destCDS.Fields[I].FieldName).Value;

      destCDS.Post;

      srcCDS.Next;
    end;
  finally
    destCDS.ReadOnly := OldReadOnly;

    srcCDS.EnableControls();
    destCDS.EnableControls();
  end;
end;

procedure cdsCopyFrom( CDS: TClientDataSet; ADataSet: TDataSet);
var
  FieldRef: TFieldClass;
  Field: TField;

  I: Integer;

  procedure AddIntegerField( AFieldName: String );
  begin
    if not Assigned( CDS.Fields.FindField( AFieldName ) ) then
    begin
      Field := TIntegerField.Create( CDS );

      with Field do
      begin
        FieldKind := fkInternalCalc;
        FieldName := AFieldName;
        Visible := False;

        DataSet := CDS;
      end;
    end;
  end;

begin
  cdsClearIndex( CDS );

  if CDS.Active then CDS.Close;

{
  if CDS.FieldCount > 0 then
  begin
    CDS.FieldDefs.BeginUpdate;
    try
      for I := CDS.FieldCount -1 to 0 do
      begin
        CDS.FieldDefs.Delete(I);
      end;
    finally
      CDS.FieldDefs.EndUpdate;
    end;
  end;
{}
// 정의된 필드가 하나도 없다면... source의 필드를 가지고 새로 만든다.
  if CDS.FieldCount <= 0 then
    for I := 0 to ADataSet.FieldCount-1 do
    begin
      FieldRef := TFieldClass(ADataSet.Fields[I].ClassType);
      FieldRef.NewInstance();
      Field := FieldRef.Create( CDS );
      with Field do
      begin
        FieldKind := fkData;
        FieldName := ADataSet.Fields[I].FieldName;

        DataSet := CDS;
      end;
    end;

  AddIntegerField( USER_COUNT_FIELD );
  AddIntegerField( USER_GROUP_FIELD );
  AddIntegerField( USER_TYPE_FIELD );
  AddIntegerField( USER_DEPTH_FIELD );

  CDS.Filter := '';
  CDS.Filtered := False;

  with TDataSetProvider.Create(nil) do
  begin
    try
      DataSet := ADataSet;
      CDS.Data := Data;
    finally
      Free;
    end;
  end;
end;

procedure cdsSummarize( CDS: TClientDataSet; Param: TSummarizeParam );
var
  GroupFieldList: TList;
  SummuryFieldList: TList;
  DisplayFieldList: TList;
  ExpressionList: TStringList;
  ExprData: array of array of Byte;

  PrevValues: TStringList;
  PrevDispValues: TStringList;

  GroupSum: array of array of Double;
  GroupCnt: array of Integer;
  TotalSum: array of Double;
  TotalCnt: Integer;

  RowOrder: Integer;

  I, J: Integer;
  idxG, idxS: Integer;
  DiffIdx: Integer;

  Field: TField;
  sumCDS: TClientDataSet;

  OldReadOnly: Boolean;

  procedure CreateObject();
  begin
    GroupFieldList := TList.Create;
    SummuryFieldList := TList.Create;
    DisplayFieldList := TList.Create;
    ExpressionList := TStringList.Create;

    PrevValues := TStringList.Create;
    PrevDispValues := TStringList.Create;

    sumCDS := TClientDataSet.Create( nil );
  end;

  procedure DestroyObject();
  begin
    FreeAndNil( GroupFieldList );
    FreeAndNil( SummuryFieldList );
    FreeAndNil( DisplayFieldList );
    FreeAndNil( ExpressionList );

    FreeAndNil( PrevValues );
    FreeAndNil( PrevDispValues );

    FreeAndNil( sumCDS );
  end;

  function srcField( AField: Pointer ): TField;
  begin
    Result := CDS.FieldByName(TField(AField).FieldName);
  end;

  function destField( AField: Pointer ): TField;
  begin
    Result := TField(AField);
  end;

  procedure CheckFields();
  const
    AcceptDataType = [ftSmallint, ftInteger, ftWord,
      ftFloat, ftCurrency, ftBCD, ftBytes, ftVarBytes, ftAutoInc,
      ftLargeint];
  var
    I: Integer;
  begin
    sumCDS.GetFieldList( GroupFieldList , Param.GroupFields );

    sumCDS.GetFieldList( SummuryFieldList , Param.SummaryFields );
    if SummuryFieldList.Count <= 0 then
    begin
      for I := 0 to sumCDS.FieldCount-1 do
        if sumCDS.Fields[I].DataType in AcceptDataType then
          SummuryFieldList.Add( sumCDS.Fields[I] );
    end;

    sumCDS.GetFieldList( DisplayFieldList , Param.DisplayFields );
  end;

  procedure CheckExpression();
  var
    Parser: TExprParser;

    I: Integer;
  begin
    ExpressionList.CommaText := StringReplace( Param.Expressions , ';' , ',' , [rfReplaceAll] );
    SetLength( ExprData , ExpressionList.Count );

    Parser := TExprParser.Create( CDS , '' , [] , [] , '' , nil , FieldTypeMap );
    try
      with ExpressionList do
      begin
        for I := 0 to Count-1 do
        begin
          Parser.SetExprParams( Values[Names[I]] , [] , [poExtSyntax, poDefaultExpr] , Names[I] );

          SetLength( ExprData[I] , Parser.DataSize );
          System.Move( Parser.FilterData[0] , ExprData[I][0] , Parser.DataSize );
        end;
      end;
    finally
      FreeAndNil( Parser );
    end;
  end;

  function CompareValues(): Integer;
  var
    J: Integer;
  begin
    Result := -1;

    if CDS.Eof then
    begin
      Result := 0;
      Exit;
    end;

    for J := 0 to GroupFieldList.Count-1 do
      if PrevValues.Values[destField(GroupFieldList[J]).FieldName] <> srcField(GroupFieldList[J]).AsString then
      begin
        Result := J;
        Exit;
      end;
  end;

  procedure AddFieldValue( Index: Integer; DisplayText: String );
  var
    J: Integer;
  begin
    for J := 0 to DisplayFieldList.Count-1 do
      destField(DisplayFieldList[J]).Value := PrevDispValues.Values[destField(DisplayFieldList[J]).FieldName];

    for J := 0 to Index-1 do
      destField(GroupFieldList[J]).AsString := PrevValues.Values[destField(GroupFieldList[J]).FieldName];
      
    destField(GroupFieldList[Index]).AsString := Trim( PrevValues.Values[destField(GroupFieldList[Index]).FieldName] ) + DisplayText;
  end;

  procedure AddSumValue( idxG: Integer );
  var
    idxS: Integer;
  begin
    with sumCDS do
    begin
      Inc( RowOrder );

      Append;
// Grouping 필드값 등록
      AddFieldValue( idxG , Param.SumText );
// 합계 필드값 등록
      for idxS := 0 to SummuryFieldList.Count-1 do
        destField(SummuryFieldList[idxS]).Value := GroupSum[idxG][idxS];
// 계산 필드값 등록
      for idxS := 0 to ExpressionList.Count-1 do
      begin
        Field := exprLValue( sumCDS , ExprData[idxS] );
        if Assigned( Field ) then
          Field.Value := exprRValue( sumCDS , ExprData[idxS] );
      end;
// 사용자 필드값 등록
      FieldByName( USER_COUNT_FIELD ).AsInteger := GroupCnt[idxG];
      FieldByName( USER_GROUP_FIELD ).AsInteger := RowOrder;
      FieldByName( USER_TYPE_FIELD ).AsInteger := 1;
      FieldByName( USER_DEPTH_FIELD ).AsInteger := TOTAL_DEPTH - idxG - 1;
      Post;

      if Assigned( Param.CallBack ) then
        Param.CallBack( sumCDS );
    end;
  end;

  procedure AddAverageValue( idxG: Integer );
  var
    idxS: Integer;
  begin
    with sumCDS do
    begin
      Inc( RowOrder );

      Append;
// Grouping 필드값 등록
      AddFieldValue( idxG , Param.AvgText );
// 평균 필드값 등록
      for idxS := 0 to SummuryFieldList.Count-1 do
      begin
        if GroupCnt[idxG] = 0 then destField(SummuryFieldList[idxS]).Value := 0
        else destField(SummuryFieldList[idxS]).Value := GroupSum[idxG][idxS] / GroupCnt[idxG];
      end;
// 계산 필드값 등록
      for idxS := 0 to ExpressionList.Count-1 do
      begin
        Field := exprLValue( sumCDS , ExprData[idxS] );
        if Assigned( Field ) then
          Field.Value := exprRValue( sumCDS , ExprData[idxS] );
      end;
// 사용자 필드값 등록
      FieldByName( USER_COUNT_FIELD ).AsInteger := GroupCnt[idxG];
      FieldByName( USER_GROUP_FIELD ).AsInteger := RowOrder;
      FieldByName( USER_TYPE_FIELD ).AsInteger := 2;
      FieldByName( USER_DEPTH_FIELD ).AsInteger := TOTAL_DEPTH - idxG - 1;
      Post;

      if Assigned( Param.CallBack ) then
        Param.CallBack( sumCDS );
    end;
  end;

begin
  if (not Assigned(CDS)) or (not CDS.Active) or (CDS.IsEmpty) then
    Exit;

  CreateObject();

// Grouping을 위한 index 적용
  if Assigned( cdsFindIndex( CDS , USER_IDX_GROUP ) ) then
    CDS.DeleteIndex( USER_IDX_GROUP );
    
  CDS.AddIndex( USER_IDX_GROUP , Param.GroupFields, [ixCaseInsensitive] );
  CDS.IndexName := USER_IDX_GROUP;

//
  CDS.Filter := '';
  CDS.Filtered := False;
  
  CDS.DisableControls;
  OldReadOnly := CDS.ReadOnly;
  CDS.ReadOnly := False;
  try
// 임시 데이터셋 초기화
    cdsCopyFieldDefs( sumCDS, CDS );
    sumCDS.CreateDataSet;

// 필드 리스트 분리
// sumCDS의 필드 리스트를 가진다.
    CheckFields();

    CheckExpression();

// 계산용 변수 초기화
    SetLength( GroupSum , GroupFieldList.Count );
    for I := 0 to GroupFieldList.Count-1 do
      SetLength( GroupSum[I] , SummuryFieldList.Count );
    SetLength( GroupCnt , GroupFieldList.Count );

    SetLength( TotalSum , SummuryFieldList.Count );
    TotalCnt := 0;

    RowOrder := 0;

    with CDS do
    begin
      First;

      while not EOF do
      begin
        Edit;
{
        for I := 0 to ExpressionList.Count-1 do
        begin
          Field := exprLValue( CDS , ExprData[I] );
          if Assigned( Field ) then
            Field.Value := exprRValue( CDS , ExprData[I] );
        end;
{}        
        FieldByName( USER_COUNT_FIELD ).AsInteger := 1;
        FieldByName( USER_GROUP_FIELD ).AsInteger := RowOrder;
        FieldByName( USER_TYPE_FIELD ).AsInteger := 0;
        FieldByName( USER_DEPTH_FIELD ).AsInteger := 0;
        Post;

// 합계 계산중...
        for idxG := 0 to GroupFieldList.Count-1 do
        begin
          for idxS := 0 to SummuryFieldList.Count-1 do
            GroupSum[idxG][idxS] := GroupSum[idxG][idxS] + srcField(SummuryFieldList[idxS]).AsFloat;

          Inc( GroupCnt[idxG] );
        end;

        for idxS := 0 to SummuryFieldList.Count-1 do
          TotalSum[idxS] := TotalSum[idxS] + srcField(SummuryFieldList[idxS]).AsFloat;;
        Inc( TotalCnt );

        if Assigned(Param.CallBack) then
          Param.CallBack( CDS );

        for idxG := 0 to GroupFieldList.Count-1 do
          PrevValues.Values[destField(GroupFieldList[idxG]).FieldName] := srcField(GroupFieldList[idxG]).AsString;

        for idxG := 0 to DisplayFieldList.Count-1 do
          PrevDispValues.Values[destField(DisplayFieldList[idxG]).FieldName] := srcField(DisplayFieldList[idxG]).AsString;

        Next;

// 값 변경 여부...
        DiffIdx := CompareValues();
        if DiffIdx >= 0 then
        begin
          for idxG := GroupFieldList.Count-1 downto DiffIdx do
          begin
            if Param.ShowSum then
              AddSumValue( idxG );

            if Param.ShowAverage then
              AddAverageValue( idxG );

// 계산 변수 초기화...
            for idxS := 0 to SummuryFieldList.Count-1 do
              GroupSum[idxG][idxS] := 0;

            GroupCnt[idxG] := 0;
          end;

          Inc( RowOrder );
        end;
      end;
    end;

// 총계...
    with sumCDS do
    begin
      if Param.ShowSum then
      begin
        Inc( RowOrder );

        Append;

        for J := 0 to DisplayFieldList.Count-1 do
          destField(DisplayFieldList[J]).Value := PrevDispValues.Values[destField(DisplayFieldList[J]).FieldName];

        if GroupFieldList.Count > 0 then
          destField(GroupFieldList[0]).AsString := Trim( Param.SumText )
        else
          Fields[0].AsString := Trim( Param.SumText );

        for I := 0 to SummuryFieldList.Count-1 do
        begin
//          if SummuryFieldList.Count-1 = I then Showmessage(Inttostr(ord(destField(SummuryFieldList[I]).ReadOnly)));
          try
            destField(SummuryFieldList[I]).Value := TotalSum[I];
          except
          end;
        end;

        for I := 0 to ExpressionList.Count-1 do
        begin
          Field := exprLValue( sumCDS , ExprData[I] );
          if Assigned( Field ) then
            Field.Value := exprRValue( sumCDS , ExprData[I] );
        end;

        FieldByName( USER_GROUP_FIELD ).AsInteger := RowOrder;
        FieldByName( USER_DEPTH_FIELD ).AsInteger := TOTAL_DEPTH;
        FieldByName( USER_TYPE_FIELD ).AsInteger := 1;
        FieldByName( USER_COUNT_FIELD ).AsInteger := TotalCnt;
        Post;

        if Assigned( Param.CallBack ) then
          Param.CallBack( sumCDS );
      end;

      if Param.ShowAverage then
      begin
        Inc( RowOrder );

        Append;

        for J := 0 to DisplayFieldList.Count-1 do
          destField(DisplayFieldList[J]).Value := PrevDispValues.Values[destField(DisplayFieldList[J]).FieldName];

        if GroupFieldList.Count > 0 then
          destField(GroupFieldList[0]).AsString := Trim( Param.AvgText )
        else
          Fields[0].AsString := Trim( Param.AvgText );

        for I := 0 to SummuryFieldList.Count-1 do
        begin
          if TotalCnt = 0 then destField(SummuryFieldList[I]).Value := 0
          else destField(SummuryFieldList[I]).Value := TotalSum[I] / TotalCnt;
        end;

        for I := 0 to ExpressionList.Count-1 do
        begin
          Field := exprLValue( sumCDS , ExprData[I] );
          if Assigned( Field ) then
            Field.Value := exprRValue( sumCDS , ExprData[I] );
        end;

        FieldByName( USER_GROUP_FIELD ).AsInteger := RowOrder;
        FieldByName( USER_DEPTH_FIELD ).AsInteger := TOTAL_DEPTH;
        FieldByName( USER_TYPE_FIELD ).AsInteger := 2;
        FieldByName( USER_COUNT_FIELD ).AsInteger := TotalCnt;
        Post;

        if Assigned( Param.CallBack ) then
          Param.CallBack( sumCDS );
      end;
    end;

    cdsCopyRecords( CDS , sumCDS );

    if Assigned( cdsFindIndex( CDS , USER_IDX_SORT ) ) then
      CDS.DeleteIndex( USER_IDX_SORT );

    CDS.AddIndex( USER_IDX_SORT ,  USER_GROUP_FIELD + ';' + USER_DEPTH_FIELD , [ixCaseInsensitive] );
    CDS.IndexName := USER_IDX_SORT;
  finally
    DestroyObject();

    CDS.ReadOnly := OldReadOnly;
    CDS.First;
    CDS.EnableControls;
  end;
end;

procedure cdsSort( CDS: TClientDataSet; Column: TColumn; Asc: Boolean );
begin
  cdsSort( CDS , Column , '' , Asc );
end;

procedure cdsSort( CDS: TClientDataSet; Column: TColumn; FixedFields: String; Asc: Boolean );
const
  AcceptDataType = [ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
    ftBytes, ftVarBytes, ftAutoInc, ftFixedChar, ftWideString,
    ftLargeint, ftADT, ftInterface, ftIDispatch, ftGuid];
var
  Grid: TDBGrid;
  Field: TField;

  bm: TBookmark;
begin
  if not Assigned(Column)
    or not Assigned(Column.Field)
    or not Assigned(Column.Grid)
    or not ( Column.Grid is TDBGrid )
    or not Assigned(Column.Grid.DataSource)
    or not Assigned(Column.Grid.DataSource.DataSet)
    or not ( Column.Grid.DataSource.DataSet is TClientDataSet )  then
    Exit;

  CDS := Column.Grid.DataSource.DataSet as TClientDataSet;
  Grid := Column.Grid as TDBGrid;
  Field := Column.Field;

  if not CDS.Active then
    Exit;

  if Grid.FieldCount <= 0 then
    Exit;

  if ( Field.FieldKind <> fkData ) or ( not (Field.DataType in AcceptDataType) ) then
    Exit;

  bm := CDS.GetBookmark();
  CDS.DisableControls;
  try
    with CDS, Field do
    begin
      Grid.SelectedRows.Clear;

      if Assigned( cdsFindIndex( CDS , USER_IDX_SORT ) ) then
        DeleteIndex( USER_IDX_SORT );

      if Assigned( cdsFindIndex( CDS , USER_IDX_GROUP ) ) then
      begin
{      
        if Asc then
          AddIndex( USER_IDX_SORT , USER_GROUP_FIELD + ';' + USER_DEPTH_FIELD + ';' + FieldName, [ixCaseInsensitive] )
        else
          AddIndex( USER_IDX_SORT , USER_GROUP_FIELD + ';' + USER_DEPTH_FIELD + ';' + FieldName, [ixCaseInsensitive], FieldName );
{}          
        if Asc then
          AddIndex( USER_IDX_SORT , USER_GROUP_FIELD + ';' + FieldName, [ixCaseInsensitive] )
        else
          AddIndex( USER_IDX_SORT , USER_GROUP_FIELD + ';' + FieldName, [ixCaseInsensitive], FieldName );
{}          
      end
      else
      begin
        if Trim(FixedFields) <> '' then
        begin
          if Asc then
            AddIndex( USER_IDX_SORT , FixedFields + ';' + FieldName, [ixCaseInsensitive] )
          else
            AddIndex( USER_IDX_SORT , FixedFields + ';' + FieldName, [ixCaseInsensitive], FieldName );
        end
        else
        begin
          if Asc then
            AddIndex( USER_IDX_SORT , FieldName, [ixCaseInsensitive] )
          else
            AddIndex( USER_IDX_SORT , FieldName, [ixDescending, ixCaseInsensitive] );
        end;
      end;

      IndexName := USER_IDX_SORT;

      First;
    end;
  finally
//    CDS.GotoBookmark( bm );
    CDS.FreeBookmark( bm );
    CDS.EnableControls;
  end;
end;

procedure cdsGroupFilter( CDS: TClientDataSet; GroupFields: String; ShowData: Boolean );
var
  DefGroupFieldList: TStringList;
  GroupFieldList: TStringList;

  Filter: String;

  I: Integer;
  Depth: Integer;
begin
  if not Assigned( CDS ) or not CDS.Active then
    Exit;

  if not Assigned( cdsFindIndex( CDS , USER_IDX_GROUP ) ) then
    Exit;

  if ShowData and ( CompareText( cdsFindIndex( CDS , USER_IDX_GROUP ).Fields , GroupFields ) = 0 ) then
  begin
    CDS.Filter := '';
    CDS.Filtered := False;
    Exit;
  end;

  DefGroupFieldList := TStringList.Create;
  GroupFieldList := TStringList.Create;
  try
    DefGroupFieldList.CommaText := StringReplace( cdsFindIndex( CDS , USER_IDX_GROUP ).Fields , ';' , ',' , [rfReplaceAll] );
    GroupFieldList.CommaText := StringReplace( GroupFields , ';' , ',' , [rfReplaceAll] );

    if not ShowData and ( CompareText( cdsFindIndex( CDS , USER_IDX_GROUP ).Fields , GroupFields ) = 0 ) then
    begin
      CDS.Filter := USER_DEPTH_FIELD + '<>0';
      CDS.Filtered := True;
      Exit;
    end;

    Filter := '';

    if ShowData then
      Filter := USER_DEPTH_FIELD + '=0';

    for I := 0 to GroupFieldList.Count-1 do
    begin
      Depth := DefGroupFieldList.IndexOf( GroupFieldList[I] );
      if Depth >= 0 then
      begin
        if Filter <> '' then
          Filter := Filter + ' or ';
        Filter := Filter + USER_DEPTH_FIELD + '=' + IntToStr(TOTAL_DEPTH-Depth-1);
      end;
    end;

    if Filter <> '' then
      Filter := Filter + ' or ';
    Filter := Filter + USER_DEPTH_FIELD + '=' + IntToStr(TOTAL_DEPTH);

    CDS.Filter := Filter;
    CDS.Filtered := True;
  finally
    FreeAndNil( DefGroupFieldList );
    FreeAndNil( GroupFieldList );
  end;
end;

initialization

finalization

end.
