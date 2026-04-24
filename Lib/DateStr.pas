unit DateStr;

interface

{날짜와 관련된 함수}
//=====================================================================================================
// 8자리 날짜스트링이 맞는 날짜인지 Check한다.(년월일)
function CheckYMD(S_Date: String): Boolean;

// 6자리 날짜스트링이 맞는 날짜인지 Check한다.(년월)
function CheckYM(S_Date: String): Boolean;

// 6자리 시간스트링이 맞는 시간인지 Check한다.(시분초)
function CheckHMS(S_TIME: String): Boolean;

// 현재년, 나이 ===> 해당년도
function CalcAgeYear(Year, Age:String; Flag: Boolean=False): String;

// S_DATE로부터 S_BASE까지의 만 년수(연미만 절사한 년수)를 계산한다.
function CalcFullYear(S_DATE, S_BASE: String): Integer;

// S_BASE로부터 Years만큼 전 년도를 구한다. Return값은 8자리 날짜스트링
function CalcBeforeYear(Years: Integer; S_BASE: String): String;

// S_BASE로부터 Years만큼 다음 년도를 구한다. Return값은 8자리 날짜스트링
function CalcAfterYear(Years: Integer; S_BASE: String): String;

// S_DATE로부터 S_BASE까지의 만 개월수(월미만 절사한 개월수)를 계산한다.
function CalcFullMonth(S_DATE, S_BASE: String): Integer;

// S_BASE로부터 Months만큼 전 월을 구한다. Return값은 8자리 날짜스트링
function CalcBeforeMonth(Months: Integer; S_BASE: String): String;

// S_DATE로부터 S_BASE까지의 년, 개월, 일을 구한다. Return값은 6자리 날짜스트링
function CalcFullDateStr(S_Date, S_BASE : String) : String;

// Start_Date로부터 End_Date까지의 일수 계산.
function CalcBeforeDay(Start_Date, End_Date : String) : Integer;

// 년월일의 날짜형식의 자릿수 맞추기}{공백을 0으로 전환
function SetDateStr(YYMMDD:String) : String;

// 해당요일을 돌려준다.
function DayOfWeekValue(DateStr :String; Flag: Integer = 1):String;

// 해당달의 마지막날 구하기
function LastDayOfMonth(DateStr :String):String;
function LastDayOfMonthToDate(DateStr :String):TDateTime;

// 데이트형의 스트링에서 년,월,일구하기
procedure DecodeDateStr(DateStr : String;var YY,MM,DD : word);

// 타임형의 스트링에서 시간,분,초구하기
procedure DecodeTimeStr(DateStr : String;var HH,MM,SS,MS : word);

// 스트링형을 데이트형으로
function DateStrToDate(DateStr:String):TDateTime;

// 스트링형을 타임형으로
function DateStrToTime(DateStr:String):TDateTime;

// 스트링형을 DateTime형으로
function DateStrToDateTime(DateStr:String):TDateTime;

// 몇년 몇개월--> 개월수로만 표시
function YMToMonths(YM:String):Integer;

// 개월수 -- > 몇년 몇개월
function MonthsToYM(Month:Integer):String;

// 기준 년,월,일을 입력해서 1년의 날수를 계산
function Get_YEAR_DAYS(DateStr : String) : Word;

// !@년 #$개월 + %^년 &*개월 == > ?>년 <[개월
function AddYM(YYMM,YM:String):string;

// !@년 #$개월 - %^년 &*개월 == > ?>년 <[개월
function SubYM(YYMM,YM:String):string;

// 19981212 --> 1998년12월12일
function EncodeHYMD(YYMMDD:String):String;

// 199812   --> 1998년12월
function EncodeHYM(YYMM:String):String;

// 1212   --> 12월12일
function EncodeHMD(MMDD:String):String;

// 120505   --> 12시05분05초
function EncodeHHNS(HHNNSS:String):String;

// 19981212 --> 1998-12-12
function EncodeSYMD(YYMMDD:String):String;

// 199812 --> 1998-12
function EncodeSYM(YYMM:String):String;

// 120505 --> 12:05:05
function EncodeSHNS(HHNNSS:String):String;

// 300 --> 00:05:00
function EncodeHNS(Duration: Longint; FixLen: Integer = 2): String;

// 00:05:00 --> 300
function DecodeHNS(sDuration: String): Longint;

