unit libAvaya;

interface

uses
  Sysutils, windows, forms, ComCtrls, Dialogs, Classes, BRIDGECLIENTXLib_TLB, varAvaya;

//------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------
    procedure Ava_Initialize;
    function Ava_State(var TmrState: Integer; var DeviceState:Integer): Integer;
    function Ava_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;
    procedure Ava_ErrMsg(nCode: LongInt);

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

implementation

uses DebugLib;


//------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------
procedure Ava_Initialize;
begin
  cxBridge.cxSetConnection('192.168.1.50', 8010, 8020, 3, 100);
  cxBridge.cxCreateServerThread(8020);
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
    bWDTrans   := False;
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


end.

