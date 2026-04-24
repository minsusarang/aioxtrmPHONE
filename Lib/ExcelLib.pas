unit ExcelLib;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, DBGrids, FileCtrl, ComObj, ComCtrls, TlHelp32, OleServer
  , Variants, ExcelXp; //, Excel97;

type
  TCompareKind = (ckAllData, ckSubData);

  //Horizontal Cell Alignment
  THCellAlignment = (hcaDefault, hcaGeneral, hcaLeft, hcaCenter, hcaRight, hcaFill,
                     hcaJustify, hcaCenterAcrossSelection, hcaDistributed);
  //Vertical Cell Alignment
  TVCellAlignment = (vcaDefault, vcaTop, vcaCenter, vcaBottom, vcaJustify, vcaDistributed);

  TTitleColumnType = (tctNone, tctTop, tctMiddle, tctBottom, tctTopBottom);

  TKeyField = record
    RName : String;
    RCompareKind : TCompareKind;
    RFromIndex : Integer;
    RToIndex : Integer;
  end;

  TExcelColumn = class(TCollectionItem)
  private
    FAlignment: TAlignment;
    FColumnTitle: String;
    FFieldIndex: String;
    FColumnType: String;
    FFontName: String;
    FFontSize: Integer;
    FColor: TColor;
    FWidth: Integer;
    procedure SetAlignment(Value: TAlignment); virtual;
    procedure SetColumnTitle(const Value: String);
    procedure SetFieldIndex(const Value: String);
    procedure SetColumnType(const Value: String);
    procedure SetFontName(const Value: String);
    procedure SetFontSize(Value: Integer); virtual;
    procedure SetColor(Value: TColor);
    procedure SetWidth(Value: Integer); virtual;
  public
    constructor Create(Collection: TCollection);
    destructor Destroy; override;
  published
    property  Alignment: TAlignment read FAlignment write SetAlignment;
    property  ColumnTitle: String read FColumnTitle write SetColumnTitle;
    property  FieldIndex: String read FFieldIndex write SetFieldIndex;
    property  ColumnType: String read FColumnType write SetColumnType;
    property  FontName: String read FFontName write SetFontName;
    property  FontSize: Integer read FFontSize write SetFontSize;
    property  Color: TColor read FColor write SetColor;
    property  Width: Integer read FWidth write SetWidth;
  end;

  TExcelColumnClass = class of TExcelColumn;

  TExcelColumns = class(TCollection)
  private
    function GetColumn(Index: Integer): TExcelColumn;
    function InternalAdd: TExcelColumn;
    procedure SetColumn(Index: Integer; Value: TExcelColumn);
  public
    constructor Create(ExcelColumnClass: TExcelColumnClass);
    function  Add: TExcelColumn;
    property Items[Index: Integer]: TExcelColumn read GetColumn write SetColumn; default;
  end;

  TExcelData = class
  private
    FCellPos : TStringList;
    FCellVal : TStringList;

    FColumns: TExcelColumns;

    FMasterKey : TKeyField;
    FDetailKey : TKeyField;

    FAppRootPath : String;
    FExcelSrcPath : String;
    FExcelDesPath : String;
    FExcelSrcFName : String;
    FExcelDesFName : String;
    FSheetName: String;

    FHeaderString: String;
    FTitleString: String;
    FFooterString: String;
    FFirstRow : Integer;
    FDotZeroCount: Integer;
    FIsWriteTitle: Boolean;
    FIsDBGridToTitle: Boolean;
    FIsDBGridToInitData: Boolean;
    FIsTotalFooter: Boolean;
    FIsShowOpenQuest: Boolean;
    FIsDualLineControl: Boolean;
    FIsTitleFreeze: Boolean;

    function GetCellPos(Index: Integer): String;
    procedure SetCellPos(Index: Integer; const Value: String);
    function GetCellVal(Index: Integer): String;
    procedure SetCellVal(Index: Integer; const Value: String);
    function GetCount: Integer;
    procedure SetColumns(Value: TExcelColumns);
    procedure MakeHeaderString;
    procedure MakeFooterString;
    procedure SetDotZeroCount(Value: Integer);

    destructor Destroy;
  protected
    function  CreateColumns: TExcelColumns; dynamic;
  public
    constructor Create; overload;
    constructor Create(ACellPos, ACellVal : TStringList); overload;

    procedure Clear;

    procedure Add(ACellPos, ACellVal : String);  overload;
    procedure AddColumn(AFieldIndex: Integer; AColumnType: String); overload;
    procedure AddColumn(AFieldIndex: String; AColumnType: String); overload;

    procedure SetFileName(sRootPath, sSrcFileName, sDesFileName: String; iFlag:Integer=0);
    procedure MakeLineString(ATitle, ATitleProperty: String; AWidth, AColspan, ARowSpan: Integer; ATCType: TTitleColumnType; Rownum: Integer=0);
    function GetHtml: String;

    property CPItems[Index: Integer]: String read GetCellPos write SetCellPos;
    property CVItems[Index: Integer]: String read GetCellVal write SetCellVal;
    property Count: Integer read GetCount;

    property M_FName         : String       read FMasterKey.RName        write FMasterKey.RName;
    property M_CompareKind   : TCompareKind read FMasterKey.RCompareKind write FMasterKey.RCompareKind;
    property M_FromIndex     : Integer      read FMasterKey.RFromIndex   write FMasterKey.RFromIndex;
    property M_ToIndex       : Integer      read FMasterKey.RToIndex     write FMasterKey.RToIndex;

    property D_FName         : String       read FDetailKey.RName        write FDetailKey.RName;
    property D_CompareKind   : TCompareKind read FDetailKey.RCompareKind write FDetailKey.RCompareKind;
    property D_FromIndex     : Integer      read FDetailKey.RFromIndex   write FDetailKey.RFromIndex;
    property D_ToIndex       : Integer      read FDetailKey.RToIndex     write FDetailKey.RToIndex;

    property Columns: TExcelColumns read FColumns write SetColumns;
    property SheetName       : String       read FSheetName              write FSheetName;
    property FirstRow        : Integer      read FFirstRow               write FFirstRow;
    property TitleString     : String       read FTitleString            write FTitleString;
    property DotZeroCount    : Integer      read FDotZeroCount           write SetDotZeroCount;
    property IsWriteTitle    : Boolean      read FIsWriteTitle           write FIsWriteTitle;
    property IsDBGridToTitle : Boolean      read FIsDBGridToTitle        write FIsDBGridToTitle;
    property IsDBGridToInitData : Boolean   read FIsDBGridToInitData     write FIsDBGridToInitData;
    property IsTotalFooter   : Boolean      read FIsTotalFooter          write FIsTotalFooter;
    property IsShowOpenQuest : Boolean      read FIsShowOpenQuest        write FIsShowOpenQuest;
    property IsDualLineControl : Boolean    read FIsDualLineControl      write FIsDualLineControl;
    property IsTitleFreeze   : Boolean      read FIsTitleFreeze          write FIsTitleFreeze;
  end;

function IsRun(sFindFile : string): Boolean;

