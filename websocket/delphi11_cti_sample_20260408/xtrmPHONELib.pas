unit xtrmPHONELib;

interface

uses
  Windows, Classes,  SysUtils, System.IniFiles;

type
  TxtrmPHONELib = class(TObject)
  private
    function IniDeleteKey(IniFileName, Section, Ident: String): Boolean;
    function IniReadInteger(IniFileName, Section, Ident: String; Default: Integer): Integer;
    function IniReadString(IniFileName: String; Section, Ident, Default: AnsiString): AnsiString;
    function IniWriteInteger(IniFileName, Section, Ident: String; Value: Integer): Boolean;
    function IniWriteString(IniFileName, Section, Ident, Value: String): Boolean;
  public
    function fn_GetOption(sIniFilePath: String): Boolean;
  end;

  TOptionRec = record
    IsWebSocketURL1: String;
    IsWebSocketURL2: String;
    IsCtiServer: String;
    IsExtension: String;
    IsInitMode: String;
    IsOverrideLogin: Boolean;
    IsAutoReconnect: Boolean;

    IsUserID  : String;
    IsPhoneID : String;

    IsAutoAnswer: Boolean;
    IsCatchCall: Boolean;
    IsTelNumberNoCheck: Boolean;
    IsPhoneBookHisDay: Integer;
    IsAccessCode: String;
  end;

var
  OptionRec: TOptionRec;
  PhoneLib: TxtrmPHONELib;

implementation


function TxtrmPHONELib.fn_GetOption(sIniFilePath: String):Boolean;
begin
  Result := True;
  try

    OptionRec.IsWebSocketURL1    := IniReadString(sIniFilePath, 'Connection', 'WebSocketUrl1' , '');
    OptionRec.IsWebSocketURL2    := IniReadString(sIniFilePath, 'Connection', 'WebSocketUrl2' , '');
    OptionRec.IsCtiServer        := IniReadString(sIniFilePath, 'Connection', 'CtiServer'    , '');
    OptionRec.IsExtension        := IniReadString(sIniFilePath, 'Connection', 'Extension'    , '');
    OptionRec.IsInitMode         := IniReadString(sIniFilePath, 'Connection', 'InitMode'     , '');
    OptionRec.IsOverrideLogin    := Uppercase(IniReadString(sIniFilePath, 'Connection', 'OverrideLogin', 'False'))='TRUE';
    OptionRec.IsAutoReconnect    := Uppercase(IniReadString(sIniFilePath, 'Connection', 'AutoReconnect', 'False'))='TRUE';

    OptionRec.IsUserID           := IniReadString(sIniFilePath, 'AgentInfo', 'UserID', '');
    OptionRec.IsPhoneID          := IniReadString(sIniFilePath, 'AgentInfo', 'PhoneID', '');

    OptionRec.IsAutoAnswer       := Uppercase(IniReadString(sIniFilePath, 'Common', 'IsAutoAnswer', 'False'))='TRUE';
    OptionRec.IsCatchCall        := Uppercase(IniReadString(sIniFilePath, 'Common', 'IsCatchCall', 'False'))='TRUE';
    OptionRec.IsTelNumberNoCheck := Uppercase(IniReadString(sIniFilePath, 'Common', 'IsTelNumberNoCheck', 'False'))='TRUE';
    OptionRec.IsPhoneBookHisDay  := StrToIntDef(IniReadString(sIniFilePath, 'Common', 'IsPhoneBookHisDay', '1'),1);
    OptionRec.IsAccessCode       := IniReadString(sIniFilePath, 'Common', 'IsAccessCode', '9');
  except
    Result := False;
  end;
end;


//Ini파일에서 문자읽기
function TxtrmPHONELib.IniReadString(IniFileName : String; Section, Ident, Default : AnsiString) : AnsiString;
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
function TxtrmPHONELib.IniReadInteger(IniFileName : String; Section, Ident : String; Default : Integer) : Integer;
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
function TxtrmPHONELib.IniWriteString(IniFileName : String; Section, Ident, Value : String) : Boolean;
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
function TxtrmPHONELib.IniWriteInteger(IniFileName : String; Section, Ident : String; Value : Integer) : Boolean;
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
function TxtrmPHONELib.IniDeleteKey(IniFileName : String; Section, Ident : String) : Boolean;
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


initialization
  PhoneLib := TxtrmPHONELib.Create;

finalization
  FreeAndNil(PhoneLib);

end.