// 19980909 --> 1998년 9월 9일
function EncodePYMD(Format_Str : String) : String;

// 199809 --> 1998년 9월
function EncodePYM(Format_Str : String) : String;

// 19981212010101 --> 1998-12-12,01:01:01
function EncodeSYMDHNS(YYMMDD:String):String;

// 19981212 --> 199812
function YMDToYM(YYMMDD:string):string;

// 19981212 --> 12121998
function YMDToMDY(YYMMDD:String):string;

// 다음달을 구한다.
function AddMonth(DateStr: String; Base: SmallInt):String;

// 특정한 날을 받았을때 해당월의 마지막날보다 크면 이 날의 마지막날을 보낸다.
function LastDayCheck_Change(DateStr: String): String;

function Y2K_Date(dt_str : string) : string;

// 경과초를 구하는 함수
function CalcSecondElapse(aStrDate1,aStrDate2:String):String;

// Int값으로 반환한다.
function DateTimeToUnix(const AValue: TDateTime): Int64;

// Int값 날자형으로 반환한다.
function UnixToDateTime(const AValue: Int64): TDateTime;

// Int값으로 반환한다.
function DateTimeToUnixKMT(const AValue: TDateTime): Int64;

// Int값 날자형으로 반환한다.
function UnixToDateTimeKMT(const AValue: Int64): TDateTime;



//=====================================================================================================

implementation

uses  System.SysUtils, UtilLib;

const
{ Units of time }

  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;

{ Days between TDateTime basis (12/31/1899) and Unix time_t basis (1/1/1970) }

  UnixDateDelta = 25569;   // GMT

{날짜와 관련된 함수}
//=====================================================================================================
function CheckYMD(S_Date: String): Boolean;
var
  S_TDate: String;
begin
  Result := true;

  S_TDate := Format('%-8.8s',[ S_Date ]);
//  Insert( DateSeparator, S_TDate, 5);
//  Insert( DateSeparator, S_TDate, 8);
  try
//    StrToDate(S_TDate);
    EncodeDate( StrToInt(Copy(S_TDate, 1, 4)), StrToInt(Copy(S_TDate, 5, 2)), StrToInt(Copy(S_TDate, 7, 2)));
  except
//    on E:EConvertError do
    Result := false;
  end;
end;

function CheckYM(S_Date: String): Boolean;
var
  S_TDate: String;
begin
  Result := true;

  S_TDate := Format('%-6.6s',[ S_Date ]);
  S_TDate := S_TDate + '01';
  Insert( FormatSettings.DateSeparator, S_TDate, 5);
  Insert( FormatSettings.DateSeparator, S_TDate, 8);
  try
    StrToDate(S_TDate);
  except
//    on E:EConvertError do
      Result := false;
  end;
end;

function CheckHMS(S_TIME: String): Boolean;
var
  S_TTIME: String;
begin
  Result := true;
  S_TTIME := Format('%-6.6s',[ S_TIME ]);
  try
    EncodeTime( StrToInt(Copy(S_TTIME, 1, 2)), StrToInt(Copy(S_TTIME, 3, 2)), StrToInt(Copy(S_TTIME, 5, 2)),0);
  except
    Result := false;
  end;
end;

function CalcAgeYear(Year,Age:String; Flag: Boolean=False): String;
begin
  if Flag then Result := IntToStr(StrToInt(Year)-(1900+StrToInt(Age)))
  else  Result := IntToStr(StrToInt(Year)-(1900+StrToInt(Age))+1);
end;

function CalcFullYear(S_DATE, S_BASE: String): Integer;    // 연미만 절사
begin
  Result := -1;

  if (CheckYMD(S_DATE) = False) or (CheckYMD(S_BASE) = False) then
    exit;

  Result := StrToInt(Copy(S_BASE,1,4))-StrToInt(Copy(S_DATE,1,4));
  if (StrToInt(Copy(S_BASE,5,2))*100+StrToInt(Copy(S_BASE,7,2))) - (StrToInt(Copy(S_DATE,5,2))*100+StrToInt(Copy(S_DATE,7,2))) < 0 then
    Dec(Result);

  if Result < 0 then Result := -1;
end;