//틀고정
function prFreezePanes(vExcel: Variant; iRow: Integer; bFreeze: Boolean = True): Boolean;
//라인 삭제
function prEntireRowDel(vExcel: Variant; iFromRow, iToRow: Integer): Boolean;
//셀 병합
function prCellMerge(vExcel: Variant; sFromCell, sToCell: String; hcaAlign: THCellAlignment; vcaAlign: TVCellAlignment;
                     bWrapText, bAddIndent, bShrinkToFit: Boolean; iOrientation: Integer = 0): Boolean;
function GetChar(cFromCell: Char; iFieldCnt:Integer; FirstFlag: Boolean):String;
//데이터 삽입
function prDataInsert(vExcel: Variant; vData: Variant; cFromCell: Char; iFieldCnt, iInsertRow: Integer; ColorIdx: Longint=-1): Boolean;
//GRID->엑셀에 저장(기존 생성폼에 그대로 추가한다.)
function prExcel_WriteForm(DBGrid: TDBGrid; ExcelData: TExcelData; SheetNum : Integer=0;IsQuestion : Boolean = TRUE): Boolean;

//Master & Detail Grid->Excel
function prExcel_WriteMDForm(MasterDBGrid, DetailDBGrid: TDBGrid; ExcelData: TExcelData): Boolean;
//
function DBGridToExcelText(DBGrid: TDBGrid; ExcelData: TExcelData): Boolean;
function DBGridToExcelFile(CDS: TDataSet; ExcelData: TExcelData): Boolean;

function ExcelToText_FileChange(FFileName: String; FFormat: String = 'dat'): String;

implementation
  uses DebugLib;


var
  FLogFileName: String;

function LogStart(AFileName: String): Boolean;
var
  fp: Integer;
begin
  Result := False;

  FLogFileName := AFileName;

  fp := FileCreate(FLogFileName);
  if fp < 0 then Exit;

  FileClose(fp);
  Result := True;
end;

function Log(Msg: String): Boolean;
var
  F : TextFile;
begin
  Result := False;

  try
    AssignFile(F, FLogFileName);
    Append(F);
    Writeln(F, Msg);
    CloseFile(F);
  except
    ;
  end;

  result := True;
end;

function ReplaceStr(var SrcStr: String; SubStr,ToStr:String) : string;
var i: Integer;
    Re : string;
begin
  Re := '';
  while true do
  begin
    i:= Pos(SubStr,SrcStr);
    if i = 0 then break;
    Delete(SrcStr,i,Length(SubStr));
    Insert(ToStr,SrcStr,i);
  end;
  Re := Re + SrcStr;
  Result := re;
end;

{ TColumn }

constructor TExcelColumn.Create(Collection: TCollection);
begin
  try
    inherited Create(Collection);
    FFontName := '돋움';
    FFontSize := 9;
    FAlignment := taLeftJustify;
    FColor := clWhite;
    FWidth := 60;
  finally
  end;
end;

destructor TExcelColumn.Destroy;
begin
  inherited Destroy;
end;

procedure TExcelColumn.SetAlignment(Value: TAlignment);
begin
  FAlignment := Value;
end;

procedure TExcelColumn.SetColumnTitle(const Value: String);
begin
  FColumnTitle := Value;
end;

procedure TExcelColumn.SetFieldIndex(const Value: String);
begin
  FFieldIndex := Value;
end;

procedure TExcelColumn.SetColumnType(const Value: String);
begin
  FColumnType := Value;
end;

procedure TExcelColumn.SetFontName(const Value: String);
begin
  FFontName:= Value;
end;

procedure TExcelColumn.SetFontSize(Value: Integer);
begin
  FFontSize := Value;
end;

procedure TExcelColumn.SetColor(Value: TColor);
begin
  if (Value = FColor) then Exit;
  FColor := Value;
end;

procedure TExcelColumn.SetWidth(Value: Integer);
begin
  FWidth := Value;
end;

{TExcelColumns}
function TExcelColumns.GetColumn(Index: Integer): TExcelColumn;
begin
  Result := TExcelColumn(inherited Items[Index]);
end;

function TExcelColumns.InternalAdd: TExcelColumn;
begin
  Result := Add;
end;

procedure TExcelColumns.SetColumn(Index: Integer; Value: TExcelColumn);
begin
  Items[Index].Assign(Value);
end;

constructor TExcelColumns.Create(ExcelColumnClass: TExcelColumnClass);
begin
  inherited Create(ExcelColumnClass);
end;

function TExcelColumns.Add: TExcelColumn;
begin
  Result := TExcelColumn(inherited Add);
end;

//=====================================================================================================
procedure TExcelData.Add(ACellPos, ACellVal: String);
begin
  FCellPos.Add(ACellPos);
  FCellVal.Add(ACellVal);
end;

procedure TExcelData.Clear;
begin
  FCellPos.Clear;
  FCellVal.Clear;
end;

procedure TExcelData.AddColumn(AFieldIndex: Integer; AColumnType: String);
var
  TempColumn: TExcelColumn;
begin
  TempColumn := Columns.Add;
  with TempColumn do
  begin
    FieldIndex := IntToStr(AFieldIndex);
    ColumnType := AColumnType;
  end;
end;

procedure TExcelData.AddColumn(AFieldIndex: String; AColumnType: String);
var
  TempColumn: TExcelColumn;
begin
  TempColumn := Columns.Add;
  with TempColumn do
  begin
    FieldIndex := AFieldIndex;
    ColumnType := AColumnType;
  end;
end;

constructor TExcelData.Create;
begin
  FColumns := CreateColumns;
  FCellPos := TStringList.Create;
  FCellVal := TStringList.Create;
  FDotZeroCount := 0;
  FTitleString := '';
  FIsShowOpenQuest := True;
end;

constructor TExcelData.Create(ACellPos, ACellVal: TStringList);
begin
  FCellPos.Assign(ACellPos);
  FCellVal.Assign(ACellVal);
end;

destructor TExcelData.Destroy;
begin
  FColumns.Free;
  FColumns := nil;
  if Assigned(FCellPos) then FCellPos.Free;
  if Assigned(FCellVal) then FCellVal.Free;
end;

function TExcelData.CreateColumns: TExcelColumns;
begin
  Result := TExcelColumns.Create(TExcelColumn);
end;

function TExcelData.GetCellPos(Index: Integer): String;
begin
  Result := FCellPos[Index];
end;

function TExcelData.GetCellVal(Index: Integer): String;
begin
  Result := FCellVal[Index];
end;

function TExcelData.GetCount: Integer;
begin
  Result := FCellPos.Count;
end;

procedure TExcelData.SetColumns(Value: TExcelColumns);
begin
  Columns.Assign(Value);
end;

procedure TExcelData.MakeHeaderString;
  function SetLineValue: String;
  begin
    Result := '';
    Result := Result + '	border-top:0.5pt solid windowtext;'                                  +#13#10;
    Result := Result + '	border-right:0.5pt solid windowtext;'                                +#13#10;
    Result := Result + '	border-bottom:0.5pt solid windowtext;'                               +#13#10;
    Result := Result + '	border-left:0.5pt solid windowtext;'                                 +#13#10;
  end;
  function SetDefaultValue: String;
  begin
    Result := SetLineValue;
    Result := Result + '	background:white;'                                                   +#13#10;
    Result := Result + '	mso-pattern:auto none;}'                                             +#13#10;
  end;
