unit CallListForm;

interface

uses
  Winapi.Windows,  System.Classes,  System.IniFiles,  System.Math,  System.SysUtils,
  Vcl.ComCtrls,  Vcl.Controls,  Vcl.ExtCtrls,  Vcl.Forms,  Vcl.Graphics,  Vcl.Grids,
  Vcl.StdCtrls, AdvUtil, AdvObj, BaseGrid, AdvGrid, AdvGlowButton, DCPcrypt2, DCPblockciphers,  DCPsha1,  DCPrijndael;

type
  TFrmCallList = class(TForm)
    btn_Search: TAdvGlowButton;
    btn_Close: TAdvGlowButton;
    SGrid1: TAdvStringGrid;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure btnCloseClick(Sender: TObject);
    procedure Initialize;

    procedure SGrid1GetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvGrid_Clear(int_Title_Row: Integer; strgrid: TAdvStringGrid);
    function ReadCallHistory(sFileName: String): Boolean;
    function FN_FORMATPHONE(s_Char, s_PhoneNum: String): String;  public

  end;

  const
  g1_NO      = 0;
  g1_CALL_DT = 1;
  gd_INOUT   = 2;
  gd_PHONE   = 3;

var
  FrmCallList: TFrmCallList;

implementation
uses UtilLib;

{$R *.dfm}
{$WARN IMPLICIT_STRING_CAST OFF}

procedure TFrmCallList.Initialize;
begin

  with SGrid1 do
  begin
    ColCount := 4;
    Cells[g1_NO        ,0] := '순번';
    Cells[g1_CALL_DT   ,0] := '통화일자';
    Cells[gd_INOUT     ,0] := 'In/Out';
    Cells[gd_PHONE     ,0] := '전화번호';

    ColWidths[g1_NO      ] := 60;
    ColWidths[g1_CALL_DT ] := 130;
    ColWidths[gd_INOUT   ] := 80;
    ColWidths[gd_PHONE   ] := 120;
  end;
  btn_SearchClick(self);
end;

procedure TFrmCallList.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCallList.btn_SearchClick(Sender: TObject);
var iDay : Integer;
    sDateTime  : TDateTime;
    sFileName : String;
begin
  AdvGrid_Clear(1,SGrid1);
  try
    for iDay := 0 to 6 do
    begin
      sDateTime := Now - iDay;
      sFileName := ExtractFilePath(Application.ExeName) + 'Log\' + 'callhis_' + FormatDateTime('YYYYMMDD', sDateTime) + '.dbgc';
      if FileExists(sFileName) then
        ReadCallHistory(sFileName);
    end;
  except
    //
  end;
  SGrid1.RowCount := SGrid1.RowCount - 1;
end;


function TFrmCallList.ReadCallHistory(sFileName:String): Boolean;

var
  s_TextRocord, sMessage: String;
  DCP_rijndael: TDCP_rijndael;

  i_idx, r_idx: Integer;
  Rtl: TStringArray;

  slFile : TStringList;
  stream : TFileStream;
begin
  try
    slFile := TStringList.Create;
    stream := TFileStream.Create(sFileName, fmShareDenyNone);
    slFile.LoadFromStream(stream);

    for i_idx := slFile.Count-1 downto 0 do
    begin
      DCP_rijndael := TDCP_rijndael.Create(nil);
      DCP_rijndael.InitStr ('tele123**', TDCP_sha1);//it is initialized
      s_TextRocord := slFile.Strings[i_idx];
      sMessage := DCP_rijndael.DecryptString(s_TextRocord);//we decipher

      r_idx := UtilLib.GetField(sMessage, '^', Rtl);
      if r_idx >= 1 then
      begin
        with SGrid1 do
        begin
          Cells[g1_NO        ,RowCount - 1] := intToStr(RowCount - 1);
          Cells[g1_CALL_DT   ,RowCount - 1] := Rtl[0];
          Cells[gd_INOUT     ,RowCount - 1] := Rtl[1];
          Cells[gd_PHONE     ,RowCount - 1] := FN_FORMATPHONE('-',StringReplace(Rtl[2],'-','',[rfReplaceAll]));
          RowCount := RowCount + 1;
        end;
      end;
    end;
  finally
    FreeAndNil(stream);
    FreeAndNil(slFile);
  end;
  {}