function CalcBeforeYear(Years: Integer; S_BASE: String): String;
begin
  Result := FormatDateTime('yyyymmdd', 0);

  if Length(S_BASE) <> 8 then
    exit;

  Result := IntToStr(StrToInt(Copy(S_BASE, 1, 4))-Years) + Copy(S_BASE, 5, 4);
end;

function CalcAfterYear(Years: Integer; S_BASE: String): String;
begin
  Result := FormatDateTime('yyyymmdd', 0);

  if Length(S_BASE) <> 8 then
    exit;

  Result := IntToStr(StrToInt(Copy(S_BASE, 1, 4))+Years) + Copy(S_BASE, 5, 4);
end;

function CalcFullMonth(S_DATE, S_BASE: String): Integer;   // 월미만 절사
var
  I_Year: Integer;
  I_Month: Integer;
begin
  Result := -1;

  if (Length(S_DATE) <> 8) or (Length(S_BASE) <> 8) then
    exit;

  I_Year := CalcFullYear( S_DATE, S_BASE);
  if I_Year = -1 then
    exit;

  if Copy(S_BASE, 5, 2) > Copy(S_DATE, 5, 2) then
  begin
    I_Month := StrToInt(Copy(S_BASE,5,2))-StrToInt(Copy(S_DATE,5,2));
    if StrToInt(Copy(S_BASE,7,2))-StrToInt(Copy(S_DATE,7,2)) < 0 then
      Dec(I_Month);
  end
  else if Copy(S_BASE, 5, 2) = Copy(S_DATE, 5, 2) then
  begin
    I_Month := 0;
    if StrToInt(Copy(S_BASE,7,2))-StrToInt(Copy(S_DATE,7,2)) < 0 then
      I_Month := 11;
  end
  else
  begin
    I_Month := 12 - (StrToInt(Copy(S_DATE,5,2)) - StrToInt(Copy(S_BASE,5,2)));
    if StrToInt(Copy(S_BASE,7,2))-StrToInt(Copy(S_DATE,7,2)) < 0 then
      Dec(I_Month);
  end;

  Result := I_Year * 12 + I_Month;
end;

function CalcBeforeMonth(Months: Integer; S_BASE: String): String;
var
  iYear: Integer;
  iMonth: Integer;
  iDay: Integer;
begin
  Result := FormatDateTime('yyyymmdd', 0);

  if Length(S_BASE) <> 8 then
    exit;

  iYear := Months div 12;
  iMonth := Months mod 12;
  iDay := StrToInt(Copy(S_BASE, 7, 2));
  if StrToInt(Copy(S_BASE, 5, 2)) > iMonth then
  begin
    iYear := StrToInt(Copy(S_BASE, 1, 4)) - iYear;
    iMonth := StrToInt(Copy(S_BASE, 5, 2)) - iMonth;
  end
  else if StrToInt(Copy(S_BASE, 5, 2)) = iMonth then
  begin
    iYear := StrToInt(Copy(S_BASE, 1, 4)) - iYear -1;
    iMonth := 12;
  end
  else
  begin
    iYear := StrToInt(Copy(S_BASE, 1, 4)) - iYear - 1;
    iMonth := 12 - ( iMonth - StrToInt(Copy(S_BASE, 5, 2)) );
  end;

{  if iMonth = 2 then
  begin
    if IsLeapYear(iYear) and (iDay in [30, 31]) then
      iDay = 29;
    if iDay in [29, 30, 31] then
      iDay = 28;
  end;
  if (iMonth in [4, 6, 9, 11]) and (iDay = 31) then
    iDay = 30;
}

  Result := Format( '%.4d%.2d%.2d', [ iYear, iMonth, iDay] );
end;

function CalcFullDateStr(S_Date, S_BASE : String) : String;
type Month = 1..12;
var YY,DD,D: word;
    mm : Month;
    Months : word;
begin
  Result :='';
  if (Length(S_DATE) <> 8) or (Length(S_BASE) <> 8) then exit;

  YY := StrToInt(Copy(S_BASE,1,4));
  MM := StrToInt(Copy(S_BASE,5,2))-1;
  if MM = 0 then MM := 12;
  DD := StrToInt(Copy(S_BASE,7,2));
  D  := StrToInt(Copy(S_Date,7,2));

  {이전달의 날의 수에서 뺀다.}
  if DD >= D then DD := DD-D
  else DD:= DD + MonthDays[IsLeapYear(YY)][MM] - D;

  Months := CalcFullMonth(S_DATE,S_BASE);
  Result := FillCharAligned(IntToStr(Months div 12),2,'0',False)
          + FillCharAligned(IntToStr(Months mod 12),2,'0',False)
          + FillCharAligned(IntToStr(DD),2,'0',False);