begin
  FHeaderString := '';
  FHeaderString := FHeaderString + '<html xmlns:x="urn:schemas-microsoft-com:office:excel">'               +#13#10;
  FHeaderString := FHeaderString + '<HEAD>'                                                                +#13#10;
  FHeaderString := FHeaderString + '<meta http-equiv="Content-Language" content="ko">'                     +#13#10;
  FHeaderString := FHeaderString + '<META http-equiv="Content-Type" content="text/html; charset=euc-kr">'  +#13#10;
  FHeaderString := FHeaderString + '<style>'                                                               +#13#10;
  FHeaderString := FHeaderString + '<!--table'                                                             +#13#10;
  FHeaderString := FHeaderString + '	{mso-displayed-decimal-separator:"\.";'                              +#13#10;
  FHeaderString := FHeaderString + '	mso-displayed-thousand-separator:"\,";}'                             +#13#10;
  FHeaderString := FHeaderString + '@page'                                                                 +#13#10;
  FHeaderString := FHeaderString + '  {margin:.2in .2in .2in .2in;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-header-margin:.2in;'                                             +#13#10;
  FHeaderString := FHeaderString + '	mso-footer-margin:.2in;}'                                            +#13#10;
  FHeaderString := FHeaderString + 'tr'                                                                    +#13#10;
  FHeaderString := FHeaderString + '	{mso-height-source:none;'                                            +#13#10;
  FHeaderString := FHeaderString + '  height:14.25pt;'                                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-ruby-visibility:none;}'                                          +#13#10;
  FHeaderString := FHeaderString + 'col'                                                                   +#13#10;
  FHeaderString := FHeaderString + '	{mso-width-source:none;'                                             +#13#10;
  FHeaderString := FHeaderString + '	mso-ruby-visibility:none;}'                                          +#13#10;
  FHeaderString := FHeaderString + 'br'                                                                    +#13#10;
  FHeaderString := FHeaderString + '	{mso-data-placement:same-cell;}'                                     +#13#10;
  FHeaderString := FHeaderString + 'td'                                                                    +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style0;'                                           +#13#10;
  FHeaderString := FHeaderString + '	padding-top:1px;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	padding-right:1px;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	padding-left:1px;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	mso-ignore:padding;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	color:windowtext;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	font-size:9.0pt;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	font-weight:400;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	font-style:normal;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	text-decoration:none;'                                               +#13#10;
  FHeaderString := FHeaderString + '	font-family:돋움체, monospace;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-font-charset:129;'                                               +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:General;'                                          +#13#10;
  FHeaderString := FHeaderString + '	text-align:general;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	vertical-align:;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	border:none;'                                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-background-source:auto;'                                         +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	mso-protection:locked visible;'                                      +#13#10;
  FHeaderString := FHeaderString + '	white-space:nowrap;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-rotate:0;}'                                                      +#13#10;
  FHeaderString := FHeaderString + 'ruby'                                                                  +#13#10;
  FHeaderString := FHeaderString + '	{ruby-align:left;}'                                                  +#13#10;
  FHeaderString := FHeaderString + 'rt'                                                                    +#13#10;
  FHeaderString := FHeaderString + '	{color:windowtext;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	font-size:8.0pt;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	font-weight:400;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	font-style:normal;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	text-decoration:none;'                                               +#13#10;
  FHeaderString := FHeaderString + '	font-family:돋움체, monospace;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-font-charset:129;'                                               +#13#10;
  FHeaderString := FHeaderString + '	mso-char-type:none;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	display:none;}'                                                      +#13#10;
  FHeaderString := FHeaderString + '.style_normal'                                                         +#13#10;
  FHeaderString := FHeaderString + '	{mso-number-format:General;'                                         +#13#10;
  FHeaderString := FHeaderString + '	text-align:general;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	vertical-align:middle;'                                              +#13#10;
  FHeaderString := FHeaderString + '	white-space:nowrap;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-rotate:0;'                                                       +#13#10;
  FHeaderString := FHeaderString + '	mso-background-source:auto;'                                         +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	color:windowtext;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	font-size:10.0pt;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	font-weight:400;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	font-style:normal;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	text-decoration:none;'                                               +#13#10;
  FHeaderString := FHeaderString + '	font-family:돋움체, monospace;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-font-charset:129;'                                               +#13#10;
  FHeaderString := FHeaderString + '	border:none;'                                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-protection:locked visible;'                                      +#13#10;
  FHeaderString := FHeaderString + '	mso-style-name:표준;'                                                +#13#10;
  FHeaderString := FHeaderString + '	mso-style-id:0;}'                                                    +#13#10;
  FHeaderString := FHeaderString + '.xl_caption'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:left;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	font-size:12.0pt;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	Height:20.0pt;'                                                      +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_caption_center'                                                    +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	font-size:12.0pt;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	Height:20.0pt;'                                                      +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_caption_center2'                                                   +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	font-size:14.0pt;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	font-style:bold;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	Height:55.0pt;'                                                      +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_title'                                                             +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	font-size:10.0pt;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	Height:17.25pt;'                                                     +#13#10;
  FHeaderString := FHeaderString + SetLineValue;
  FHeaderString := FHeaderString + '	background:#FFFF99;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	white-space:normal;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto none;}'                                             +#13#10;
  FHeaderString := FHeaderString + '.xl_title_height'                                                      +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	font-size:10.0pt;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	Height:24.0pt;'                                                     +#13#10;
  FHeaderString := FHeaderString + SetLineValue;
  FHeaderString := FHeaderString + '	background:#FFFF99;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	white-space:normal;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto none;}'                                             +#13#10;
  FHeaderString := FHeaderString + '.xl_normal'                                                            +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_normal_dec'                                                        +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:\@;'                                               +#13#10;
  FHeaderString := FHeaderString + '	text-align:left;'                                                    +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_normal_dec_center'                                                 +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:\@;'                                               +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	white-space:normal;'                                                 +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_normal_center'                                                     +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	white-space:normal;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto none;'                                              +#13#10;
  FHeaderString := FHeaderString + '	Height:18.0pt;'                                                     +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_normal_center_height'                                              +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + '	Height:72.0pt;'                                                     +#13#10;
  FHeaderString := FHeaderString + '	white-space:normal;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto none;'                                              +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_normal_left'                                                       +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	text-align:left;'                                                    +#13#10;
  FHeaderString := FHeaderString + '	white-space:normal;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	Height:18.0pt;'                                                     +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_normal_right'                                                      +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + '	white-space:normal;'                                                 +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_decimal'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_decimal0'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_decimal1'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0.0_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_decimal2'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0.00_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_decimal3'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0.000_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_decimal4'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0.0000_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_decimal5'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0.00000_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_ssn'                                                               +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"000000\\-0000000";'                               +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_summary'                                                           +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