end;

procedure TFrmCallList.AdvGrid_Clear(int_Title_Row: Integer; strgrid: TAdvStringGrid);
var
  i: Integer;
begin
  try
    for i := int_Title_Row to strgrid.RowCount do
      strgrid.rows[i].Clear;
    strgrid.RowCount := int_Title_Row + 1;

  except
    //
  end;
end;


procedure TFrmCallList.SGrid1GetAlignment(Sender: TObject; ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  begin
    if ARow = 0 then
    begin
      HAlign := taCenter;
    end;

    if ARow >= 1 then
    begin
      case ACol of
        99:
          HAlign := taLeftJustify;
      else
        HAlign := taCenter;
      end;
    end;
  end;
end;


FUNCTION TFrmCallList.FN_FORMATPHONE(s_Char, s_PhoneNum :String) : String;
var
  s_Str,  s_Result : String;
  i_n,  i_FDashIdx,  i_MDashIdx : Integer;
BEGIN
  Result := '';

  s_Str := Trim(s_PhoneNum);

  s_Str := StringReplace(s_Str,'-','',[rfReplaceAll]);
  s_Str := StringReplace(s_Str,'.','',[rfReplaceAll]);
  s_Str := StringReplace(s_Str,' ','',[rfReplaceAll]);
  s_Str := StringReplace(s_Str,'(','',[rfReplaceAll]);
  s_Str := StringReplace(s_Str,')','',[rfReplaceAll]);
  s_Str := StringReplace(s_Str,'/','',[rfReplaceAll]);

  IF LENGTH(s_Str) >= 3 THEN
  begin
    IF Copy(s_Str, 1, 1) = '0' THEN
    begin
      IF Copy(s_Str, 2, 1) = '2' THEN
      begin
        i_FDashIdx := 2;
      end
      else if (Copy(s_Str, 2, 1) = '5') AND (Copy(s_Str, 3, 1) = '0') THEN
      begin
        i_FDashIdx := 4;
      end
      else if (Copy(s_Str, 2, 1) = '3') AND (Copy(s_Str, 3, 1) = '0') THEN
      begin
        i_FDashIdx := 4;
      end
      else if (Copy(s_Str, 2, 1) = '1') AND (Copy(s_Str, 3, 1) = '3') THEN
      begin
        IF Copy(s_Str, 4, 1) = '0' THEN
        begin
          i_FDashIdx := 4;
        end
        ELSE
        begin
          i_FDashIdx := 3;
        end;;
      end
      else
      begin
        i_FDashIdx := 3;
      end;
    end
    else
    begin
        i_FDashIdx := 3;
    end;;

    IF Copy(s_Str, i_FDashIdx+1, 1) = '0' THEN
    begin
      IF Copy(s_Str, 1, 3) = '080' THEN
      begin
        s_Str := TRIM(Copy(s_Str, 1, i_FDashIdx)) + TRIM(Copy(s_Str, i_FDashIdx+2, LENGTH(s_Str)));
      end;
    end;

    IF (LENGTH(s_Str) - i_FDashIdx) >= 9 THEN
    begin
      i_MDashIdx := i_FDashIdx + 4 + 1;
    end
    ELSE
    begin
      i_MDashIdx := LENGTH(s_Str) - 4 + 1;
    END;

  end
  else if s_Str = '02' THEN
  begin
    i_FDashIdx := 2;
  end;

  IF i_MDashIdx >= 0 THEN
    s_Result := TRIM(Copy(s_Str, 1, i_MDashIdx-1) + s_Char + Copy(s_Str, i_MDashIdx, LENGTH(s_Str)));


  IF i_FDashIdx >= 0 THEN
    s_Result := TRIM(Copy(s_Result, 1, i_FDashIdx) + s_Char + Copy(s_Result, i_FDashIdx+1, LENGTH(s_Result)));

  Result := s_Result;

end;

procedure TFrmCallList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cahide;
end;

procedure TFrmCallList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
