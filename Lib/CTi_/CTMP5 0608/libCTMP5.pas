  unit libCTMP5;

interface

uses
  Windows, SysUtils, Classes, varCTMP5, defCTMP5, constCTMP5, Forms, ComCtrls, Dialogs;

type

  TCTMP = class
  private
    function CheckOpenServer(ID : ctmpGateID) : Integer;
  public
    GateID          : ctmpGateID;
//    Invok           : ctmpCenterID;
    Invok           : ctmpInvokeID;
    ServerName      : ctmpNameString;
{$IFDEF avaya_ctmp5}
    ServerName2     : ctmpNameString; //이중화시 사용
    USEHA           : ctmpInt;     // 이중화 사용여부 0 :미사용, 1 : 사용
{$ENDIF}    
    PortNo          : ctmpInt;
    OpenData        : ctmpOpenData;
    DeviceNumber    : ctmpDeviceString;
    iDeviceNumber   : ctmpINT;
    AgentId         : ctmpDeviceString;
    sAgentID        : ctmpDeviceString;  //ctmpINT; //2011.03.03
    AgentData       : ctmpDeviceString;
    AgentGroup      : ctmpDeviceString;
    NetworkType     : ctmpNetString;
    AppName         : ctmpApplString;
    DefPbx          : ctmpINT;
    PrivateData     : ctmpPrivateData;
    AgentMode       : ctmpAgentMode_Def;
    ReasonCode      : ctmpINT;
    CurrentEvent    : ctmpEventData;

    //Call
    CalledNumber    : ctmpDeviceString;
    UEI             : ctmpUEI;
    UUI             : ctmpApplString;
    NewCall         : ctmpConnectionID;
    ActCall         : ctmpConnectionID;
    HeldCall        : ctmpConnectionID;
    NewCall2        : ctmpConnectionID;
    Account         : ctmpApplString;
    AuthCode        : ctmpApplString;
    CI              : ctmpCI;

    //transfer
    nDialNumber     : ctmpDeviceString;
    ConsulCall      : ctmpINT;               //ConsultationCall
    TransCall       : ctmpConnectionID;      //transfer
    nCallList       : ctmpConnectionList;
    nCallClass      : ctmpDeviceClass_Def;

    procedure Initialize;
    procedure Finalize;
    procedure SetStatus(tForm: TCustomForm; tBar: TStatusBar; Index: Integer; Flag: Boolean=True);
    function GetErrorMessage(ErrorCode : ctmpError_Def): String;
    function GetAgentStatus(DeviceNO: ctmpINT = 0): Integer;
//    function GetAgentStatusEx(var AgentRec: TAgentRec; AID: ctmpDeviceString; DeviceNO: ctmpDeviceString ): Integer;
    function GetAgentStatusEx(var AgentRec: TAgentRec; AID: ctmpDeviceString; DeviceNO: ctmpINT =0 ): Integer;
    function GetAgentState: Integer;
    function SetAgentStatus(aMode: ctmpAgentMode_Def; aReasoncode: ctmpINT = 0): Integer;
    function ConnectionServer : Integer;
    function CloseServer(ID: ctmpGateID): Integer;

    procedure fCTIGetErrorMsg(ErrorCode: ctmpError_Def; Msg: String = ''; Flag: Boolean = False);
    function fCtiLogin(sCtiID, sDevice: String): Integer;
    function fCtiLogOut: Integer;
    function fCtiMakeCall(sDial: String; Msg: String=''): Integer;
    function fCtiPWDConfirm(Msg: String=''): Integer;
    function fCtiSingleTransferCall(sDial: String): Integer;
    function fCtiAnswer: Integer;
    function fCtiDisconnect: Integer;
    function fCtiHold: Integer;
    function fCtiRetrieve: Integer;
  end;

//------------------------------------------------------------------------------
//Record - Clear
//------------------------------------------------------------------------------
    procedure prClearRec;
    procedure prClearRecServRec;
    procedure prClearCTIServRec;
    procedure prClearTmrRec;
    procedure prClearCustRec(bFlag: Boolean=True);
    procedure prClearTelInfoRec;
    procedure prClearReservSetRec;
    procedure prClearReservOldRec;
    procedure prClearStateRec;
    procedure prClearCallRec;
    procedure prClearOutBoundRec;
    procedure prClearCallerInfoRec;
var
  CTMP : TCTMP;

implementation

uses
  DebugLib, UtilLib;

procedure TCTMP.Initialize;
begin
  GateID := 0; //old --- 0
  Invok := 0;  //odl --- 0  linkMode 0:none, 1:asai, 2:merdian, 3:csta1, 4:csta2, 5:csta3
  StrCopy(AgentData, PChar('000'));
  StrCopy(AgentGroup, PChar('000'));

  if TmrRec.RemoteLogin then
    StrCopy(ServerName, PChar('192.168.1.153')) //192.168.1.151
  else
    StrCopy(ServerName, PChar(CTIServRec.CTIIP));

{$IFDEF avaya_ctmp5}
  if CTIServRec.HAUSE = 1 then  //cti서버 이중화를 한다면
  begin
    StrCopy(ServerName2, PChar(CTIServRec.CTIIP2));
  end;
{$ENDIF}

  PortNo := StrToIntDef(CTIServRec.CTIPort, 9707);  // old default value : 0
  openData.deviceType     := ctmpV_Station;
  openData.APIversion     := $50;

  if CTIServRec.CTIType = ctmpV_None then openData.APIextensions  := ctmpV_ASAI
  else openData.APIextensions  := CTIServRec.CTIType;
//  Prj.GetCTIServerInfo;
end;

