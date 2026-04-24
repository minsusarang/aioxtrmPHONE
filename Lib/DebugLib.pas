////////////////////////////////////////////////////////////////////////////////
// Debug에 관련된 Library
////////////////////////////////////////////////////////////////////////////////
unit DebugLib;

interface

uses SysUtils, Windows, DCPcrypt2, DCPsha1, DCPblockciphers, DCPrijndael;

const C1 = 7419; C2 = 5239; Key = 8675;
      HexaChar : array [0..15] of AnsiChar =( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                                          'A', 'B', 'C', 'D', 'E', 'F' );
type
  TDebug = class(TObject)
  private
    FDebugLevel: Integer;
    FFileName: String;
  public
//    constructor Create;
//    destructor Destroy; override;

    function Write(Level, Serial: Integer; Msg: String): Boolean;

    procedure ChangeLevel(DebugLevel: Integer);
    procedure Start(DebugLevel: Integer; AFileName: String);
    procedure Stop;
    property DebugLevel: Integer read FDebugLevel;

  end;

var
  Debug: TDebug;

  g_AES256_LOG     : String;

implementation

{ TDebug }
{
constructor TDebug.Create(DebugLev: Integer; AFileName: String);
begin
  inherited;
end;

destructor TDebug.Destroy;
begin
  inherited;
end;
}
procedure TDebug.ChangeLevel(DebugLevel: Integer);
begin
  FDebugLevel := DebugLevel;
end;

procedure TDebug.Start(DebugLevel: Integer; AFileName: String);
var
  fp: Integer;
begin
  inherited;

  if DebugLevel = 0 then Exit;

  FDebugLevel := DebugLevel;
  FFileName := AFileName;

  if not FileExists(AFileName) then
  begin
    fp := FileCreate(FFileName);
    if fp < 0 then
      DebugLevel :=0;
    FileClose(fp);
  end;
end;

procedure TDebug.Stop;
begin

end;

function TDebug.Write(Level, Serial: Integer; Msg: String): Boolean;
var
  F : TextFile;
  sMessage : string;
  DCP_rijndael: TDCP_rijndael;
begin
  Result := False;
  {$IFDEF dbg}
    OutputDebugString(PChar(Msg));
  {$ENDIF}


  if Copy(Trim(Msg),1,27) = 'select count(*) as cnt from'    then exit;


  if FDebugLevel <= 0 then  exit;
  try
//    sMessage := Msg;

  {$IFDEF NotEncrypt   }
    sMessage := Msg;
  {$ELSE}
    DCP_rijndael := TDCP_rijndael.Create(nil);
//    DCP_rijndael.InitStr ('tele123**', TDCP_sha1);//it is initialized
    DCP_rijndael.InitStr (g_AES256_LOG, TDCP_sha1);//it is initialized

    sMessage := DCP_rijndael.EncryptString (Msg);//it is ciphered
    OutputDebugString(PChar(Msg));
  {$ENDIF}

    if (Level >= FDebugLevel) then
    begin
      try
        AssignFile(F, FFileName);
        Append(F);
        Writeln(F, Format('[%s][%0.3d][%0.5d] %s;', [FormatDateTime('YYYY-MM-DD HH:MM:SS:ZZZ', Now) , Level, Serial, sMessage]));
        CloseFile(F);
      except
        ;
      end;
    end;
  {$IFDEF NotEncrypt   }
    //
  {$ELSE}
    DCP_rijndael.Free;
  {$ENDIF}
  except
  {$IFDEF NotEncrypt   }
    //
  {$ELSE}
    DCP_rijndael.Free;
  {$ENDIF}
  end;
  result := True;
end;




{ Initialization and cleanup }

procedure InitLibrary;
begin
  Debug := TDebug.Create;
end;

procedure DoneLibrary;
begin
  FreeAndNil(Debug);
end;

initialization
  InitLibrary;

finalization
  DoneLibrary;

end.


