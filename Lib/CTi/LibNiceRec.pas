{/==============================================================================
  Name : LibNiceRec
  Name-kr : Nice녹취서버Lib
  Ver : 1.0.0.1
  Description : Nice녹취서버용 DLL Lib
  Changes :
    2005. 02. 28 : 1.0.0.1 각 녹취서버별로 Lib 분리
    2004. 04. 20 : 1.0.0.0 Nice+동방 통합 Lib 구성
//=============================================================================}
unit LibNiceRec;

interface

uses
  Sysutils, varRec, libRec;

const
  {Rec}
  RECDLLFNC1    = 'clscapi.dll';
  RECDLLFNC1Sub = 'nice.dll';
  {Play}
  SAVEDLLFNC1 = 'PlayBackMFC.dll';

  loggerIdArr: array[0..3] of Integer = (10039701,
                                         10217701,
                                         10217702,
                                         10039703);
  IPArr: array[0..3] of String = ('192.168.1.15',
                                  '192.168.1.19',
                                  '192.168.1.18',
                                  '192.168.1.22');
  loggerId1 = 2529501;//192.168.1.15
  loggerId2 = 10217702;//192.168.1.19
  loggerId3 = 10217701;//192.168.1.18
  loggerId4 = 2846001;//192.168.1.22
  loggerId5 = 10039702;//192.168.1.25

  SvrErrMsg: array[0..3] of String = ('CLS_RC_SUCCESS',//Call successfully completed.
                                      'CLS_RC_GENERAL_FAILURE',//General error received from NiceCLS Server. Call clsGetError().
                                      'CLS_RC_COMMUNICATION_FAILURE',//Communication with NiceCLS Server failed. Call clsGetError().
                                      'CLS_RC_TEMPORARY_FAILURE');//Internal NiceCLS failure (temporary failure). You should retry

  ErrMsg: array[0..17] of String = ('PLAYBACK_STATUS_OK',                    //0
                                    'PLAYBACK_LOGGER_ADDRESS_NOT_FOUND',     //1
                                    'PLAYBACK_ILLEGAL_NUMBER_OF_LOGGERS',    //2
                                    'PLAYBACK_ALLOCATION_FAILED',            //3
                                    'PLAYBACK_INIT_SERVERS_FAILURE',         //4
                                    'PLAYBACK_MAX_LOGGERS_ALREADY_DEFINED',  //5
                                    'PLAYBACK_LOGGER_ADDRESS_TOO_LONG',      //6
                                    'PLAYBACK_STOP_TIME_EXCEEDS_START_TIME', //7
                                    'PLAYBACK_ADD_DEVICE_FAILURE',           //8
                                    'PLAYBACK_OVER_LAN_FAILED',              //9
                                    'PLAYBACK_SAVE_WAV_FAILED',              //10
                                    'PLAYBACK_SAVE_AUD_FAILED',              //11
                                    'PLAYBACK_LOCATE_FAILED',                //12
                                    'PLAYBACK_AUDIO_NOT_ON_DISK',            //13
                                    'PLAYBACK_LOGGERS_LIST_NOT_SUBMITTED',   //14
                                    'PLAYBACK_NOT_CONNECTED',                //15
                                    'FILENAME_DUPLICATION',                  //16
                                    'SaveProcess_FAILED');                   //17


  {Rec}
//1. 녹취서버 접속함수 - 인자값(녹취IP, 녹취Port)
function clsConnectionOpen(IP:PChar; Port:Longint): Longint; stdcall; External RECDLLFNC1;
//2. 녹취서버 접속해제함수 - 인자값(X)
function clsConnectionClose: Longint; StdCall; External RECDLLFNC1;
//3. 녹음 시작함수 - 인자값(내선번호, AgentID(CTI_ID), 전화번호, 녹취ID, 내선번호(Sub), 컨택여부, 주민번호, 콜분류(c5))
function CtiStartCallfun(Station:PChar;
                         AgentID:Longint;
                         PhoneNumber:PChar;
                         CID:PChar;
                         CallID:Longint;
                         Contract:String;
                         JuminNo:PChar;
                         CallType:PChar
                         ): Longint; StdCall; External RECDLLFNC1Sub;
//4. 녹음 종료함수 - 인자값(내선번호, AgentID(CTI_ID), 전화번호, 녹취ID, 내선번호(Sub), 컨택여부, 주민번호, 콜분류(c5))
function CtiEndCallfun(Station:PChar;
                       AgentID:Longint;
                       PhoneNumber:PChar;
                       CID:PChar;
                       CallID:Longint;
                       Contract:String;
                       JuminNo:PChar;
                       CallType:PChar
                       ): Longint; StdCall; External RECDLLFNC1Sub;


  {Play}
//녹취서버 접속 함수(4 in 1) - 서버증설로 사용x
function ConnectToLogger(IP: String; loggerId:Longint): Longint; stdcall; External SAVEDLLFNC1;
//녹취서버 접속 함수
function InitLogger(): Longint; stdcall; External SAVEDLLFNC1;
function SetNumLogger(LoggerNum: Integer): Longint; stdcall; External SAVEDLLFNC1;
function AddLogger(IP: String; loggerId:Longint): Longint; stdcall; External SAVEDLLFNC1;
function SubmitLogger(): Longint; stdcall; External SAVEDLLFNC1;
//녹취서버 접속해제 함수
function DisconnectLogger: Longint; stdCall; External SAVEDLLFNC1;
//녹취 플레이 함수
function PlaybackStart(loggerId, channel: Longint; startTime, stopTime: String): Longint; stdcall; External SAVEDLLFNC1;
//눅취파일 저장 함수
function AudFileSave(loggerId, channel: longint; startTime, stopTime, filePath: String;errorCode: Longint): Longint; stdcall; External SAVEDLLFNC1;
function WavFileSave(loggerId, channel: longint; startTime, stopTime, filePath: String;errorCode: Longint): Longint; stdcall; External SAVEDLLFNC1;


    //========================================================
    function NiceServInitialize(var Err: String; bFlag: Boolean=False): Integer;
    function NiceServConnect(ARec: TRecServRec): Boolean;
    function NiceServDisConnect: Boolean;
    function NiceRecStart(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;
    function NiceRecStop(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;


implementation

function NiceServInitialize(var Err: String; bFlag: Boolean): Integer;
var
  nChkRtn: Integer;
begin
  //InitLogger
  Result := 1;
  nChkRtn := InitLogger;
  if nChkRtn <> 0 then
  begin
    Err := 'InitLogger : "'+ErrMsg[nChkRtn]+'"';
    Exit;
  end;
  //SetNumLogger
  Result := 2;
  if not bFlag then nChkRtn := SetNumLogger(8)
  else nChkRtn := SetNumLogger(2);
  if nChkRtn <> 0 then
  begin
    Err := 'SetNumLogger : "'+ErrMsg[nChkRtn]+'"';
    Exit;
  end;
  //AddLogger
  if not bFlag then
  begin
    Result := 3;
    nChkRtn := AddLogger('192.168.1.15', loggerId1);
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger1 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;
    Result := 4;
    nChkRtn := AddLogger('192.168.1.19', loggerId2);
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger2 : "'+ErrMsg[nChkRtn]+'"';
      Exit;                                                                  
    end;
    Result := 5;
    nChkRtn := AddLogger('192.168.1.18', loggerId3);
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger3 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;
  end;
  Result := 6;
  nChkRtn := AddLogger('192.168.1.22', loggerId4);
  if nChkRtn <> 0 then
  begin
    Err := 'AddLogger4 : "'+ErrMsg[nChkRtn]+'"';
    Exit;
  end;
  //SubmitLogger
  Result := 7;
  nChkRtn := SubmitLogger;
  if nChkRtn <> 0 then
  begin
    Err := 'SubmitLogger : "'+ErrMsg[nChkRtn]+'"';
    Exit;
  end;
  Err := '';
  Result := 0;
end;

function NiceServConnect(ARec: TRecServRec): Boolean;
var
  nResult: Integer;
begin
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceServConnect', 'start', '', 'NICE 녹취서버와 연결 시작'));
  nResult := clsConnectionOpen(PChar(ARec.RecIP), StrToInt(ARec.RecPort));
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'clsConnectionOpen', 'process', IntToStr(nResult)));
  Result := nResult=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceServConnect', 'end', '', 'NICE 녹취서버와 연결 종료'));
end;

function NiceServDisConnect: Boolean;
var
  nResult: Integer;
begin
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceServDisConnect', 'start', '', 'NICE 녹취서버와 연결해제 시작'));
  nResult := clsConnectionClose;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'clsConnectionClose', 'process', IntToStr(nResult)));
  Result := nResult=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceServDisConnect', 'end', '', 'NICE 녹취서버와 연결해제 종료'));