//  FHeaderString := FHeaderString + '	text-align:left;'                                                    +#13#10;
  FHeaderString := FHeaderString + SetLineValue;
  FHeaderString := FHeaderString + '	background:#FFCC99;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto none;}'                                             +#13#10;
  FHeaderString := FHeaderString + '.xl_summary_dec'                                                       +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:xl_normal;'                                        +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\#\,\#\#0_ ";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:right;'                                                   +#13#10;
  FHeaderString := FHeaderString + SetLineValue;
  FHeaderString := FHeaderString + '	background:#FFCC99;'                                                 +#13#10;
  FHeaderString := FHeaderString + '	mso-pattern:auto none;}'                                             +#13#10;
  FHeaderString := FHeaderString + '.xl_percent0'                                                          +#13#10;
  FHeaderString := FHeaderString + '  {mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:0%;'                                               +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_percent1'                                                          +#13#10;
  FHeaderString := FHeaderString + '  {mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:0.0%;'                                             +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_percent2'                                                          +#13#10;
  FHeaderString := FHeaderString + '  {mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:0.00%;'                                            +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_percent3'                                                          +#13#10;
  FHeaderString := FHeaderString + '  {mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:0.000%;'                                            +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_percent4'                                                          +#13#10;
  FHeaderString := FHeaderString + '  {mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:0.0000%;'                                            +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_mmdd'                                                         +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"mm\\\-dd";'                                       +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_yyyymmdd'                                                     +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"yyyy\\\-mm\\\-dd";'                               +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_yyyymmdd'                                                          +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"0000\\-00\\-00";'                                 +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_hnnss'                                                        +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\[h\]:mm:ss";'                                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_hhnnss'                                                       +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"hh:mm:ss";'                                       +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_hhnnss'                                                            +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"hh\\:mm\\:ss";'                                   +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_yyyymmddhhnnss'                                               +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"yyyy\\\-mm\\\-dd hh:mm:ss";'                      +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_ddmmyy'                                                       +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"dd\\\-mmm\\\-yy";'                                +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_mmdd_ed'                                                       +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\[ENG\]mm\\\-dd ddd";'                            +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_yyyymmdd_ed'                                                   +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\[ENG\]yyyy\\\-mm\\\-dd ddd";'                    +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + '.xl_date_ddmmyy_ed'                                                     +#13#10;
  FHeaderString := FHeaderString + '	{mso-style-parent:style_normal;'                                     +#13#10;
  FHeaderString := FHeaderString + '	mso-number-format:"\[ENG\]dd\\\-mmm\\\-yy ddd";'                     +#13#10;
  FHeaderString := FHeaderString + '	text-align:center;'                                                  +#13#10;
  FHeaderString := FHeaderString + SetDefaultValue;
  FHeaderString := FHeaderString + ''                                                                      +#13#10;
  FHeaderString := FHeaderString + '-->'                                                                   +#13#10;
  FHeaderString := FHeaderString + '</style>'                                                              +#13#10;
  FHeaderString := FHeaderString + '</HEAD>'                                                               +#13#10;
  FHeaderString := FHeaderString + '<body>'                                                                +#13#10;
  FHeaderString := FHeaderString + '<table>'                                                               +#13#10;
end;

procedure TExcelData.MakeFooterString;
begin
  FFooterString := '';
  FFooterString := FFooterString + '</table>' +#13#10;
  FFooterString := FFooterString + '</body>'  +#13#10;
  FFooterString := FFooterString + '</html>'  +#13#10;
end;

procedure TExcelData.SetDotZeroCount(Value: Integer);
begin
  if Value > 5 then Value := 5;
  FDotZeroCount := Value;
end;

procedure TExcelData.SetCellPos(Index: Integer; const Value: String);
begin
  FCellPos[Index] := Value;
end;

procedure TExcelData.SetCellVal(Index: Integer; const Value: String);
begin
  FCellVal[Index] := Value;
end;

procedure TExcelData.SetFileName(sRootPath, sSrcFileName, sDesFileName: String; iFlag:Integer=0);
begin
  FAppRootPath   := sRootPath;
  case iFlag of
  0:begin
      FExcelSrcPath  := sRootPath + 'Resource\';
      FExcelDesPath  := sRootPath + 'Data\';
    end;
  1:begin
      FExcelSrcPath  := sRootPath;
      FExcelDesPath  := sRootPath;
    end;
  end;
  FExcelSrcFName := sSrcFileName;
  FExcelDesFName := sDesFileName;

  if not DirectoryExists(FAppRootPath) then CreateDir(FAppRootPath);
  if not DirectoryExists(FExcelSrcPath) then CreateDir(FExcelSrcPath);
  if not DirectoryExists(FExcelDesPath) then CreateDir(FExcelDesPath);
end;

procedure TExcelData.MakeLineString(ATitle, ATitleProperty: String; AWidth, AColspan, ARowSpan: Integer; ATCType: TTitleColumnType; Rownum: Integer=0);
var
  Str: String;
  StrWidth, StrCol, StrRow: String;
begin
  case ATCType of
  tctNone, tctTop, tctTopBottom : Str := '<tr>'+#13#10;
  tctMiddle, tctBottom: Str := '';
  end;
  if not (ATCType in [tctNone]) then
  begin
    if (AWidth > 0) then StrWidth := ' width="'+IntToStr(AWidth)+'"'
    else StrWidth := '';
    if (AColspan > 0) then StrCol := ' colspan="'+IntToStr(AColspan)+'"'
    else StrCol := '';
    if (ARowSpan > 0) then StrRow := ' rowspan="'+IntToStr(ARowSpan)+'"'
    else StrRow := '';

    if Rownum > 0 then
    begin
      ATitle := ReplaceStr(ATitle, '[ROW]',IntToStr(Rownum));
    end;
    if Copy(ATitle,1,1) = '=' then
      Str := Str + '<td '+StrWidth+StrCol+StrRow+' class='+ATitleProperty+' x:fmla="'+ATitle+'"></td>'+#13#10
    else
      Str := Str + '<td '+StrWidth+StrCol+StrRow+' class='+ATitleProperty+'>'+ATitle+'</td>'+#13#10;
  end;
  case ATCType of
  tctTop, tctMiddle: ;
  tctNone, tctBottom, tctTopBottom : Str := Str + '</tr>'+#13#10;
  end;
  TitleString := TitleString + Str;
end;

function TExcelData.GetHtml: String;
begin
  MakeHeaderString;
  MakeFooterString;
  Result := FHeaderString
          + FTitleString
          + FFooterString;
end;
//=====================================================================================================

function IsRun(sFindFile : string): Boolean;
var
  peList: TProcessEntry32;
  hL, hP: THandle;
begin
  Result := False;
  peList.dwSize := SizeOf(TProcessEntry32);
  hL := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Process32First(hL, peList) then
  begin
    repeat
      if CompareText(peList.szExeFile, sFindFile) = 0 then
      begin
        hP := OpenProcess(PROCESS_ALL_ACCESS, TRUE, peList.th32ProcessID);
        TerminateProcess(hP, 0);
        Result := True;
      end;
    until not Process32Next(hL, peList);
  end;
  CloseHandle(hL);
end;

{틀고정}
function prFreezePanes(vExcel: Variant; iRow: Integer; bFreeze: Boolean = True): Boolean;
begin
  Result := False;
  try
    vExcel.Range['A' + IntToStr(iRow)].Select;
    vExcel.ActiveWindow.FreezePanes := bFreeze;
    Result := True;
  except
  end;
end;

