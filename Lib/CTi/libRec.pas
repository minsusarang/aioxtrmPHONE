{/==============================================================================
  Name : libRec
  Name-kr : 녹취서버 프로젝트용 lib
  Ver : 1.0.0.0
  Description : 녹취서버에서 각 프로젝트에 사용할 lib 선언
  Changes :
    2005. 03. 07 : 1.0.0.0 녹취서버 프로젝트용 lib 생성
//=============================================================================}
unit libRec;

interface

uses
  Windows, Sysutils, Forms, FileCtrl, varRec;
type
  TRecLog = class(TObject)
  private
    procedure LogStart(AFileName: String);
    procedure LogStop;
    { Private declarations }

  protected
    constructor Create;
  public
    destructor Destroy; override;
    class function CreateInstance: TRecLog;
  public
    function Log(Msg: String): Boolean;
    function LogValue(AServ, AFnc, AAct, AResult: String; AMsg: String=''): String;
    { Public declarations }
  end;



    //========================================================
    function RecConn(ARec: TRecordRec): Boolean;
    function RecDisConn(ARec: TRecordRec): Boolean;
    function RecStart(ARecordRec: TRecordRec; ADataRec: TRecDataRec): Boolean;
    function RecStop(ARecordRec: TRecordRec; ADataRec: TRecDataRec): Boolean;
    procedure ClearRecDataRec(ADataRec: TRecDataRec);

var
  FRecLog: TRecLog;

implementation

uses
{$IFDEF vtm}
  libVTMRec,
{$ENDIF}
{$IFDEF nice}
  libNiceRec,
{$ENDIF}
  libDBRec;

constructor TRecLog.Create;
begin
  inherited Create;
end;

destructor TRecLog.Destroy;
begin
  inherited;
end;

class function TRecLog.CreateInstance: TRecLog;
begin
  if not Assigned(FRecLog) then FRecLog := TRecLog.Create;
  Result := FRecLog;
end;

procedure InitLibrary;
var
  sDir: String;
begin
  TRecLog.CreateInstance;
  sDir := ExtractFilePath(Application.ExeName)+'RecLog';
  if not DirectoryExists(sDir) then ForceDirectories(sDir);
  FRecLog.LogStart(sDir+'\RecLog_'+FormatDateTime('YYYYMMDD', Now)+'.txt');
end;

procedure DoneLibrary;
begin
  FRecLog.LogStop;
  FreeAndNil(FRecLog);
end;

procedure TRecLog.LogStart(AFileName: String);
var
  fp: Integer;
  F: TextFile;
begin
  FLogName := AFileName;
  if not FileExists(FLogName) then
  begin
    fp := FileCreate(FLogName);
    FileClose(fp);
  end;
  try
    AssignFile(F, FLogName);
    Append(F);
    Writeln(F, '[START]=========================================================================');
    CloseFile(F);
  except
    Exit;
  end;
end;

procedure TRecLog.LogStop;
var
  F: TextFile;
begin
  try
    AssignFile(F, FLogName);
    Append(F);
    Writeln(F, '[END]===========================================================================');
    Writeln(F, '');
    CloseFile(F);
  except
    Exit;
  end;
end;

function TRecLog.Log(Msg: String): Boolean;
var
  F: TextFile;
begin
  Result := False;
  try
    AssignFile(F, FLogName);
    Append(F);
    Writeln(F, Format('[%s] %s;', [TimeToStr(Now), Msg]));
    CloseFile(F);
  except
    Exit;
  end;
  Result := True;
end;

function TRecLog.LogValue(AServ, AFnc, AAct, AResult: String;
  AMsg: String=''): String;
var
  xStr: String;
begin
  xStr := '';
  xStr := xStr+'Svr="'+Format('%-10.10s',[AServ])+'"';
  xStr := xStr+', Fnc="'+Format('%-20.20s',[AFnc])+'"';
  xStr := xStr+', Act="'+Format('%-10.10s',[AAct])+'"';
  xStr := xStr+', Rtn="'+Format('%-5.5s',[AResult])+'"';
  if AMsg<>'' then
    xStr := xStr+', Msg="'+Format('%-.100s',[AMsg])+'"';
  Result := xStr;
end;


function RecConn(ARec: TRecordRec): Boolean;
begin
  TRecSvrConnArr[0] := False;
  TRecSvrConnArr[1] := False;
  if ARec.IsRec then
  begin
    try
      case ARec.MainServ.RecGB of
        1 : TRecSvrConnArr[0] := True;
{$IFDEF nice}
        2 : TRecSvrConnArr[0] := NiceServConnect(ARec.MainServ);
{$ENDIF}
{$IFDEF vtm}
        3 : TRecSvrConnArr[0] := VTMServConnect(ARec.MainServ);
{$ENDIF}
      end;
    except
    end;
    if ARec.IsDualRec then
    begin
      try
        case ARec.SubServ.RecGB of
          1 : TRecSvrConnArr[1] := True;
{$IFDEF nice}
          2 : TRecSvrConnArr[1] := NiceServConnect(ARec.SubServ);
{$ENDIF}
{$IFDEF vtm}
          3 : TRecSvrConnArr[1] := VTMServConnect(ARec.SubServ);
{$ENDIF}
        end;
      except
      end;
    end;
  end;
  Result := (TRecSvrConnArr[0] or TRecSvrConnArr[1]) or (not ARec.IsRec);
end;

function RecDisConn(ARec: TRecordRec): Boolean;
var
  bRtnMain, bRtnSub: Boolean;
begin
  bRtnMain := False;
  bRtnSub  := False;
  if ARec.IsRec then
  begin
    if TRecSvrConnArr[0] then
    begin
      try
        case ARec.MainServ.RecGB of
          1 : bRtnMain := True;
{$IFDEF nice}
          2 : bRtnMain := NiceServDisConnect;
{$ENDIF}
{$IFDEF vtm}
          3 : bRtnMain := VTMServDisConnect;
{$ENDIF}
        end;
      except
      end;
    end;
    if ARec.IsDualRec then
    begin
      try
        case ARec.SubServ.RecGB of
          1 : bRtnSub := True;
{$IFDEF nice}
          2 : bRtnSub := NiceServDisConnect;
{$ENDIF}
{$IFDEF vtm}
          3 : bRtnSub := VTMServDisConnect;
{$ENDIF}
        end;
      except
      end;
    end;
  end;
  Result := (bRtnMain or bRtnSub) or (not ARec.IsRec);
end;

function RecStart(ARecordRec: TRecordRec; ADataRec: TRecDataRec): Boolean;
begin
  TRecResultArr[0] := False;
  TRecResultArr[1] := False;
  if ARecordRec.IsRec then
  begin
    try
      with ARecordRec do
      begin
        case MainServ.RecGB of
          1 : TRecResultArr[0] := DBRecStart(MainServ, ADataRec, MainServ.RecRepeat);
{$IFDEF nice}
          2 : TRecResultArr[0] := NiceRecStart(MainServ, ADataRec, MainServ.RecRepeat);
{$ENDIF}
{$IFDEF vtm}
          3 : TRecResultArr[0] := VTMRecStart(MainServ, ADataRec, MainServ.RecRepeat);
{$ENDIF}
        end;
      end;
    except
    end;
    if ARecordRec.IsDualRec then
    begin
      try
        with ARecordRec do
        begin
          case SubServ.RecGB of
            1 : TRecResultArr[1] := DBRecStart(SubServ, ADataRec, SubServ.RecRepeat);
{$IFDEF nice}
            2 : TRecResultArr[1] := NiceRecStart(SubServ, ADataRec, SubServ.RecRepeat);
{$ENDIF}
{$IFDEF vtm}
            3 : TRecResultArr[1] := VTMRecStart(SubServ, ADataRec, SubServ.RecRepeat);
{$ENDIF}
          end;
        end;
      except
      end;
    end;
  end;
  Result := (TRecResultArr[0] or TRecResultArr[1]) or (not ARecordRec.IsRec);
end;

function RecStop(ARecordRec: TRecordRec; ADataRec: TRecDataRec): Boolean;
var
  bRtnMain, bRtnSub: Boolean;
begin
  bRtnMain := False;
  bRtnSub  := False;
  if ARecordRec.IsRec then
  begin
    with ARecordRec do
    begin
      case MainServ.RecGB of
        1 : bRtnMain := DBRecStop(MainServ, ADataRec);
{$IFDEF nice}
        2 : bRtnMain := NiceRecStop(MainServ, ADataRec, MainServ.RecRepeat);
{$ENDIF}
{$IFDEF vtm}
        3 : bRtnMain := VTMRecStop(ADataRec);
{$ENDIF}
      end;
    end;
    if ARecordRec.IsDualRec then
    begin
      with ARecordRec do
      begin
        case SubServ.RecGB of
          1 : bRtnSub := DBRecStop(SubServ, ADataRec);
{$IFDEF nice}
          2 : bRtnSub := NiceRecStop(SubServ, ADataRec, SubServ.RecRepeat);
{$ENDIF}
{$IFDEF vtm}
          3 : bRtnSub := VTMRecStop(ADataRec);
{$ENDIF}
        end;
      end;
    end;
  end;
  Result := (bRtnMain or bRtnSub) or (not ARecordRec.IsRec);
end;

procedure ClearRecDataRec(ADataRec: TRecDataRec);
begin
  with ADataRec do
  begin
    Station     := '';
    AgentID     := '';
    AgentNM     := '';
    PhoneNumber := '';
    CID         := '';
    CallID      := '';
    Contract    := 'N';
    JuminNo     := '';
    CallType    := '';
  end;
end;

initialization
  InitLibrary;

finalization
  DoneLibrary;

end.