procedure TCTMP.Finalize;
begin
  CloseServer(GateID);
end;

//기존에 접속되어 있는 GateID를 삭제 한다.
function TCTMP.CheckOpenServer(ID : ctmpGateID) : Integer;
var
  i : ctmpGateID;
begin
  Result := 1;
  if ID > 1 then
  begin
    for i := (ID - 1) downto 1 do
    begin
      Result := CloseServer(ID);
    end;
  end;
end;

function TCTMP.ConnectionServer : Integer;
var
  AgentRec: TAgentRec;
  r: Integer;
  nRtn:integer;
begin

  Debug.Write(1, 99991, 'ConnectionServer Started!');
  Initialize;
  Debug.Write(1, 99991, 'ConnectionServer Info : ' + ServerName + ' : ' + inttostr(PortNo));
{$IFDEF avaya_ctmp5}

  if CTIServRec.HAUSE = 1 then //이중화 서버 오픈
  begin
    Result := nxcapiOpenServerHA(GateID, Invok, OpenData, ServerName, ServerName2, PortNo,
                           NetworkType, AppName, ctmpV_SYNC, DefPbx);
    Debug.Write(1, 99991, 'nxcapiOpenServerHA,  Result='+IntToStr(Result)+',  GateID='+IntToStr(GateID)+',  Invok='+IntToStr(Invok));
  end
  else
  begin
    Result := nxcapiOpenServer(GateID, Invok, OpenData, ServerName, PortNo,
                           NetworkType, AppName, ctmpV_SYNC, DefPbx);
    Debug.Write(1, 99991, 'nxcapiOpenServer,  Result='+IntToStr(Result)+',  GateID='+IntToStr(GateID)+',  Invok='+IntToStr(Invok));
  end;
{$ENDIF}

  if Result <> ctmpNormal then
  begin
    fCTIGetErrorMsg( Result, 'ConnectionServer - ctmpOpenServer' );
    Exit;
  end;

  Result := nxcapiMonitorStart(GateID, Invok);
  Debug.Write(1, 99991, 'nxcapiMonitorStart,  Result='+IntToStr(Result));
  if Result <> ctmpNormal then
  begin
    fCTIGetErrorMsg( Result, 'nxcapiMonitorStart - ctmpMonitorStart' );
{$IFDEF avaya_ctmp5}
  if USEHA = 0 then //단일화 서버 클로즈
  begin
    nxcapiCloseServer(GateID, Invok);
  end
  else
  begin
    nxcapiCloseServerHA(GateID, Invok);
  end;
{$ENDIF}
    Exit;
  end;

  Result := GetAgentStatusEx(AgentRec, sAgentID); //,TmrRec.Device
  Debug.Write(1, 99991, 'GetAgentStatusEx,  Result='+IntToStr(Result));

  if AgentRec.eAgentMode <> ctmpV_AgentLogout then
  begin
//    if (MessageBox(0, PChar('다른 상담원이 아이디['+IntToStr(iAgentID)+']를 사용중에 있습니다.'+#13+#10+''+#13+#10+   2011.03.03
    if (MessageBox(0, PChar('다른 상담원이 아이디['+(sAgentID)+']를 사용중에 있습니다.'+#13+#10+''+#13+#10+
                      '상담원상태['+IntToStr(AgentRec.eAgentMode)+'], 사용DN['+IntToStr(AgentRec.eAgentDN)+'] '+#13+#10+''+#13+#10+
                     '로그아웃시키고 로그인 하시겠습니까?'), 'CTMP', MB_ICONQUESTION or MB_OKCANCEL) = IDOK) then

    nRtn := Ctmp.fCtiLogOut;
  if nRtn <> ctmpNormal then
  begin
    //prStatusMsg(sTitle+Ctmp.GetErrorMessage(nRtn));
    Exit;
  end;

 //   r := SetAgentStatus(ctmpV_AgentLogout);
    Debug.Write(1, 99991, 'SetAgentStatus ctmpV_AgentLogout,  Result='+IntToStr(r));
    Result := SetAgentStatus(ctmpV_AgentLogIn);
//    SetAgentStatus(ctmpV_AgentReady)
  end
  else
  begin
    Result := SetAgentStatus(ctmpV_AgentLogin);
//    SetAgentStatus(ctmpV_AgentReady);
  end;
  {}

  Debug.Write(1, 99991, 'SetAgentStatus ctmpV_AgentLogIn,  Result='+IntToStr(Result));
  if Result <> ctmpNormal then
  begin
    fCTIGetErrorMsg( Result, 'ConnectionServer - SetAgentStatus' );
    CloseServer(GateID);
    Exit;
  end;

  Result := SetAgentStatus(ctmpV_AgentNotReady, 1);
  Debug.Write(1, 99991, 'SetAgentStatus ctmpV_AgentNotReady,  Result='+IntToStr(Result));
  if Result <> ctmpNormal then
  begin
    fCTIGetErrorMsg( Result, 'ConnectionServer - SetAgentStatus' );
    Exit;
  end;

//  CheckOpenServer(GateID);
end;

function TCTMP.CloseServer(ID: ctmpGateID): Integer;
var
  r: Integer;
begin
  Initialize;
  r := nxcapiMonitorStop(ID, Invok);
{$IFDEF avaya_ctmp5}
  if USEHA = 0 then //단일화 서버 클로즈
  begin
    r := nxcapiCloseServer(ID, Invok);
  end
  else
  begin
    r := nxcapiCloseServerHA(ID, Invok);
  end;
{$ENDIF}


  Result := r;
end;