end;

// Start_Date로부터 End_Date까지의 일수 계산.
function CalcBeforeDay(Start_Date, End_Date : String) : Integer;
var
  s_date, e_date : String;
begin
  Result := -1;

  if (length(Start_Date) <> 8) or (length(End_Date) <> 8) then
    Exit;

  if (not CheckYMD(Start_Date)) or (not CheckYMD(End_Date)) then
    Exit;

  s_date := EncodeSYMD(Start_Date);
  e_date := EncodeSYMD(End_Date);

  Result := Trunc((StrToDate(e_date) - StrToDate(s_date)));
end;

function SetDateStr(YYMMDD:String) : String;
var i : Byte;
    Temp : String;
begin
  Temp:='';
  for i:=1 to Round(Length(YYMMDD) div 2 + Length(YYMMDD) mod 2) do
  begin
    Temp := Temp + Format('%-0.2d', [StrToIntDef(ExtractNumeric(Copy(YYMMDD,(i-1)*2+1,2)),0)]);
  end;
  Result := Temp;
end;

// Flag 1:월요일, 2:월, 3:Mon
function DayOfWeekValue(DateStr :String; Flag: Integer = 1):String;
const
  DAYOFWEEK_FARR: array [1..7] of String =('일요일','월요일','화요일','수요일','목요일','금요일','토요일');
  DAYOFWEEK_SARR: array [1..7] of String =('일','월','화','수','목','금','토');
  DAYOFWEEK_EARR: array [1..7] of String =('SUN','MON','TUE','WEN','THU','FRI','SAT');
begin
  case Flag of
  1: Result := DAYOFWEEK_FARR[DayOfWeek(DateStrToDate(DateStr))];
  2: Result := DAYOFWEEK_SARR[DayOfWeek(DateStrToDate(DateStr))];
  3: Result := DAYOFWEEK_EARR[DayOfWeek(DateStrToDate(DateStr))];
  end;
end;

{그달의 마지막날을 구한다.}
function LastDayOfMonth(DateStr :String):String;
begin
  Result := FormatDateTime('yyyymmdd',LastDayOfMonthToDate(DateStr));
end;

function LastDayOfMonthToDate(DateStr :String):TDateTime;
var YY,MM,DD : word;
    Date1 : TDateTime;
begin
  DecodeDateStr(DateStr,YY,MM,DD);
  Date1 := EncodeDate(YY,MM,27)+15;
  DecodeDate(Date1,YY,MM,DD);
  Date1 := EncodeDate(YY,MM,1)-1;
  Result := Date1;
end;

procedure DecodeDateStr(DateStr : String;var YY,MM,DD : word);
begin
  YY := StrToInt(Copy(DateStr,1,4));
  MM := StrToInt(Copy(DateStr,5,2));
  DD := StrToInt(Copy(DateStr,7,2));
end;

procedure DecodeTimeStr(DateStr : String;var HH,MM,SS,MS : word);
begin
  HH := StrToInt(Copy(DateStr,1,2));
  MM := StrToInt(Copy(DateStr,3,2));
  SS := StrToInt(Copy(DateStr,5,2));
  if Length(DateStr) = 6 then MS := 0
  else MS := StrToInt(Copy(DateStr,6,2));
end;

function DateStrToDate(DateStr:String):TDateTime;
var YY,MM,DD : word;
begin
  DecodeDateStr(DateStr,YY,MM,DD);
  Result:=EncodeDate(YY,MM,DD);
end;

function DateStrToTime(DateStr:String):TDateTime;
var HH,MM,SS,MS : word;
begin
  DecodeTimeStr(DateStr,HH,MM,SS,MS);
  Result:=EncodeTime(HH,MM,SS,MS);
end;

