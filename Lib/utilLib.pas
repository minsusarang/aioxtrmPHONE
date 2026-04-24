//******************************************************************************
// 공통라이브러리
//******************************************************************************


unit UtilLib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IpHlpApi, IpTypes,
  StdCtrls, DBCtrls, Mask, Grids, DBGrids, DBAdvGrid, AdvGrid, ExtCtrls, ComCtrls, Db, DBTables,
  Buttons,  DBClient, IniFiles, Imm, AdvEdit, winsock, CurvyControls, AdvPanel, BaseGrid,
  AdvCombo, ComObj, ADODB, TlHelp32, FileCtrl, Registry, ShlObj, ActiveX, uCDSUtil, AdvOfficePager,
  Variants , Shader, Uni;

type
  TStringArray = array of string;
  TCharSet = set of Char;

  TCompareKind = (ckAllData, ckSubData);
  TcdsSumRecordType = (srtData, srtSum, srtAveg);
function GetWindowsDir: string;
function GetWindowsSysTemDir: string;
//======================================================================================

   {화면 및 Panel등에 관한 함수}
//=====================================================================================================
// parameter로 받은 Form에 있는 Edit Box, Combo Box, Label, StringGrid등을 Clear한다.
procedure ClearForm(Form: TForm; ClassName: TClass);
procedure Color_Initialize(Form: TForm; ClassName: TClass);

// parameter로 받은 Control에 있는 Edit Box, Combo Box, Label, StringGrid등을 Clear한다.
procedure ClearControl(Sender: TWinControl; ClassName: TClass);

// StringGrid를 Clear한다.
procedure ClearStringGrid(Sender: TStringGrid; ClearFixed: Boolean);

// Control에 속한 모든 Control의 Enabled속성을 Setting한다.
procedure EnableControl(Sender: TWinControl; Flag: Boolean);

// 컨트롤.Enabled := E , 컨트롤.Clear도 동시에
procedure SetControlColor(Control:TControl; E:Boolean);
procedure SetControlColor2(Control: TControl; Enable, DoClear: Boolean);

procedure UserMouseWheelHandler(Sender: TObject; var Message: TMessage);
procedure MemoScrollBar(AMemo: TMemo);
//=====================================================================================================


//=====================================================================================================
// 주민번호6자리를 8자리 날짜스트링으로 변환(2000문제 땜시)
function JuminToDate(Jumin: String): String;

// 주민번호에서 성별을 구하기[1,3: 남자 / 2,4:여자](2000문제 땜시)
function JuminToSex(Jumin: String): String;
function JuminToSexMF(Jumin: String): String;

// 주민번호에서 성별, 나이를 구하는 함수
function GetAgeSex(CurrentDate, Juid: String; var SEX:String; Flag: Boolean=True): Integer; overload;
function GetAgeSex(CurrentDate, Juid: String; Flag: Boolean=True): Integer; overload;
function GetAge(CurrentDate, BirthDate: String; Flag: Boolean=True): Integer;
function GetAgeSex_Insure(CurrentDate, Juid: String; var SEX:String): Integer; overload;
function GetAgeSex_Insure(CurrentDate, Juid: String): Integer; overload;
function GetAge_Insure(CurrentDate, BirthDate: String): Integer;
//=====================================================================================================


{ 일반적인 함수 }
//=====================================================================================================
{스트링변환 및 숫자변환 등에 관련된 함수}
// A, B둘 중 큰 값을 구한다. Integer형
function IMax(A, B: Integer): Integer;

// A, B둘 중 작은 값을 구한다. Integer형
function IMin(A, B: Integer): Integer;

// A, B둘 중 큰 값을 구한다. Float형
function FMax(A, B: Double): Double;

// A, B둘 중 작은 값을 구한다. Float형
function FMin(A, B: Double): Double;

//=====================================================================================================


{ Data를 Check하는 함수 }
//=====================================================================================================
// 주민등록번호가 맞는 형식인지 Check한다.
function CheckJumin(No:String; Flag: Boolean=False) : Boolean;

// 사업자번호가 맞는 형식인지 Check한다.
function CheckBussiness(No:String) : Boolean;

// 숫자만 포함하고 있는지 Check한다.
function CheckNumeric(Num:String) :Boolean;

// 숫자나 문자(Alphabet)만 포함하고 있는지 Check한다.
function CheckAlphaNumeric(Source: String): Boolean;

// String이 공백문자만 포함하고 있는지 Check한다.
function HasOnlyBlank(Str: String): Boolean;

// 값이 음수,0,양수인지 체크한다.
function Sign(Int : Extended) : Integer;

// 한글, 영문 , 스페이스만 입력가능
function CheckNameRule(Str: WideString): Boolean;
//=====================================================================================================


{ 변환 함수 }
//=====================================================================================================
// String이 Null이면 'Null'이라는 문자열을 Return해 준다.
function StrToNull(Source: String): String;

// String을 Float로 변환하되 Exception이 raise되는 경우 Default값을 준다.
function StrToFloatDef(const S: string; Default: Extended): Extended;

//=====================================================================================================


{ 스트링변수 관련함수 }
//=====================================================================================================
// String에서 숫자만 Return한다.
function ExtractNumeric(Str : String) : String;

// String에서 부호,소수점을 포함한 숫자만 Return한다.
function ExtractFloat(Str : String) : String;

// String에서 숫자를 가져와서 Numeric숫자형식의 String으로 Return. ("2,351 원" -> "2,351")
function StrToNumericStr(Str: String) : String;

// String에서 숫자를 가져와서 Float숫자형식의 String으로 Return. ("2,351 원" -> "2,351")
function StrToFloatStr(Str: String) : String;

// String에서 2Byte공백을 Space Character 두개로 변환하고, 앞 뒤의 공백을 제거한다.
function TrimMb(Value: String): String;

// Source에 포함된 DString을 모두 제거한다.
function DeleteString(const Source, DString: String): String;

// 반각스페이스, 전각스페이스를 모두 삭제
function DeleteSpace(DestStr : String) : String;

// Source에 포함된 Ch Char를 모두 제거한다.
function DeleteChar(DestStr : String; Ch : Char) : String;
function DeleteChars(Src: String; CharSet: TCharSet): String;

function FillChar_MS(Length : Integer; Ch : Char) : String;

// Str을 지정한 Len의 길이로 변환하되, LeftAlign속성에 따라 좌, 우로 정렬하고 남는 공백에는 word를 채운다.
function FillCharAligned(Str : String;Len : word;ch : Char;LeftAlign :Boolean) : String;

// TStrings에서 가장 큰 값을 찾는다.(String이 실수로 변환이 않된다면 0으로 처리)
function GetMax(Source: TStrings): Double;

// TStrings에서 가장 작은 값을 찾는다.(String이 실수로 변환이 않된다면 0으로 처리)
function GetMin(Source: TStrings): Double;

function Get_SP_ParseCsvStr(str_Data: string; str_CvsChar: Char; int_index : integer):string;
function Get_FN_TIME_FORMAT(sStr: string) : string;
function Get_FN_DATE_FORMAT(sStr: string) : string;
function Get_FN_PHONE_FORMAT(sMASKYN, sStr: string) : string;
function Get_FN_ssTOhhnnss(iSecond: integer) : string;
function Get_FN_RATIO(f_Number1, f_Number2:Double; f_Number3: integer) : Double;
function Get_FN_DIVISION(f_Number1, f_Number2:Double; f_Number3: integer) : Double;
{
// Boolean형을 Integer로 변환한다.
function BoolToInt(Bool : Boolean) : Byte;

// Boolean형을 Char로 변환한다.
function BoolToChar(Bool : Boolean) : Char;
function BoolToYNChar(Bool : Boolean) : Char;

// Integer형을 Boolean형으로 변환한다.
function IntToBool(Int : Integer) : Boolean;
}
function BoolToInt(Bool : Boolean) : Byte;
function BoolToChar(Bool : Boolean) : Char;
function BoolToOXChar(Bool : Boolean) : Char;
function BoolToTFChar(Bool : Boolean) : Char;
function BoolToYNChar(Bool : Boolean) : Char;

function IntToBool(Int : Integer) : Boolean;
function CharToBool(Ch : Char) : Boolean;
function YNCharToBool(Ch : Char) : Boolean;
function TFCharToBool(Ch : Char) : Boolean;
function OXCharToBool(Ch : Char) : Boolean;

function StrToBool(Str : String; Idx: Integer=1) : Boolean;
function YNStrToBool(Str : String; Idx: Integer=1) : Boolean;
function TFStrToBool(Str : String; Idx: Integer=1) : Boolean;
function OXStrToBool(Str : String; Idx: Integer=1) : Boolean;

// 12자리 전화번호String을 구분기호를 포함한 전화번호String(또는 12자리 전화번호String)으로 변환한다.
function EncodeTEL_NO(TEL_NO:String;IncludeBracket:Boolean) : String;

// 4자리 전화번호String 3개를 구분기호를 포함한 전화번호String(또는 12자리 전화번호String)으로 변환한다.
function EncodeTEL_NO123(TEL_NO1,TEL_NO2,TEL_NO3:String;IncludeBracket:Boolean) : String;

// 스트링앞뒤에 ''추가
function Quotes(S:String):String;

// 스트링에서 서브스트링을 변경
function ReplaceStrF(SrcStr: String; SubStr,ToStr:String) : string;
// 스트링에서 서브스트링을 변경
function ReplaceStr(var SrcStr: String; SubStr,ToStr:String) : string;
function ReplaceStrOne(var SrcStr: String; SubStr,ToStr:String) : string;


//=====================================================================================================

//그리드상에서의 정렬을 보다 편하게
procedure SetAlign(Align : TAlignment; Canvas : TCanvas; Rect : TRect; Data : String);

//=====================================================================================================

// 13자리 주민등록번호를 구분기호를 포함한 String으로 변환한다.
function StrPlusJUMINFormat(JUMIN: String): String;

// 6자리 우편번호를 구분기호를 포함한 String으로 변환한다.
function StrPlusZIPCODEFormat(ZIPCODE: String): String;

// 10자리 사업자등록번호를 구분기호를 포함한 String으로 변환한다.
function StrPlusCOMPIDFormat(s_stock: String): String;

function FormatJUMIN(const Str: String): String;
function FormatZIPCODE(const Str: String): String;

//=====================================================================================================

{$IFDEF CDSUTIL}
// DBGrid Title을 클릭했을때 소트한다.
procedure TitleClick_Sort(SCDataSet: TClientDataSet; SDBGrid: TDBGrid; Column: TColumn; var Asc: Boolean); overload;
procedure TitleClick_Sort(SCDataSet : TClientDataSet; SDBGrid: TDBGrid; Column: TColumn; Field_Sort: String; var Asc: Boolean); overload;
{$ENDIF}

// ClientDate의 인덱스를 지운다.
procedure Clear_Index(SCDataSet: TClientDataSet);

//=====================================================================================================

function RoundAt(X: Extended; Pos: Integer): Extended;
function TruncAt(X: Extended; Pos: Integer): Extended;
function ZeroToNull(Source: Integer): String;
function FloatZeroToNull(Source: Extended): String;

//=====================================================================================================

function QueryToData(Query: TQuery):OleVariant;
procedure QueryToCDS(Query: TQuery; CDS: TClientDataSet);
procedure ADOQueryToCDS(Query: TADOQuery; CDS: TClientDataSet);
procedure UniQueryToCDS(Query: TUniQuery; CDS: TClientDataSet);