end;

function NiceRecStart(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;
  function RecStart(nCnt: Integer): Integer;
  begin
    with ADataRec do
    begin
      FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'RacDataRec', 'value', '', Station+','+AgentID+','+AgentNM+','+PhoneNumber+','+CID+','+CallID+','+Contract+','+JuminNo+','+CallType));
      try
        Result := CtiStartCallfun(PChar(Station),
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
      FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'CtiStartCallfun', 'process'+IntToStr(nCnt), IntToStr(Result), 'NICE 녹취 '+IntToStr(nCnt)+'차 시도'));
    end;
  end;
var
  nLoop, nReturn: Integer;
begin
  Result := False;
  nReturn := 9;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceRecStart', 'start', ''));
  for nLoop := 1 to nLoopCount do
  begin
    nReturn := RecStart(nLoop);
    case ABS(nReturn) of
      0 : break;
      2 : NiceServConnect(AServRec);
    end;
  end;
  Result := nReturn=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceRecStart', 'end', ''));
end;

function NiceRecStop(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;
var
  nLoop, nReturn: Integer;
begin
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceRecStop', 'start', ''));
  with ADataRec do
  begin
    try
      for nLoop := 1 to nLoopCount do
      begin
        nReturn := CtiEndCallfun(PChar(Station),
                                 StrToInt64(AgentID),
                                 PChar(PhoneNumber),
                                 PChar(CID),
                                 StrToInt64(CallID),
                                 Contract,
                                 PChar(JuminNo),
                                 PChar(CallType));
        case ABS(nReturn) of
          0 : break;
          2 : NiceServConnect(AServRec);
        end;
      end;
    except
      nReturn := 99999;
    end;
  end;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'CtiEndCallfun', 'process', IntToStr(nReturn), 'NICE 녹취 종료'));
  Result := nReturn=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrNice], 'NiceRecStop', 'end', ''));