function DateStrToDateTime(DateStr:String):TDateTime;
var Year, Month, Day, Hour, Minte, Sesond : String;
begin
//  DateStr := 20220209103035
  FormatSettings.ShortDateFormat := 'YYYY-MM-DD';
  FormatSettings.LongTimeFormat  := 'YYYY-MM-DD';

  FormatSettings.ShortTimeFormat := 'hh:nn:ss';
  FormatSettings.LongTimeFormat  := 'hh:nn:ss';

  FormatSettings.DateSeparator := '-';
  FormatSettings.TimeSeparator := ':';

  Year   := Copy(DateStr, 1,4);
  Month  := Copy(DateStr, 5,2);
  Day    := Copy(DateStr, 7,2);
  Hour   := Copy(DateStr, 9,2);
  Minte  := Copy(DateStr,11,2);
  Sesond := Copy(DateStr,13,2);

  Result:= StrToDateTime(Year + '-' + Month + '-' + Day + ' ' + Hour + ':' + Minte + ':' + Sesond , FormatSettings)

end;

{몇년 몇개월--> 개월수로만 표시}
function YMToMonths(YM:String):Integer;
begin
//  YM:=ExtractNum(YM);
  try
    Result:=StrToInt(Copy(YM,1,2))*12+StrToInt(Copy(YM,3,2));
  except
    Result:=0;
  end;
end;

{개월수--> 몇년 몇개월로 표시}
function MonthsToYM(Month:Integer):String;
var Y,M:Integer;
begin
  Y:=Month div 12;
  M:=Month mod 12;
  Result:=Format('%-0.2d',[Y])+Format('%-0.2d',[M]);
end;

function Get_YEAR_DAYS(DateStr : String) : Word;
var YY,MM,DD: Word;
begin
  Result := 365;
  DecodeDateStr(DateStr, YY,MM,DD);
  if      Copy(DateStr,5,4) >= '0229' then YY := YY+1
//  else if Copy(DateStr,5,4) = '0229' then YY := YY+1
  else if Copy(DateStr,5,4) < '0229' then YY := YY;
  Result := Result + Ord(IsLeapYear(YY));
end;

{몇년몇개월의 합-->몇년 몇개월로 표시}
function AddYM(YYMM,YM:String):string;
begin
  Result := MonthsToYM(YMToMonths(YM)+YMToMonths(YYMM));
end;

{몇년몇개월의 차-->몇년 몇개월로 표시}
function SubYM(YYMM,YM:String):string;
begin
  Result:=MonthsToYM(YMToMonths(YYMM)-YMToMonths(YM));
end;

function EncodeHYMD(YYMMDD:String):String;
begin
  Result := '';
  if StrToFloatDef(YYMMDD,0) = 0 then exit;
  case Length(YYMMDD) of
    8 : Result:=Copy(YYMMDD,1,4)+'년'+Copy(YYMMDD,5,2)+'월'+Copy(YYMMDD,7,2)+'일';
    6 : Result:=Copy(YYMMDD,1,2)+'년'+Copy(YYMMDD,3,2)+'월'+Copy(YYMMDD,5,2)+'일';
  end
end;

function EncodeHYM(YYMM:String):String;
begin
  Result := '';
  if StrToFloatDef(YYMM,0) = 0 then exit;
  case Length(YYMM) of
    6 : Result:=Copy(YYMM,1,4)+'년'+Copy(YYMM,5,2)+'월';
    4 : Result:=Copy(YYMM,1,2)+'년'+Copy(YYMM,3,2)+'월';
  end;
end;

function EncodeHMD(MMDD:String):String;
begin
  Result := '';
  if StrToFloatDef(MMDD,0) = 0 then exit;
  case Length(MMDD) of
     4 : Result:=Copy(MMDD,1,2)+'월'+Copy(MMDD,3,2)+'일';
  end;
end;

function EncodeHHNS(HHNNSS:String):String;
begin
  Result := '';
  if StrToFloatDef(HHNNSS,0) = 0 then exit;
  case Length(HHNNSS) of
     4 : Result:=Copy(HHNNSS,1,2)+'시'+Copy(HHNNSS,3,2)+'분';
     6 : Result:=Copy(HHNNSS,1,2)+'시'+Copy(HHNNSS,3,2)+'분' + Copy(HHNNSS,5,2) + '초';
  end;
end;

function EncodeSYMD(YYMMDD:String):String;
begin
  case Length(YYMMDD) of
    8 : Result:=Copy(YYMMDD,1,4)+'-'+Copy(YYMMDD,5,2)+'-'+Copy(YYMMDD,7,2);
    6 : Result:=Copy(YYMMDD,1,2)+'-'+Copy(YYMMDD,3,2)+'-'+Copy(YYMMDD,5,2);
   else Result:='';
  end;