function TCTMP.SetAgentStatus(aMode: ctmpAgentMode_Def; aReasoncode: ctmpINT = 0): Integer;
begin
  Debug.Write(1, 99991, 'SetAgentStatus '#13#10 + 'DN: ' + DeviceNumber + #13#10'aMode :' + inttostr(amode) + #13#10 + 'agentID : ' + agentID );
  Result := nxcapiSetFeatureAgentStatus(GateID, Invok, DeviceNumber, aMode,
                                      AgentId, AgentData, AgentGroup,
                                      aReasoncode, 0, privateData);
  WorkStateCD := aReasoncode;
end;

function TCTMP.GetAgentStatus(DeviceNO: ctmpINT = 0): Integer;
var
  sAgentMode      : ctmpAgentMode_Def;
  sAgentID        : ctmpDeviceString;
  sReasonCode     : ctmpINT;
  sPrivateData    : ctmpPrivateData;
  Device          : ctmpDeviceString;
begin
  Debug.Write(1, 99991, 'GetAgentStatus Started!');

  System.FillChar(sAgentID, sizeof(sAgentID), $0);
  System.FillChar(sPrivateData, sizeof(sPrivateData), $0);

  if DeviceNo = 0 then   StrCopy(Device, DeviceNumber)
  else StrCopy(Device, PChar(IntToStr(DeviceNo)));


  Result := nxcapiQueryAgentStatus(GateID, Invok, Device, sAgentMode, AgentID, sReasonCode, sPrivateData);
  Debug.Write(1, 99991, 'GetAgentStatus,  GateID='+IntToStr(GateID));
  Debug.Write(1, 99991, 'GetAgentStatus,  Invok='+IntToStr(Invok));
  Debug.Write(1, 99991, 'GetAgentStatus,  DialNumber='+Device);
  Debug.Write(1, 99991, 'GetAgentStatus,  sAgentMode='+IntToStr(sAgentMode));
  Debug.Write(1, 99991, 'GetAgentStatus,  sAgentID='+AgentID);
  Debug.Write(1, 99991, 'GetAgentStatus,  sReasonCode='+IntToStr(sReasonCode));
  Debug.Write(1, 99991, 'GetAgentStatus Ended!');
{}
end;

//function TCTMP.GetAgentStatusEx(var AgentRec: TAgentRec; AID: ctmpDeviceString; DeviceNO: ctmpINT = 0) : Integer;
//function TCTMP.GetAgentStatusEx(var AgentRec: TAgentRec; AID: ctmpINT; DeviceNO: ctmpINT = 0) : Integer;
function TCTMP.GetAgentStatusEx(var AgentRec: TAgentRec; AID: ctmpDeviceString; DeviceNO: ctmpINT ): Integer;
begin
//  Result := ctmpQueryAgentStatusEx(GateID, Invok, iAgentID, iDialNumber,

//  StrLCopy(iAgentID, pChar(@sCtiID[1]), high(iAgentID));

  with AgentRec do
  begin
    Result := nxcapiQueryAgentStatusEx(GateID, Invok, AID,  DeviceNO,
                                     eAgentID, eAgentMode, eAgentDN, eAgentblendMode, eAgentBlockMode, eAgentTime, eAgentType);
  end;
  if Result <> ctmpNormal then  fCTIGetErrorMsg( Result, 'GetAgentStatusEx' );
  Debug.Write(1, 99991, 'GetAgentStatus,  AgentRec.eAgentMode='+IntToStr(AgentRec.eAgentMode));
  Debug.Write(1, 99991, 'GetAgentStatus,  AgentRec.AgentID='+(AgentRec.eAgentID));
end;

function TCTMP.GetAgentState: Integer;
var
  AgentRec: TAgentRec;
  nRtn: Integer;
begin
  Result := -1;
  if GateID > 0 then
  begin
    nRtn := GetAgentStatusEx(AgentRec, sAgentID);
    if nRtn <> ctmpNormal then
    begin
//      ErrorMsg(nRtn);
      Debug.Write(1, 99991, 'SetStatus, GateID='+IntToStr(GateID) + ', GetAgentStatusEx Result='+IntToStr(nRtn)+', '+GetErrorMessage(nRtn));
      Exit;
    end;
    Result := AgentRec.eAgentMode;
  end
  else Result := ctmpV_AgentLogout;
end;

procedure TCTMP.SetStatus(tForm: TCustomForm; tBar: TStatusBar; Index: Integer; Flag: Boolean=True);
var
  nRtn : Integer;
  workStr, notReadyStr : String;
  AgentRec: TAgentRec;
begin

  if Flag  and (GateID > 0)then
  begin
    nRtn := GetAgentStatusEx(AgentRec, sAgentID);
    if nRtn <> ctmpNormal then
    begin
      Exit;
    end;
    gAgentMode := AgentRec.eAgentMode;
  end;

  //서버Open 시에만 적용됨
  case gAgentMode of
  ctmpV_AgentLogin         : workStr := '로그인';       // 10
  ctmpV_AgentLogout        : workStr := '로그아웃';     // 11
  ctmpV_AgentNotReady      :   case WorkStateCD  of
                                0: workStr := '-';
                                1: workStr := '작업';   // 1
                                2: workStr := '이석';   // 2
                                3: workStr := '식사';   // 3
                                4: workStr := '휴식';   // 4
                                5: workStr := '회의';   // 5
                                6: workStr := '교육';   // 6
                                7: workStr := '';
                                8: workStr := '';
                                9: workStr := '';
                                else
                                  workStr := '-';
                                end;
  ctmpV_AgentReady         : workStr := '대기';         // 0
  ctmpV_AgentOtherWork     : workStr := '통화중';       // 12
  ctmpV_AgentAfterCallWork : workStr := '후처리';       // 13
  end;


  Debug.Write(1, 99991, 'SetStatus,  workStr='+workStr);
  if Assigned(tForm) and Assigned(tBar) then
  begin
    with tForm do
      tBar.Panels[Index].Text := workStr;
  end;
end;

function TCTMP.fCtiLogin(sCtiID, sDevice: String): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiLogin :"Start", sCtiID :"'+sCtiID+'", sDevice :"'+sDevice+'"');

  with OpenData do
  begin
    deviceType     := ctmpV_Station;
    APIversion     := ctmpAPIVersion;
    StrCopy(deviceDn, PChar(sDevice));
  end;
  StrCopy(DeviceNumber, PChar(sDevice));
  StrCopy(AgentId, PChar(sCtiID));
  StrCopy(NetWorkType, PChar(ctmpNetWorkType));
  StrCopy(AppName,     PChar(ctmpAppName));
  DefPbx := ctmpDefPbx;
  Invok  := ctmpInvok;
  System.FillChar(privateData, sizeof(privateData), $0);

//  iAgentID := ctmpINT(StrToInt(sCtiID));
//  iAgentID := sCtiID;
  StrLCopy(sAgentID, pChar(@sCtiID[1]), high(sAgentID));
  iDeviceNumber := ctmpINT(StrToInt(sDevice));

  nReturn := ConnectionServer;

  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiLogin :"End", Return :"'+IntToStr(nReturn)+'"');
end;

function TCTMP.fCtiLogOut: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiLogOut :"Start"');

  case GetAgentState of
  ctmpV_AgentLogout :begin
      Result := 1;
    end;
  ctmpV_AgentLogin, ctmpV_AgentReady, ctmpV_AgentNotReady, ctmpV_AgentAfterCallWork:
    begin
      Result := SetAgentStatus(ctmpV_AgentLogout);
      if Result <> ctmpNormal then
      begin
        Exit;
      end;
      if GateID > 0 then Finalize;
      prClearTmrRec;
    end;
  end;
  Debug.Write(1, 31100, 'fCtiLogOut :"End", Return :"'+IntToStr(Result)+'"');
end;

function TCTMP.fCtiMakeCall(sDial: String; Msg: String=''): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiMakeCall :"Start", sDial="'+sDial+'", Msg='+Msg);

  System.FillChar(UEI, sizeof(UEI), $0);
  System.FillChar(CI, sizeof(CI), $0);
  System.FillChar(NewCall, sizeof(NewCall), $0);
  System.FillChar(CalledNumber, sizeof(CalledNumber), $0);

  strCopy(CalledNumber, PChar(sDial)); //대상전화번호
  StrCopy(Account, PChar(''));
  StrCopy(AuthCode, PChar(''));
  StrCopy(UUI, PChar(''));

  with UEI do
  begin
    UEILen := Length(Msg);
    strCopy(UEIData, PChar(Msg));
  end;

  NewCall.deviceID := CalledNumber;
  NewCall.devIDType := STATIC_ID;

  nReturn := nxcapiMakeCall(GateID, Invok, DeviceNumber, CalledNumber, UUI, Account, AuthCode,
                       NewCall,
                       UEI,
                       CI,
                       privateData);
  if nReturn <> ctmpNormal then
  begin
    fCTIGetErrorMsg( Result, 'fCtiMakeCall - nxcapiMakeCall' );
//    Exit;
  end;

  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiMakeCall :"End", Return :"'+IntToStr(nReturn)+'"');
end;



function TCTMP.fCtiPWDConfirm(Msg: String=''): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiPWDConfirm :"Start", Msg='+Msg);

  System.FillChar(UEI, sizeof(UEI), $0);

  with UEI do
  begin
    UEILen := Length(Msg);
    strCopy(UEIData, PChar(Msg));
  end;

  nReturn := nxcapiPwdConfirm(GateID, Invok, iDeviceNumber, 0, UEI);
  if nReturn <> ctmpNormal then
  begin
    fCTIGetErrorMsg( Result, 'fCtiPWDConfirm - nxcapiPwdConfirm' );
//    Exit;
  end;

  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiPWDConfirm :"End", Return :"'+IntToStr(nReturn)+'"');
end;


function TCTMP.fCtiSingleTransferCall(sDial: String): Integer;
var
  nReturn: Integer;
  nNewCall        :   u_int;
begin
  Debug.Write(1, 31100, 'fCtiSingleTransferCall :"Start", sDevice :"'+sDial+'"');

  System.FillChar(UEI, sizeof(UEI), $0);
  System.FillChar(CI, sizeof(CI), $0);
  System.FillChar(NewCall, sizeof(NewCall), $0);
  System.FillChar(CalledNumber, sizeof(CalledNumber), $0);

  strCopy(CalledNumber, PChar(sDial)); //대상전화번호
  StrCopy(Account, PChar(''));
  StrCopy(AuthCode, PChar(''));
  StrCopy(UUI, PChar(''));

  with UEI do
  begin
    UEILen := 0;
    strCopy(UEIData, PChar(''));
  end;

//  NewCall.deviceID := CalledNumber;
//  NewCall.devIDType := STATIC_ID;

  nReturn := nxcapiSingleStepTransfer( GateID,
                                              Invok,
                                              ActCall,
                                              CalledNumber,
                                              ctmpV_On,
                                              nNewCall,
                                              UUI,
                                              Account,
                                              AuthCode,
                                              UEI,
                                              CI);

  if nReturn <> ctmpNormal then
  begin
    fCTIGetErrorMsg( Result, 'fCtiSingleTransferCall - ctmpMakeCall' );
//    Exit;
  end;

  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiSingleTransferCall :"End", Return :"'+IntToStr(nReturn)+'"');
end;

function TCTMP.fCtiAnswer: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiAnswer :"Start"');
  nReturn := nxcapiAnswerCall(GateID, Invok, ActCall, privateData);
  if nReturn <> ctmpNormal then fCTIGetErrorMsg( nReturn , 'fCtiAnswer - ctmpAnswerCall' );
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiAnswer :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Disconnect-----------------------------------------------------
function TCTMP.fCtiDisconnect: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiDisconnect :"Start"');
  nReturn := nxcapiClearConnection(GateID, Invok, ActCall, PrivateData);
  if nReturn <> ctmpNormal then fCTIGetErrorMsg( nReturn , 'fCtiDisconnect - ctmpClearConnection' );
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiDisconnect :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Hold-----------------------------------------------------------
function TCTMP.fCtiHold: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiHold :"Start"');
  nReturn := 9999;
  case GetAgentState of
    ctmpV_AgentOtherWork :begin
      nReturn := nxcapiHoldCall(GateID, Invok, ActCall, Byte('0'), privateData);
      if nReturn <> ctmpNormal then fCTIGetErrorMsg( nReturn , 'fCtiHold - ctmpHoldCall' );
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiHold :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Retrieve-------------------------------------------------------
function TCTMP.fCtiRetrieve: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiRetrieve :"Start"');
  nReturn := 9999;
//  case GetAgentState of
//    ctmpV_AgentOtherWork :begin
      nReturn := nxcapiRetrieveCall(GateID, Invok, HeldCall, privateData);
      if nReturn <> ctmpNormal then fCTIGetErrorMsg( nReturn , 'fCtiHold - ctmpRetrieveCall' );
//    end;
//  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiRetrieve :"End", Return :"'+IntToStr(nReturn)+'"');
end;



procedure TCTMP.fCTIGetErrorMsg(ErrorCode: ctmpError_Def; Msg: String = ''; Flag : Boolean = False);
var
  ErrorMsg: String;
begin
  Debug.Write(1, 31100, 'fCTIGetErrorMsg :"Start"');
  if Msg = '' then
    ErrorMsg := GetErrorMessage(ErrorCode)
  else
    ErrorMsg := Msg + ':' + GetErrorMessage(ErrorCode);
//  ShowMessage('- CTi ErrorMessage -'#13 + GetErrorMessage(ErrorCode));
//  if (not Flag) and (ErrorCode <> ctmpNormal) then
//      MessageBox(0, PChar('['+IntToStr(ErrorCode)+'] : '+GetErrorMessage(ErrorCode)), 'CTMP', MB_ICONERROR or MB_OK)
//  else
//    MessageBox(0, PChar(Msg), 'CTMP', MB_ICONERROR or MB_OK);
  Debug.Write(9, 999,'- CTi ErrorMessage - ' + ErrorMsg);
  Debug.Write(1, 31100, 'fCTIGetErrorMsg :"End", Return :"'+IntToStr(ErrorCode)+'", Msg :"'+ErrorMsg+'"');
end;

function TCTMP.GetErrorMessage(ErrorCode : ctmpError_Def): String;
begin
  case ErrorCode of
  ctmpPbxErr                  : Result := '교환기에서 알 수 없는 error발생';
  ctmpUnspecCstaErr           : Result := 'CSTA가 지원하지 않는 spec';
  ctmpCstaBadErr              : Result := 'Switch	CSTA error';
  ctmpOpGeneric               : Result := 'Op generic';
  ctmpReqIncomWithObj         : Result := 'Request incom with object';
  ctmpValueOutOfRange         : Result := 'Value out of range';
  ctmpObjectNotKnown          : Result := 'Object not known';
  ctmpInvCallingDevice        : Result := '잘못된 발신 전화번호 입니다.';
  ctmpInvCalledDevice         : Result := '잘못된 착신 전화번호 입니다.';
  ctmpInvForwardingDest       : Result := '잘못된 착신전환 전화번호 입니다.';
  ctmpPrivViolSpecDev         : Result := 'Private viol spec device';
  ctmpPrivViolCalledDev       : Result := 'Private viol called device';
  ctmpPrivViolCallingDev      : Result := 'Private viol calling device';
  ctmpInvCallIdentifier       : Result := '잘못된 call Reference ID를 사용하였습니다.';
  ctmpInvDevIdentifier        : Result := '잘못된 device ID를 사용하였습니다.';
  ctmpInvConnIdentifier       : Result := '잘못된 connect ID를 사용하였습니다.';
  ctmpInvalidDest             : Result := '잘못된 목적지입니다.';
  ctmpInvalidFeature          : Result := '잘못된 feature입니다.';
  ctmpInvAllocState           : Result := '잘못된 allocate state입니다.';
  ctmpInvCrossRefId           : Result := '잘못된 cross reference identifier 입니다.';
  ctmpInvObjectType           : Result := '잘못된 object type입니다.';
  ctmpSecurityViol            : Result := 'Security viol';
  ctmpInvCSTAAppCor           : Result := 'Invalid CSTA application correlator';
  ctmpAccountCode             : Result := 'Account code';
  ctmpAuthCode                : Result := 'Authorized code';
  ctmpReqIncCallingDev        : Result := 'Request inc calling device';
  ctmpReqIncCalledDev         : Result := 'Request Inc called device';
  ctmpInvMessageID            : Result := '잘못된 message ID입니다.';
  ctmpMessageIDReq            : Result := 'Message ID request';
  ctmpMediaIncompatible       : Result := 'Media incompatible';
  ctmpStGeneric               : Result := 'St generic';
  ctmpBadObjState             : Result := '구현할 수 없는 상태입니다.';
  ctmpInvConnIdActCall        : Result := 'Active call에 대한 잘못된 connection identifier입니다.';
  ctmpNoActiveCall            : Result := 'Active call이 아닙니다.';
  ctmpNoHeldCall              : Result := '보류호(Held call)가 아닙니다.';
  ctmpNoCallToClear           : Result := 'No call to clear';
  ctmpNoConnToClear           : Result := 'No connection to clear';
  ctmpNoCallToAnswer          : Result := 'No call to answer';
  ctmpNoCallToComplete        : Result := 'No call to complete';
  ctmpNoAbleToPlay            : Result := 'No able to play';
  ctmpNoAbleToResume          : Result := 'No able to resume';
  ctmpEndOfMessage            : Result := '메시지의 끝입니다.';
  ctmpBeginOfMessage          : Result := '메시지의 시작입니다.';
  ctmpMessageSuspended        : Result := '메시지가 정지되었습니다.';
  ctmpSysGeneric              : Result := 'Sys Generic';
  ctmpServiceBusy             : Result := 'Service busy';
  ctmpResourceBusy            : Result := 'Resource busy';
  ctmpResOutOfServ            : Result := 'Resource out of service';
  ctmpNetBusy                 : Result := 'Network busy';
  ctmpNetOutOfServ            : Result := 'Network out of service';
  ctmpOverallMonLimEx         : Result := 'Overall monitor limit Ex';
  ctmpConfMemberLimEx         : Result := 'Conference member limit Ex';
  ctmpSubsGeneric             : Result := 'Subs generic';
  ctmpObjMonLimEx             : Result := 'Object monitor limit Ex';
  ctmpExTrunkLimEx            : Result := 'Ex trunk limit ex';
  ctmpOutstandReqLimEx        : Result := 'Outstand request limit Ex';
  ctmpPerfGeneric             : Result := 'Perf generic';
  ctmpPerfLimEx               : Result := 'Perf limit Ex';
  ctmpUnspecified             : Result := 'Unspecified';
  ctmpSeqNumErr               : Result := 'Sequence numeric error';
  ctmpTimeStampErr            : Result := '시간 에러입니다.';
  ctmpPacErr                  : Result := 'Pac error';
  ctmpSealErr                 : Result := 'Seal error';
  ctmpAlreadyAdded            : Result := '이미 추가된 Device입니다.';
  ctmpAsn1DecodeErr           : Result := '교환기로부터의 메시지를 해독하는데 에러가 발생 했습니다. 개발사에 문의 바랍니다.';
  ctmpAsn1EncodeErr           : Result := '교환기로부터 메시지를 암호화하는데 에러가 발생했습니다. 개발사에 문의 바랍니다.';
  ctmpDupOpenServer           : Result := '다른 사용자가 Open하고자 하는 Device를 이미 Open 하여 사용 중입니다.';
  ctmpFileOpenError           : Result := '에러 메시지 파일을 찾을 수 없습니다.';
  ctmpInvLicenseKey           : Result := '라이센스 키가 틀립니다. 개발사에 문의 바랍니다.';
  ctmpIsCurrentDn             : Result := 'Current DN으로 설정되어 있기 때문에 제거 할 수 없습니다.'+#13#10+'Current DN을 변경하여 주십시오.';
  ctmpIsOpenDn                : Result := 'Open시의 DN으로 설정되어 있기 때문에 제거 할 수 없습니다.'+#13#10+'ctmpCloseServer를 사용하여 주십시오.';
  ctmpLibFail                 : Result := 'API로 부터 존재할 수 없는 메시지가 접수 되었습니다. '+#13#10+'개발사에 문의하여 주십시오.';
  ctmpLinkConnectFail         : Result := '교환기를 접속할 수 없습니다. '+#13#10+'교환기의 상태나 네트워크를 확인하여 주십시오.';
  ctmpLinkDown                : Result := '교환기와의 Link가 해제 되었습니다. '+#13#10+'교환기의 상태나 네트워크를 확인하여 주십시오.';
  ctmpNotMemberDn             : Result := '추가된 Device가 아닙니다. 먼저 ctmpAddDevice를 사용하여 추가하여 주십시오.';
  ctmpNotOpen                 : Result := 'CCSE와 gate가 생성되지 않았습니다. '+#13#10+'ctmpOpenServer를 사용하여 gate를 할당 받으십시오. '+#13#10+'모든 function은 ctmpOpenServer를 사용 후에 이용할 수 있습니다.';
  ctmpOpenLimitReached        : Result := 'CCSE가 Open할 수 있는 최대의 시스템자원을 사용하였습니다. '+#13#10+'개발사에 문의하여 주십시오.';
  ctmpTimeout                 : Result := '교환기가 메시지를 응답하지 않습니다. '+#13#10+'교환기의 상태나 네트워크를 확인하여 주십시오.';
  ctmpTooManyOpens            : Result := 'CCSE가 설정된 최대 Device수 만큼 이미 사용 중 입니다. '+#13#10+'필요치 않는 프로그램을 제거하거나 개발사에 문의하여 최대 Device수를 추가 하여 주십시오. '+#13#10+'CCSE가 설정된 최대 Device수 만큼 이미 사용 중 입니다. '+#13#10+'필요치 않는 프로그램을 제거하거나 개발사에 문의하여 최대 Device수를 추가 하여 주십시오.';
  ctmpUnknownErrCode          : Result := '에러 메시지 파일에 찾고자하는 에러코드가 존재 하지 않습니다.';
  ctmpNotSupport              : Result := 'CCSE가 지원하지 않습니다';
  ctmpCCSEFail                : Result := 'CCSE Processor가 Down되었을때';
  ctmpCCSELinkFailPbx         : Result := 'CCSE와 PBX의 Link가 끊어졌을 때';
  ctmpCCSENoActPbx            : Result := 'CCSE와 PBX의 Link는 살아있지만 PBX가 정상적으로 동작을 하지 않을 때';
  ctmpAlreadyOpen             : Result := '이미 Open되어 있습니다. '+#13#10+'다른 DN으로 Open하려면 먼저 ctmpCloseServer를 사용한 후 다시 Open하십시오.';
  ctmpBodyErr                 : Result := 'CCSE로부터 받은 메시지의 길이가 비정상적입니다. '+#13#10+'개발사에 문의하여 주십시오.';
  ctmpHeadErr                 : Result := 'CCSE로부터 받은 메시지의 종류를 알 수 없습니다. '+#13#10+'개발사에 문의하여 주십시오.';
  ctmpInvAgentMode            : Result := '잘못된 Agent mode를 사용하였습니다.';
  ctmpInvDeviceType           : Result := '잘못된 Device type을 사용하였습니다.';
  ctmpInvDNDMode              : Result := '잘못된 DND mode를 사용하였습니다.';
  ctmpInvGate                 : Result := '잘못된 Gate ID를 사용하였습니다. '+#13#10+'Open시 할당받은 Gate ID를 확인하여 주십시오.';
  ctmpInvNetType              : Result := '잘못된 Network type를 사용하였습니다.';
  ctmpInvParam                : Result := '잘못된 Parameter를 사용하였습니다.';
  ctmpNoEvent                 : Result := 'Event 메시지가 없습니다.';
  ctmpNotOn                   : Result := 'Monitor가 시작되지 않았습니다. '+#13#10+'먼저 ctmpMonitorStart 를 사용하며 Monitor mode를 On시키십시오.';
  ctmpRpcConnectFail          : Result := 'CCSE와 연결이 끊겼습니다. '+#13#10+'CCSE의 상태나 네트워크를 확인하여 주십시오.';
  ctmpServerTimeOut           : Result := 'CCSE가 메시지를 응답하지 않습니다. '+#13#10+'CCSE의 상태나 네트워크를 확인하여 주십시오.';
  ctmpServerUnknown           : Result := 'CCSE를 찾을 수 없습니다. '+#13#10+'CCSE의 설치정보나 네트 워크를 확인하여 주십시오.';
  ctmpUnsupAPIversion         : Result := '지원하지 않는 API 버전입니다.';
  ctmpUnsupProc               : Result := '설정된 Device type에서는 사용할 수 없는 Function 입니다.';
  ctmpAcseTimeout             : Result := 'ACSE Time Out이 발생하였습니다.';
  ctmpAgentIdNotFound         : Result := '없는 Agent ID입니다.';
  ctmpInvalidInvokeId         : Result := '잘못된 Invoke ID입니다';
  ctmpDataNotFound            : Result := 'Data를 찾을 수 없습니다.';
  ctmpInvDN                   : Result := '잘못된 DN입니다.';
  ctmpTooManyMultiAddDeviceDn : Result := '너무 많은 DN을 Add시켰습니다. '+#13#10+'1000개 미만으로 다시 시도해 주십시오.';
  ctmpStartReceiveErr         : Result := 'Socket Receive환경을 초기화 하지 못했습니다.';
  ctmpEtc                     : Result := '';
  else
    Result := '에러 메세지를 확인 할 수 없습니다.'+#13#10+'관리자에게 문의 하시기 바랍니다.';
  end;
end;

//------------------------------------------------------------------------------
//Record - Clear
//------------------------------------------------------------------------------
procedure prClearRec;
begin
  //prClearTmrRec;
  //prClearCustRec;
  //prClearReservOldRec;

  prClearTelInfoRec;
  prClearReservSetRec;
  prClearStateRec;
  prClearCallRec;
  prClearOutBoundRec;
end;

procedure prClearRecServRec;
begin
  Debug.Write(1, 31200, 'prClearRecServRec :"Start"');
  with RecServRec do begin
    RecMode := 0;
    RecIP   := '';
    RecPort := '';
  end;
  Debug.Write(1, 31200, 'prClearRecServRec :"End"');
end;

procedure prClearCTIServRec;
begin
  Debug.Write(1, 31200, 'prClearCTIServRec :"Start"');
  with CTIServRec do begin
{$IFDEF avaya_ctmp5}
    CTIIP   := '';
    CTIIP2  := '';
    CTIPort := '';
    CTIPort2:= '';
    HAUSE   := 0;
{$ELSE}
    CTIIP   := '';
    CTIPort := '';
{$ENDIF}
    CTIType := 0;
  end;
  Debug.Write(1, 31200, 'prClearCTIServRec :"End"');
end;

procedure prClearTmrRec;
begin
  Debug.Write(1, 31200, 'prClearTmrRec :"Start"');
  with TmrRec do begin
    TmrID   := '';
    TmrNM   := '';
    TmrPW   := '';
    TmrJU   := '';
    AgentCD := '';
    PartCD  := '';
    PartSCD  := '';
    CTiID   := '';
    CID     := '';
    InDT    := '';
    OutDT   := '';
    TmLvCD  := '';
    TmrGB   := '3';
    IP      := '';
    Device  := '';
  end;
  Debug.Write(1, 31200, 'prClearTmrRec :"End"');
end;

procedure prClearCustRec(bFlag: Boolean=True);
begin
  Debug.Write(1, 31200, 'prClearCustRec :"Start"');
  with CallRec.CustRec do begin
    if bFlag then CustID := '';
    CustNM    := '';
    JuID      := '';
    CampID    := '';
    CompanyCD := '';
    CompanyNM := '';
  end;
  Debug.Write(1, 31200, 'prClearCustRec :"End"');
end;

procedure prClearTelInfoRec;
begin
  Debug.Write(1, 31200, 'prClearTelInfoRec :"Start"');
  with CallRec.TelInfoRec do begin
    TelSNO     := '0';
    TelGB      := '';
    Tel0       := '';
    Tel1       := '';
    Tel2       := '';
    ContactCD  := '000';
    RelationCD := '000';
  end;
  Debug.Write(1, 31200, 'prClearTelInfoRec :"End"');
end;

procedure prClearReservSetRec;
begin
  Debug.Write(1, 31200, 'prClearReservSetRec :"Start"');
  with ReservSetRec, ReservTel do begin
    TelSNO       := '0';
    TelGB        := '';
    Tel0         := '';
    Tel1         := '';
    Tel2         := '';
    ContactCD    := '000';
    RelationCD   := '000';
    ReservDT     := '';
    ReservTM     := '';
    ReservCustGB := '';
  end;
  Debug.Write(1, 31200, 'prClearReservSetRec :"End"');
end;

procedure prClearReservOldRec;
begin
  Debug.Write(1, 31200, 'prClearReservOldRec :"Start"');
  with ReservOldRec do begin
    ReservID := 'CALL00000000000';
    LateCNT  := '0';
    OCallID  := 'CALL00000000000';
    ReservMM := '';
  end;
  Debug.Write(1, 31200, 'prClearReservOldRec :"End"');
end;

procedure prClearStateRec;
begin
  with CallRec do begin
{    OldState.StateCD  := '';
    OldState.StateSCD := '';
    NewState.StateCD  := '';
    NewState.StateSCD := '';
    EtcState.StateCD  := '';
    EtcState.StateSCD := '';{}
  end;
end;

procedure prClearCallRec;
begin
  Debug.Write(1, 31200, 'prClearCallRec :"Start"');
  with CallRec do begin
    bSaved     := False;
    bDialed    := False;
    bConnected := False;
    bRecord    := False;
    bReConnected := False;
    bWDChecked := False;
    CallID     := '';
    CallDT     := '00000000';
    CallDDT    := '';
    CallDDT1   := Now;
    CallBDT    := '';
    CallBDT1   := Now;
    CallDialTM := '0';
    CallEDT    := '';
    CallEDT1   := Now;
    CallTM     := '0';
    CallSDT    := '';
    CallSDT1   := Now;
    CallSaveTM := '0';
    CallFormCD := '000';
    ReceiverNM := '';
    JuminID    := '';

    StateCD    := '';
    StateSCD   := '';
    OtherCD    := '';
    OtherSCD   := '';
{}
    OrigID     := 'CALL00000000000';
    CallMM     := '';
    ReservID   := '';
    RecID      := 'CALL00000000000';
    RecStatus  := '000';
    Trans_DT   := '99999999';
    Trans_TM   := '000000';
    Trans_GB   := '0';
    Contract   := '';
    InOutFlag  := '-';
    WD_Indicator := '';
  end;
  Debug.Write(1, 31200, 'prClearCallRec :"End"');
end;

procedure prClearOutBoundRec;
begin
  Debug.Write(1, 31200, 'prClearOutBoundRec :"Start"');
  with OutBoundRec do
  begin
    bPopup     := False;
    CampSeqNO  := '';
    CampaignID := '';
    CallMode   := '';
    CustID     := '';
    CustTel    := '';
    CustInfo1  := '';
    CustInfo2  := '';
    CustInfo3  := '';
    CustInfo4  := '';
    CustInfo5  := '';
    CustInfo6  := '';
    CallResult := '';
    ReservedGB := '';
    CallLogID  := '';
    ReservedDT := '';
  end;
  Debug.Write(1, 31200, 'prClearOutBoundRec :"End"');
end;

procedure prClearCallerInfoRec;
begin
  Debug.Write(1, 31200, 'prClearCallerInfoRec :"Start"');
  with CallerInfoRec do
  begin
    CustID       := '';
    CustTel      := '';
    CustTel0     := ''; 
    CustTel1     := ''; 
    CustTelGB    := ''; 
    CustLV       := ''; 
    ServiceCD    := ''; 
    CallGB       := ''; 
    TmrRequestDT := ''; 
    TmrConnectDT := ''; 
    WindowID     := ''; 
    TabID        := ''; 
    ServiceTYPE  := '';

    ReservInfo111:= '';
    ReservInfo112:= '';

    ReservInfo121:= '';
    ReservInfo122:= '';
    ReservInfo123:= '';
    ReservInfo124:= '';

    ReservInfo210:= '';
    ReservInfo310:= '';
    ReservInfo410:= '';
  end;
  Debug.Write(1, 31200, 'prClearCallerInfoRec :"End"');
end;


{ Initialize and Finalize }
procedure InitLibrary;
begin
  CTMP := TCTMP.Create;
end;

procedure DoneLibrary;
begin
  try
    FreeAndNil(CTMP);
  except
    //여기서 왜 에러가 나지???-_-
  end;
end;

initialization
  InitLibrary;

finalization
  DoneLibrary;


end.