{
procedure QueryToSumCDS(Query: TQuery; CDS: TClientDataSet; DisplayFields, GroupFields, SumFields, Expressions: String; WithAvg: Boolean = False;
  SumDisplay: String = ''; AvgDisplay: String = ''; CallBack: TNotifyEvent = nil);
procedure sumcdsGroupFilter( CDS: TClientDataSet; GroupFields: String; ShowData: Boolean );
procedure ADOQueryToSumCDS(Query: TADOQuery; CDS: TClientDataSet; DisplayFields, GroupFields, SumFields, Expressions: String; WithAvg: Boolean = False;
  SumDisplay: String = ''; AvgDisplay: String = ''; CallBack: TNotifyEvent = nil);
procedure UniQueryToSumCDS(Query: TUniQuery; CDS: TClientDataSet; DisplayFields, GroupFields, SumFields, Expressions: String; WithAvg: Boolean = False;
  SumDisplay: String = ''; AvgDisplay: String = ''; CallBack: TNotifyEvent = nil);
{}
function IsNull(Form : TForm; Sender:TObject; Msg : String; ViewMsg : Boolean) : Boolean;   //메세지 처리 함수

function ForceMsg(Form : TForm; Sender:TObject; Msg : String; ViewMsg : Boolean) : Boolean;

//=====================================================================================================
{한글모드제어}
//=====================================================================================================

//현재 한글모드를 가져온다.(한글:True, 영문:False)
function GetHangeulMode(Sender: TForm): Boolean;

//한글,영문모드로 변경해준다. SetHangeul [True:한글 | False:영문]
procedure SetHangeulMode(Sender: TForm; SetHangeul: Boolean);

//=====================================================================================================

//메세지를 쉽게 DisPlay.  다음라인 '|' , Flag [1..4] =('Error','Question','Warning','Information')
function MsgDisplay(Msg:String;Flag:Integer):Integer;

//Edit Check한다. 정상값이면 True,  sTemp1:첫줄메세지 ,sTemp2:두번째메세지, Flag는 왜 쓰는지???
function IsEditCheck(TempEdit:TEdit;sTemp1,sTemp2:String;Flag:Integer):Boolean;

//MaskEdit Check한다. 정상값이면 True,  sTemp1:첫줄메세지 ,sTemp2:두번째메세지, Flag는 왜 쓰는지???
function IsMEditCheck(TempEdit:TMaskEdit;sTemp1,sTemp2:String;Flag:Integer):Boolean;

//=====================================================================================================
//Ini파일에서 문자읽기
function IniReadString(IniFileName : String; Section, Ident, Default : AnsiString) : AnsiString; //20110404
//Ini파일에서 숫자읽기
function IniReadInteger(IniFileName : String; Section, Ident : String; Default : Integer) : Integer;
//Ini파일에서 문자쓰기
function IniWriteString(IniFileName : String; Section, Ident, Value: String) : Boolean;
//Ini파일에서 숫자쓰기
function IniWriteInteger(IniFileName : String; Section, Ident : String; Value: Integer) : Boolean;
//Ini파일에서 삭제
function IniDeleteKey(IniFileName : String; Section, Ident : String) : Boolean;
//=====================================================================================================
//Delay
procedure Delay(const nTime: Word);
//=====================================================================================================
function GetField(Src: String; FS: Char; var s_arr: TStringArray): Integer;
function GetFieldFix(Src: String; ColLength: Integer; LengthArr: Array of Integer; var s_arr: TStringArray): Integer;

function LFLFtoCRLF(Src: String): String;
function LFLFtoSpace(Src: String): String;
function SingleQtoClear(Src: String): String;
function CRLFtoPIPE(Src: String): String;
function PIPEtoCRLF(Src: String): String;
function GetIdxString(Src: String; Idx: Integer): String;
function fn_Quotation_Delete(Str:string):string;
function fn_My_LocalIP: String;
function fn_My_MAC_Address: String;

//엑셀에 저장하기
procedure ULib_ClientSaveExcel(aForm:TForm; aDBGrid :TDBGrid; aFileName: string);
function DBGridToExcel(DBGrid :TDBGrid; DefaultFileName : String) : Boolean;
function DBAdvGridToExcel(DBGrid :TDBAdvGrid; DefaultFileName : String) : Boolean;
function AdvStringGridToExcel(AdvStringGrid: TAdvStringGrid): Boolean;

//GRID->엑셀에 저장하기
procedure prExcel_Write(title : String; DBGrid : TDBGrid; AutoFit_Flag: Boolean = True);

function FormatPhone(AChar: Char; Src: string): string;
function fnParseCsvStr(const CsvStr : string; Cvsgubun : Char; Index: Integer): string;
function CheckItem(Msg: String; Flag: Boolean=False; Edit:  TAdvEdit=nil): Boolean;    overload;
function CheckItem(Msg: String; Flag: Boolean=False; CurvyEdit: TCurvyEdit=nil): Boolean;  overload;
function CheckItem(Msg: String; Flag: Boolean=False; Combo: TAdvComboBox=nil): Boolean;  overload;
function CheckItem_MSG(Msg: String; Flag: Boolean=False): Boolean;

function CheckTelArea(Tel0: String): String;
function CheckTel(Tel, Caption: String; Flag: Boolean; Edit: TCurvyEdit=nil): Boolean;

//GRID->엑셀에 저장하기
procedure prExcel_Write1(title, sub_title1, sub_title2, sub_title3, sub_title4 : String; DBGrid : TDBGrid; s_tail1, s_tail2 : String);
function IsRun(sFindFile : string): Boolean;

function fn_week(str_date : string) : String;

function Str_Decoding(s : String) :String;
function Str_Encoding(s : String):String;


function CreateShortcut(const CmdLine, Args, WorkDir, LinkFile: string): IPersistFile;
procedure CreateShortcuts(Str1, Str2, Str3: String; Flag: Boolean=True);
procedure CreateInternetShortcuts(const LocationURL, FileName: String);


function CopyWideString(Source: WideString; Index, Count: Integer): String;

const
  FS= chr($1C);
  NUL = chr($00);
  STX = chr($02);
  ETX = chr($03);
  EOT = chr($04);
  ENQ = chr($05);
  ACK = chr($06);
  BEL = chr($07);
  LF  = chr($0A);
  FF  = chr($0C);
  CR  = chr($0D);
  NAK = chr($15);
  ESC = chr($1B);

  ERROR_OK=$0A;    QUESTION_OK=$14;    WARNING_OK=$1E;    INFORMATION_OK=$28;
  ERROR_YESNO=$0E; QUESTION_YESNO=$18; WARNING_YESNO=$22; INFORMATION_YESNO=$2C;

  FSTART=0; FCOMMIT=1; FROLLBACK=2; FRCOMMIT=3;
  DateMaskText = '9999\-99\-99;0;_';

  ConstDDD1: String='10,11,13,130,16,17,18,19';
  ConstDDD2: String='2,31,32,33,41,42,43,44,51,52,53,54,55,61,62,63,64,70,303,502,505,506';


const
  USER_GROUP_FIELD = uCDSUtil.USER_GROUP_FIELD;
  USER_DEPTH_FIELD = uCDSUtil.USER_DEPTH_FIELD;
  USER_TYPE_FIELD  = uCDSUtil.USER_TYPE_FIELD;
  USER_COUNT_FIELD = uCDSUtil.USER_COUNT_FIELD;

  TOTAL_DEPTH = uCDSUtil.TOTAL_DEPTH;


implementation

uses DateStr, Math, DebugLib, Provider;


//=====================================================================================================
function GetWindowsDir: string;
var
  Buff: array[0..MAX_PATH] of Char;
  Len : Integer;
begin
  Len := GetWindowsDirectory(Buff, MAX_PATH);
  if Len > 0 then
  begin
    Result := Buff;
    if Buff[Len - 1] <> '\' then Result := Result + '\';
  end
  else Result := '';
end;

function GetWindowsSysTemDir: string;
var
  Buff: array[0..MAX_PATH] of Char;
  Len : Integer;
begin
  Len := GetSystemDirectory(Buff, MAX_PATH);
  if Len > 0 then
  begin
    Result := Buff;
    if Buff[Len - 1] <> '\' then Result := Result + '\';
  end
  else Result := '';
end;
//=====================================================================================================
{화면 및 Panel등에 관한 함수}
//=====================================================================================================
procedure ClearForm(Form: TForm; ClassName: TClass);
var
  I: Integer;
  J, K: Integer;

  tpControl: TComponent;
begin
  for I := 0 to Form.ComponentCount-1 do
  begin
    tpControl := Form.Components[I];

    if (tpControl is ClassName) and (tpControl is TEdit) then
      TEdit(tpControl).Clear
    else if (tpControl is ClassName) and (tpControl is TMaskEdit) then
      TMaskEdit(tpControl).Clear
    else if (tpControl is ClassName) and (tpControl is TAdvEdit) then
      TAdvEdit(tpControl).Clear
//    else if (tpControl is ClassName) and (tpControl is TAlignEdit) then
//      TAlignEdit(tpControl).Clear
    else if (tpControl is ClassName) and (tpControl is TMemo) then
      TMemo(tpControl).Clear

    else if (tpControl is ClassName) and (tpControl is TCustomComboBox) then
    begin
      if TComboBox(tpControl).Style = csDropDownList then 
        if TComboBox(tpControl).Tag <= TCombobox(tpControl).Items.Count then
          TComboBox(tpControl).ItemIndex := TComboBox(tpControl).Tag
        else TComboBox(tpControl).ItemIndex := 0
      else TComboBox(tpControl).ItemIndex := -1;
{
      if Assigned(TComboBox(tpControl).OnChange) then
        TComboBox(tpControl).OnChange(TComboBox(tpControl));
}        
    end
    else if (tpControl is ClassName) and (tpControl is TRadioGroup) then
    begin
      if TRadioGroup(tpControl).Tag <= TRadioGroup(tpControl).Items.Count then
        TRadioGroup(tpControl).ItemIndex := TRadioGroup(tpControl).Tag
    end
    else if (tpControl is ClassName) and (tpControl is TStringGrid) then
    begin
      for J := TStringGrid(tpControl).FixedCols to TStringGrid(tpControl).ColCount-1 do
        for K := TStringGrid(tpControl).FixedRows to TStringGrid(tpControl).RowCount-1 do
          TStringGrid(tpControl).Cells[ J, K] := '';
    end
    else if (tpControl is ClassName) and (tpControl is TCheckBox) then
    begin
      if TCheckBox(tpControl).Tag <= 1 then
        TCheckBox(tpControl).Checked := Boolean(TCheckBox(tpControl).Tag);
      if Assigned(TCheckBox(tpControl).OnClick) then
        TCheckBox(tpControl).OnClick(TCheckBox(tpControl));
    end
    else if (tpControl is ClassName) and (tpControl is TLabel) then
    begin
      if TLabel(tpControl).Tag = -5 then
        TLabel(tpControl).Caption := '';
    end
{    else if (tpControl is ClassName) and (tpControl is TExtLabel) then
    begin
      if TExtLabel(tpControl).Tag = -5 then
      begin
        TExtLabel(tpControl).Code := '';
        TExtLabel(tpControl).Caption := '';
      end;
    end
    {}
    else if (tpControl is ClassName) and (tpControl is TFrame) then
    begin
      ClearControl(TFrame(tpControl), ClassName);
    end;
  end;
end;

procedure Color_Initialize(Form: TForm; ClassName: TClass);
var
  I: Integer;
  J, K: Integer;

  tpControl: TComponent;
begin
  exit;
  for I := 0 to Form.ComponentCount-1 do
  begin
    tpControl := Form.Components[I];
    if (tpControl is ClassName) and (tpControl is TEdit) then
      TEdit(tpControl).Font.Color := clBlack
    else if (tpControl is ClassName) and (tpControl is TMaskEdit) then
      TMaskEdit(tpControl).Font.Color := clBlack
    else if (tpControl is ClassName) and (tpControl is TadvComboBox) then
      TadvComboBox(tpControl).Font.Color := clBlack
    else if (tpControl is ClassName) and (tpControl is TListBox) then
      TListBox(tpControl).Font.Color := clBlack
    else if (tpControl is ClassName) and (tpControl is TAdvEdit) then
      TAdvEdit(tpControl).Font.Color := clBlack
    else if (tpControl is ClassName) and (tpControl is TMemo) then
      TMemo(tpControl).Font.Color := clBlack
    else if (tpControl is ClassName) and (tpControl is TCustomComboBox) then
    begin
//      TCustomComboBox(tpControl).Font.Color := clBlack
    end
    else if (tpControl is ClassName) and (tpControl is TRadioGroup) then
    begin
      TRadioGroup(tpControl).Color := $00F7F7F7;
    end
    else if (tpControl is ClassName) and (tpControl is TDBAdvGrid) then
    begin
      TDBAdvGrid(tpControl).Look := glWin7;
    end
    else if (tpControl is ClassName) and (tpControl is TStringGrid) then
    begin
      TStringGrid(tpControl).Font.Color := clBlack
    end
    else if (tpControl is ClassName) and (tpControl is TAdvStringGrid) then   //
    begin
      TAdvStringGrid(tpControl).Look := glWin7;
    end
    else if (tpControl is ClassName) and (tpControl is TBaseGrid) then        //TAdvStringGrid  TObjStringGrid
    begin
      TAdvStringGrid(tpControl).Look := glWin7;
    end
    else if (tpControl is ClassName) and (tpControl is TCheckBox) then
    begin
      TCheckBox(tpControl).Color := $00F7F7F7;
    end
    else if (tpControl is ClassName) and (tpControl is TLabel) then
    begin
      TPanel(tpControl).Font.Color := clBlack
    end
    else if (tpControl is ClassName) and (tpControl is TPanel) then           //TShader
    begin
      //TPanel(tpControl).Color := $00ADA399;
      TPanel(tpControl).Font.Color := clblack;
      TPanel(tpControl).Font.Style := [fsBold];
    end
    else if (tpControl is ClassName) and (tpControl is TAdvPanel) then
    begin
      TAdvPanel(tpControl).Color := clWhite;
      TAdvPanel(tpControl).Font.Color := clWhite;
      TAdvPanel(tpControl).Font.Style := [fsBold];
    end
    else if (tpControl is ClassName) and (tpControl is TAdvOfficePager) then
    begin
//
    end
    else if (tpControl is ClassName) and (tpControl is TGroupBox) then
    begin
      TGroupBox(tpControl).Color := $00F7F7F7;
    end
    else if (tpControl is ClassName) and (tpControl is TFrame) then
    begin
      //
    end;

  end;


end;

procedure ClearControl(Sender: TWinControl; ClassName: TClass);
var
  I: Integer;

  tpControl: TControl;
begin
  for I := 0 to Sender.ControlCount-1 do
  begin
    tpControl := Sender.Controls[I];

//    Debug.Write(1,1,'tpControl.ClassName=' + IntToStr(I) + Sender.Controls[I].ClassName);

    if tpControl is TWinControl then
      ClearControl( TWinControl(tpControl), ClassName);
    if (tpControl is ClassName) and (tpControl is TEdit) then
      TEdit(tpControl).Clear
    else if (tpControl is ClassName) and (tpControl is TMaskEdit) then
      TMaskEdit(tpControl).Clear
    else if (tpControl is ClassName) and (tpControl is TAdvEdit) then
      TAdvEdit(tpControl).Clear
    else if (tpControl is ClassName) and (tpControl is TCurvyEdit) then
     TCurvyEdit(tpControl).SetFocus
    else if (tpControl is ClassName) and (tpControl is TMemo) then
      TMemo(tpControl).Clear

    else if (tpControl is ClassName) and (tpControl is TCustomComboBox) then
    begin
      if TComboBox(tpControl).Style = csDropDownList then
        if TComboBox(tpControl).Tag <= TComboBox(tpControl).Items.Count then
          TComboBox(tpControl).ItemIndex := TComboBox(tpControl).Tag
        else TComboBox(tpControl).ItemIndex := 0
      else TComboBox(tpControl).ItemIndex := -1;
      if Assigned(TComboBox(tpControl).OnChange) then
        TComboBox(tpControl).OnChange(TComboBox(tpControl));
    end
    else if (tpControl is ClassName) and (tpControl is TAdvComboBox) then
    begin
      if TAdvComboBox(tpControl).Style = csDropDownList then
        if TAdvComboBox(tpControl).Tag <= TAdvComboBox(tpControl).Items.Count then
          TAdvComboBox(tpControl).ItemIndex := TAdvComboBox(tpControl).Tag
        else TAdvComboBox(tpControl).ItemIndex := 0
      else TAdvComboBox(tpControl).ItemIndex := -1;
      if Assigned(TAdvComboBox(tpControl).OnChange) then
        TAdvComboBox(tpControl).OnChange(TAdvComboBox(tpControl));
    end
    else if (tpControl is ClassName) and (tpControl is TRadioGroup) then
    begin
      if TRadioGroup(tpControl).Tag <= TRadioGroup(tpControl).Items.Count then
        TRadioGroup(tpControl).ItemIndex := TRadioGroup(tpControl).Tag
    end
    else if (tpControl is ClassName) and (tpControl is TStringGrid) then
      ClearStringGrid(TStringGrid(tpControl), false)
    else if (tpControl is ClassName) and (tpControl is TCheckBox) then
    begin
      if TCheckBox(tpControl).Tag <= 1 then
        TCheckBox(tpControl).Checked := Boolean(TCheckBox(tpControl).Tag);
      if Assigned(TCheckBox(tpControl).OnClick) then
        TCheckBox(tpControl).OnClick(TCheckBox(tpControl));
    end
    else if (tpControl is ClassName) and (tpControl is TLabel) then
    begin
      if TLabel(tpControl).Tag = -5 then
        TLabel(tpControl).Caption := '';
    end;
{    else if (tpControl is ClassName) and (tpControl is TExtLabel) then
    begin
      if TExtLabel(tpControl).Tag = -5 then
      begin
        TExtLabel(tpControl).Code := '';
        TExtLabel(tpControl).Caption := '';
      end;
    end;
{}
  end;
end;

procedure ClearStringGrid(Sender: TStringGrid; ClearFixed: Boolean);
var
  I, J: Integer;
begin
  with Sender do
  begin
    if ClearFixed then
    begin
      for I := 0 to RowCount-1 do
        for J := 0 to ColCount-1 do
          Cells[ J, I] := '';
    end
    else
    begin
      for I := FixedRows to RowCount-1 do
        for J := FixedCols to ColCount-1 do
          Cells[ J, I] := '';
    end;
  end;
end;

procedure EnableControl(Sender: TWinControl; Flag: Boolean);
var
  I: Integer;
begin
  Sender.Enabled := true;
  for I := 0 to Sender.ControlCount-1 do
    if (Sender.Controls[I] is TControl) then
      TControl( Sender.Controls[I] ).Enabled := Flag;

  Sender.Enabled := Flag;
end;

procedure SetControlColor(Control:TControl; E:Boolean);
begin
  if Control is TEdit then
  begin
    TEdit(Control).Enabled := E;
    if TEdit(Control).Enabled then TEdit(Control).Color := clWhite
    else TEdit(Control).Color := clBtnFace;
    if not E then TEdit(Control).Clear;
  end;
{
  if Control is TAlignEdit then
  begin
    TAlignEdit(Control).Enabled := E;
    if TAlignEdit(Control).Enabled then TAlignEdit(Control).Color := clWhite
    else TAlignEdit(Control).Color := clBtnFace;
    if not E then TAlignEdit(Control).Clear;
  end;
{}
  if Control is TMaskEdit then
  begin
    TMaskEdit(Control).Enabled := E;
    if TMaskEdit(Control).Enabled then TMaskEdit(Control).Color := clWhite
    else TMaskEdit(Control).Color := clBtnFace;
    if Not E then TMaskEdit(Control).Clear;
  end;

  if Control is TLabel then
  begin
//    TLabel(Control).Enabled:=E;
//    if TLabel(Control).Enabled then TLabel(Control).Color:=clWhite
//    else TLabel(Control).Color:=clBtnFace;
    if not E then TLabel(Control).Caption:='';
  end;
  
  if Control is TComboBox then
  begin
    TComboBox(Control).Enabled:=E;
    if TComboBox(Control).Enabled then TComboBox(Control).Color:=clWhite
    else TComboBox(Control).Color:=clBtnFace;
    if Not E then TComboBox(Control).ItemIndex:=-1;
  end;
end;

procedure SetControlColor2(Control: TControl; Enable, DoClear: Boolean);
begin
  Control.Enabled := Enable;

  if Control is TEdit then
  begin
    if Enable then
      TEdit(Control).Color := clWhite
    else
      TEdit(Control).Color := clBtnFace;

    if (not Enable) and DoClear then
      TEdit(Control).Clear;
  end;
{
  if Control is TAlignEdit then
  begin
    if TAlignEdit(Control).Enabled then
      TAlignEdit(Control).Color := clWhite
    else
      TAlignEdit(Control).Color := clBtnFace;

    if (not Enable) and DoClear then
      TAlignEdit(Control).Clear;
  end;
{}
  if Control is TMaskEdit then
  begin
    if TMaskEdit(Control).Enabled then
      TMaskEdit(Control).Color := clWhite
    else
      TMaskEdit(Control).Color := clBtnFace;

    if (not Enable) and DoClear then
      TMaskEdit(Control).Clear;
  end;

  if Control is TLabel then
  begin
    if (not Enable) and DoClear then
      TLabel(Control).Caption := '';
  end;

  if Control is TComboBox then
  begin
    if TComboBox(Control).Enabled then
      TComboBox(Control).Color := clWhite
    else
      TComboBox(Control).Color := clBtnFace;

    if (not Enable) and DoClear then
      TComboBox(Control).ItemIndex := -1;
  end;
end;

procedure UserMouseWheelHandler(Sender: TObject; var Message: TMessage);
begin
  if Message.msg = WM_MOUSEWHEEL then begin
    if (Sender is TDBgrid) then begin
      if Message.wParam > 0 then begin
        keybd_event(VK_UP, VK_UP, 0, 0);
        keybd_event(VK_UP, VK_UP, 0, 0);
        keybd_event(VK_UP, VK_UP, 0, 0);
      end
      else if Message.wParam < 0 then begin
        keybd_event(VK_DOWN, VK_DOWN, 0, 0);
        keybd_event(VK_DOWN, VK_DOWN, 0, 0);
        keybd_event(VK_DOWN, VK_DOWN, 0, 0);
       end;
    end;
  end;
end;

procedure MemoScrollBar(AMemo: TMemo);
var
  nNowHeight: Integer;
  xSelStart: Integer;
begin
  with AMemo do
  begin
    xSelStart := SelStart;
    nNowHeight := Lines.Count*ABS(Font.Height)+4;
    if Height < nNowHeight then ScrollBars := ssVertical
    else ScrollBars := ssNone;
    SelStart := xSelStart;
  end;
end;

//=====================================================================================================


//=====================================================================================================
// Data를 Check하는 함수
//주민번호6자리를 8자리 날짜스트링으로 변환(2000문제 땜시)
function JuminToDate(Jumin: String): String;
begin
  Result := '';
  if Length(JUMIN) <> 13 then
    exit;

  Result := Copy(Jumin, 1, 6);
  if Jumin[7] in ['1','2','5','6'] then
    Result := '19' + Result
  else if Jumin[7] in ['3','4','7','8'] then
    Result := '20' + Result;
end;

// 주민번호에서 성별을 구하기[1,3: 남자 / 2,4:여자](2000문제 땜시)
function JuminToSex(Jumin: String): String;
begin
  Result := '';
  if Length(JUMIN) <> 13 then
    exit;

  if Jumin[7] in ['1','3','5','7'] then
    Result := '1'
  else if Jumin[7] in ['2','4','6','8'] then
    Result := '2';
end;

function JuminToSexMF(Jumin: String): String;
begin
  case StrToIntDef(JuminToSex(Jumin),0) of
  0: Result := '';
  1: Result := 'M';
  2: Result := 'F';
  end;
end;


function GetAgeSex(CurrentDate, Juid: String; var SEX:String; Flag: Boolean=True): Integer;
var
  yy,mm,dd: Word;
  iy, im,id: Word;
  age, wmm, wdd: Integer;
begin
   SEX := '';
   Result := 0;
   if Length(Juid) <> 13 then exit;

   if Juid[7] in ['1','3','5','7'] then SEX:= '남자';
   if Juid[7] in ['2','4','6','8'] then SEX:= '여자';
   try
     DecodeDate(DateStrToDate(CurrentDate), iy, im, id);
     DecodeDate(DateStrToDate(JuminToDate(Juid)), yy, mm, dd);
   except
     exit;
   end;

   age := iy - yy;
   wmm := im - mm;
   wdd := id - dd;

   if wmm < 0 then  dec(age)
   else
     if Flag and (wmm = 0) and (wdd < 0) then dec(age);
   Result := age;
end;

function GetAgeSex(CurrentDate, Juid: String; Flag: Boolean=True): Integer;
var
  yy,mm,dd: Word;
  iy, im,id: Word;
  age, wmm, wdd: Integer;
begin
   Result := 0;
   if Length(Juid) <> 13 then exit;

   try
     DecodeDate(DateStrToDate(CurrentDate), iy, im, id);
     DecodeDate(DateStrToDate(JuminToDate(Juid)), yy, mm, dd);
   except
     exit;
   end;

   age := iy - yy;
   wmm := im - mm;
   wdd := id - dd;

   if wmm < 0 then  dec(age)
   else
     if Flag and (wmm = 0) and (wdd < 0) then dec(age);
   Result := age;
end;

function GetAge(CurrentDate, BirthDate: String; Flag: Boolean=True): Integer;
var
  yy,mm,dd: Word;
  iy, im,id: Word;
  age, wmm, wdd: Integer;
begin
   Result := 0;
   if Length(BirthDate) <> 8 then exit;

   try
     DecodeDate(DateStrToDate(CurrentDate), iy, im, id);
     DecodeDate(DateStrToDate(BirthDate), yy, mm, dd);
   except
     exit;
   end;

   age := iy - yy;
   wmm := im - mm;
   wdd := id - dd;

   if wmm < 0 then  dec(age)
   else
     if Flag and (wmm = 0) and (wdd < 0) then dec(age);
   Result := age;
end;

function GetAgeSex_Insure(CurrentDate, Juid: String; var SEX:String): Integer;
var
  yy,mm,dd: Word;
  iy, im,id: Word;
  age, wmm, wdd: Integer;
begin
   SEX := '';
   Result := 0;
   if Length(Juid) <> 13 then exit;

   if Juid[7] in ['1','3','5','7'] then SEX:= '남자';
   if Juid[7] in ['2','4','6','8'] then SEX:= '여자';
   try
     DecodeDate(DateStrToDate(CurrentDate), iy, im, id);
     DecodeDate(DateStrToDate(JuminToDate(Juid)), yy, mm, dd);
   except
     exit;
   end;

   age := iy - yy;
   wmm := im - mm;
   wdd := id - dd;

   if age = 15 then
   begin
     if wmm < 0 then  dec(age)
     else
       if (wmm = 0) and (wdd < 0) then dec(age);
   end
   else
   begin
     if wmm > 6 then inc(age);
     if wmm < -6 then dec(age);
     if (wmm =6) and (wdd >=0) then inc(age);
     if (wmm= -6) and (wdd < 0) then dec(age);
   end;
   Result := age;
end;

function GetAgeSex_Insure(CurrentDate, Juid: String): Integer;
var
  yy,mm,dd: Word;
  iy, im,id: Word;
  age, wmm, wdd: Integer;
begin
   Result := 0;
   if Length(Juid) <> 13 then exit;

   try
     DecodeDate(DateStrToDate(CurrentDate), iy, im, id);
     DecodeDate(DateStrToDate(JuminToDate(Juid)), yy, mm, dd);
   except
     exit;
   end;

   age := iy - yy;
   wmm := im - mm;
   wdd := id - dd;

   if age = 15 then
   begin
     if wmm < 0 then  dec(age)
     else
       if (wmm = 0) and (wdd < 0) then dec(age);
   end
   else
   begin
     if wmm > 6 then inc(age);
     if wmm < -6 then dec(age);
     if (wmm =6) and (wdd >=0) then inc(age);
     if (wmm= -6) and (wdd < 0) then dec(age);
   end;
   Result := age;
end;

function GetAge_Insure(CurrentDate, BirthDate: String): Integer;
var
  yy,mm,dd: Word;
  iy, im,id: Word;
  age, wmm, wdd: Integer;
begin
   Result := 0;
   if Length(BirthDate) <> 8 then exit;

   try
     DecodeDate(DateStrToDate(CurrentDate), iy, im, id);
     DecodeDate(DateStrToDate(BirthDate), yy, mm, dd);
   except
     exit;
   end;

   age := iy - yy;
   wmm := im - mm;
   wdd := id - dd;

   if age = 15 then
   begin
     if wmm < 0 then  dec(age)
     else
       if (wmm = 0) and (wdd < 0) then dec(age);
   end
   else
   begin
     if wmm > 6 then inc(age);
     if wmm < -6 then dec(age);
     if (wmm =6) and (wdd >=0) then inc(age);
     if (wmm= -6) and (wdd < 0) then dec(age);
   end;
   Result := age;
end;

//=====================================================================================================


{ 일반적인 함수 }
//=====================================================================================================
function IMax(A, B: Integer): Integer;
begin
  Result := A;
  if A < B then
    Result := B;
end;

function IMin(A, B: Integer): Integer;
begin
  Result := A;
  if A > B then
    Result := B;
end;

function FMax(A, B: Double): Double;
begin
  Result := A;
  if A < B then
    Result := B;
end;

function FMin(A, B: Double): Double;
begin
  Result := A;
  if A > B then
    Result := B;
end;


//=====================================================================================================


{ Data를 Check하는 함수 }
//=====================================================================================================
function CheckJumin(No:String; Flag: Boolean=False) : Boolean;
var
  i, Sum, Rest: Integer;
const
  weight_kr : packed array [1..12] of Integer =
          ( 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 );
  weight_fg : packed array [1..12] of Integer =
          ( 9, 8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6 );
begin
  Result := False;

  if Length(No) <> 13 then Exit;

  if CheckYMD(JuminToDate(No)) = false then Exit;
  if not(No[7] in ['1'..'8']) then Exit;
//  Flag := not (No[7] in ['5'..'8']);
  if Flag and (No[7] in ['1'..'4']) then
  begin
    try
      Sum:= 0;
      for i := 1 to  12 do
        Sum:= Sum + StrToInt(No[i]) * Weight_kr[i];
      Rest:= 11-(Sum mod 11);
      if Rest = 11 then Rest:= 1;
      if Rest = 10 then Rest:= 0;
      Result := Char(Rest+48) = No[13];
    except
      Result := False;
      Exit;
    end;
  end
{
  else  if Flag and (No[7] in ['5'..'8']) then
  begin
    try
      Sum:= 0;
      for i := 1 to  12 do
        Sum:= Sum + StrToInt(No[i]) * Weight_fg[i];
      Rest:= ((Sum mod 11) + 2) mod 10;
      if (No[12] in ['7'..'9']) then
      begin
        Result := Char(Rest+48) = No[13];
      end
      else Result := False;
    except
      Result := False;
      Exit;
    end;
  end
{}
  else Result := True;
end;

// 사업자번호가 맞는 형식인지 Check한다.
function CheckBussiness(No:String) : Boolean;
var
   iMN,i,iNum : Integer;
   sTemp : Array[1..10] of String;
begin
  if Length(No) = 10 then
  begin
    for i:=1 To Length(No) do
    begin //각각의 값을 배열에 저장
      sTemp[i]:=Copy(No, i, 1);
    end;
    iMN:=((StrToInt(sTemp[9])*5) div 10)
       +((StrToInt(sTemp[9])*5) mod 10)
         +StrToInt(sTemp[1])
         +StrToInt(sTemp[4])
         +StrToInt(sTemp[7])     //
        +(StrToInt(sTemp[2])
         +StrToInt(sTemp[5])
         +StrToInt(sTemp[8]))*3  //
        +(StrToInt(sTemp[3])
         +StrToInt(sTemp[6]))*7;
    iNum:=iMN mod 10;
    if StrToInt(sTemp[10])=((10 - iNum) mod 10) then
    begin //맞으면
      Result:=True;
      Exit;
    end
    else
    begin
      Result:=False;
      Exit;
    end;
  end
  else
  begin
    Result:=False;
  end;
end;

function CheckNumeric(Num:String) :Boolean;
var
  i : Integer;
begin
  for i:=1 to length(Num) do
  begin
    if not (Num[i] in ['0'..'9']) then
    begin
      Result := false;
      exit;
    end;
  end;
  Result := True;
end;

function CheckAlphaNumeric(Source: String): Boolean;
var
  i : Integer;
begin
  for i := 1 to Length(Source) do
  begin
    if not (Source[i] in ['a'..'z', 'A'..'Z', '0'..'9']) then
    begin
      Result := false;
      exit;
    end;
  end;
  Result := True;
end;

function HasOnlyBlank(Str: String): Boolean;  // String변수가 공백으로만 이루어졌는지 판단하는 함수
//var
//  I: Integer;
begin
  Result := Trim(Str) = '';
{  Result := false;
  for I := 1 to Length(Str) do
  begin
    if Str[I] <> ' ' then
      exit;
  end;
  Result := true;
}
end;

// 값이 음수,0,양수인지 체크한다.
function Sign(Int : Extended) : Integer;
begin
  if Int > 0 then
    Result :=  1
  else if Int < 0 then
    Result := -1
  else
    Result :=  0;
end;

function CheckNameRule(Str: WideString): Boolean;
var
  I: Integer;
begin
  for I := 1 to Length(Str) do
  begin
    Result := (Length(Format('%.2x',[Ord(Str[I])]))=4) or (char(Str[I]) in [' ','a'..'z','A'..'Z']);
    if not Result then Exit;
  end;
  Result := (Str = Trim(Str));
end;

//=====================================================================================================


{ 변환함수 }
//=====================================================================================================
function StrToNull(Source: String): String;
begin
  Result := Source;
  if Source = '' then
    Result := 'null';
end;

function StrToFloatDef(const S: string; Default: Extended): Extended;
begin
  try
    Result := StrToFloat(S);
  except
    Result := Default;
  end;
end;

//=====================================================================================================


{ 스트링변수 관련함수 }
//=====================================================================================================
function ExtractNumeric(Str : String): String;
var i:byte;
begin
  Result:='';
  for i:=1 to Length(Str) do
    if Str[i] in ['0'..'9'] then Result := Result + Str[i];
end;

function ExtractFloat(Str : String): String;
var i:byte;
begin
  Result:='';

  if Str = '' then exit;

  if Str[1] = '-' then
    Result := Result + '-';

  for i := 1 to Length(Str) do
    if Str[i] in ['0'..'9'] then
      Result := Result + Str[i]
    else if Str[i] = '.' then
    begin
      if Pos( '.', Result) > 0 then
      begin
        Result := '0';
        exit;
      end;
      Result := Result + Str[i];
    end;
end;

// String에서 숫자를 가져와서 Numeric숫자형식의 String으로 Return. ("2,351 원" -> "2,351")
function StrToNumericStr(Str: String) : String;
begin
  Result := FormatFloat('#,##0', StrToFloatDef(ExtractNumeric(Str), 0));
end;

// String에서 숫자를 가져와서 Float숫자형식의 String으로 Return. ("2,351 원" -> "2,351")
function StrToFloatStr(Str: String) : String;
begin
  Result := FormatFloat('#,##0', StrToFloatDef(ExtractFloat(Str), 0));
end;


function TrimMb(Value: String): String;
var
  i: Integer;
  sTemp, Str_Buf: String;
begin
  sTemp := Value;

  for i:= 1 to Length(STemp) - 1 do
  begin
    Str_Buf := copy(STemp,i,2);
    if (Str_Buf = '　') and (ByteType(sTemp, i) = mbLeadByte) then
    begin
      Delete( sTemp, I, 2);
      Insert( '  ', sTemp, I);
    end;
  end;

  Result := Trim(sTemp);
end;

function DeleteString(const Source, DString: String): String;
var
  RString: String;
  OffSet: Integer;
begin
  RString := Source;
  repeat
    OffSet := Pos( DString, RString);
    if OffSet > 0 then
      Delete( RString, OffSet, Length(DString));
  until OffSet = 0;

  Result := RString;
end;

function DeleteSpace(DestStr : String) : String;
begin
  Result := DeleteString(DestStr, ' ');
  Result := DeleteString(Result, '　');
end;

function DeleteChar(DestStr : String; Ch : Char) : String;
begin
  while Pos(Ch,DestStr) <> 0 do
    Delete(DestStr,Pos(Ch,DestStr),1);
  Result := DestStr;
end;

function DeleteChars(Src: String; CharSet: TCharSet): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Src) do
  begin
    if not (Src[I] in CharSet) then
      Result := Result + Src[I];
  end;
end;


function FillChar_MS(Length : Integer; Ch : Char) : String;
var
  s: String;
  i : Integer;
begin
  s :='';
  for i := 1 to Length do
    s := s + ch;
  Result := s;
end;

function FillCharAligned(Str : String;Len : word;ch : Char;LeftAlign :Boolean) : String;
var i : word;
begin
  Result := Str;
//  if (Len - Length(Str) >0) and (Str<>'') then
  if (Len - Length(AnsiString(Str)) >0) then
    case LeftAlign of
      true : for i:=1 to (Len - Length(AnsiString(Str))) do
               Result := Result + Ch;
     False : for i:=1 to (Len - Length(AnsiString(Str))) do
               Result := Ch + Result;
    end;
end;

function GetMax(Source: TStrings): Double;
var
  I: Integer;
  J: Integer;
  Stop: Boolean;
begin
  Result := 0;

  Stop := false;
  J := 0;
  while not Stop do
  begin
    try
      Stop := J >= Source.Count;
      Result := StrToFloat(Source[J]);
      Stop := true;
    except
      Inc(J);
    end;
  end;

  for I := J to Source.Count-1 do
  begin
    try
      if Result < StrToFloat(Source[I]) then
        Result := StrToFloat(Source[I]);
    except
      ;
    end;
  end;
end;

function GetMin(Source: TStrings): Double;
var
  I: Integer;
  J: Integer;
  Stop: Boolean;
begin
  Result := 0;

  Stop := false;
  J := 0;
  while not Stop do
  begin
    try
      Stop := J >= Source.Count;
      Result := StrToFloat(Source[J]);
      Stop := true;
    except
      Inc(J);
    end;
  end;

  for I := J to Source.Count-1 do
  begin
    try
      if Result > StrToFloat(Source[I]) then
        Result := StrToFloat(Source[I]);
    except
      ;
    end;
  end;
end;

function Get_SP_ParseCsvStr(str_Data: string; str_CvsChar: Char; int_index : integer):string;
var s_Temp : TStringList;
begin
  Result := '';
  s_Temp := TStringList.Create;
  try
    s_Temp.Delimiter     := str_CvsChar;
    s_Temp.DelimitedText := str_Data;
    Result := s_Temp[int_index];
  finally
    s_Temp.Free;
  end;
end;

{
function BoolToInt(Bool : Boolean) : Byte;
begin
  Result := Ord(Bool);
end;

function BoolToChar(Bool : Boolean) : Char;
begin
  Result := IntToStr(Ord(Bool))[1];
end;

function BoolToYNChar(Bool: Boolean): Char;
begin
  if Bool then
    Result := 'Y'
  else
    Result := 'N';
end;

function IntToBool(Int : Integer) : Boolean;
begin
  Result := Int <> 0;
end;
}
function BoolToInt(Bool : Boolean) : Byte;
begin
  Result := Ord(Bool);
end;

function BoolToChar(Bool : Boolean) : Char;
begin
  Result := IntToStr(Ord(Bool))[1];
end;

function BoolToYNChar(Bool : Boolean) : Char;
begin
  Result := 'N';
  if Bool then Result := 'Y';
end;

function BoolToTFChar(Bool : Boolean) : Char;
begin
  Result := 'F';
  if Bool then Result := 'T';
end;

function BoolToOXChar(Bool : Boolean) : Char;
begin
  Result := 'X';
  if Bool then Result := 'O';
end;

function IntToBool(Int : Integer) : Boolean;
begin
  Result := Int <> 0;
end;

function CharToBool(Ch : Char) : Boolean;
begin
  Result := Ch = '1';
end;

function YNCharToBool(Ch : Char) : Boolean;
begin
  Result := Ch = 'Y';
end;

function TFCharToBool(Ch : Char) : Boolean;
begin
  Result := Ch = 'T';
end;

function OXCharToBool(Ch : Char) : Boolean;
begin
  Result := Ch = 'O';
end;

function StrToBool(Str : String; Idx: Integer=1) : Boolean;
begin
  if Str = '' then Result := False
  else Result := CharToBool(Str[Idx]);
end;

function YNStrToBool(Str : String; Idx: Integer=1) : Boolean;
begin
  if Str = '' then Result := False
  else Result := YNCharToBool(Str[Idx]);
end;

function TFStrToBool(Str : String; Idx: Integer=1) : Boolean;
begin
  if Str = '' then Result := False
  else Result := TFCharToBool(Str[Idx]);
end;

function OXStrToBool(Str : String; Idx: Integer=1) : Boolean;
begin
  if Str = '' then Result := False
  else Result := OXCharToBool(Str[Idx]);
end;

function EncodeTEL_NO(TEL_NO:String;IncludeBracket:Boolean) : String;
  function StrAligned(Str : String;LeftAlign : Boolean) : String;
  begin
    Result := FillCharAligned(DeleteChar(Str,' '),Length(Str),' ',LeftAlign);
  end;
var A,B,C : String;
begin
  IncludeBracket := IncludeBracket and (TEL_NO<>'');

  A := StrAligned(Copy(TEL_NO,1,4),False);
  B := StrAligned(Copy(TEL_NO,5,4),False);
  C := StrAligned(Copy(TEL_NO,9,4),False);
  if IncludeBracket then Result := '('+A+')'+B+'-'+C
  else Result := A+B+C;
end;
                               
function EncodeTEL_NO123(TEL_NO1,TEL_NO2,TEL_NO3:String;IncludeBracket:Boolean) : String;
begin
  IncludeBracket := IncludeBracket and ((TEL_NO1<>'') and (TEL_NO2<>'') and (TEL_NO3<>''));
  TEL_NO1 := FillCharAligned(DeleteChar(TEL_NO1,' '),Length(TEL_NO1),' ',True);
  TEL_NO2 := FillCharAligned(DeleteChar(TEL_NO2,' '),Length(TEL_NO2),' ',True);
  TEL_NO3 := FillCharAligned(DeleteChar(TEL_NO3,' '),Length(TEL_NO3),' ',True);
  if IncludeBracket then Result := '('+TEL_NO1+')'+TEL_NO2+'-'+TEL_NO3
  else Result := TEL_NO1+TEL_NO2+TEL_NO3;
end;



(****** Query문을 작성할때앞뒤에 따옴표를 더해준다 .****)
function Quotes(S:String):String;
begin
//  Result := ''''+S+'''';
  Result := QuotedStr(S);
end;

(****** 스트링에서 서브스트링을 변경***)
function ReplaceStrF(SrcStr: String; SubStr,ToStr:String) : string;
begin
  Result := ReplaceStr(SrcStr, SubStr, ToStr);
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

function ReplaceStrOne(var SrcStr: String; SubStr,ToStr:String) : string;
var i, r: Integer;
    Re : string;
begin
  Re := '';
  r := 0;
  while true do
  begin
    i:= Pos(SubStr,Copy(SrcStr, r+1, Length(SrcStr)-r));
    if (i = 0) then break;
    System.Delete(SrcStr,i+r,Length(SubStr));
    System.Insert(ToStr,SrcStr,i+r);
    if Length(SubStr) > Length(ToStr) then
      r := r + i + Length(ToStr) -1
    else
      r := r + i + Length(SubStr)-1;
  end;
  Re := Re + SrcStr;
  Result := re;
end;

function Get_FN_TIME_FORMAT(sStr: string) : string;
begin
  Result := '';
  if length(sStr) = 6 then
    Result := Copy(sStr,1,2) + ':' + Copy(sStr,3,2) + ':' + Copy(sStr,5,2)
  else
    Result := '';
end;

function Get_FN_DATE_FORMAT(sStr: string) : string;
begin
  Result := '';
  if length(sStr) = 8 then
    Result := Copy(sStr,1,4) + '-' +  Copy(sStr,5,2) + '-' + Copy(sStr,7,2)
  else
    Result := '';
end;

function Get_FN_PHONE_FORMAT(sMASKYN, sStr: string) : string;
var s_PHONENUBER:String;
begin
  Result := '';
  s_PHONENUBER := Trim(sStr);

  s_PHONENUBER := StringReplace(s_PHONENUBER,'-','',[rfReplaceAll]);
  s_PHONENUBER := StringReplace(s_PHONENUBER,'.','',[rfReplaceAll]);
  s_PHONENUBER := StringReplace(s_PHONENUBER,' ','',[rfReplaceAll]);
  s_PHONENUBER := StringReplace(s_PHONENUBER,'(','',[rfReplaceAll]);
  s_PHONENUBER := StringReplace(s_PHONENUBER,')','',[rfReplaceAll]);
  s_PHONENUBER := StringReplace(s_PHONENUBER,'/','',[rfReplaceAll]);
  s_PHONENUBER := StringReplace(s_PHONENUBER,'*','',[rfReplaceAll]);

  if length(s_PHONENUBER) <= 6 then
    Result := s_PHONENUBER
  else if length(s_PHONENUBER) <= 7 then
    if UpperCase(sMASKYN) = 'Y' then
      Result := Copy(s_PHONENUBER,1,3) + '-****'
    else
      Result := Copy(s_PHONENUBER,1,3) + '-' +  Copy(s_PHONENUBER,4,4)
  else if length(s_PHONENUBER) <= 8 then
    if UpperCase(sMASKYN) = 'Y' then
      Result := Copy(s_PHONENUBER,1,4) + '-****'
    else
      Result := Copy(s_PHONENUBER,1,4) + '-' +  Copy(s_PHONENUBER,5,4)
  else if length(s_PHONENUBER) <= 9 then
    if UpperCase(sMASKYN) = 'Y' then
      Result := Copy(s_PHONENUBER,1,2) + '-****-' +  Copy(s_PHONENUBER,6,4)
    else
      Result := Copy(s_PHONENUBER,1,2) + '-' +  Copy(s_PHONENUBER,3,3) + '-' +  Copy(s_PHONENUBER,6,4)
  else if length(s_PHONENUBER) <= 10 then
    if UpperCase(sMASKYN) = 'Y' then
      if Copy(s_PHONENUBER,1,2) = '02' then
        Result := Copy(s_PHONENUBER,1,2) + '-****-' +  Copy(s_PHONENUBER,7,4)
      else
        Result := Copy(s_PHONENUBER,1,2) + '-****-' +  Copy(s_PHONENUBER,7,4)
    else
      if Copy(s_PHONENUBER,1,2) = '02' then
        Result := Copy(s_PHONENUBER,1,2) + '-' +  Copy(s_PHONENUBER,3,4) + '-' +  Copy(s_PHONENUBER,7,4)
      else
        Result := Copy(s_PHONENUBER,1,2) + '-' +  Copy(s_PHONENUBER,3,4) + '-' +  Copy(s_PHONENUBER,7,4)
  else if length(s_PHONENUBER) <= 11 then
    if UpperCase(sMASKYN) = 'Y' then
      Result := Copy(s_PHONENUBER,1,3) + '-****-' +  Copy(s_PHONENUBER,8,4)
    else
      Result := Copy(s_PHONENUBER,1,3) + '-' +  Copy(s_PHONENUBER,4,4) + '-' +  Copy(s_PHONENUBER,8,4)
  else
    Result := s_PHONENUBER;

end;

function Get_FN_ssTOhhnnss(iSecond: integer) : string;
var r, r1, r2 : integer;
begin
  r  := iSecond;
  r1 := Trunc(r / 60); //분
  r2 := Trunc(r1 / 60); //시
  r  := r - (r1 * 60);
  r1 := r1 - (r2 * 60);
  Result := format('%.2d',[r2]) + ':' + format('%.2d',[r1])  + ':' + format('%.2d',[r]);
end;

function Get_FN_RATIO(f_Number1, f_Number2:Double; f_Number3: integer) : Double;
var f_Value : Double;
begin
  Result := 0.0;

  if f_Number1 = 0 then
    Result := 0.0;

  if f_Number2 = 0 then
    Result := 0.0;

  if (f_Number1 <> 0.0) and (f_Number2 <> 0.0) then
  begin
    f_Value := (f_Number1 *1.0) / f_Number2 * 100;
    Result  := RoundTo(f_Value, f_Number3);
  end;

end;
function Get_FN_DIVISION(f_Number1, f_Number2:Double; f_Number3: integer) : Double;
var f_Value : Double;
begin
  Result := 0.0;

  if f_Number1 = 0 then
    Result := 0.0;

  if f_Number2 = 0 then
    Result := 0.0;

  if (f_Number1 <> 0.0) and (f_Number2 <> 0.0) then
  begin
    f_Value := (f_Number1 *1.0) / f_Number2;
    Result  := RoundTo(f_Value, f_Number3);
  end;

end;


//=====================================================================================================
(* 그리드상에서의 정렬을 편하게***)
procedure SetAlign(Align : TAlignment; Canvas : TCanvas; Rect : TRect; Data : String);
var
  old_Align : word;
begin
  case Align of
    taLeftJustify :
      begin;
        Canvas.TextRect(Rect,Rect.Left+2,
                             Rect.Top+(Rect.Bottom-Rect.Top-Canvas.TextHeight(Data)) div 2,Data);
      end;
    taRightJustify :
      begin
        Canvas.TextRect(Rect,Rect.Right-Canvas.TextWidth(Data)-2,
                             Rect.Top+(Rect.Bottom-Rect.Top-Canvas.TextHeight(Data)) div 2,Data);
      end;
    taCenter :
      begin
        Old_Align := SetTextAlign( Canvas.Handle, TA_CENTER );
        Canvas.FillRect(Rect);
        ExtTextOut( Canvas.Handle, Rect.Left+(Rect.Right-Rect.Left) div 2,
                    Rect.Top+(Rect.Bottom-Rect.Top-Canvas.TextHeight(Data)) div 2, ETO_CLIPPED or
                    ETO_OPAQUE, @Rect, PChar(Data), Length(Data), nil);
        SetTextAlign(Canvas.Handle, Old_Align);
      end;
  end;
end;

function StrPlusJUMINFormat(JUMIN: String): String;
begin
  Result := Copy(JUMIN,1,6) + '-' + Copy(JUMIN,7,7);
end;

function StrPlusZIPCODEFormat(ZIPCODE: String): String;
begin
  Result := Copy(ZIPCODE,1,3) + '-' + Copy(ZIPCODE,4,3);
end;

function StrPlusCOMPIDFormat(s_stock: String): String;
begin
  Result := Copy(s_stock,1,3) + '-' + Copy(s_stock,4,2) + '-'
            + Copy(s_stock,6,5);
end;

function FormatJUMIN(const Str: String): String;
begin
  Result := FillCharAligned(Copy(Str, 1, 6) + '-' + Copy(Str, 7, 7), 14, ' ', True);
end;

function FormatZIPCODE(const Str: String): String;
begin
//  Result := FillCharAligned(Copy(Str, 1, 3) + '-' + Copy(Str, 4, 3), 7, ' ', True);
  Result := '';
  if Trim(Str) ='' then exit;

  Result := FillCharAligned(Copy(Str, 1, 3), 3, ' ', True) + '-' +
            FillCharAligned(Copy(Str, 4, 3), 3, ' ', True);
end;

{$IFDEF CDSUTIL}
procedure TitleClick_Sort(SCDataSet : TClientDataSet; SDBGrid: TDBGrid; Column: TColumn; var Asc: Boolean);
begin
  Asc := not(Asc);
  cdsSort(SCDataSet, Column, Asc);
end;

procedure TitleClick_Sort(SCDataSet : TClientDataSet; SDBGrid: TDBGrid; Column: TColumn; Field_Sort: String; var Asc: Boolean);
begin
  Asc := not(Asc);
  cdsSort(SCDataSet, Column, Field_Sort, Asc);
end;
{$ENDIF}

procedure Clear_Index(SCDataSet: TClientDataSet);
begin
{$IFDEF CDSUTIL}
  cdsClearIndex(SCDataSet);
{$ENDIF}
end;
//

function RoundAt(X: Extended; Pos: Integer): Extended;
var
  Buffer: Extended;
  I: Integer;
  Str_Buff, Int_Str_Buff: String;
  J: Integer;
begin
  Result := X;

  if Pos = 0 then
    Exit;

  if Pos < 0 then
    Pos := Pos + 1;

  I := Sign(X);
  Buffer := Abs(X);
  Buffer := Buffer / Power( 10, Pos);
  Buffer := Buffer + 0.5;
//  Buffer := Int(Buffer);
  Str_Buff := FloatToStr(Buffer);
  Int_Str_Buff := '';
  for J := 1 to Length(Str_Buff) do
  begin
    if Str_Buff[J] = '.' then
      Break;
    Int_Str_Buff := Int_Str_Buff + Str_Buff[J];
  end;
  Buffer := StrToFloat(Int_Str_Buff);
  Buffer := Buffer * Power( 10, Pos) * I;

  Result := Buffer;
end;

function TruncAt(X: Extended; Pos: Integer): Extended;
var
  Buffer: Extended;
  I: Integer;
  Str_Buff, Int_Str_Buff: String;
  J: Integer;
begin
  Result := X;

  if Pos = 0 then
    Exit;

  if Pos < 0 then
    Pos := Pos + 1;

  I := Sign(X);
  Buffer := Abs(X);
  Buffer := Buffer / Power( 10, Pos);
  Buffer := Int(Buffer);
  Str_Buff := FloatToStr(Buffer);
  Int_Str_Buff := '';
  for J := 1 to Length(Str_Buff) do
  begin
    if Str_Buff[J] = '.' then
      Break;
    Int_Str_Buff := Int_Str_Buff + Str_Buff[J];
  end;
  Buffer := StrToFloat(Int_Str_Buff);
  Buffer := Buffer * Power( 10, Pos) * I;

  Result := Buffer;
end;

function ZeroToNull(Source: Integer): String;
begin
  if Source = 0 then
    Result := ''
  else
    Result := IntToStr(Source);
end;

function FloatZeroToNull(Source: Extended): String;
begin
  if Source = 0 then
    Result := ''
  else
    Result := FloatToStr(Source);
end;

procedure QueryToCDS(Query: TQuery; CDS: TClientDataSet);
begin
  Clear_Index(CDS);

  if CDS.Active then CDS.Close;

  with TProvider.Create(nil) do
  begin
    try
      DataSet := Query;
      CDS.Data := Data;
    finally
      Free;
    end;
  end;
end;

procedure UniQueryToCDS(Query: TUniQuery; CDS: TClientDataSet);
begin
  Clear_Index(CDS);

  if CDS.Active then CDS.Close;

  with TProvider.Create(nil) do
  begin
    try
      DataSet := Query;
      CDS.Data := Data;
    finally
      Free;
    end;
  end;
end;

{$IFDEF CDSUTIL}
{
procedure QueryToSumCDS(Query: TQuery; CDS: TClientDataSet; DisplayFields, GroupFields, SumFields, Expressions: String; WithAvg: Boolean = False;
  SumDisplay: String = ''; AvgDisplay: String = ''; CallBack: TNotifyEvent = nil);
var
  Param: TSummarizeParam;
begin
  cdsCopyFrom(CDS, Query);
  Param.GroupFields := GroupFields; //그릅핑 필드
  Param.SummaryFields := SumFields; //합계처리할 필드
  Param.Expressions := Expressions; // 계산식 필드
  Param.DisplayFields := DisplayFields; // 디폴트값 필드
  Param.ShowSum := True;
  Param.ShowAverage := WithAvg;
  Param.SumText := SumDisplay;
  Param.AvgText := AvgDisplay;
  Param.CallBack := CallBack;

  cdsSummarize( CDS , Param );
end;

procedure ADOQueryToSumCDS(Query: TADOQuery; CDS: TClientDataSet; DisplayFields, GroupFields, SumFields, Expressions: String; WithAvg: Boolean = False;
  SumDisplay: String = ''; AvgDisplay: String = ''; CallBack: TNotifyEvent = nil);
var
  Param: TSummarizeParam;
begin
  cdsCopyFrom(CDS, Query);
  Param.GroupFields := GroupFields; //그릅핑 필드
  Param.SummaryFields := SumFields; //합계처리할 필드
  Param.Expressions := Expressions; // 계산식 필드
  Param.DisplayFields := DisplayFields; // 디폴트값 필드
  Param.ShowSum := True;
  Param.ShowAverage := WithAvg;
  Param.SumText := SumDisplay;
  Param.AvgText := AvgDisplay;
  Param.CallBack := CallBack;

  cdsSummarize( CDS , Param );
end;

procedure UniQueryToSumCDS(Query: TUniQuery; CDS: TClientDataSet; DisplayFields, GroupFields, SumFields, Expressions: String; WithAvg: Boolean = False;
  SumDisplay: String = ''; AvgDisplay: String = ''; CallBack: TNotifyEvent = nil);
var
  Param: TSummarizeParam;
begin
  cdsCopyFrom(CDS, Query);
  Param.GroupFields := GroupFields; //그릅핑 필드
  Param.SummaryFields := SumFields; //합계처리할 필드
  Param.Expressions := Expressions; // 계산식 필드
  Param.DisplayFields := DisplayFields; // 디폴트값 필드
  Param.ShowSum := True;
  Param.ShowAverage := WithAvg;
  Param.SumText := SumDisplay;
  Param.AvgText := AvgDisplay;
  Param.CallBack := CallBack;

  cdsSummarize( CDS , Param );
end;

{}
procedure sumcdsGroupFilter( CDS: TClientDataSet; GroupFields: String; ShowData: Boolean );
begin
  cdsGroupFilter( CDS , GroupFields, ShowData );
end;
{$ENDIF}


function QueryToData(Query: TQuery):OleVariant;
begin
  with TProvider.Create(nil) do
  begin
    try
      DataSet := Query;
      Result := Data;
    finally
      Free;
    end;
  end;
end;

procedure ADOQueryToCDS(Query: TADOQuery; CDS: TClientDataSet);
begin
  Clear_Index(CDS);

  if CDS.Active then CDS.Close;

  with TProvider.Create(nil) do
  begin
    try
      Debug.Write(1,1,'ADOQueryToCDS 1');
      DataSet := Query;
      Debug.Write(1,1,'ADOQueryToCDS 2');
      CDS.Data := Data;
      Debug.Write(1,1,'ADOQueryToCDS 3');
    finally
      Free;
    end;
  end;
end;

function IsNull(Form : TForm; Sender:TObject; Msg : String; ViewMsg : Boolean) : Boolean;
begin
  Result:=False;
  if not TWinControl(Sender).CanFocus then exit;

  if Sender is TEdit then
    if TEdit(Sender).Text='' then Result:=True;
//  if Sender is TAlignEdit then
//    if TAlignEdit(Sender).Text='' then Result:=True;
  if Sender is TMaskEdit then
    if TMaskEdit(Sender).Text='' then Result:=True;
  if Sender is TComboBox then
    if TComboBox(Sender).ItemIndex=-1 then Result:=True;
  if not Result then exit;

  if ViewMsg then
    Application.MessageBox(PChar(Msg), 'Warning', MB_Ok + MB_IconWarning);

  if TWinControl(Sender).CanFocus then Form.ActiveControl := TWinControl(Sender);
end;

function ForceMsg(Form : TForm; Sender:TObject; Msg : String; ViewMsg : Boolean) : Boolean;
begin
  Result := ViewMsg;
//  if not TWinControl(Sender).CanFocus then exit;

  if ViewMsg then
    Application.MessageBox(PChar(Msg), PChar(TForm(Form).Name), mb_OK);
//    ShowMessage(Msg);
  if TWinControl(Sender).CanFocus then
    TForm(Form).ActiveControl := TWinControl(Sender);
end;

{현재 한글/영문 상태}
function GetHangeulMode(Sender: TForm): Boolean;
var
  tMode : HIMC;
  Conversion, Sentence: DWORD;
begin
  tMode := ImmGetContext(Sender.Handle);
  ImmGetConversionStatus(tMode, Conversion, Sentence);
  if Conversion = IME_CMODE_HANGEUL then
    GetHangeulMode := True
  else
    GetHangeulMode := False;
end;

//한글,영문모드로 변경해준다.
procedure SetHangeulMode(Sender: TForm; SetHangeul: Boolean);
var
  tMode : HIMC;
begin
  tMode := ImmGetContext(Sender.Handle);
  if SetHangeul then  // 한글모드로
    ImmSetConversionStatus(tMode, IME_CMODE_HANGEUL,
                                  IME_CMODE_HANGEUL)
  else                // 영문모드로
    ImmSetConversionStatus(tMode, IME_CMODE_ALPHANUMERIC,
                                  IME_CMODE_ALPHANUMERIC);
end;

//메세지를 쉽게 DisPlay
function MsgDisplay(Msg:String; Flag:Integer):Integer;
Const
  MsgStr_Arr : Array [1..4] of String=('Error','Question','Warning','Information');
begin
  while Pos('|', Msg) > 0 do Msg[Pos('|', Msg)] := #13;
  Result := Application.MessageBox(PChar(Msg),PChar(MsgStr_Arr[(Flag div 10)]),StrToInt('$'+IntToStr(Flag)));
end;

//Edit Check한다. 정상값이면 True,  sTemp1:첫줄메세지 ,sTemp2:두번째메세지, Flag는 왜 쓰는지???
function IsEditCheck(TempEdit:TEdit;sTemp1,sTemp2:String;Flag:Integer):Boolean;
begin
  if Flag in [1,2] then
  begin
    if TempEdit.Text ='' then
    begin
      if Flag =1 then MsgDisplay(sTemp1+'||'+sTemp2+'를 입력하시오.',WARNING_OK )
      else MsgDisplay(sTemp1+'||'+sTemp2+'을 입력하시오.',WARNING_OK );
      TempEdit.SetFocus;
      Result := False;
    end
    else Result := True;
  end
  else
  begin
    try
       StrToFloat(TempEdit.Text);
       Result := True;
    except
      if Flag =3 then MsgDisplay(sTemp1+'||숫자값만 입력이 가능합니다.|'+sTemp2+'를 입력하시오.',WARNING_OK )
      else MsgDisplay(sTemp1+'||숫자값만 입력이 가능합니다.|'+sTemp2+'을 입력하시오.',WARNING_OK );
      TempEdit.SetFocus;
      Result := False;
    end;
  end;
end;

//MaskEdit Check한다. 정상값이면 True,  sTemp1:첫줄메세지 ,sTemp2:두번째메세지, Flag는 왜 쓰는지???
function IsMEditCheck(TempEdit:TMaskEdit;sTemp1,sTemp2:String;Flag:Integer):Boolean;
begin
  if Flag in [1,2] then
  begin
    if TempEdit.Text ='' then
    begin
      if Flag =1 then MsgDisplay(sTemp1+'||'+sTemp2+'를 입력하시오.',WARNING_OK )
      else MsgDisplay(sTemp1+'||'+sTemp2+'을 입력하시오.',WARNING_OK );
      TempEdit.SetFocus;
      Result := False;
    end
    else Result := True;
  end
  else
  begin
    try
       StrToFloat(TempEdit.Text);
       Result := True;
    except
      if Flag =3 then MsgDisplay(sTemp1+'||숫자값만 입력이 가능합니다.|'+sTemp2+'를 입력하시오.',WARNING_OK )
      else MsgDisplay(sTemp1+'||숫자값만 입력이 가능합니다.|'+sTemp2+'을 입력하시오.',WARNING_OK );
      TempEdit.SetFocus;
      Result := False;
    end;
  end;
end;

//Ini파일에서 문자읽기
function IniReadString(IniFileName : String; Section, Ident, Default : AnsiString) : AnsiString;
var IniFile : TIniFile;
begin
  Result := Default;
  IniFile := TIniFile.Create(IniFileName);
  try
    Result  := IniFile.ReadString(Section, Ident, Default);
  finally
    IniFile.Free;
  end;
end;

//Ini파일에서 숫자읽기
function IniReadInteger(IniFileName : String; Section, Ident : String; Default : Integer) : Integer;
var IniFile : TIniFile;
begin
  Result := Default;
  IniFile := TIniFile.Create(IniFileName);
  try
    Result  := IniFile.ReadInteger(Section, Ident, Default);
  finally
    IniFile.Free;
  end;
end;

//Ini파일에서 문자쓰기
function IniWriteString(IniFileName : String; Section, Ident, Value : String) : Boolean;
var IniFile : TIniFile;
begin
  Result := False;
  IniFile := TIniFile.Create(IniFileName);
  try
    IniFile.WriteString(Section, Ident, Value);
    Result := True;
  finally
    IniFile.Free;
  end;
end;

//Ini파일에서 숫자쓰기
function IniWriteInteger(IniFileName : String; Section, Ident : String; Value : Integer) : Boolean;
var IniFile : TIniFile;
begin
  Result := False;
  IniFile := TIniFile.Create(IniFileName);
  try
    IniFile.WriteInteger(Section, Ident, Value);
    Result := True;
  finally
    IniFile.Free;
  end;
end;

//Ini파일에서 삭제
function IniDeleteKey(IniFileName : String; Section, Ident : String) : Boolean;
var IniFile : TIniFile;
begin
  Result := False;
  IniFile := TIniFile.Create(IniFileName);
  try
    IniFile.DeleteKey(Section, Ident);
    Result := True;
  finally
    IniFile.Free;
  end;
end;


//Delay
procedure Delay(const nTime: Word);
var Start: Double;
begin
  Start := GetTickCount;
  repeat
    Sleep(1);
    Application.ProcessMessages;
  until (GetTickCount - Start) >= nTime
end;

function GetField(Src: String; FS: Char; var s_arr: TStringArray): Integer;
var
  I, J: Integer;
begin
  SetLength(s_arr, 10);

  I := 0;
  Src := Src + FS;
  while true do
  begin
    J := Pos(FS, Src);

    if (J <= 0) then break;

    s_arr[I] := Copy(Src, 1, J-1);
    Delete(Src, 1, J);
    Inc(I);
    if Length(s_arr) <= I then
      SetLength(s_arr, Length(s_arr) + 10);
  end;

  SetLength(s_arr, I);
  Result := I;
end;

function GetFieldFix(Src: String; ColLength: Integer; LengthArr: Array of Integer; var s_arr: TStringArray): Integer;
var
  I: Integer;
  StartPoint: Integer;
begin
  SetLength(s_arr, ColLength);
  StartPoint := 1;
  s_arr[0] := Copy(Src, StartPoint, LengthArr[0]);
  for I := 1 to ColLength -1 do
  begin
    StartPoint := StartPoint + LengthArr[I-1];
    s_arr[I] := Copy(Src, StartPoint, LengthArr[I]);
  end;
  Result := I;
end;

function LFLFtoCRLF(Src: String): String;
var
  Str: String;
begin
  Str := Src;
  Result := ReplaceStr(Str, #10#10, #13#10);
end;

function LFLFtoSpace(Src: String): String;
var
  Str: String;
begin
  Str := Src;
  Result := ReplaceStr(Str, #10#10, ' ');
end;
function SingleQtoClear(Src: String): String;
var
  Str: String;
begin
  Str := Src;
  Result := ReplaceStr(Str, '''', '');
end;

function CRLFtoPIPE(Src: String): String;
var
  Str: String;
begin
  Str := Src;
  Result := ReplaceStr(Str, #13#10, '|');
end;

function PIPEtoCRLF(Src: String): String;
var
  Str: String;
begin
  Str := Src;
  Result := ReplaceStr(Str, '|', #13#10);
end;

function GetIdxString(Src: String; Idx: Integer): String;
var
  StrList: TStringList;
begin
  StrList := TStringList.Create;
  StrList.CommaText := Src;
  Result := StrList[Idx];
  StrList.Free;
end;

//싱글 더블 쿼테이션 제거
function fn_Quotation_Delete(Str:string):string;
var s_Temp : string;
begin
  Result := '';
  s_Temp := Str;
  s_Temp := StringReplace(s_Temp,'''','`',[rfReplaceAll]);
  s_Temp := StringReplace(s_Temp,'"','`',[rfReplaceAll]);

  Result := s_Temp;

end;

function fn_My_LocalIP: String;
type
  PaPInAddr = ^TaPInAddr;
  TaPInAddr = array[0..10] of PInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of Ansichar;
  GInitData: TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));

  phe := GetHostByName(buffer);
  if phe = nil then Exit;

  pptr := PaPInAddr(Phe^.h_addr_list);

  Result := StrPas(inet_ntoa(pptr^[0]^));

  WSACleanup;
end;


function fn_My_MAC_Address: string;
var
  NumInterfaces: Cardinal;
  AdapterInfo: array of TIpAdapterInfo;

  OutBufLen: ULONG;
  i: integer;
begin
  GetNumberOfInterfaces(NumInterfaces);
  SetLength(AdapterInfo, NumInterfaces);
  OutBufLen := NumInterfaces * SizeOf(TIpAdapterInfo);
  GetAdaptersInfo(@AdapterInfo[0], OutBufLen);
  Result := '';

  for i := 0 to NumInterfaces - 1 do
  begin
    if AdapterInfo[i].AddressLength = 0 then Continue;

    Result := '|' + Result + Format('%.2x:%.2x:%.2x:%.2x:%.2x:%.2x',
    [AdapterInfo[i].Address[0], AdapterInfo[i].Address[1],
    AdapterInfo[i].Address[2], AdapterInfo[i].Address[3],
    AdapterInfo[i].Address[4], AdapterInfo[i].Address[5]]);
  end;

  Delete(Result, 1, 1);
end;


//엑셀에 저장하기
procedure ULib_ClientSaveExcel(aForm:TForm; aDBGrid :TDBGrid; aFileName: string);
var
  SaveDialog : TSaveDialog;
  iRow,iCol  : integer;
  ExcelF: TextFile;
  sDir:String;
  sLines: String;
  SavePlace: TBookmark;
begin
  SaveDialog := TSaveDialog.Create(nil);

  try
    if aDBGrid.DataSource.DataSet.IsEmpty then
    begin
      ShowMessage('검색된 데이타가 없습니다');
      Exit;
    end;

    with aForm, SaveDialog do
    begin
      SaveDialog.Options := [ofOverwritePrompt];
      Filter := 'Excel 형식 (*.xls)';
      DefaultExt := 'xls';
      FileName := FormatDateTime('"'+aFileName+'_"YYYYMMDD".xls"',Now);
      GetDir(0,sDir);
      InitialDir := sDir;
      FilterIndex := 1;
      if Execute then
      begin
        AssignFile(ExcelF, SaveDialog.FileName);
        Rewrite(ExcelF);
        aDBGrid.Enabled :=False;

        SavePlace := aDBGrid.DataSource.DataSet.GetBookmark;

        aDBGrid.DataSource.DataSet.First;
        for iCol := 0 to aDBGrid.FieldCount -1 do
          if aDBGrid.Fields[iCol].Visible then
             sLines := sLines + #9 + aDBGrid.Columns[iCol].Title.Caption;
        Writeln(ExcelF,sLines);
        sLines := '';

        aDBGrid.DataSource.DataSet.First;

        while not aDBGrid.DataSource.DataSet.Eof  do
        begin
          for iCol := 0 to aDBGrid.FieldCount -1 do
            if aDBGrid.Fields[iCol].Visible then
            begin
              if aDBGrid.Columns[iCol].Field.DataType = ftString then
                sLines := sLines + #9 + ''''  + (aDBGrid.Fields[iCol].DisplayText) + ''
              else
                sLines := sLines + #9 + ' '   + aDBGrid.Fields[iCol].DisplayText + ' ';
            end;
          Writeln(ExcelF,sLines);
          sLines := '';
          aDBGrid.DataSource.DataSet.Next;
        end;

        // 본문생성
        CloseFile(ExcelF);
        aDBGrid.DataSource.DataSet.GotoBookmark(SavePlace);
        aDBGrid.DataSource.DataSet.FreeBookmark(SavePlace);
        aDBGrid.Enabled := True;
      end;
    end;
  finally
  end;
end; {}


function AdvStringGridToExcel(AdvStringGrid: TAdvStringGrid): Boolean;
var
  XL, XArr: Variant;
  i, j: Integer;
  XLastPosion: string;
  Sp: Integer;
begin

  // 데이타 처리변수
  XArr := VarArrayCreate([1, AdvStringGrid.ColCount], VarVariant);

  try
    // 엑셀을 실행
    XL := CreateOLEObject('Excel.Application');
  except
    MessageDlg('Excel이 설치되어 있지 않습니다.', MtWarning, [mbok], 0);
    exit;
  end;

  XL.WorkBooks.Add; // 새로운 페이지 생성
  // XL.Visible := True;

  for i := 0 to AdvStringGrid.RowCount - 1 do
  begin
    for j := 0 to AdvStringGrid.ColCount - 1 do
    begin

      case j of
        0:
          XArr[j + 1] := Char(39) + AdvStringGrid.Cells[j, i];
      else
        XArr[j + 1] := AdvStringGrid.Cells[j, i];
      end;

    end;

    Sp := AdvStringGrid.ColCount div 26;
    if Sp <> 0 then
      XLastPosion := chr(64 + Sp) + chr(64 + AdvStringGrid.ColCount mod 26)
    else
      XLastPosion := chr(64 + AdvStringGrid.ColCount);

    // 엑셀에 값을 넣는다.
    XL.Range['A' + IntToStr(i + 1), XLastPosion + IntToStr(i + 1)
      ].Value := XArr;

  end;
  // 셀 크기 조정
  XL.Range['A1', XLastPosion + IntToStr(i + 1)].Select;
  XL.Selection.Columns.AutoFit;
  XL.Range['A1', 'A1'].Select;
  XL.Visible := True;
  Result := True;
end;


function DBGridToExcel(DBGrid :TDBGrid; DefaultFileName : String) : Boolean;
var
  SaveDialog : TSaveDialog;
  iRow,iCol  : integer;
  ExcelF: TextFile;
  sDir:String;
  sLines: String;
  SavePlace: TBookmark;
begin
  Result := False;
  SaveDialog := TSaveDialog.Create(nil);

  try
    if TDBGrid(DBGrid).DataSource.DataSet.IsEmpty then Exit;

    with SaveDialog do
    begin
      SaveDialog.Options := [ofOverwritePrompt];
      Filter := 'Excel 형식 (*.xls)';
      DefaultExt := 'xls';
      FileName := FormatDateTime('"'+DefaultFileName+'_"YYYYMMDD".xls"', Now);
      GetDir(0,sDir);
      InitialDir := sDir;
      FilterIndex := 1;
      if Execute then
      begin
        AssignFile(ExcelF, SaveDialog.FileName);
        Rewrite(ExcelF);
        TDBGrid(DBGrid).DataSource.DataSet.DisableControls;

        SavePlace := TDBGrid(DBGrid).DataSource.DataSet.GetBookmark;

        DBGrid.DataSource.DataSet.First;
        Debug.Write(1,1,'TDBGrid(DBGrid).FieldCount='+IntToStr(TDBGrid(DBGrid).FieldCount));

        for iCol := 0 to TDBGrid(DBGrid).FieldCount -1 do
        begin
          if TDBGrid(DBGrid).Fields[iCol].Visible then
          begin
             sLines := sLines + #9 + TDBGrid(DBGrid).Columns[iCol].Title.Caption;
             Debug.Write(1,1,TDBGrid(DBGrid).Columns[iCol].Title.Caption);
          end;
        end;
        Writeln(ExcelF,sLines);
        sLines := '';

        DBGrid.DataSource.DataSet.First;

        while not TDBGrid(DBGrid).DataSource.DataSet.Eof  do
        begin
          for iCol := 0 to TDBGrid(DBGrid).FieldCount -1 do
          begin
//            Debug.Write(1,1,'iCol='+IntToStr(iCol));
            if TDBGrid(DBGrid).Fields[iCol].Visible then
            begin
              if TDBGrid(DBGrid).Columns[iCol].Field.DataType = ftString then
                sLines := sLines + #9 + ''  + TDBGrid(DBGrid).Fields[iCol].DisplayText + ''
              else
                sLines := sLines + #9 + ' '   + TDBGrid(DBGrid).Fields[iCol].DisplayText + ' ';
            end;
          end;
          Writeln(ExcelF,sLines);
          sLines := '';
          TDBGrid(DBGrid).DataSource.DataSet.Next;
        end;

        // 본문생성
        CloseFile(ExcelF);
        TDBGrid(DBGrid).DataSource.DataSet.GotoBookmark(SavePlace);
        TDBGrid(DBGrid).DataSource.DataSet.FreeBookmark(SavePlace);
        TDBGrid(DBGrid).DataSource.DataSet.EnableControls;
      end;
    end;
    Result := True;
  finally
  end;
end;



function DBAdvGridToExcel(DBGrid :TDBAdvGrid; DefaultFileName : String) : Boolean;
var
  SaveDialog : TSaveDialog;
  iRow,iCol  : integer;
  ExcelF: TextFile;
  sDir:String;
  sLines: String;
  SavePlace: TBookmark;
begin
  Result := False;
  SaveDialog := TSaveDialog.Create(nil);

  try
    if TDBAdvGrid(DBGrid).DataSource.DataSet.IsEmpty then Exit;

    with SaveDialog do
    begin
      SaveDialog.Options := [ofOverwritePrompt];
      Filter := 'Excel 형식 (*.xls)';
      DefaultExt := 'xls';
      FileName := FormatDateTime('"'+DefaultFileName+'_"YYYYMMDD".xls"', Now);
      GetDir(0,sDir);
      InitialDir := sDir;
      FilterIndex := 1;
      if Execute then
      begin
        AssignFile(ExcelF, SaveDialog.FileName);
        Rewrite(ExcelF);
        TDBAdvGrid(DBGrid).DataSource.DataSet.DisableControls;

        SavePlace := TDBAdvGrid(DBGrid).DataSource.DataSet.GetBookmark;

        DBGrid.DataSource.DataSet.First;
        for iCol := 0 to TDBAdvGrid(DBGrid).ColCount - 1 do
          if Assigned(TDBAdvGrid(DBGrid).Columns[iCol]) and ((TDBAdvGrid(DBGrid).Columns[iCol].Width) > 0) then
             sLines := sLines + #9 + TDBGrid(DBGrid).Columns[iCol].Title.Caption;
        Writeln(ExcelF,sLines);
        sLines := '';

        DBGrid.DataSource.DataSet.First;

        while not TDBAdvGrid(DBGrid).DataSource.DataSet.Eof  do
        begin
          for iCol := 0 to TDBAdvGrid(DBGrid).ColCount - 1 do
            if Assigned(TDBAdvGrid(DBGrid).Columns[iCol]) and ((TDBAdvGrid(DBGrid).Columns[iCol].Width) > 0) then
            begin
              if TDBAdvGrid(DBGrid).Columns[iCol].Field.DataType = ftString then
                sLines := sLines + #9 + ''  + (TDBAdvGrid(DBGrid).Fields[iCol].DisplayText) + ''
              else
                sLines := sLines + #9 + ' '   + TDBAdvGrid(DBGrid).Fields[iCol].DisplayText + ' ';
            end;
          Writeln(ExcelF,sLines);
          sLines := '';
          TDBAdvGrid(DBGrid).DataSource.DataSet.Next;
        end;

        // 본문생성
        CloseFile(ExcelF);
        TDBAdvGrid(DBGrid).DataSource.DataSet.GotoBookmark(SavePlace);
        TDBAdvGrid(DBGrid).DataSource.DataSet.FreeBookmark(SavePlace);
        TDBAdvGrid(DBGrid).DataSource.DataSet.EnableControls;
      end;
    end;
    Result := True;
  finally
  end;
end;




// *****************************************************************************
// 함 수 명 : prExcel_Write(DBGrid : TDBGrid);
// 기    능 : excel 화일로 변환
// *****************************************************************************
procedure prExcel_Write(title : String; DBGrid : TDBGrid; AutoFit_Flag: Boolean = True);
var
  XL, XArr, IVar    : variant;
  i,k,j,m,Field_count : integer;
begin
  Field_count := DBGrid.FieldCount;                         // 가로 칸수

  XArr := VarArrayCreate([1,Field_count],varVariant);              // XArr에 크기선언
  XL   := CreateOLEObject('Excel.Application');                    // Excel 기동
  XL.WorkBooks.Add;                                                // Excel에 sheet 추가
  XL.Visible := False;                                              // Excel 보여주기

  {Title Setting}
  XArr[1] := title;
  XL.Range['A1','A1'].Value := XArr;                              // 타이틀
  XL.Range['A1', 'A1'].Select;
  XL.Selection.font.bold := True;          // 타이틀폰트 설정
  XL.Selection.font.Underline := True;

  for i := 1 to Field_count  do                                   // 타이틀에 내용이 있으면 실행
      XArr[i] := DBGrid.Columns[i-1].Title.Caption;

  if Field_count < 27 then
     XL.Range['A2',CHR(64+Field_count)+'2'].Value := XArr            // CHR(64+Field_count)  64년 ASCii 'A' 이므로 count1 까지를 선택
  else
  begin
    XL.Range['A2', CHR(64 + 26) + '2'].Value := XArr;

    for K := 27 to Field_Count do
    begin
      if K < 53 then
        XL.Range['A'+Chr(38+K) + '2','A'+Chr(38+K) + '2'].Value := XArr[K]
      else
        XL.Range['B'+Chr(38+K-26) + '2','B'+Chr(38+K-26) + '2'].Value := XArr[K];
    end

  end;

  {Grid의 내용을 Excel에 Setting}
  j := 2;
  DBGrid.DataSource.DataSet.First;
  with DBGrid.DataSource.DataSet do
  begin
     while Not Eof do
     begin
       k := 0;
       for i := 1 to Field_count do
       begin
         inc(k);
         IVar := DBGrid.Fields[i-1].Text;
         XArr[k] := IVar;
       end;

       if Field_count < 27 then
          XL.Range['A'+IntToStr(j+1),CHR(64+Field_count)+IntToStr(j+1)].Value := XArr
       else
       begin
          XL.Range['A'+IntToStr(j+1),CHR(64+26)+IntToStr(j+1)].Value := XArr;

          for K := 27 to Field_Count do
          begin
            if K < 53 then
              XL.Range['A'+Chr(38+K) + IntToStr(j+1),'A'+Chr(38+K) + IntToStr(j+1)].Value := XArr[K]
            else
              XL.Range['B'+Chr(38+K-26) + IntToStr(j+1),'B'+Chr(38+K-26) + IntToStr(j+1)].Value := XArr[K];
          end;
       end;
       inc(j);
       Next;
     end;
  end;

  if AutoFit_Flag then
  begin
    XL.cells.Select;

    XL.Selection.Columns.AutoFit;

    if Field_count < 27 then
       XL.Range['A2',CHR(64+Field_count)+'2'].Select            // CHR(64+Field_count)  64년 ASCii 'A' 이므로 count1 까지를 선택
    else if Field_count < 53 then
      XL.Range['A2', 'A'+Chr(38+Field_Count)+'2'].Select
    else
      XL.Range['A2', 'B'+Chr(38+Field_Count-26)+'2'].Select;

    XL.selection.autofilter;
    XL.Selection.font.bold := True;           // 타이틀폰트 설정
    XL.Selection.interior.colorindex := 15;   // 칼라설정
  end;
  XL.Visible := True;                                              // Excel 보여주기
end;

function FormatPhone(AChar: Char; Src: string): string;
var
  Str: String;
  n: Integer;
  FDashIdx, MDashIdx: Integer;
begin
  n := 0;
  Str := DeleteChars(Src,['-','.',' ','(',')','/',' ']);

  FDashIdx := 0;
  MDashIdx := -1;

  while Copy(Str,1,2) = '00' do Delete(Str,1,1);

  if Length(Str) >= 3 then
  begin
    if Str[1] = '0' then
    begin
      if Str[2] = '2' then FDashIdx := 2
      else if (Str[2] = '5') and (Str[3] = '0') then FDashIdx := 4
      else if (Str[2] = '3') and (Str[3] = '0') then FDashIdx := 4
      else if (Str[2] = '1') and (Str[3] = '3') then
      begin
        if (Str[4] = '0') then      FDashIdx := 4
        else FDashIdx:=3;
      end
      else FDashIdx:=3;
    end;

    if Str[FDashIdx+1] = '0' then
    begin
      if Copy(Str, 1, 3) <> '080' then Delete(Str,FDashIdx+1,1);
    end;

    if (Length(Str) - FDashIdx >= 9) then
      MDashIdx := FDashIdx + 4 + 1
    else if (Length(Str)-FDashIdx > 4) then
      MDashIdx := Length(Str) - 4 + 1;
  end
  else if Str = '02' then
    FDashIdx := 2;

  if MDashIdx >= 0 then
    Insert(AChar, Str, MDashIdx);
  if FDashIdx > 0 then
    Insert(AChar, Str, FDashIdx+1);
  Result := Str;
end;



{******************************************************************************
 기능   : 문자열에서 특정문자열을 파싱하여 순서대로 return
 input  : CsvStr : 문자열, Index : 0,1,2 등
 output : 문자열
 example: str = '111,222,333,444,555'
          First := ParseCsvStr(Str, 0); // First = '111'
          Second := ParseCsvStr(Str, 1); // Second = '222'
          Third = ParseCsvStr(Str, 2); // Third = '333'
 *****************************************************************************}
function fnParseCsvStr(const CsvStr : string; Cvsgubun : Char; Index: Integer): string;
var P : PChar;
    SeperatorChar : Char;
    CurIndex, DivPos : Integer;
begin
  SeperatorChar := Cvsgubun;
  if Index < 0 then Exit;

  Result := '0';
  P := PChar(CsvStr);
  CurIndex := 0;
  repeat
    DivPos := Pos(SeperatorChar, string(P));
    if CurIndex = Index then
    begin
      if DivPos <> 0 then
        Result := Copy(string(P), 1, DivPos - 1)
      else
        Result := Copy(string(P), 1, Length(string(P)));
      Exit;
    end;
    Inc(P, DivPos);
    Inc(CurIndex);
  until P = '';
end;


function CheckItem(Msg: String; Flag: Boolean=False; Edit: TAdvEdit=nil): Boolean;
begin
  Result := True;

  if Flag then
  begin
    Result := False;
    Application.MessageBox(PChar(Msg), 'Error', MB_ICONERROR+MB_OK);
    if not Assigned(Edit) then exit;
    Edit.SetFocus;
  end;
end;

function CheckItem(Msg: String; Flag: Boolean=False; CurvyEdit: TCurvyEdit=nil): Boolean;
begin
  Result := True;

  if Flag then
  begin
    Result := False;
    Application.MessageBox(PChar(Msg), 'Error', MB_ICONERROR+MB_OK);
    if not Assigned(CurvyEdit) then exit;
    CurvyEdit.SetFocus;
  end;
end;

function CheckItem(Msg: String; Flag: Boolean=False; Combo: TAdvComboBox=nil): Boolean;
begin
  Result := True;
  if Flag then
  begin
    Result := False;
    Application.MessageBox(PChar(Msg), 'Error', MB_ICONERROR+MB_OK);
    if not Assigned(Combo) then exit;
    Combo.SetFocus;
  end;
end;

function CheckItem_MSG(Msg: String; Flag: Boolean=False): Boolean;
begin
  Result := True;
  if Flag then
  begin
    Result := False;
    Application.MessageBox(PChar(Msg), 'Error', MB_ICONERROR+MB_OK);
  end;
end;

function CheckTelArea(Tel0: String): String;
var
  DddList: TStringList;
begin
  try
    DddList := TStringList.Create;
    DddList.CommaText := ConstDDD1;
    Result := '3';
    if not (DddList.IndexOf(Format('%.d',[StrToIntDef(Tel0,0)])) < 0) then Exit;
    DddList.CommaText := ConstDDD2;
    Result := '1';
    if not (DddList.IndexOf(Format('%.d',[StrToIntDef(Tel0,0)])) < 0) then Exit;
    Result := '2';
  finally
    DddList.Free;
  end;
end;

function CheckTel(Tel, Caption: String; Flag: Boolean; Edit: TCurvyEdit=nil): Boolean;
var
  DddList: TStringList;
  Msg: String;
  r: Integer;
  Rtl: TStringArray;
begin
  Result := False;
  Msg := '전화번호를 잘못입력하셨습니다.'+#13#13+Caption+' 다시 입력하시오.';

  r := GetField(Tel, '-', Rtl);
  if not CheckItem(Msg, not(r = 3), Edit) then Exit;

  if not( (Rtl[0]='') and (Rtl[1]='') and (Rtl[2]='') ) then
  begin
    Result := CheckItem(Msg, ( (Rtl[0]='') or (Rtl[1]='') or (Rtl[2]='') ), Edit);
    if not Result then exit;
    DddList := TStringList.Create;
    try
      if Flag then DddList.CommaText := ConstDDD1
      else DddList.CommaText := ConstDDD2;
      Result := CheckItem(Msg+#13+'(없는 지역번호를 입력)', (DddList.IndexOf(Format('%.d',[StrToIntDef(Rtl[0],0)])) < 0), Edit);
      if not Result then exit;
      Result := CheckItem(Msg+#13+'(끝자리가 4자리가 아님)',  Length(Rtl[2])<>4, Edit);
      if not Result then exit;
      Result := CheckItem(Msg+#13+'(중간자리가 4자리가 아님)',  (Rtl[0]='010') and (Length(Rtl[1])<>4), Edit);
      if not Result then exit;
    finally
      DddList.Free;
    end;
  end;
end;


// *****************************************************************************
// 함 수 명 : prExcel_Write(DBGrid : TDBGrid);
// 기    능 : excel 화일로 변환
// *****************************************************************************
procedure prExcel_Write1(title, sub_title1, sub_title2, sub_title3, sub_title4 : String; DBGrid : TDBGrid; s_tail1, s_tail2 : String);
var
  XL, XArr, IVar    : variant;
  i,k,j,Field_count : integer;
begin
  try
    Field_count := DBGrid.FieldCount;                                // 가로 칸수

    XArr := VarArrayCreate([1,Field_count],varVariant);              // XArr에 크기선언
    XL   := CreateOLEObject('Excel.Application');                    // Excel 기동
    XL.WorkBooks.Add;                                                // Excel에 sheet 추가
    XL.Visible := True;                                              // Excel 보여주기

    {Title Setting}
    XArr[1] := title;
    XL.Range['A1','A1'].Value := XArr;                              // 타이틀
    XL.Range['A1','A1'].Select;
    XL.Selection.font.bold := True;          // 타이틀폰트 설정
    XL.Selection.font.Underline := True;

    XArr[1] := sub_title1;
    XL.Range['A3','A3'].Value := XArr;                              // 타이틀
    XArr[1] := sub_title2;
    XL.Range['A4','A4'].Value := XArr;                              // 타이틀
    XArr[1] := sub_title3;
    XL.Range['A5','A5'].Value := XArr;                              // 타이틀
    XArr[1] := sub_title4;
    XL.Range['A6','A6'].Value := XArr;                              // 타이틀


    for i := 1 to Field_count  do                                   // 타이틀에 내용이 있으면 실행
       XArr[i] := DBGrid.Columns[i-1].Title.Caption;

    if Field_count < 27 then
       XL.Range['A7',CHR(64+Field_count)+'7'].Value := XArr            // CHR(64+Field_count)  64년 ASCii 'A' 이므로 count1 까지를 선택
    else
    begin
      XL.Range['A7', CHR(64 + 26) + '7'].Value := XArr;

      for K := 27 to Field_Count do
        XL.Range['A'+Chr(38+K) + '7','A'+Chr(38+K) + '7'].Value := XArr[K];
    end;

    {Grid의 내용을 Excel에 Setting}
    j := 7;
    DBGrid.DataSource.DataSet.First;
    with DBGrid.DataSource.DataSet do
    begin
       while Not Eof do
       begin
         k := 0;
         for i := 1 to Field_count do
         begin
           inc(k);
           if Assigned(DBGrid.Fields[i-1]) then
                IVar := DBGrid.Fields[i-1].Text
           else IVar := '';
           XArr[k] := IVar;
         end;

         if Field_count < 27 then
           XL.Range['A'+IntToStr(j+1),CHR(64+Field_count)+IntToStr(j+1)].Value := XArr
         else
         begin
           XL.Range['A'+IntToStr(j+1),CHR(64+26)+IntToStr(j+1)].Value := XArr;
           for K := 27 to Field_Count do
             XL.Range['A'+Chr(38+K) + IntToStr(j+1),'A'+Chr(38+K) + IntToStr(j+1)].Value := XArr[K];
         end;
         inc(j);
         Next;
       end;
    end;

    XL.cells.Select;

    XL.Selection.Columns.AutoFit;

    if Field_count < 27 then
       XL.Range['A7',CHR(64+Field_count)+'7'].Select            // CHR(64+Field_count)  64년 ASCii 'A' 이므로 count1 까지를 선택
    else
    begin
      XL.Range['A7', 'A'+Chr(38+Field_Count)+'7'].Select;
    end;

    XL.selection.autofilter;
    XL.Selection.font.bold := True;           // 타이틀폰트 설정
    XL.Selection.interior.colorindex := 15;   // 칼라설정

    if Field_count < 27 then
    begin
       XL.Range['A7',CHR(64+Field_count)+IntToStr(j)].borders.Item[1].Linestyle := 1;
       XL.Range['A7',CHR(64+Field_count)+IntToStr(j)].borders.Item[2].Linestyle := 1;
       XL.Range['A7',CHR(64+Field_count)+IntToStr(j)].borders.Item[3].Linestyle := 1;
       XL.Range['A7',CHR(64+Field_count)+IntToStr(j)].borders.Item[4].Linestyle := 1;
    end
    else
    begin
       XL.Range['A7','A'+Chr(38+K) + IntToStr(j)].borders.Item[1].Linestyle := 1;
       XL.Range['A7','A'+Chr(38+K) + IntToStr(j)].borders.Item[2].Linestyle := 1;
       XL.Range['A7','A'+Chr(38+K) + IntToStr(j)].borders.Item[3].Linestyle := 1;
       XL.Range['A7','A'+Chr(38+K) + IntToStr(j)].borders.Item[4].Linestyle := 1;
    end;

    inc(j);
    if s_tail1 <> '' then
    begin
       IVar := s_tail1;
       XArr[k] := IVar;
       XL.Range['A'+IntToStr(j+1),'A'+IntToStr(j+1)].Value := s_tail1;
    end;
    inc(j);
    if s_tail2 <> '' then
    begin
       IVar := s_tail2;
       XArr[k] := IVar;
       XL.Range['A'+IntToStr(j+1),'A'+IntToStr(j+1)].Value := s_tail2;
    end;
{
CellForm := cfText;
Columns['A'].NumberFormatLocal := '#,##0';
{}
  except
    if not VarIsEmpty(XL) then
      XL.Quit;               {Excel 종료}
    IsRun('Excel');
  end;
end;

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


function fn_week(str_date: String) : String;
var
  ADate: TDateTime;
  days: array[1..7] of string;
begin
  days[1] := 'Sunday';
  days[2] := 'Monday';
  days[3] := 'Tuesday';
  days[4] := 'Wednesday';
  days[5] := 'Thursday';
  days[6] := 'Friday';
  days[7] := 'Saturday';
  ADate := StrToDate(str_date);
  Result := days[DayOfWeek(ADate)];
end;

function Str_Decoding(s : String) :String;
var
  Str, RStr: AnsiString;
  I, Len : Integer;
begin
  Result := '';
  Str := Trim(s);
  if Str = '' then exit;

  RStr :='';
  for I:=0 to (length(Str) div 2) -1 do
  begin
    RStr := RStr + AnsiChar( $0F xor StrToInt('$'+Str[I*2+1]+Str[I*2+2]));
  end;

  if Copy(RStr,2,1)='k' then Delete(RStr,2,1);
  if Length(RStr) >= 8 then
  begin
    Delete(RStr,5,1);
    Delete(RStr,7,1);
  end;

  Result := RStr;
end;

function Str_Encoding(s : String):String;
var
  Tmp_Arr : Array[0..400] of Char;
  Str: AnsiString;
  I : Integer;
  ReturnStr: AnsiString;
begin
  Result := '';
  Str := Trim(s);
  if Str = '' then exit;
  if Length(Str) >= 6 then
  begin
    insert('z',Str,7);
    insert('a',Str,5);
  end;
  if (Length(Str) mod 2) <>0 then insert('k',Str,2);
  ReturnStr := '';
  for I := 0 to Length(Str)-1 do
  begin
    ReturnStr := ReturnStr +Format('%.2x',[ $0F xor ord(Str[i+1]) ]);
//    debug.Write(1,9999,'i='+IntToStr(I)+', '+Format('%.2x',[ ord(Str[i+1]) ]));
  end;

  Result := ReturnStr;
end;

function CreateShortcut(const CmdLine, Args, WorkDir, LinkFile: string): IPersistFile;
var
  MyObject : IUnknown;
  MySLink : IShellLink;
  MyPFile : IPersistFile;
  WideFile : WideString;
begin
  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;
  MyPFile := MyObject as IPersistFile;

  with MySLink do
  begin
    SetPath(PChar(CmdLine));
    SetArguments(PChar(Args));
    SetWorkingDirectory(PChar(WorkDir));
  end;

  WideFile := LinkFile;
  MyPFile.Save(PWChar(WideFile), False);
  Result := MyPFile;
end;

procedure CreateShortcuts(Str1, Str2, Str3: String; Flag: Boolean=True);
var
  Directory, ExecDir: String;
  MyReg: TreginiFile;
begin
  MyReg := TreginiFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
//  MyReg := TreginiFile.Create;
//  MyReg.RootKey := HKEY_CURRENT_USER;
//  MyReg.OpenKey('Software\MicroSoft\Windows\CurrentVersion\Explorer',False);
  ExecDir := ExtractFilePath(Str1);
  Directory :=  MyReg.ReadString('Shell Folders', 'Desktop', '');
  MyReg.Free;

  if Flag and FileExists(Directory + '\'+Str3+'.lnk') then exit;
  CreateShortcut(Str1, Str2, ExecDir,  Directory + '\'+Str3+'.lnk');
end;

procedure CreateInternetShortcuts(const LocationURL, FileName: String);
var
  Directory: String;
  MyReg: TRegIniFile;
begin
  MyReg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
  Directory :=  MyReg.ReadString('Shell Folders', 'Desktop', '');
  MyReg.Free;
//  if FileExists(Directory + '\'+FileName+'.url') then DeleteFile(Directory + '\'+FileName+'.url');
  with TIniFile.Create(Directory + '\'+FileName+'.url') do
  try
    WriteString('InternetShortcut', 'URL', LocationURL);
  finally
    Free;
  end;
end;

function CopyWideString(Source: WideString; Index, Count: Integer): String;
begin
  Result := Copy(Source, Index, Count);
end;

{

//실행 파일을 부르고 HANDLE이 다시 돌아오기를 기다린다.
//-----------------------------------------------------------------------------
function  uf_RunAndWait32(FName : string; vis : Integer): boolean;
//-----------------------------------------------------------------------------
var
  WorkDir : String;
  StartupInfo : TSTARTUPINFO ;
  ProcessInfo : TPROCESSINFORMATION;
begin
  WorkDir := ExtractFilePath(Application.ExeName);

  FillMemory( @StartupInfo , sizeof( STARTUPINFO ), 0 );
  StartupInfo.cb := sizeof( STARTUPINFO );
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := vis;
  if  not CreateProcess(
	nil,
 	PChar(Fname),
 	nil,
 	nil,
 	FALSE,
 	0,
 	nil,
 	PChar(WorkDir),
 	StartupInfo,
 	ProcessInfo ) then
   begin
        Result := FALSE;
   end
   else
   begin
   	WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
   	Result := TRUE;
   end;
   Application.ProcessMessages;
end;

{}

end.

