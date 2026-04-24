{/==============================================================================
  Name : LibVTMRec
  Name-kr : VTM녹취서버Lib
  Ver : 1.0.0.1
  Description : VTM녹취서버용 DLL Lib
  Changes :
    2005. 02. 28 : 1.0.0.0 VTM녹취서버용 DLL Lib 생성
//=============================================================================}
unit LibVTMRec;

interface

uses
  Sysutils, varRec, libRec;

const
  {rec}
  RECDLLFNC1 = 'VTM.dll';//'VTMCApi.dll';
  RECDLLFNC2 = 'VTMCApi.dll';


  {Rec}
//1. 녹취서버 접속함수 - 인자값(녹취IP, 녹취Port)
function VTMInitialize: Longint; stdcall; External RECDLLFNC1;
function ConnectingTheVTM(IP:PChar; Port:Longint): Longint; stdcall; External RECDLLFNC1;
//2. 녹취서버 접속해제함수 - 인자값(X)
function DisconnectingTheVTM: Longint; stdcall; External RECDLLFNC1;
//3. 녹음 시작함수 - 인자값(내선번호, AgentID(CTI_ID), 전화번호, 녹취ID, 내선번호(Sub), 컨택여부, 주민번호, 콜분류(c5))
function VTMStartCall(Station:PChar;
                      AgentID:Longint;
                      PhoneNumber:PChar;
                      CID:PChar;
                      CallID:Longint;
                      Contract:String;
                      JuminNo:PChar;
                      CallType:PChar
                      ): Longint; StdCall; External RECDLLFNC1;
//4. 녹음 종료함수 - 인자값(내선번호, AgentID(CTI_ID), 전화번호, 녹취ID, 내선번호(Sub), 컨택여부, 주민번호, 콜분류(c5))
function VTMEndCall(Station:PChar;
                    AgentID:Longint;
                    PhoneNumber:PChar;
                    CID:PChar;
                    CallID:Longint;
                    Contract:String;
                    JuminNo:PChar;
                    CallType:PChar
                    ): Longint; StdCall; External RECDLLFNC1;
//5. 에러확인 함수
function VTMGetErrorCode(var nError:Longint): Longint; StdCall; External RECDLLFNC1;

    //========================================================
    function VTMServConnect(ARec: TRecServRec; bReConn: Boolean=False): Boolean;
    function VTMServDisConnect: Boolean;
    function VTMRecStart(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;
    function VTMRecStop(ARec: TRecDataRec): Boolean;


implementation

function VTMServConnect(ARec: TRecServRec; bReConn: Boolean=False): Boolean;
var
  nResult, xEr: Integer;
begin
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMServConnect', 'start', '', 'VTM 녹취서버와 연결 시작'));
  if not bReConn then
  begin
    nResult := VTMInitialize;
    FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMInitialize', 'process', IntToStr(nResult)));
    Result := nResult=0;
    if nResult<>0 then Exit;
  end;
  nResult := ConnectingTheVTM(PChar(ARec.RecIP), StrToInt(ARec.RecPort));
  if nResult<>0 then nResult := VTMGetErrorCode(xEr);
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'ConnectingTheVTM', 'process', IntToStr(nResult)));
  Result := nResult=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMServConnect', 'end', '', 'VTM 녹취서버와 연결 종료'));
end;

function VTMServDisConnect: Boolean;
var
  nResult: Integer;
begin
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMServDisConnect', 'start', '', 'VTM 녹취서버와 연결해제 시작'));
  nResult := DisconnectingTheVTM;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'DisconnectingTheVTM', 'process', IntToStr(nResult)));
  Result := nResult=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMServDisConnect', 'end', '', 'VTM 녹취서버와 연결해제 종료'));
end;

function VTMRecStart(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;
  function RecStart(nCnt: Integer): Integer;
  begin
    with ADataRec do
    begin
      FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'RacDataRec', 'value', '', Station+','+AgentID+','+AgentNM+','+PhoneNumber+','+CID+','+CallID+','+Contract+','+JuminNo+','+CallType));
      try
        Result := VTMStartCall(PChar(Station),
                               StrToInt64(AgentID),
                               PChar(PhoneNumber),
                               PChar(CID),
                               StrToInt64(CallID),
                               Contract,
                               PChar(JuminNo),
                               PChar(CallType));
      except
        Result := 99999;
      end;
      FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMStartCall', 'process'+IntToStr(nCnt), IntToStr(Result), 'VTM 녹취 '+IntToStr(nCnt)+'차 시도'));
    end;
  end;
var
  nLoop, nReturn, xSoc, nErrCode: Integer;
begin
  Result := False;
  nReturn := 9;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMRecStart', 'start', ''));
  for nLoop := 1 to nLoopCount do
  begin
    nReturn := RecStart(nLoop);
    case ABS(nReturn) of
      0 : break;
      2 : VTMServConnect(AServRec, True);
    else
      begin
        nErrCode := VTMGetErrorCode(xSoc);
        FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMGetErrorCode', 'err', 'VTM 에러메세지:'+IntToStr(nErrCode)));
      end;
    end;
  end;
  Result := nReturn=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMRecStart', 'end', ''));
end;

function VTMRecStop(ARec: TRecDataRec): Boolean;
var
  nResult: Integer;
begin
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMRecStop', 'start', ''));
  with ARec do
  begin
    try
      nResult := VTMEndCall(PChar(Station),
                           StrToInt64(AgentID),
                           PChar(PhoneNumber),
                           PChar(CID),
                           StrToInt64(CallID),
                           Contract,
                           PChar(JuminNo),
                           PChar(CallType));
    except
      nResult := 99999;
    end;
  end;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMEndCall', 'process', IntToStr(nResult), 'VTM 녹취 종료'));
  Result := nResult=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrVTM], 'VTMRecStop', 'end', ''));
end;

end.




