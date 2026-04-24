unit libGENESYS;

interface

uses
  Sysutils, windows, forms, ComCtrls, Dialogs, Classes, BRIDGECLIENTXLib_TLB, varGENESYS,
  GENESYS_INTERFACELib_TLB, UtilLib;

//------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------
    procedure Ava_Initialize;
    function Ava_State(var TmrState: Integer; var DeviceState:Integer): Integer;
    function Ava_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;
    procedure Ava_ErrMsg(nCode: LongInt);

    function Genesys_Initialize : Integer;
    function Genesys_State(var TmrState: Integer; var DeviceState:Integer) : Integer;
    function Genesys_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;    
    procedure ParsingMessage(sMsg : String);   //Genesys            

//------------------------------------------------------------------------------
//Record - Clear
//------------------------------------------------------------------------------
    procedure prClearRec;
    procedure prClearRecServRec;
    procedure prClearTmrRec;
    procedure prClearCustRec(bFlag: Boolean=True);
    procedure prClearTelInfoRec;
    procedure prClearReservSetRec;
    procedure prClearReservOldRec;
    procedure prClearStateRec;
    procedure prClearCallRec;

var
  cxBridge: TBridgeClientX;
  Genesys : TGenesys_Interface;
implementation

uses DebugLib;


//------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------
procedure Ava_Initialize;
begin
{
  cxBridge.cxSetConnection('192.168.1.50', 8010, 8020, 3, 100);
  cxBridge.cxCreateServerThread(8020);
  {}
end;

function Genesys_Initialize : Integer;
begin
  try
//    result :=  Genesys.ConnectToServerEx('10.10.14.202',3000,'10.10.14.203',3010);   {SIP Real}
    result :=  Genesys.ConnectToServerEx('10.10.14.203',3500,'10.10.14.202',3500);   {Alcatel Real}
//    result :=  Genesys.ConnectToServerEx('10.10.14.75',5000,'10.10.14.75',5000);       {Alcatel Test}
  except
    //
  end;
end;


function Ava_State(var TmrState: Integer; var DeviceState:Integer): Integer;
var
  nRtn: Integer;
  sStatus: String;
begin
  sStatus := cxBridge.cxGetAgentState(TmrRec.Device, TmrRec.CTiID);
  nRtn := StrToInt(Copy(sStatus, 1, 4));
  DeviceState := StrToInt(Copy(sStatus, 5, 1));
  TmrState := StrToInt(Copy(sStatus, 6, 1));
  Result := nRtn;
end;
 {}
function Genesys_State(var TmrState: Integer; var DeviceState:Integer) : Integer;
var
  nRtn: Integer;
  sStatus: Integer;
begin
//  nRtn := Genesys.QueryAddress(TmrRec.Device, 17);
//  DeviceState := EventMsg.WorkMode;
end;

function Ava_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;
var
  sTmr, sDevice: String;
  nRtn, nTmr, nDevice: Integer;
begin
  nRtn := Ava_State(nTmr, nDevice);
  case nTmr of
    AGENT_X   :sTmr := '-';
    AGENT_LO  :sTmr := '로그아웃';
    AGENT_R   :sTmr := '대기';
    AGENT_AUX :
      begin
        if WorkStateCD=0 then sTmr := '작업'
        else sTmr := arNotReady[WorkStateCD];
      end;
    AGENT_ACW :sTmr := '후처리';
  end;
  case nDevice of
    DEVICE_X    :sDevice := '-';
    DEVICE_IDLE :sDevice := '대기';
    DEVICE_BUSY :sDevice := '통화중';
  end;
  if Assigned(tForm) and Assigned(tBar) then
  begin
    with tForm do
      tBar.Panels[Index].Text := sTmr+'/'+sDevice;
  end;
  Result := nTmr*10+nDevice;
{}
end;

function Genesys_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;
var
  sTmr, sDevice: String;
  nRtn, nTmr, nDevice, nReady: Integer;
begin
  nTmr := EventMsg.WorkMode;
  nReady := gReadyMode;   //  대기처리를 위해서
  Debug.Write(1, 99999, 'nTmr = '+IntToStr(nTmr));

//  AgentWorkModeUnknown  = 0; // 0
//  AgentManualIn         = 1; // 1
//  AgentAutoIn           = 2; // 2
//  AgentAfterCallWork    = 3; // 3  AgentSetWork
//  AgentAuxWork          = 4; // 4  AgentSetNotReady
//  AgentNoCallDisconnect = 5; // 5

//  AGENT_GUNKNOWN  = 0;
//  AGENT_GMANUALIN = 1;
//  AGENT_GAUTOIN = 2;
//  AGENT_GACW = 3;
//  AGENT_GAUX = 4;
//  AGENT_NOCALLDISCONNECT = 5;

  // 상담원상태
  case nTmr of
    AGENT_GUNKNOWN    :
      begin
        if nReady=1 then sTmr := '대기'
        else sTmr := '-';
      end;
    AGENT_GMANUALIN   :sTmr := '대기';
    AGENT_GAUX :
      begin
        if WorkStateCD=0 then sTmr := '작업'
        else sTmr := arNotReady[WorkStateCD];
      end;
    AGENT_GACW :sTmr := '후처리';
  end;

  // 전화기상태
  if gAgentID <> ''  then sDevice := '통화중'
  else if gAgentID = '' then sDevice := '-'
  else sDevice := '대기';
{}
{  if (gAgentID <> '') and (gConnID <> '0000000000000000') then sDevice := '통화중'
  else if (gAgentID = '') and (gConnID = '') then sDevice := '-'
//  else if (gAgentID <> '') and (gConnID = '0000000000000000') then sDevice := '대기';
  else sDevice := '대기';{}

  if Assigned(tForm) and Assigned(tBar) then
  begin
    with tForm do
      tBar.Panels[Index].Text := sTmr+'/'+sDevice;
  end;
  Result := nTmr*10+nDevice;
{}
end;

procedure Ava_ErrMsg(nCode: LongInt);
var
  Msg: String;
begin
//에러메세지 찾아서..
  ShowMessage(' - CTi ErrorMessage -                '+#13#13+
              'Code : "'+IntToStr(nCode)+'"'+#13+
              'Msg. : "'+String(Msg)+'"');
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
  WorkStateCD := 0;
  gReadyMode  := 0;
  Debug.Write(1, 31200, 'prClearTmrRec :"End"');
end;

procedure prClearCustRec(bFlag: Boolean=True);
begin
  Debug.Write(1, 31200, 'prClearCustRec :"Start"');
  with CallRec.CustRec do begin
    if bFlag then CustID := '';
    CustNM    := '';
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

procedure ParsingMessage(sMsg : String);
var
  r : Integer;
  Rtl : TStringArray;
begin
  r := GetField(sMsg, ';', Rtl);
  EventMsg.Event               := Rtl[0];
  EventMsg.Server              := Rtl[1];
  EventMsg.ConnID              := Rtl[2];
  EventMsg.PreviousConnID      := Rtl[3];
  EventMsg.CallID              := Rtl[4];
  EventMsg.FirstTranfHomeLoc   := Rtl[5];
  EventMsg.FirstDNOrigdn       := Rtl[6];
  EventMsg.LastTransfHomeLoc   := Rtl[7];
  EventMsg.LastDNOrigdn        := Rtl[8];
  EventMsg.CallType            := StrToInt(Rtl[9]);
  EventMsg.CallState           := StrToInt(Rtl[10]);
  EventMsg.AgentID             := Rtl[11];
  EventMsg.WorkMode            := StrToInt(Rtl[12]);
  EventMsg.ErrorCode           := Rtl[13];
  EventMsg.ErrorMessage        := Rtl[14];
  EventMsg.CollectedDigits     := Rtl[15];
  EventMsg.LastCollectedDigit  := Rtl[16];
  EventMsg.ThisDN              := Rtl[17];
  EventMsg.ThisQueue           := Rtl[18];
  EventMsg.ThisTrunk           := Rtl[19];
  EventMsg.OtherDN             := Rtl[20];
  EventMsg.OtherQueue          := Rtl[21];
  EventMsg.OtherTrunk          := Rtl[22];
  EventMsg.ThirdPartyDN        := Rtl[23];
  EventMsg.ThirdPartyQueue     := Rtl[24];
  EventMsg.ThirdPartyTrunk     := Rtl[25];
  EventMsg.DNIS                := Rtl[26];
  EventMsg.ANI                 := Rtl[27];
  EventMsg.RouteType           := Rtl[28];
  EventMsg.XRouteType          := Rtl[29];
  EventMsg.CallingLineName     := Rtl[30];
  EventMsg.Seconds             := Rtl[31];
  EventMsg.Useconds            := Rtl[32];
  EventMsg.User_CallData_Key   := Rtl[33];
  EventMsg.User_CallData_Value := Rtl[34];
  EventMsg.InfoType            := Rtl[35];
  EventMsg.AgentStatus         := Rtl[36];
  EventMsg.CallsInQueue        := Rtl[37];
  EventMsg.AgentsInQueue       := Rtl[38];
  EventMsg.AvailableAgents     := Rtl[39];
  EventMsg.status              := StrToInt(Rtl[40]);
  EventMsg.strQueue            := Rtl[41];
  EventMsg.strReasons_Key      := Rtl[42];
  EventMsg.strReasons_Data     := Rtl[43];
end;

end.