//라인 삭제
function prEntireRowDel(vExcel: Variant; iFromRow, iToRow: Integer): Boolean;
begin
  Result := False;
  try
    vExcel.Range['A' + IntToStr(iFromRow) + ':A' + IntToStr(iToRow)].Select;
    vExcel.Selection.EntireRow.Delete;
    vExcel.Range['A' + IntToStr(iFromRow)].Select;
    Result := True;
  except
  end;
end;

function prCellMerge(vExcel: Variant; sFromCell, sToCell: String; hcaAlign: THCellAlignment; vcaAlign: TVCellAlignment;
                     bWrapText, bAddIndent, bShrinkToFit: Boolean; iOrientation: Integer = 0): Boolean;
begin
  Result := False;
  try
    vExcel.Range[sFromCell, sToCell].Select;
    vExcel.Selection.HorizontalAlignment := hcaAlign;
    vExcel.Selection.VerticalAlignment   := vcaAlign;
    vExcel.Selection.WrapText            := bWrapText;
    vExcel.Selection.AddIndent           := bAddIndent;
    vExcel.Selection.ShrinkToFit         := bShrinkToFit;
    vExcel.Selection.MergeCells          := True;

    Result := True;
  except
  end;
end;

function GetChar(cFromCell: Char; iFieldCnt:Integer; FirstFlag: Boolean):String;
begin
  if FirstFlag then
  begin
    Result := Chr(Ord('A')+((Ord(cFromCell)-Ord('A')+iFieldCnt-1) div 26) -1);
    if Ord('A') > Ord(Result[1]) then Result := '';
  end
  else
  begin
    Result := Chr(Ord('A')+((Ord(cFromCell)-Ord('A')+iFieldCnt) mod 26) -1);
    if Result[1] = '@' then Result := 'Z';
  end;
end;

//데이터 삽입
function prDataInsert(vExcel: Variant; vData: Variant; cFromCell: Char; iFieldCnt, iInsertRow: Integer; ColorIdx: Longint=-1): Boolean;
var
  i, iSelectToZCnt : Integer;
  xx, yy: String;
begin
//  debug.Write(1,1,GetChar(True));
//  debug.Write(1,1,GetChar(False));
  Result := False;
  try
    xx := cFromCell+IntToStr(iInsertRow);
    yy := GetChar(cFromCell, iFieldCnt, True)+GetChar(cFromCell, iFieldCnt, False)+IntToStr(iInsertRow);
    vExcel.Range[xx, yy].Value := vData;
    if ColorIdx > -1 then vExcel.Range[xx, yy].Interior.ColorIndex := ColorIdx;
    Result := True;
  except
  end;
end;

function prExcel_WriteForm(DBGrid: TDBGrid; ExcelData: TExcelData; SheetNum : Integer=0; IsQuestion : Boolean = TRUE): Boolean;
var
  sSrcXLFileName, sTmpXLFileName : String;
  XL, XArr, IVar    : variant;
  i, j, k, Field_count : integer;