end;

function EncodeSYM(YYMM:String):String;
begin
  case Length(YYMM) of
    6: Result:=Copy(YYMM,1,4)+'-'+Copy(YYMM,5,2);
    4: Result:=Copy(YYMM,1,2)+'-'+Copy(YYMM,3,2);
   else Result:='';
  end;
end;

function EncodeSHNS(HHNNSS:String):String;
begin
  Result := '';
  if StrToFloatDef(HHNNSS, 0) = 0 then exit;
  case Length(HHNNSS) of
    6: Result := Copy(HHNNSS,1,2)+':'+Copy(HHNNSS,3,2)+':'+Copy(HHNNSS,5,2);
  end;
end;

// 300 --> 00:05:00
function EncodeHNS(Duration: Longint; FixLen: Integer = 2): String;
var
  HH, MM, SS: Integer;
begin
  HH := Duration div (60*60);
  MM := (Duration - (HH*60*60)) div (60);
  SS := (Duration - (HH*60*60) - (MM*60)) mod 60;
  Result := Format('%.'+IntToStr(FixLen)+'d:%.2d:%.2d',[HH,MM,SS]);
end;

// 00:05:00 --> 300
function DecodeHNS(sDuration: String): Longint;
var
  HH, MM, SS, Idx: Integer;
begin
  Idx := Pos(':',sDuration);
  HH := StrToIntDef( Copy(sDuration, 1, Idx-1 ) , 0) * (60*60);
  MM := StrToIntDef( Copy(sDuration, Idx+1, 2 ) , 0) * (60);
  SS := StrToIntDef( Copy(sDuration, Idx+4, 2 ) , 0);
  Result := HH+MM+SS;
end;

//19980909 --> 1998년 9월 9일
function EncodePYMD(Format_Str : String) : String;
var
  Date_Buf : String;
begin
  Result := '';
  Date_Buf := ExtractNumeric(Format_Str);
  if (length(Date_Buf) <> 8) and (length(Date_Buf) <> 6) then
    Exit;

  if Length(Date_Buf) = 8 then
  begin
    if CheckYMD(Date_Buf) = true then
      Result := FormatDateTime( 'yyyy"년" m"월" d"일"', DateStrToDate(Date_Buf))
    else
      Result := '----년 --월 --일';
  end
  else
  begin
    if CheckYM(Date_Buf) = true then
    begin
      Date_Buf := Date_Buf + '01';
      Result := FormatDateTime( 'yyyy"년" m"월"', DateStrToDate(Date_Buf+'01'));
    end
    else
      Result := '----년 --월';
  end;
end;

//199809 --> 1998년 9월
function EncodePYM(Format_Str : String) : String;
begin
  Result := EncodePYMD(Format_Str);
end;

function EncodeSYMDHNS(YYMMDD:String):String;
begin
  case Length(YYMMDD) of
    14 : Result:=Copy(YYMMDD,1,4)+'-'+Copy(YYMMDD,5,2)+'-'+Copy(YYMMDD,7,2)+','+Copy(YYMMDD,9,2)+':'+Copy(YYMMDD,11,2)+':'+Copy(YYMMDD,13,2);
    12 : Result:=Copy(YYMMDD,1,2)+'-'+Copy(YYMMDD,3,2)+'-'+Copy(YYMMDD,5,2)+','+Copy(YYMMDD,7,2)+':'+Copy(YYMMDD,9,2)+':'+Copy(YYMMDD,11,2);
   else Result:='';
  end;
end;

function YMDToYM(YYMMDD:String):string;
begin
  case Length(YYMMDD) of
    8 : Result:=Copy(YYMMDD,1,4)+Copy(YYMMDD,5,2);
    6 : Result:=Copy(YYMMDD,1,2)+Copy(YYMMDD,3,2);
   else Result:='';
  end;
end;

function YMDToMDY(YYMMDD:String):string;
begin
  case Length(YYMMDD) of
    8 : Result:=Copy(YYMMDD,5,4)+Copy(YYMMDD,1,4);
    6 : Result:=Copy(YYMMDD,5,4)+Copy(YYMMDD,1,2);
   else Result:='';
  end;
end;