end;


{
type
  TCls_Call_Information_Ex_Rec = record//packed record
    lSwitchId         : Longint;
    lCallId           : Longint;
    lAgentId          : Longint;
    cTrunkGroup       : array [0..8] of Char;  //typedef char CLS_TRUNK_GROUP[CLS_TRUNK_NUMBER_L+1];
    cTrunkNumber      : array [0..8] of Char;  //typedef char CLS_TRUNK_NUMBER[CLS_TRUNK_NUMBER_L+1];
    cStation          : array [0..20] of Char; //typedef char CLS_STATION_EX[CLS_STATION_EX_L+1];
    cDepartment       : array [0..8] of Char;  //typedef char CLS_DEPARTMENT[CLS_DEPARTMENT_L+1];
    cDeviceType       : array [0..1] of Char;  //typedef char CLS_DEVICE_TYPE[CLS_DEVICE_TYPE_L+1];
    lDeviceId         : Longint;
    cDirection        : array [0..1] of Char;  //typedef char CLS_DIRECTION[CLS_DIRECTION_L+1];
    cPhoneNumber      : array [0..40] of Char; //typedef char CLS_PHONE_NUMBER_EX[CLS_PHONE_NUMBER_EX_L+1];
    cInwardDialing    : array [0..40] of Char; //typedef char CLS_INWARD_DIALING_EX[CLS_INWARD_DIALING_EX_L+1];
    cTrunkName        : array [0..20] of Char; //typedef char CLS_TRUNK_NAME[CLS_TRUNK_NAME_L+1];
    cAgentName        : array [0..20] of Char; //typedef char CLS_AGENT_NAME[CLS_AGENT_NAME_L+1];
    lRecordFlag       : Longint;
    lRecordingTrunk   : Longint;
    lRecordingChannel : Longint;
    lCallEvents       : Longint;
    lEventTime        : Longint;

    lDuration         : Longint;
    cOptID1           : array [0..20] of Char; //typedef char CLS_OPT_ID1[CLS_OPT_ID1_L+1];
    cOptID2           : array [0..20] of Char; //typedef char CLS_OPT_ID2[CLS_OPT_ID2_L+1];
    lOptID3           : Longint;
    lOptID4           : Longint;

    lEventAudioDelay  : Longint;

    lOtherSwitchId    : Longint;
    lCallIndex        : Longint;
    lCallClass        : Longint;
    lDepartmentCode   : Longint;
    lRecPriority      : Longint;
    lProdPriority     : Longint;
    lInitiatorType    : Longint;
    cInitiatorID      : array [0..40] of Char; //typedef char CLS_INITIATOR_ID[CLS_INITIATOR_ID_L+1];

    cOptID5           : array [0..40] of Char; //typedef char CLS_OPT_ID5[CLS_OPT_ID5_L+1];
    cOptID6           : array [0..40] of Char; //typedef char CLS_OPT_ID6[CLS_OPT_ID6_L+1];
    cOptID7           : array [0..30] of Char; //typedef char CLS_OPT_ID7[CLS_OPT_ID7_L+1];
    cOptID8           : array [0..30] of Char; //typedef char CLS_OPT_ID8[CLS_OPT_ID8_L+1];
    lOptID9           : Longint;
    lOptID10          : Longint;
    lOptID11          : Longint;
    lOptID12          : Longint;

    cExternalCallID   : array [0..40] of Char; //typedef har CLS_EXTARNAL_CALL_ID[CLS_EXTR_CID_L+1];
    cReserved2        : array [0..40] of Char; //typedef char CLS_RESERVED2[CLS_RESRV2_L+1];
    cReserved3        : array [0..20] of Char; //typedef char CLS_RESERVED3[CLS_RESRV3_L+1];
    cReserved4        : array [0..20] of Char; //typedef char CLS_RESERVED4[CLS_RESRV4_L+1];
    lCompoundId       : Longint;
    lOtherAgentId     : Longint;
    lReserved7        : Longint;
    lReserved8        : Longint;
  end;

  TCls_Call_Resp_Rec = record
    lCLSCallId : Longint;
    lReserved1 : Longint;
    lReserved2 : Longint;
    lReserved3 : Longint;
    lReserved4 : Longint;
    cReserved  : array [0..64 - 1] of Char;    //typedef char cReserved[64];
  end;

type  PCls_Call_Information_Ex_Rec = ^TCls_Call_Information_Ex_Rec;
type  PPCls_Call_Information_Ex_Rec = ^PCls_Call_Information_Ex_Rec;
type  PCls_Call_Resp_Rec = ^TCls_Call_Resp_Rec;
type  PPCls_Call_Resp_Rec = ^PCls_Call_Resp_Rec;{}

{  //3. 녹음 시작함수
  function clsStartCallEx(PCls_Call_Information_Ex_Rec:PPCls_Call_Information_Ex_Rec; PCls_Call_Resp_Rec:PPCls_Call_Resp_Rec): Longint; stdcall; External RECDLLFNC;
  //4. 녹음 종료함수
  function clsEndCallEx(PCls_Call_Information_Ex_Rec:PPCls_Call_Information_Ex_Rec; PCls_Call_Resp_Rec:PPCls_Call_Resp_Rec): Longint; stdcall; External RECDLLFNC;
  function clsCallInfoExInitial(Cls_Call_Information_Ex_Rec:PCls_Call_Information_Ex_Rec): Longint; stdcall; External RECDLLFNC;{}

end.