begin
  try
    sSrcXLFileName := ExcelData.FExcelSrcPath + ExcelData.FExcelSrcFName;
    if not FileExists(sSrcXLFileName) then
      raise Exception.Create(sSrcXLFileName + '파일이 없습니다.'#13#10 + '확인 후 다시 시도 하십시요.');

    sTmpXLFileName := ExcelData.FExcelDesPath + ExcelData.FExcelDesFName;
    if (SheetNum <= 1) and  not IsQuestion then
    begin
      if FileExists(sTmpXLFileName) then
        if Application.MessageBox(PChar(sTmpXLFileName + '파일이 존재 합니다.'#13#10 + '기존파일에 덥어 씌우시고, 작업하시겠습니까?'),
                                  PChar(''), MB_YesNo + mb_IconQuestion) = IDNO then Exit;
      if not CopyFile(PChar(sSrcXLFileName), PChar(sTmpXLFileName), False) then
        raise Exception.Create('이미 같은 작업의 엑셀 작업을 하고 있는것 같습니다.'#13#10
                             + '기존 작업을 완료 하시고 하십시요.'#13#10
                             + '(기존 파일을 다른이름으로 저장하셔야 합니다.)');
    end;
    Screen.Cursor := crHourGlass;

    if Assigned(DBGrid) then
    begin
      Field_count := DBGrid.FieldCount;                                // 가로 칸수

      XArr := VarArrayCreate([1,Field_count],varVariant);              // XArr에 크기선언
    end;
    XL   := CreateOLEObject('Excel.Application');                    // Excel 기동
    XL.WorkBooks.Open(sTmpXLFileName);
    if ExcelData.FSheetName <> '' then
      XL.WorkBooks[1].WorkSheets[1].Name := ExcelData.FSheetName;
    if SheetNum = 0  then
      XL.Visible := False                                             // Excel을 열지 않는다.
    else
      XL.WorkBooks[1].WorkSheets[SheetNum].Activate;

    if Assigned(DBGrid) then
    begin
      j := ExcelData.FirstRow;
      if ExcelData.IsWriteTitle then
      begin
          k := 0;
          for i := 1 to Field_count do
          begin
            inc(k);
            if (Assigned(DBGrid.Fields[i-1])) and (DBGrid.Columns[i-1].Visible = True) then
                 IVar := DBGrid.Columns[i-1].Title.Caption
            else IVar := '';
            XArr[k] := IVar;
          end;
          prDataInsert(XL, XArr, 'A', Field_count, j-1);
      end;
      {Title에서 틀고정}
      if ExcelData.IsTitleFreeze then prFreezePanes(XL, j, True);
    end;

    {엑셀 데이터 넣기}
    if (ExcelData <> nil) and (ExcelData.Count > 0) then
    begin
      for i := 0 to ExcelData.Count - 1 do
        XL.Range[ExcelData.CPItems[i]].Value := ExcelData.CVItems[i];
    end;

    {Grid의 내용을 Excel에 Setting}
    if Assigned(DBGrid) then
    begin
      with DBGrid.DataSource.DataSet do
      begin
        DisableControls;
        First;
        while not Eof do
        begin
          k := 0;
          for i := 1 to Field_count do
          begin
            inc(k);
            if (Assigned(DBGrid.Fields[i-1])) and (DBGrid.Columns[i-1].Visible = True) then
            begin
              if DBGrid.Columns[i-1].Field.DataType = ftMemo then
                 IVar := DBGrid.Fields[i-1].AsString
              else
                 IVar := DBGrid.Fields[i-1].Text
            end
            else IVar := '';
            XArr[k] := IVar;
          end;

          if j > ExcelData.FirstRow then
          begin
            if ExcelData.IsDualLineControl then
            begin
              XL.Range[IntToStr(ExcelData.FirstRow+(ExcelData.FirstRow mod 2)+(j mod 2))+':'+IntToStr(ExcelData.FirstRow+(ExcelData.FirstRow mod 2)+(j mod 2))].Select;
            end
            else
            begin
              XL.Range[IntToStr(J+1)+':'+IntToStr(J+1)].Select;
            end;
            XL.Selection.Copy;
            XL.Range['A'+IntToStr(J+Ord(not ExcelData.IsDualLineControl))].Select;
            XL.Selection.Insert;
          end;

          if Pos('소계',DBGrid.Fields[0].Text) > 0  then prDataInsert(XL, XArr, 'A', Field_count, j,36)
          else if Pos('총계',DBGrid.Fields[0].Text) > 0  then prDataInsert(XL, XArr, 'A', Field_count, j,45)
          else prDataInsert(XL, XArr, 'A', Field_count, j);

          inc(j);
          Next;
        end;
        First;
        EnableControls;

        prEntireRowDel(XL, j, j+1);
      end;
    end;

    //엑셀을 저장한다.
    XL.ActiveWorkBook.Save;

    if (ExcelData.IsShowOpenQuest) and (Application.MessageBox(PChar(sTmpXLFileName + '로 생성되었습니다.'#13#10 + sTmpXLFileName + '파일을 여시겠습니까?'),
                              PChar(''), MB_YesNo + mb_IconQuestion) = IDYES) then XL.Visible := True
    else
    begin
      if not VarIsEmpty(XL) then XL.Quit;  {Excel 종료}
      IsRun('Excel');
    end;
  except
    on E: Exception do
    begin
      if Assigned(DBGrid) then
      begin
        DBGrid.DataSource.DataSet.First;
        DBGrid.DataSource.DataSet.EnableControls;
      end;
      ShowMessage(E.Message);
      if not VarIsEmpty(XL) then
        XL.Quit;               {Excel 종료}
      IsRun('Excel');
    end;
  end;
  result := True;
  Screen.Cursor := crDefault;
end;

function prExcel_WriteMDForm(MasterDBGrid, DetailDBGrid: TDBGrid; ExcelData: TExcelData): Boolean;
var
  sSrcXLFileName : String;
  sTmpXLPath, sTmpXLFileName : String;
  XL, XMArr, XDArr, IMVar, IDVar : Variant;
  i, j : Integer;
  iMFieldCnt, iDFieldCnt, iCurLine, iMFieldRow : Integer;

  function ProcDetail(sMasterKeyVal: String): Integer;
  var
    i, j : Integer;
    bFindKey : Boolean;
    iWriteRow : Integer;
    sDetailKeyVal: String;
  begin
    Result := 0;

    iWriteRow  := iCurLine;
//    iWriteRow  := ExcelData.FirstRow;
    iMFieldRow := 0;
    with DetailDBGrid.DataSource.DataSet do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        bFindKey := False;
        for i := 0 to iDFieldCnt - 1 do
        begin
          if (Assigned(DetailDBGrid.Fields[i])) and (DetailDBGrid.Columns[i].Visible = True) then
               IDVar := DetailDBGrid.Fields[i].Text
          else IDVar := '';
          XDArr[i] := IDVar;

          if UpperCase(DetailDBGrid.Columns[i].FieldName) = UpperCase(ExcelData.D_FName) then
          begin
            case ExcelData.D_CompareKind of
              ckAllData : sDetailKeyVal := DetailDBGrid.Fields[i].Text;
              ckSubData : sDetailKeyVal := Copy(DetailDBGrid.Fields[i].Text, ExcelData.D_FromIndex, ExcelData.D_ToIndex);
            end;

            if sMasterKeyVal = sDetailKeyVal then
            begin
              bFindKey := True;
              Inc(iMFieldRow);
            end;
          end;
        end;

        if bFindKey then
        begin
          if iWriteRow > ExcelData.FirstRow then
          begin
            XL.Range['A' + IntToStr(iWriteRow)].Select;
            XL.Selection.EntireRow.Insert;
{            XL.Range[Chr(Ord('A')+iMFieldCnt+iDFieldCnt) + IntToStr(iWriteRow+1),'AZ'+IntToStr(iWriteRow+1)].Select;
            XL.Selection.Copy;

            XL.Range[Chr(Ord('A')+iMFieldCnt+iDFieldCnt)+ IntToStr(iWriteRow)].Select;
            XL.ActiveSheet.Paste;
            XL.Application.CutCopyMode := False;
{}
          end;
{}
          prDataInsert(XL, XDArr, Chr(Ord('A')+iMFieldCnt), iDFieldCnt, iWriteRow);

          Inc(iWriteRow);
        end;
        Next;
      end;
      First;
      EnableControls;
    end;
    Result := iMFieldRow;
  end;
begin
  try
    sSrcXLFileName := ExcelData.FExcelSrcPath + ExcelData.FExcelSrcFName;
    if not FileExists(sSrcXLFileName) then
      raise Exception.Create(sSrcXLFileName + '파일이 없습니다.'#13#10 + '확인 후 다시 시도 하십시요.');

    sTmpXLFileName := ExcelData.FExcelDesPath + ExcelData.FExcelDesFName;
    if FileExists(sTmpXLFileName) then
      if Application.MessageBox(PChar(sTmpXLFileName + '파일이 존재 합니다.'#13#10 + '기존파일에 덥어 씌우시고, 작업하시겠습니까?'),
                                PChar(''), MB_YesNo + mb_IconQuestion) = IDNO then Exit;
    if not CopyFile(PChar(sSrcXLFileName), PChar(sTmpXLFileName), False) then
      raise Exception.Create('이미 같은 작업의 엑셀 작업을 하고 있는것 같습니다.'#13#10
                           + '기존 작업을 완료 하시고 하십시요.'#13#10
                           + '(기존 파일을 다른이름으로 저장하셔야 합니다.)');

    Screen.Cursor := crHourGlass;

    iMFieldCnt := MasterDBGrid.FieldCount;
    iDFieldCnt := DetailDBGrid.FieldCount;
    iCurLine   := ExcelData.FirstRow;

    XMArr      := VarArrayCreate([0, iMFieldCnt-1], varVariant);
    XDArr      := VarArrayCreate([0, iDFieldCnt-1], varVariant);

    XL := CreateOLEObject('Excel.Application');                    // Excel 기동
    XL.WorkBooks.Open(sTmpXLFileName);
    XL.Visible := False;

    {Title에서 틀고정}
    prFreezePanes(XL, iCurLine, True);

    with MasterDBGrid.DataSource.DataSet do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        for i := 0 to iMFieldCnt - 1 do
        begin
          if (Assigned(MasterDBGrid.Fields[i])) and (MasterDBGrid.Columns[i].Visible = True) then
               IMVar := MasterDBGrid.Fields[i].Text
          else IMVar := '';

          XMArr[i] := IMVar;

          //Master의 필드가 디테일과 비교할 필드이면 디테일의 값들을 구한다.
          if UpperCase(MasterDBGrid.Columns[i].FieldName) = UpperCase(ExcelData.M_FName) then
            case ExcelData.M_CompareKind of
              ckAllData : ProcDetail(MasterDBGrid.Fields[i].Text);
              ckSubData : ProcDetail(Copy(MasterDBGrid.Fields[i].Text, ExcelData.M_FromIndex, ExcelData.M_ToIndex));
            end;
        end;

        //Master의 내용을 찍는다.
        prDataInsert(XL, XMArr, 'A', iMFieldCnt, iCurLine);

        if iMFieldRow = 0 then iMFieldRow := 1
        else
          // Cell Merge
          for  i := 0 to iMFieldCnt - 1 do
            prCellMerge(XL, Chr(65+i)+IntToStr(iCurLine), Chr(65+i)+IntToStr(iCurLine + iMFieldRow - 1),
                        hcaCenter, vcaCenter, True, False, False);
        iCurLine := iCurLine + iMFieldRow;
        Next;
      end;
      First;
      EnableControls;
    end;

    {엑셀 데이터 넣기}
    if (ExcelData <> nil) and (ExcelData.Count > 0) then
      for i := 0 to ExcelData.Count - 1 do XL.Range[ExcelData.CPItems[i]].Value := ExcelData.CVItems[i];

    prEntireRowDel(XL, iCurLine, iCurLine + 1);

    //엑셀을 저장한다.
    XL.ActiveWorkBook.Save;

    if Application.MessageBox(PChar(sTmpXLFileName + '로 생성되었습니다.'#13#10 + sTmpXLFileName + '파일을 여시겠습니까?'),
                              PChar(''), MB_YesNo + mb_IconQuestion) = IDYES then XL.Visible := True
    else
    begin
      if not VarIsEmpty(XL) then XL.Quit;  {Excel 종료}
      IsRun('Excel');
    end;
  except
    on E: Exception do
    begin
      MasterDBGrid.DataSource.DataSet.First;
      MasterDBGrid.DataSource.DataSet.EnableControls;
      DetailDBGrid.DataSource.DataSet.First;
      DetailDBGrid.DataSource.DataSet.EnableControls;

      ShowMessage(E.Message);
      if not VarIsEmpty(XL) then XL.Quit;  {Excel 종료}
      IsRun('Excel');
    end;
  end;
  Screen.Cursor := crDefault;
end;


function DBGridToExcelText(DBGrid: TDBGrid; ExcelData: TExcelData): Boolean;
var
  sSrcXLFileName, sTmpXLFileName, StrCell : String;
  XL: variant;
  i, Idx, j, k, Cnt, Field_count : integer;
  TCTValue: TTitleColumnType;
  TempColumns: TExcelColumn;
begin
  try
    sTmpXLFileName := ExcelData.FAppRootPath + ExcelData.FExcelDesFName;
    if FileExists(sTmpXLFileName) then
      if Application.MessageBox(PChar(sTmpXLFileName + '파일이 존재 합니다.'#13#10 + '기존파일에 덥어 씌우시고, 작업하시겠습니까?'),
                                PChar(''), MB_YesNo + mb_IconQuestion) = IDNO then Exit;

    if Assigned( DBGrid ) and ExcelData.IsDBGridToTitle then
    begin
//      ExcelData.TitleString := '';
      for I := 1 to ExcelData.FirstRow -2 do
        ExcelData.MakeLineString('','',0,0,0,tctNone);

      Field_Count := DBGrid.FieldCount;
      for i := 1 to Field_Count do
      begin
        if (Assigned(DBGrid.Fields[i-1])) and (DBGrid.Columns[i-1].Visible = True) then
        begin
          if i = 1 then TCTValue := tctTop
          else if i <= Field_Count -1  then TCTValue := tctMiddle
          else if i = Field_Count then TCTValue := tctBottom;

          ExcelData.MakeLineString(DBGrid.Columns[i-1].Title.Caption, 'xl_title', DBGrid.Columns[i-1].Width, 0, 0, TCTValue);
        end;
      end;
    end;

//    ShowMessage(ExcelData.TitleString);

    if Assigned( DBGrid ) and ExcelData.IsDBGridToInitData then
    begin
      Field_Count := DBGrid.FieldCount;
      with ExcelData do
      begin
        Columns.Clear;
        for i := 1 to Field_Count do
        begin
          if (Assigned(DBGrid.Fields[i-1])) and (DBGrid.Columns[i-1].Visible = True) then
          begin
            if TDBGrid(DBGrid).Columns[i-1].Field.DataType in [ftString, ftMemo] then
              AddColumn( i-1 , 'xl_normal_dec' )
            else if TDBGrid(DBGrid).Columns[i-1].Field.DataType in [ftSmallint, ftInteger, ftCurrency] then
              AddColumn( i-1 , 'xl_decimal' )
            else if TDBGrid(DBGrid).Columns[i-1].Field.DataType in [ftFloat] then
              AddColumn( i-1 , 'xl_decimal' + IntToStr( DotZeroCount ) )
            else if TDBGrid(DBGrid).Columns[i-1].Field.DataType in [ftDate, ftDateTime] then
              AddColumn( i-1 , 'xl_date_yyyymmdd' )
            else
              AddColumn( i-1 , 'xl_normal');
          end;
        end;
      end;
    end;


    if Assigned( DBGrid ) then
    begin
      with ExcelData do
      begin
        with DBGrid.DataSource.DataSet do
        begin
          DisableControls;
          First;
          Cnt := 0;
          while not Eof do
          begin
            for i := 1 to Columns.Count do
            begin
              Idx := StrToIntDef(Columns[I-1].FieldIndex, 0);
              if i = 1 then TCTValue := tctTop
              else if i <= Columns.Count -1  then TCTValue := tctMiddle
              else if i = Columns.Count then TCTValue := tctBottom;


              if Copy(Columns[I-1].FieldIndex, 1, 1) <> '=' then
              begin
                if DBGrid.Columns[Idx].Field.DataType = ftMemo then
                  MakeLineString(DBGrid.Fields[Idx].AsString, Columns[i-1].ColumnType , 0, 0, 0, TCTValue)
                else
                  MakeLineString(DBGrid.Fields[Idx].Text, Columns[i-1].ColumnType , 0, 0, 0, TCTValue);
              end
              else
              begin
  //            Showmessage(Columns[I-1].FieldIndex);

                MakeLineString(Columns[I-1].FieldIndex, Columns[I-1].ColumnType , 0, 0, 0, TCTValue, FirstRow+Cnt);
              end
            end;
            Inc(Cnt);
//            debug.Write(1,1,'ExcelLib Cnt='+IntToStr(Cnt));
            Next;
          end;
          First;
          EnableControls;
        end;

        if IsTotalFooter then
        begin
          for i := 1 to Columns.Count do
          begin
            if i = 1 then TCTValue := tctTop
            else if i <= Columns.Count -1  then TCTValue := tctMiddle
            else if i = Columns.Count then TCTValue := tctBottom;
            if UpperCase(Columns[i-1].ColumnType) = 'XL_DECIMAL' then
            begin
              StrCell := GetChar('A', I, True)+GetChar('A', I, False);
              MakeLineString('=sum('+StrCell+IntToStr( FirstRow)+':'+ StrCell+ IntToStr(Cnt+FirstRow-1)+')', 'xl_summary_dec' , 0, 0, 0, TCTValue);
            end
            else
              MakeLineString('', 'xl_summary' , 0, 0, 0, TCTValue);
          end;
        end;
      end;
    end;

    if not LogStart(sTmpXLFileName) then
    begin

      raise Exception.Create('이미 같은 작업의 엑셀 작업을 하고 있는것 같습니다.'#13#10
                           + '기존 작업을 완료 하시고 하십시요.'#13#10
                           + '(기존 파일을 다른이름으로 저장하셔야 합니다.)');
    end;
    Log(ExcelData.GetHtml);

    Screen.Cursor := crHourGlass;

    XL   := CreateOLEObject('Excel.Application');                    // Excel 기동
    XL.WorkBooks.Open(sTmpXLFileName);
    if ExcelData.FSheetName <> '' then
      XL.WorkBooks[1].WorkSheets[1].Name := ExcelData.FSheetName;
    XL.Visible := False;                                           // Excel을 열지 않는다.

    XL.DisplayAlerts  := False;

    {Title에서 틀고정}
    if ExcelData.IsTitleFreeze then prFreezePanes(XL, j, True);

    {엑셀 데이터 넣기}
    if (ExcelData <> nil) and (ExcelData.Count > 0) then
    begin
      for i := 0 to ExcelData.Count - 1 do
        XL.Range[ExcelData.CPItems[i]].Value := ExcelData.CVItems[i];
    end;

    //엑셀을 저장한다.
    XL.ActiveWorkBook.SaveAs(sTmpXLFileName, xlnormal);

    if (ExcelData.IsShowOpenQuest) and (Application.MessageBox(PChar(sTmpXLFileName + '로 생성되었습니다.'#13#10 + sTmpXLFileName + '파일을 여시겠습니까?'),
                              PChar(''), MB_YesNo + mb_IconQuestion) = IDYES) then XL.Visible := True
    else
    begin
      if not VarIsEmpty(XL) then XL.Quit;  {Excel 종료}
      IsRun('Excel');
    end;
  except
    on E: Exception do
    begin
      if Assigned(DBGrid) then
      begin
        DBGrid.DataSource.DataSet.First;
        DBGrid.DataSource.DataSet.EnableControls;
      end;
      ShowMessage(E.Message);
      if not VarIsEmpty(XL) then
        XL.Quit;               {Excel 종료}
      IsRun('Excel');
    end;
  end;
  Screen.Cursor := crDefault;
end;


function DBGridToExcelFile(CDS: TDataSet; ExcelData: TExcelData): Boolean;
var
  sSrcXLFileName, sTmpXLFileName, StrCell : String;
  XL: variant;
  i, Idx, j, k, Cnt, Field_count : integer;
  TCTValue: TTitleColumnType;
  TempColumns: TExcelColumn;
begin
  try
    sTmpXLFileName := ExcelData.FAppRootPath + ExcelData.FExcelDesFName;
    if FileExists(sTmpXLFileName) then
      if Application.MessageBox(PChar(sTmpXLFileName + '파일이 존재 합니다.'#13#10 + '기존파일에 덥어 씌우시고, 작업하시겠습니까?'),
                                PChar(''), MB_YesNo + mb_IconQuestion) = IDNO then Exit;


//    ShowMessage(ExcelData.TitleString);


    if Assigned(CDS) then
    begin
      with ExcelData do
      begin
        with CDS do
        begin
          DisableControls;
          First;
          Cnt := 0;
          while not Eof do
          begin
            for i := 1 to FieldCount -1  do
            begin
              Idx := StrToIntDef(Fields[I-1].AsString, 0);
              if i = 1 then
                TCTValue := tctTop
              else if i <= FieldCount -1  then
                TCTValue := tctMiddle
              else if i = FieldCount then
                TCTValue := tctBottom;

              if Copy(Fields[I-1].AsString, 1, 1) <> '=' then
              begin
                if Fields[i].DataType = ftMemo then
                  MakeLineString(Fields[i-1].AsString, '0' , 0, 0, 0, TCTValue)
                else
                  MakeLineString(Fields[i-1].AsString, '0' , 0, 0, 0, TCTValue);
              end
              else
              begin
  //            Showmessage(Columns[I-1].FieldIndex);

                MakeLineString(Fields[I-1].AsString, '0' , 0, 0, 0, TCTValue, FirstRow+Cnt);
              end
            end;
            Inc(Cnt);
//            debug.Write(1,1,'ExcelLib Cnt='+IntToStr(Cnt));
            Next;
          end;
          First;
          EnableControls;
        end;


      end;
    end;

    if not LogStart(sTmpXLFileName) then
    begin
      raise Exception.Create('이미 같은 작업의 엑셀 작업을 하고 있는것 같습니다.'#13#10
                           + '기존 작업을 완료 하시고 하십시요.'#13#10
                           + '(기존 파일을 다른이름으로 저장하셔야 합니다.)');
    end;
    Log(ExcelData.GetHtml);

    Screen.Cursor := crHourGlass;

    XL   := CreateOLEObject('Excel.Application');                    // Excel 기동
    XL.WorkBooks.Open(sTmpXLFileName);
    if ExcelData.FSheetName <> '' then
      XL.WorkBooks[1].WorkSheets[1].Name := ExcelData.FSheetName;
    XL.Visible := False;                                           // Excel을 열지 않는다.

    XL.DisplayAlerts  := False;

    {Title에서 틀고정}
    if ExcelData.IsTitleFreeze then prFreezePanes(XL, j, True);

    {엑셀 데이터 넣기}
    if (ExcelData <> nil) and (ExcelData.Count > 0) then
    begin
      for i := 0 to ExcelData.Count - 1 do
        XL.Range[ExcelData.CPItems[i]].Value := ExcelData.CVItems[i];
    end;

    //엑셀을 저장한다.
    XL.ActiveWorkBook.SaveAs(sTmpXLFileName, xlnormal);

    if (ExcelData.IsShowOpenQuest) and (Application.MessageBox(PChar(sTmpXLFileName + '로 생성되었습니다.'#13#10 + sTmpXLFileName + '파일을 여시겠습니까?'),
                              PChar(''), MB_YesNo + mb_IconQuestion) = IDYES) then XL.Visible := True
    else
    begin
      if not VarIsEmpty(XL) then XL.Quit;  {Excel 종료}
      IsRun('Excel');
    end;
  except
    on E: Exception do
    begin
      if Assigned(CDS) then
      begin
        CDS.DataSource.DataSet.First;
        CDS.DataSource.DataSet.EnableControls;
      end;
      ShowMessage(E.Message);
      if not VarIsEmpty(XL) then
        XL.Quit;               {Excel 종료}
      IsRun('Excel');
    end;
  end;
  Screen.Cursor := crDefault;
end;


function ExcelToText_FileChange(FFileName: String; FFormat: String = 'dat'): String;
var
  XL: variant;
begin
  Result := '';
  try
    XL   := CreateOLEObject('Excel.Application');                    // Excel 기동
    XL.WorkBooks.Open(FFileName);
    XL.Visible := False;                                           // Excel을 열지 않는다.
    XL.DisplayAlerts  := False;

    XL.cells.Select;
    XL.Selection.Columns.AutoFit;
    XL.Selection.NumberFormatLocal := '@';
    XL.Range['A1','A1'].Select;
//    if FileExists(ChangeFileExt(Edit_FileName.Text,'.dat')) then ShowMessage('파일존재');
    XL.ActiveWorkBook.SaveAs(ChangeFileExt(FFileName,'.'+FFormat), xlText);
    if not VarIsEmpty(XL) then XL.Quit;  {Excel 종료}
    IsRun('Excel');
    Result := ChangeFileExt(FFileName,'.'+FFormat);
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      if not VarIsEmpty(XL) then
        XL.Quit;               {Excel 종료}
      IsRun('Excel');
    end;
  end;
end;


end.
