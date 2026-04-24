////////////////////////////////////////////////////////////////////////////////
//                              Nagi's NiceRecLib                             //
////////////////////////////////////////////////////////////////////////////////
// Ver. 1.0.0.0                                                               //
// Last Update : 2004. 04. 20                                                 //
////////////////////////////////////////////////////////////////////////////////
unit NiceRecLib;//[DebugCode:32xxx]

interface

uses
  Windows, Sysutils,  varSCplus5,
  //CTMP 추가...
{$IFDEF avaya_ctmp}
  varCTMP,
{$ENDIF}
{$IFDEF avaya_ctmp4}
  varCTMP4,
{$ENDIF}
{$IFDEF avaya_ctmp5}
  varCTMP5,
{$ENDIF}
  DebugLib;

const
  {동방 - rec}
  RECDLLFNC1    = 'Dbic_rec.dll';
  {동방 - wav Changer}
  SAVEDLLFNC1   = 'g723_wav_dll.dll';

  {Nice - Rec}
  RECDLLFNC2    = 'clscapi.dll';
  RECDLLFNC2Sub = 'nice.dll';
  {Nice - Play}
  SAVEDLLFNC2 = 'PlayBackMFC.dll';

  loggerId1 = 10039701;//192.168.1.15  NL1
  loggerId2 = 10039703;//192.168.1.18  NL2
  loggerId3 = 10217701;//192.168.1.19  NL3
  loggerId4 = 10039702;//192.168.1.25  NL4
  loggerId5 = 10556802;//192.168.1.31  NL5
  loggerId6 = 10727902;//192.168.1.32  NL6
  loggerId7 = 11229801;//192.168.1.22  검색용 NL1
  loggerId8 = 11229802;//192.168.1.21  검색용 NL2
  loggerId9 = 11190001;//192.168.1.34  검색용 NL3
  loggerId10 = 11229505;//192.168.1.225  검색용 NL4
  loggerId11 = 11229501;//192.168.1.195  검색용 NL5
  loggerId12 = 11229503;//192.168.1.197  검색용 NL6
  loggerId13 = 11229803;//192.168.1.199  검색용 NL7
  loggerId14 = 11409601;//192.168.1.196  검색용 NL8
  loggerId15 = 11409602;//192.168.1.198  검색용 NL9

  gNumLogger = 30;
  TLoggerIdArr: array[0..3] of LongInt = (2529501,   //192.168.1.15
                                          10217702,  //192.168.1.19
                                          10217701,  //192.168.1.18
                                          10039702); //192.168.1.25
{
  TIPArr: array[0..3] of String = ('192.168.1.15',
                                   '192.168.1.19',
                                   '192.168.1.18',
                                   '192.168.1.25');
{}
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


  {동방 - Rec}

//1. 녹음 시작함수 - 인자값(녹취IP, 녹취Port, 녹음내선번호(4), CID(15), PCS번호(15), 상담원ID(8), 상담원이름(10))
function Rec_Start(IP, Port, Device ,CID, PCS, S_ID, S_NAME:PChar):Boolean; stdcall; External RECDLLFNC1;
//2. 녹음 종료함수 - 인자값(녹취IP, 녹취Port, 녹음내선번호(4))
function Rec_Stop(IP, Port, Device: PChar): Boolean; stdcall; External RECDLLFNC1;
//3. 녹음 마킹지정 - 인자값(녹취IP, 녹취Port, 녹음내선번호(4))
function Rec_Marking(IP, Port, Device: PChar): Boolean; stdcall; External RECDLLFNC1;


  {동방 - wav Changer}

function g723_wav_convert(G723File, WavFile: PChar): Boolean; stdcall; External SAVEDLLFNC1;


  {Nice - Rec}

//1. 녹취서버 접속함수 - 인자값(녹취IP, 녹취Port)
function clsConnectionOpen(IP:PChar; Port:Longint): Longint; stdcall; External RECDLLFNC2;
//2. 녹취서버 접속해제함수 - 인자값(X)
function clsConnectionClose: Longint; StdCall; External RECDLLFNC2;

//3. temp녹음 시작함수 - 인자값(내선번호, AgentID(CTI_ID), 전화번호, 녹취ID, 내선번호(Sub), 컨택여부, 주민번호, 콜분류(c5))
function CtiStartCallfun(Station:PChar;
                         AgentID:Longint;
                         PhoneNumber:PChar;
                         CID:PChar;
                         CallID:Longint;
                         Contract:String;
                         JuminNo:PChar;
                         CallType:PChar
                         ): Longint; StdCall; External RECDLLFNC2Sub;
//4. temp녹음 종료함수 - 인자값(내선번호, AgentID(CTI_ID), 전화번호, 녹취ID, 내선번호(Sub), 컨택여부, 주민번호, 콜분류(c5))
function CtiEndCallfun(Station:PChar;
                       AgentID:Longint;
                       PhoneNumber:PChar;
                       CID:PChar;
                       CallID:Longint;
                       Contract:String;
                       JuminNo:PChar;
                       CallType:PChar
                       ): Longint; StdCall; External RECDLLFNC2Sub;


  {Nice - Play}

//녹취서버 접속 함수(4 in 1) - 서버증설로 사용x
function ConnectToLogger(IP: String; loggerId:Longint): Longint; stdcall; External SAVEDLLFNC2;
//녹취서버 접속 함수
function InitLogger(): Longint; stdcall; External SAVEDLLFNC2;
function SetNumLogger(LoggerNum: Integer): Longint; stdcall; External SAVEDLLFNC2;
function AddLogger(IP: String; loggerId:Longint): Longint; stdcall; External SAVEDLLFNC2;
function SubmitLogger(): Longint; stdcall; External SAVEDLLFNC2;
//녹취서버 접속해제 함수
function DisconnectLogger: Longint; stdCall; External SAVEDLLFNC2;
//녹취 플레이 함수
function PlaybackStart(loggerId, channel: Longint; startTime, stopTime: String): Longint; stdcall; External SAVEDLLFNC2;
//눅취파일 저장 함수
function AudFileSave(loggerId, channel: longint; startTime, stopTime, filePath: String;errorCode: Longint): Longint; stdcall; External SAVEDLLFNC2;
function WavFileSave(loggerId, channel: longint; startTime, stopTime, filePath: String;errorCode: Longint): Longint; stdcall; External SAVEDLLFNC2;


    //========================================================
    function NiceServInitialize(var Err: String; bFlag: Boolean=False): Integer;
    function NiceServConnect: Integer;
    function NiceServDisConnect: Boolean;
    function RecStart: Boolean;
    function RecStop: Boolean;


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
  if not bFlag then nChkRtn := SetNumLogger(gNumLogger)
  else nChkRtn := SetNumLogger(18);
  if nChkRtn <> 0 then
  begin
    Err := 'SetNumLogger : "'+ErrMsg[nChkRtn]+'"';
    Exit;
  end;
  //AddLogger
  if not bFlag then
  begin
    // 임시 Retrieval 장비로 사용 2006-01-25
    // 임시 Retrieval 장비로 사용 2006-01-25
    Result := 3;
    nChkRtn := AddLogger('192.168.1.15', loggerId1);  // NL1
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger1 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;

    Result := 4;
    nChkRtn := AddLogger('192.168.1.18', loggerId2);  // NL2
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger2 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;
    Result := 5;
    nChkRtn := AddLogger('192.168.1.19', loggerId3);  // NL3
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger3 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;
    Result := 6;
    nChkRtn := AddLogger('192.168.1.25', loggerId4);  // NL4
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger4 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;

    Result := 7;
    nChkRtn := AddLogger('192.168.1.31', loggerId5);  // NL5
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger5 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;
    Result := 8;
    nChkRtn := AddLogger('192.168.1.32', loggerId6);  // NL6
    if nChkRtn <> 0 then
    begin
      Err := 'AddLogger6 : "'+ErrMsg[nChkRtn]+'"';
      Exit;
    end;

  end;
  Result := 9;
  nChkRtn := AddLogger('192.168.1.22', loggerId7); //검색용 NL1
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS1 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 10;
  nChkRtn := AddLogger('192.168.1.21', loggerId8); // 검색용 NL2
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS2 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 11;
  nChkRtn := AddLogger('192.168.1.34', loggerId9); // 검색용 NL3
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS3 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 12;
  nChkRtn := AddLogger('192.168.1.225', loggerId10); // 검색용 NL4
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS4 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 13;
  nChkRtn := AddLogger('192.168.1.195', loggerId11); // 검색용 NL5
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS5 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 14;
  nChkRtn := AddLogger('192.168.1.197', loggerId12); // 검색용 NL6
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS6 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 15;
  nChkRtn := AddLogger('192.168.1.199', loggerId13); // 검색용 NL7
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS7 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 16;
  nChkRtn := AddLogger('192.168.1.196', loggerId14); // 검색용 NL8
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS8 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Result := 17;
  nChkRtn := AddLogger('192.168.1.198', loggerId15); // 검색용 NL9
  if nChkRtn <> 0 then
  begin
    Err := 'AddLoggerS9 : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  //SubmitLogger
  Result := 18;
  nChkRtn := SubmitLogger;
  if nChkRtn <> 0 then
  begin
    Err := 'SubmitLogger : "'+ErrMsg[nChkRtn]+'"';
    Debug.Write(9, 9999, Err);
    Exit;
  end;
  Err := '';
  Result := 0;
end;

function NiceServConnect: Integer;
var
 nResult: Integer;
begin
  nResult := clsConnectionOpen(PChar(RecServRec.RecIP), StrToInt(RecServRec.RecPort));
  if nResult<>0 then
    Debug.Write(9, 80001, 'RecMode="'+IntToStr(RecServRec.RecMode)+'", Result="'+ IntToStr(nResult)+'"');
  Result := nResult;
end;

function NiceServDisConnect: Boolean;
var
  ErrCode: Integer;
begin
  Result := False;
  ErrCode := clsConnectionClose;
  if ErrCode = 0 then Result := True;
end;

function RecStart: Boolean;
  function RecLoop: Integer;
  var
    nReturn: Integer;
  begin
    nReturn := 9;
    case RecServRec.RecMode of
      0 :begin
        CallRec.bRecord := True;
        nReturn := 0;
      end;
      1 :begin//동방
        CallRec.bRecord := Rec_Start(PChar(RecServRec.RecIP), PChar(RecServRec.RecPort),
                           PChar(TmrRec.Device), PChar(CallRec.RecID),
                           PChar(CallRec.TelInfoRec.Tel0+CallRec.TelInfoRec.Tel1+CallRec.TelInfoRec.Tel2),
                           PChar(TmrRec.TmrID), PChar(TmrRec.TmrNM));
        if CallRec.bRecord then nReturn := 0
        else nReturn := 1;
      end;
      2 :begin//nice
        nReturn := CtiStartCallfun(PChar(TmrRec.Device),
                                   StrToInt64(TmrRec.TmrID),
                                   PChar(CallRec.TelInfoRec.Tel0+CallRec.TelInfoRec.Tel1+CallRec.TelInfoRec.Tel2),
                                   PChar(CallRec.RecID),
                                   StrToInt64(TmrRec.Device),
                                   CallRec.Contract,
                                   PChar(CallRec.JuminID),
                                   PChar(''));
        nReturn := Abs(nReturn);
        case nReturn of
          0 :CallRec.bRecord := True;
          1..3 :CallRec.bRecord := False;
        end;
      end;
    end;
    if nReturn<>0 then
      Debug.Write(9, 80001, 'RecMode="'+IntToStr(RecServRec.RecMode)+'", Result="'+ IntToStr(nReturn)+'"');
    Result := nReturn;
  end;
var
  nRtn: Integer;
begin
  Result := False;
  CallRec.bRecord := False;
  Debug.Write(8, 80001, 'Act="Rec 1st"');
  nRtn := RecLoop;
  if nRtn <> 0 then begin
    if (RecServRec.RecMode = 2) and (nRtn = 2) then
    begin
      Debug.Write(9, 80001, 'Act="ServConnect"');
      nRtn := NiceServConnect;
      if nRtn <> 0 then Exit;
    end;
    Debug.Write(9, 80001, 'Act="Rec 2nd"');
    nRtn := RecLoop;
    if nRtn <> 0 then Exit;
  end;
  CallRec.bRecord := True;
  Result := True;
end;

function RecStop: Boolean;
begin
  Result := False;
  if not CallRec.bRecord then Exit;
  case RecServRec.RecMode of
    0 :Result := True;
    1 :begin//동방
      Result := Rec_Stop(PChar(RecServRec.RecIP), PChar(RecServRec.RecPort), PChar(TmrRec.Device));
    end;
    2 :begin//nice
      Result := CtiEndCallfun(PChar(TmrRec.Device),
                               StrToInt64(TmrRec.TmrID),
                               PChar(CallRec.TelInfoRec.Tel0+CallRec.TelInfoRec.Tel1+CallRec.TelInfoRec.Tel2),
                               PChar(CallRec.RecID),
                               StrToInt64(TmrRec.Device),
                               CallRec.Contract,
                               PChar(CallRec.JuminID),
                               PChar('')) = 0;{}
    end;
  end;
  CallRec.bRecord := False;
end;

end.




