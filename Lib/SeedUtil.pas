unit SeedUtil;

interface

uses
  Windows, Messages, SysUtils, Classes, dialogs;

const
  BLOCK_SIZE = 16;
  RECORD_COUNT = 2000;
  PADDING_VALUE = $00;
  FILE_SIZE_LENGTH = 4;
  LENGTH_VALUE = $FF;

type
  UTF8String  = type String;
  PUTF8String = ^UTF8String;


  BDATA16 = Array[0..BLOCK_SIZE-1]   of Byte;
  BDATA32 = Array[0..BLOCK_SIZE*2-1] of Byte;
  LDATA16 = Array[0..BLOCK_SIZE-1]   of LongWord;
  LDATA32 = Array[0..BLOCK_SIZE*2-1] of LongWord;
  CDATA16 = Array[0..BLOCK_SIZE-1]   of Char;
  CDATA32 = Array[0..BLOCK_SIZE*2-1] of Char;
  CDDATA  = Array of Char;
  TFileReadArrType = Array[0..BLOCK_SIZE*RECORD_COUNT*3-1] of Ansichar;     //여기
  TSendByte = packed array of byte;

  FDATA   = Array[0..FILE_SIZE_LENGTH-1] of Char;

  function UnicodeToUtf8(Dest: PChar; MaxDestBytes: Cardinal; Source: PWideChar; SourceChars: Cardinal): Cardinal;
  function Utf8Encode(const WS: WideString): UTF8String;
  function AnsiToUtf8(const S: string): UTF8String;
  function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: Cardinal; Source: PChar; SourceBytes: Cardinal): Cardinal;
  function Utf8Decode(const S: UTF8String): WideString;
  function Utf8ToAnsi(const S: UTF8String): string;

  procedure SetLen(var LengthBuf : FDATA; ifileSize : Integer);
  function  GetLen(LengthBuf : FDATA): Integer;

  procedure GetKey(var UserKey : BDATA16; srcData: String; blockSize : Integer);
  procedure GetFileKey(var UserKey : BDATA16; FileName: String; blockSize : Integer);
  procedure GetStrKey(var UserKey : BDATA16; sKey: String; blockSize : Integer);
  procedure ArrayBCopy(var desData : BDATA16; srcData : TFileReadArrType; initNum, SizeNum : Integer);
  procedure InsertPadding(var Data : BDATA16; curPos, totalLen, blockSize: Integer);
  function DeletePadding(Data : BDATA16; blockSize: Integer; Flag: Boolean = False): String;
  function SetIntToHex(Data: BDATA16; blockSize: Integer; IsHex: Boolean; nCount: Integer = 2): String;

  function Encrypt(srcStr: TFileReadArrType; Len: Integer; roundKey:LDATA32; IsHex: Boolean): String;
  function Decrypt(srcStr: TFileReadArrType; Len: Integer; roundKey:LDATA32): String;

  function EncryptString(var MakeBuf: TFileReadArrType; const sKey, srcStr: String; nFlag: Integer = 0): Integer; OverLoad;
  function EncryptString(var MakeBuf: TSendByte; const sKey, srcStr: String; nFlag: Integer = 0): Integer; OverLoad;
  function EncryptString(sKey, srcStr: String; nFlag: Integer = 0): String; Overload;
  function EncryptString(srcStr: String; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String; Overload;
  function EncryptString(srcStr: TFileReadArrType; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String; Overload;
  function DecryptString(sKey, srcStr: String; nFlag: Integer = 0): String; Overload;
  function DecryptString(sKey:String; srcStr: TFileReadArrType; Len: Integer; nFlag: Integer = 0): String; Overload;
  function DecryptString(srcStr: String; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String; Overload;
  function DecryptString(srcStr: TFileReadArrType; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String; Overload;

  procedure EncryptFile(keyFileName, inFileName, outFileName: String; nFlag: Integer = 0); Overload;
  function EncryptFile(sKey, inFileName: String; nFlag: Integer = 0): String; Overload;
  procedure DecryptFile(keyFileName, inFileName, outFileName: String; nFlag: Integer = 0); Overload;
  function DecryptFile(sKey, inFileName: String; nFlag: Integer = 0): String; Overload;


var
  FMOD_VALUE: Integer;
  FEND_RECORD: Boolean;

implementation

uses
  Seed,
{$ifdef sds_seed}
  Sha1Util,
{$endif}
  DebugLib;

function UnicodeToUtf8(Dest: PChar; MaxDestBytes: Cardinal; Source: PWideChar; SourceChars: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Cardinal;
begin
  Result := 0;
  if Source = nil then Exit;
  count := 0;
  i := 0;
  if Dest <> nil then
  begin
    while (i < SourceChars) and (count < MaxDestBytes) do
    begin
      c := Cardinal(Source[i]);
      Inc(i);
      if c <= $7F then
      begin
        Dest[count] := Char(c);
        Inc(count);
      end
      else if c > $7FF then
      begin
        if count + 3 > MaxDestBytes then
          break;
        Dest[count] := Char($E0 or (c shr 12));
        Dest[count+1] := Char($80 or ((c shr 6) and $3F));
        Dest[count+2] := Char($80 or (c and $3F));
        Inc(count,3);
      end
      else //  $7F < Source[i] <= $7FF
      begin
        if count + 2 > MaxDestBytes then
          break;
        Dest[count] := Char($C0 or (c shr 6));
        Dest[count+1] := Char($80 or (c and $3F));
        Inc(count,2);
      end;
    end;
    if count >= MaxDestBytes then count := MaxDestBytes-1;
    Dest[count] := #0;
  end
  else
  begin
    while i < SourceChars do
    begin
      c := Integer(Source[i]);
      Inc(i);
      if c > $7F then
      begin
        if c > $7FF then
          Inc(count);
        Inc(count);
      end;
      Inc(count);
    end;
  end;
  Result := count+1;  // convert zero based index to byte count
end;

function Utf8Encode(const WS: WideString): UTF8String;
var
  L: Integer;
  Temp: UTF8String;
begin
  Result := '';
  if WS = '' then Exit;
  SetLength(Temp, Length(WS) * 3); // SetLength includes space for null terminator

  L := UnicodeToUtf8(PChar(Temp), Length(Temp)+1, PWideChar(WS), Length(WS));
  if L > 0 then
    SetLength(Temp, L-1)
  else
    Temp := '';
  Result := Temp;
end;

function AnsiToUtf8(const S: string): UTF8String;
begin
  Result := Utf8Encode(S);
end;

function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: Cardinal; Source: PChar; SourceBytes: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Byte;
  wc: Cardinal;
begin
  if Source = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := Cardinal(-1);
  count := 0;
  i := 0;
  if Dest <> nil then
  begin
    while (i < SourceBytes) and (count < MaxDestChars) do
    begin
      wc := Cardinal(Source[i]);
      Inc(i);
      if (wc and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        wc := wc and $3F;
        if (wc and $20) <> 0 then
        begin
          c := Byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;      // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
          wc := (wc shl 6) or (c and $3F);
        end;
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte

        Dest[count] := WideChar((wc shl 6) or (c and $3F));
      end
      else
        Dest[count] := WideChar(wc);
      Inc(count);
    end;
    if count >= MaxDestChars then count := MaxDestChars-1;
    Dest[count] := #0;
  end
  else
  begin
    while (i < SourceBytes) do
    begin
      c := Byte(Source[i]);
      Inc(i);
      if (c and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        c := c and $3F;
        if (c and $20) <> 0 then
        begin
          c := Byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;      // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
        end;
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte
      end;
      Inc(count);
    end;
  end;
  Result := count+1;
end;

function Utf8Decode(const S: UTF8String): WideString;
var
  L: Integer;
  Temp: WideString;
begin
  Result := '';
  if S = '' then Exit;
  SetLength(Temp, Length(S));

  L := Utf8ToUnicode(PWideChar(Temp), Length(Temp)+1, PChar(S), Length(S));
  if L > 0 then
    SetLength(Temp, L-1)
  else
    Temp := '';
  Result := Temp;
end;

function Utf8ToAnsi(const S: UTF8String): string;
begin
  Result := Utf8Decode(S);
end;

procedure SetLen(var LengthBuf : FDATA; ifileSize : Integer);
begin
  LengthBuf[0] := Chr((ifileSize shr 24) and LENGTH_VALUE);
  LengthBuf[1] := Chr((ifileSize shr 16) and LENGTH_VALUE);
  LengthBuf[2] := Chr((ifileSize shr  8) and LENGTH_VALUE);
  LengthBuf[3] := Chr(ifileSize and LENGTH_VALUE);
end;

function GetLen(LengthBuf : FDATA): Integer;
var
  b1, b2, b3, b4 : Integer;
begin
  b1 := LENGTH_VALUE and Byte(LengthBuf[0]);
  b2 := LENGTH_VALUE and Byte(LengthBuf[1]);
  b3 := LENGTH_VALUE and Byte(LengthBuf[2]);
  b4 := LENGTH_VALUE and Byte(LengthBuf[3]);
  Result := (b1 shl 24) or (b2 shl 16) or (b3 shl 8) or b4;
end;

procedure GetKey(var UserKey : BDATA16; srcData: String; blockSize : Integer);
var
  i: Integer;
begin
  FillChar(UserKey, blockSize, #0);
  for i := 0 to blockSize -1 do
    UserKey[i] := Byte(srcData[i]);
end;

procedure GetFileKey(var UserKey : BDATA16; FileName: String; blockSize : Integer);
var
  pbFileHandle : Integer;
  pcBuffer : CDATA16;
begin
  FillChar(UserKey, blockSize, #0);
  pbFileHandle := FileOpen(FileName, fmOpenRead);
  if pbFileHandle <= 0 then Exit;

  try
    FillChar(pcBuffer, blockSize, #0);
    if FileRead(pbFileHandle, pcBuffer, blockSize) > 0 then
        GetStrKey( UserKey, String(pcBuffer), blockSize );
  finally
    FileClose(pbFileHandle);
  end;
end;

procedure GetStrKey(var UserKey : BDATA16; sKey: String; blockSize : Integer);
var
  i : Integer;
begin
  FillChar(UserKey, blockSize, #0);
{$ifdef sds_seed}
  sKey := SHA1(sKey);
{$endif}
  for i := 0 to blockSize -1 do
    UserKey[i] := Byte(sKey[i+1]);
end;

procedure ArrayBCopy(var desData : BDATA16; srcData : TFileReadArrType; initNum, SizeNum : Integer);
var
  i : Integer;
begin
  for i := initNum to initNum + SizeNum -1 do
    desData[i-initNum] := Byte(srcData[i]);
end;

procedure InsertPadding(var Data : BDATA16; curPos, totalLen, blockSize: Integer);
var
  i: Integer;
begin
  if curPos+blockSize <= totalLen then Exit;

  for i := totalLen-curPos to blockSize - 1 do
    Data[i] := PADDING_VALUE;
// Debug.Write(1, 99999, 'InsertPadding blockSize-(totalLen-curPos)='+IntToStr(blockSize-(totalLen-curPos)));
{$ifndef sds_seed}
  Data[blockSize - 1] := Byte(blockSize-(totalLen-curPos));
{$endif}
end;

// flag: 마지막인이고 16보다 작은것 = True
function DeletePadding(Data : BDATA16; blockSize: Integer; Flag: Boolean = False): String;
var
  i, restLen : Integer;
begin
  Result := '';
{$ifdef sds_seed}
  restLen := 16-FMOD_VALUE;
{$else}
  restLen := Byte(Data[blockSize - 1]);
{$endif}
{
  if (Data[blockSize - 2] <> PADDING_VALUE) and (restLen > 1 ) then
  begin
    // Debug.Write(1, 99999, 'DeletePadding  Byte(Data[blockSize - 2]) <> PADDING_VALUE restLen='+IntToStr(restLen)+', Byte(Data[blockSize - 2])='+Format('%d',[Byte(Data[blockSize - 2])]) );
    restLen :=  20;
  end;
{}
  if (restLen > (blockSize - 1)) or (not Flag) then
  begin
    // Debug.Write(1, 99999, 'DeletePadding restLen > blockSize - 1 restLen='+IntToStr(restLen));
    for i := 0 to blockSize - 1 do
      Result := Result + AnsiChar(Data[i]);
  end
  else
  begin
    // Debug.Write(1, 99999, 'DeletePadding  restLen <= blockSize - 1 restLen='+IntToStr(restLen));
    for i := 0 to blockSize - restLen - 1 do
    begin
      Result := Result + AnsiChar(Data[i]);
      // Debug.Write(1, 2002, 'DeletePadding '+Format('[%.d] Hex[%2x]',[i,Data[i]]));
    end;
  end;
  // Debug.Write(1, 99999, 'DeletePadding  Finished Result='+Result);
end;

function SetIntToHex(Data: BDATA16; blockSize: Integer; IsHex: Boolean; nCount: Integer = 2): String;
var
  i : Integer;
  tempStr : String;
begin
  tempStr := '';
  for i := 0 to blockSize -1 do
  begin
    if isHex then
      tempStr := tempStr + IntToHex(Data[i], nCount)
    else
    tempStr := tempStr + Char(Data[i]);
  end;
  Result := tempStr;
end;

function Encrypt(srcStr: TFileReadArrType; Len: Integer; roundKey: LDATA32; IsHex: Boolean): String;
var
  c: Integer;
  pbData: BDATA16;
begin
  // Debug.Write(1, 99999, 'Encrypt Started!!!');
  Result := '';
  c := 0;
  while True do
  begin
    if c >= Len then Break;
    FillChar(pbData, BLOCK_SIZE, #0);
    ArrayBCopy(pbData, srcStr, c, BLOCK_SIZE);
    // Debug.Write(1, 99999, 'Encrypt c='+IntToStr(c)+', Len='+IntToStr(Len));
    InsertPadding(pbData, c, Len, BLOCK_SIZE);
    SeedEncrypt(pbData, roundKey);
    Result := Result + SetIntToHex(pbData, BLOCK_SIZE, IsHex);
//    Debug.Write(9, 99999, 'Encrypt Result = '+Result);
    Inc(c, BLOCK_SIZE);
  end;
  // Debug.Write(1, 99999, 'Encrypt Finished!!!');
end;

function Decrypt(srcStr: TFileReadArrType; Len: Integer; roundKey:LDATA32): String;
var
  c: Integer;
  pbData: BDATA16;
begin
  // Debug.Write(1, 99999, 'Decrypt Started!!!');
  Result := '';
  c := 0;
  while True do
  begin
    if c >= Len then Break;
    // Debug.Write(1, 99999, 'Decrypt c='+IntToStr(c)+', Len='+IntToStr(Len));
    FillChar(pbData, BLOCK_SIZE, #0);
    ArrayBCopy(pbData, srcStr, c, BLOCK_SIZE);
    SeedDecrypt(pbData, roundKey);
    Result := Result + DeletePadding(pbData, BLOCK_SIZE, (Len-c = BLOCK_SIZE) and FEND_RECORD  );
    Inc(c, BLOCK_SIZE);
  end;
 // Debug.Write(1, 99999, 'Decrypt Finished!!! Result='+Result);
end;

{*
 String 암호화
 srcStr: 원본스트링
 roundKey: KEY VALUE
 nFlag: 0: Hex
        1: ASCII
        2: Hex, Utf8변환
        3: ASCII, Utf8변환
*}

function EncryptString(var MakeBuf: TFileReadArrType; const sKey, srcStr: String; nFlag: Integer = 0): Integer;
var
  sReturn: String;
  I: Integer;
  bFlag: Boolean;
begin
  bFlag := nFlag in [1,3];
  sReturn:= EncryptString(skey, srcStr, nFlag-ord(bFlag));

  if bFlag then
  begin
    for I:=0 to (length(sReturn) div 2) -1 do
           MakeBuf[I] := AnsiChar(StrToInt('$'+sReturn[I*2+1]+sReturn[I*2+2])); //여기
//       MakeBuf[I] := Chr(StrToInt('$'+sReturn[I*2+1]+sReturn[I*2+2])); //여기
    Result := Length(sReturn) div 2;
  end
  else
  begin
    StrPLCopy(MakeBuf, sReturn, Length(sReturn));
    Result := Length(sReturn);
  end;
end;

function EncryptString(var MakeBuf: TSendByte; const sKey, srcStr: String; nFlag: Integer = 0): Integer;
var
  sReturn: String;
  I: Integer;
  bFlag: Boolean;
begin

  bFlag := nFlag in [1,3];
  sReturn:= EncryptString(skey, srcStr, nFlag-ord(bFlag));

  if bFlag then
  begin
    SetLength(MakeBuf, length(sReturn) div 2);
    for I:=0 to (length(sReturn) div 2) -1 do
       MakeBuf[I] := StrToInt('$'+sReturn[I*2+1]+sReturn[I*2+2]);
    Result := Length(sReturn) div 2;
  end
  else
  begin
    SetLength(MakeBuf, length(sReturn));
    for I:=0 to length(sReturn) -1 do
       MakeBuf[I] := Byte(sReturn[I+1]);
    Result := Length(sReturn);
  end;
end;

function EncryptString(sKey, srcStr: String; nFlag: Integer = 0): String;
var
  pbUserKey: BDATA16;
  pdwRoundKey: LDATA32;
begin
  FillChar(pbUserKey,   BLOCK_SIZE,   #0);
  FillChar(pdwRoundKey, BLOCK_SIZE*2, #0);

  GetStrKey(pbUserKey,sKey, BLOCK_SIZE);
  SeedEncRoundKey(pdwRoundKey, pbUserKey);

  Result := EncryptString(srcStr, Length(srcStr), pdwRoundKey, nFlag);
end;

function EncryptString(srcStr: String; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String;
var
  Buffer: TFileReadArrType;
begin
  FillChar(Buffer, Length(Buffer), #0);
  StrPLCopy(Buffer, srcStr, Len);
  Result := EncryptString(Buffer, Len, roundKey, nFlag);
end;

function EncryptString(srcStr: TFileReadArrType; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String;
var
  I, r: Integer;
  tStrSource, tStrDest: String;
begin
  // Debug.Write( 1, 2002, 'EncryptString srcStr='+String(srcStr) );
  r := Len;
  if nFlag in [2, 3] then
  begin
    tStrSource := AnsiToUtf8(String(srcStr));
    r := Length(tStrSource);
    // Debug.Write(1, 2002, 'EncryptString Utf8변환 r='+IntToStr(r)+', 변환자료='+tStrSource);
    FillChar(srcStr, Length(srcStr), #0);
    StrPLCopy(srcStr, tStrSource, r);
  end;
  tStrDest := Encrypt(srcStr, r, roundKey, nFlag in [0,2]);
{
  for i := 1 to Length(tStrSource) do
  begin
    Debug.Write(1, 2002, 'EncryptString TFileReadArrType Source '+Format('String[%.d] Hex[%2x]',[i,ord(tStrSource[I])]));
  end;
  Debug.Write(1, 2002, '------------');
  for i := 1 to Length(tStrDest) do
  begin
    Debug.Write(1, 2002, 'EncryptString TFileReadArrType Encrypt '+Format('[%.d] Hex[%2x]',[i,ord(tStrDest[I])]));
  end;
{}
//  Debug.Write(1, 2002, 'EncryptString TFileReadArrType tStrDest= '+tStrDest);
  Result := tStrDest;
end;

{*
 String 복호화
 srcStr: 암호원본스트링
 roundKey: KEY VALUE
 nFlag: 0: Hex
        1: ASCII
        2: Hex, Utf8변환
        3: ASCII, Utf8변환
*}
function DecryptString(sKey, srcStr: String; nFlag: Integer = 0): String;
var
  pbUserKey: BDATA16;
  pdwRoundKey: LDATA32;
begin
  FillChar(pbUserKey,   BLOCK_SIZE,   #0);
  FillChar(pdwRoundKey, BLOCK_SIZE*2, #0);

  GetStrKey(pbUserKey,sKey, BLOCK_SIZE);
  SeedEncRoundKey(pdwRoundKey, pbUserKey);

  Result := DecryptString(srcStr, Length(srcStr), pdwRoundKey, nFlag);
end;

function DecryptString(sKey:String; srcStr: TFileReadArrType; Len: Integer; nFlag: Integer = 0): String;
var
  pbUserKey: BDATA16;
  pdwRoundKey: LDATA32;
begin
  FillChar(pbUserKey,   BLOCK_SIZE,   #0);
  FillChar(pdwRoundKey, BLOCK_SIZE*2, #0);

  GetStrKey(pbUserKey,sKey, BLOCK_SIZE);
  SeedEncRoundKey(pdwRoundKey, pbUserKey);

  Result := DecryptString(srcStr, Len, pdwRoundKey, nFlag);
end;

function DecryptString(srcStr: String; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String;
var
  Buffer: TFileReadArrType;
begin
  FillChar(Buffer, Length(Buffer), #0);
  StrPLCopy(Buffer, srcStr, Len);
  FEND_RECORD := True;
  Result := DecryptString(Buffer, Len, roundKey, nFlag);
end;

function DecryptString(srcStr: TFileReadArrType; Len: Integer; roundKey: LDATA32; nFlag: Integer = 0): String;
var
  Buffer: TFileReadArrType;
  r: Integer;
  tStrDest: String;
begin
  r := Len;
  if nFlag in [0,2] then
  begin
    r := r div 2;
    FillChar(Buffer, Length(Buffer) , #0);
    HexToBin(srcStr, Buffer, r );
    tStrDest := Decrypt( Buffer , r , roundKey);
    case nFlag of
    0: begin
         // Debug.Write(1, 2002, 'DecryptString = '+tStrDest);
         Result :=  tStrDest;
       end;
    2: begin
         // Debug.Write(1, 2002, 'DecryptString = '+Utf8ToAnsi(tStrDest));
         Result := Utf8ToAnsi(tStrDest);
       end;
    end;
  end
  else
  begin
    tStrDest := Decrypt( srcStr , r, roundKey );
    case nFlag of
    1: begin
         // Debug.Write(1, 2002, 'DecryptString = '+tStrDest);
         Result := tStrDest;
       end;
    3: begin
         // Debug.Write(1, 2002, 'DecryptString = '+Utf8ToAnsi(tStrDest));
         Result := Utf8ToAnsi(tStrDest);
       end;
    end;
  end;
end;

{*
 파일 암호화
 keyFileName: Key File Name
 inFileName: 원본파일
 outFileName: 암호화 파일
 nFlag: 0: Hex
        1: ASCII
        2: Hex, Utf8변환
        3: ASCII, Utf8변환
*}
procedure EncryptFile(keyFileName, inFileName, outFileName: String; nFlag: Integer = 0);
var
  F1: Integer;
  F2: TextFile;
  r: Longint;
  pbUserKey: BDATA16;
  pdwRoundKey: LDATA32;
  Buffer: TFileReadArrType;

  ifileSize : Integer;
  LengthBuf : FDATA;
  i: integer;
begin
  FillChar(pbUserKey,   BLOCK_SIZE,   #0);
  FillChar(pdwRoundKey, BLOCK_SIZE*2, #0);

  if FileExists(keyFileName) then
  begin
    GetFileKey(pbUserKey,keyFileName, BLOCK_SIZE);
  end
  else
  begin
    GetStrKey(pbUserKey,keyFileName, BLOCK_SIZE);
  end;
  SeedEncRoundKey(pdwRoundKey, pbUserKey);

  try
    FileClose(FileCreate(PChar(outFileName)));
    F1 := FileOpen(inFileName, fmOpenRead);

    AssignFile(F2, outFileName);
    Append(F2);

{$ifdef sds_seed}
    ifileSize := GetFileSize(F1, nil);
    SetLen(LengthBuf, ifileSize);
    for i := 0 to FILE_SIZE_LENGTH-1 do
    begin
      Write(F2, LengthBuf[i]);
    end;
{$endif}

    while True do
    begin
      FillChar(Buffer, Length(Buffer), #0);
      r := FileRead(F1, Buffer, BLOCK_SIZE*RECORD_COUNT );
      // Debug.Write(1, 2002, 'EncryptFile r='+IntToStr(r));
      if not ( r > 0 ) then break;

      Write(F2, EncryptString( Buffer, r, pdwRoundKey, nFlag ));
    end;
  finally
    FileClose(F1);
    CloseFile(F2);
  end;
end;

//자료전송시 한번만 Read하여 처리해줌.
function EncryptFile(sKey, inFileName: String; nFlag: Integer = 0): String;
var
  F1: Integer;
  pbUserKey: BDATA16;
  pdwRoundKey: LDATA32;
  r: Integer;
  Buffer: TFileReadArrType;
begin
  Result := '';
  FillChar(pbUserKey,   BLOCK_SIZE,   #0);
  FillChar(pdwRoundKey, BLOCK_SIZE*2, #0);

  GetStrKey(pbUserKey,sKey, BLOCK_SIZE);
  SeedEncRoundKey(pdwRoundKey, pbUserKey);

  try
    F1 := FileOpen(inFileName, fmOpenRead);

    while True do
    begin
      FillChar(Buffer, Length(Buffer), #0);
      r := FileRead(F1, Buffer, BLOCK_SIZE*RECORD_COUNT );
      // Debug.Write(1, 2002, 'EncryptFile r='+IntToStr(r));
      if not ( r > 0 ) then break;

      Result := EncryptString( Buffer, r, pdwRoundKey, nFlag );
      Break;
    end;
  finally
    FileClose(F1);
  end;
end;

{*
 파일 복호화
 keyFileName: Key File Name
 inFileName: 원본파일
 outFileName: 암호화 파일
 nFlag: 0: Hex
        1: ASCII
        2: Hex, Utf8변환
        3: ASCII, Utf8변환
*}
procedure DecryptFile(keyFileName, inFileName, outFileName: String; nFlag: Integer = 0 );
var
  F1: Integer;
  F2: TextFile;
  r: Longint;
  pdwRoundKey: LDATA32;
  pbUserKey: BDATA16;
  Buffer: TFileReadArrType;

  ifileSize, itfileSize : Integer;
  LengthBuf : FDATA;
begin
  FillChar(pbUserKey,   BLOCK_SIZE,   #0);
  FillChar(pdwRoundKey, BLOCK_SIZE*2, #0);

  if FileExists(keyFileName) then
  begin
    GetFileKey(pbUserKey,keyFileName, BLOCK_SIZE);
  end
  else
  begin
    GetStrKey(pbUserKey,keyFileName, BLOCK_SIZE);
  end;
  SeedEncRoundKey(pdwRoundKey, pbUserKey);

  try
    FileClose(FileCreate(PChar(outFileName)));
    F1 := FileOpen(inFileName, fmOpenRead);

    AssignFile(F2, outFileName);
    Append(F2);

    itfileSize := FileSeek(F1, 0, 2);
    FileSeek(F1, 0, 0);

{$ifdef sds_seed}
    r := FileRead(F1, LengthBuf, FILE_SIZE_LENGTH );
    ifileSize := GetLen( LengthBuf );
    FMOD_VALUE := ifileSize mod 16;
{$endif}

    while True do
    begin
      FillChar(Buffer, Length(Buffer) , #0);
      r := FileRead(F1, Buffer, BLOCK_SIZE*RECORD_COUNT );
      FEND_RECORD := itfileSize = FileSeek(F1, 0, 1);
      // Debug.Write(1, 2002, 'DecryptFile r='+IntToStr(r));
      if not ( r > 0 ) then break;

      Write(F2, DecryptString( Buffer, r, pdwRoundKey, nFlag ) );
    end;
  finally
    FileClose(F1);
    CloseFile(F2);
  end;
end;


//자료전송시 한번만 Read하여 처리해줌.
function DecryptFile(sKey, inFileName: String; nFlag: Integer = 0): String;
var
  F1: Integer;
  pbUserKey: BDATA16;
  pdwRoundKey: LDATA32;
  r: Integer;
  Buffer: TFileReadArrType;
begin
  Result := '';
  FillChar(pbUserKey,   BLOCK_SIZE,   #0);
  FillChar(pdwRoundKey, BLOCK_SIZE*2, #0);

  GetStrKey(pbUserKey,sKey, BLOCK_SIZE);
  SeedEncRoundKey(pdwRoundKey, pbUserKey);

  try
    F1 := FileOpen(inFileName, fmOpenRead);

    while True do
    begin
      FillChar(Buffer, Length(Buffer), #0);
      r := FileRead(F1, Buffer, BLOCK_SIZE*RECORD_COUNT );
      // Debug.Write(1, 2002, 'EncryptFile r='+IntToStr(r));
      if not ( r > 0 ) then break;

      Result := DecryptString( Buffer, r, pdwRoundKey, nFlag );
      Break;
    end;
  finally
    FileClose(F1);
  end;
end;

end.