// 다음달을 구한다
function AddMonth(DateStr: String; Base: SmallInt): String;
var
  YY, MM, DD: Word;
  iYear, iMonth, iDay: Integer;
  DeltaYY, DeltaMM: Integer;
begin
  Result := '';

  if CheckYMD(DateStr) = False then
    Exit;

  DecodeDateStr(DateStr, YY, MM, DD);
  iYear := YY;
  iMonth := MM;
  iDay := DD;

  DeltaYY := Base div 12;
  DeltaMM := Base mod 12;

  iMonth := iMonth + DeltaMM;
  iYear := iYear + DeltaYY;
  if DeltaMM > 0 then
  begin
    if iMonth > 12 then
    begin
      iYear := iYear + 1;
      iMonth := iMonth - 12;
    end;
  end
  else if DeltaMM < 0 then
  begin
    if iMonth < 1 then
    begin
      iYear := iYear - 1;
      iMonth := iMonth + 12;
    end;
  end;

  Result := LastDayCheck_Change(Format('%.4d%.2d%.2d', [iYear, iMonth, iDay]));
end;

// 특정한 날을 받았을때 해당월의 마지막날보다 크면 이 날의 마지막날을 보낸다.
function LastDayCheck_Change(DateStr: String): String;
var
  Str_Buf: String;
begin
  Result := '';
  if length(DateStr) <> 8 then
    Exit;

  Str_Buf := copy(DateStr,1,6);
  Str_Buf := LastDayOfMonth(Str_Buf+'01');
  if StrToInt(copy(Str_Buf,7,2)) < StrToInt(copy(DateStr,7,2)) then
    Result := Str_Buf
  else
    Result := DateStr;
end;

function Y2K_Date(dt_str : string) : string;
begin
  if copy(dt_str, 1, 1) < '9' then
  begin
  	result := '20' + dt_str;
  end
  else
  	result := '19' + dt_str;
end;

function CalcSecondElapse(aStrDate1,aStrDate2:String):String;
var
   HYear, HMonth, HDay, Hour, Min, Sec, MSec: Word;
   HDate1, HDate2, DffDate: TDateTime;
   strtemp:String;
begin
  try
    HYear := StrToint(copy(aStrDate1,1,4));
    HMonth:= StrToint(copy(aStrDate1,5,2));
    HDay  := StrToint(copy(aStrDate1,7,2));
    Hour  := StrToint(copy(aStrDate1,9,2));
    Min   := StrToint(copy(aStrDate1,11,2));
    Sec   := StrToint(copy(aStrDate1,13,2));
    MSec  := 0;
    HDate1 := EncodeDate(HYear, HMonth, HDay) + encodeTime(Hour, Min, Sec, MSec);

    HYear := StrToint(copy(aStrDate2,1,4));
    HMonth:= StrToint(copy(aStrDate2,5,2));
    HDay  := StrToint(copy(aStrDate2,7,2));
    Hour  := StrToint(copy(aStrDate2,9,2));
    Min   := StrToint(copy(aStrDate2,11,2));
    Sec   := StrToint(copy(aStrDate2,13,2));
    MSec  := 0;
    HDate2 := EncodeDate(HYear, HMonth, HDay) + encodeTime(Hour, Min, Sec, MSec);

    DffDate := HDate1-HDate2;

    strtemp:=FormatDateTime('HHNNSS',DffDate-Trunc(DffDate));

    strTemp:=IntToStr(Trunc(DffDate)*86400
            +StrToint(copy(strtemp,1,2))*3600
            +StrToint(copy(strtemp,3,2))*60
            +StrToint(copy(strtemp,5,2)));
    Result:=strtemp;
  except
    Result:='0';
  end;
end;

function DateTimeToUnix(const AValue: TDateTime):Int64;
begin
  Result := Round((AValue - UnixDateDelta) * SecsPerDay);
end;

function UnixToDateTime(const AValue: Int64): TDateTime;
begin
  Result := AValue / SecsPerDay + UnixDateDelta;
end;

function DateTimeToUnixKMT(const AValue: TDateTime):Int64;
begin
  Result := Round(( (AValue- ((3600*9)/(3600*24))) - UnixDateDelta) * SecsPerDay);
end;

function UnixToDateTimeKMT(const AValue: Int64): TDateTime;
begin
  Result := (AValue / SecsPerDay + UnixDateDelta) + ((3600*9)/(3600*24));
end;
//=====================================================================================================

end.

