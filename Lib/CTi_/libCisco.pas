unit libCisco;

interface

uses
  Sysutils, windows, forms, ComCtrls, Dialogs, Classes, GSSOFTPHONELib_TLB, varCisco;

//------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------
    function Cisco_Initialize: Integer;
    function Cisco_State(var TmrState: Integer; var TmrAuxState:Integer): Integer;
    function Cisco_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;
    procedure Cisco_ErrMsg(nCode: LongInt);
    function Cisco_ButtonState(iMask: Integer): String;


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
    procedure prClearOutBoundRec;
    procedure prClearCallerInfoRec;

var
  cxCisco: TGSSoftPhone;
  sButtonState: array[0..16]of char;

implementation

uses DebugLib, UtilLib;


//------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------
function Cisco_Initialize: Integer;
begin
  Result := cxCisco.OnConnect('192.168.61.21','192.168.61.23');
//  cxBridge.cxCreateServerThread(8020);
end;

function Cisco_State(var TmrState: Integer; var TmrAuxState:Integer): Integer;
var
  nRtn: Integer;
  sStatus: String;
begin
  Debug.Write(1, 31200, 'Cisco_State :"Start"');
  nRtn := cxCisco.OnGetAgentState;
  TmrState := nRtn;
  nRtn := cxCisco.OnGetAgentReasonCode;
  TmrAuxState := nRtn;
  Result := nRtn;
  Debug.Write(1, 31200, 'Cisco_State :"End" TmrState='+IntToStr(TmrState)+', TmrAuxState='+IntToStr(TmrAuxState));
end;

function Cisco_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;
var
  sTmr, sDevice: String;
  nRtn, nTmr, nTmrAUX: Integer;
begin
  nRtn := Cisco_State(nTmr, nTmrAUX);
  case nTmr of
    agent_Login :sTmr := '로그인';
    agent_Logout :sTmr := '로그아웃';
    agent_NotReady :begin
                      if nTmrAUX in [1..9] then
                      begin
                         sTmr:= arNotReady[nTmrAUX];
                      end;
                    end;
    agent_Available :sTmr := '대기';
    agent_Talking :sTmr := '통화중';
    agent_Hold :sTmr := '보류중';
  end;
  if Assigned(tForm) and Assigned(tBar) then
  begin
    with tForm do
      tBar.Panels[Index].Text := sTmr;
  end;
  Result := nTmr*10+nTmrAUX;
{}
end;

procedure Cisco_ErrMsg(nCode: LongInt);
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
    RecID      := 'CALL000000000000';
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


function Cisco_ButtonState(iMask: Integer): String;
begin
  System.FillChar(sButtonState, sizeof(sButtonState), $0);

  sButtonState[Idx_LOGIN                  ] := BoolToChar((iMask and  ENABLE_LOGIN                   )= ENABLE_LOGIN);
  sButtonState[Idx_LOGOUT                 ] := BoolToChar((iMask and  ENABLE_LOGOUT                  )= ENABLE_LOGOUT                 );
  sButtonState[Idx_READY                  ] := BoolToChar((iMask and  ENABLE_READY                   )= ENABLE_READY                  );
  sButtonState[Idx_NOTREADY               ] := BoolToChar((iMask and  ENABLE_NOTREADY                )= ENABLE_NOTREADY               );
  sButtonState[Idx_ANSWER                 ] := BoolToChar((iMask and  ENABLE_ANSWER                  )= ENABLE_ANSWER                 );
  sButtonState[Idx_MAKECALL               ] := BoolToChar((iMask and  ENABLE_MAKECALL                )= ENABLE_MAKECALL               );
  sButtonState[Idx_HOLD                   ] := BoolToChar((iMask and  ENABLE_HOLD                    )= ENABLE_HOLD                   );
  sButtonState[Idx_RETRIEVE               ] := BoolToChar((iMask and  ENABLE_RETRIEVE                )= ENABLE_RETRIEVE               );
  sButtonState[Idx_RELEASE                ] := BoolToChar((iMask and  ENABLE_RELEASE                 )= ENABLE_RELEASE                );
  sButtonState[Idx_RECONNECT              ] := BoolToChar((iMask and  ENABLE_RECONNECT               )= ENABLE_RECONNECT              );
  sButtonState[Idx_CONFERENCE_COMPLETE    ] := BoolToChar((iMask and  ENABLE_CONFERENCE_COMPLETE     )= ENABLE_CONFERENCE_COMPLETE    );
  sButtonState[Idx_CONFERENCE_INIT        ] := BoolToChar((iMask and  ENABLE_CONFERENCE_INIT         )= ENABLE_CONFERENCE_INIT        );
  sButtonState[Idx_SINGLE_STEP_CONFERENCE ] := BoolToChar((iMask and  ENABLE_SINGLE_STEP_CONFERENCE  )= ENABLE_SINGLE_STEP_CONFERENCE );
  sButtonState[Idx_TRANSFER_COMPLETE      ] := BoolToChar((iMask and  ENABLE_TRANSFER_COMPLETE       )= ENABLE_TRANSFER_COMPLETE      );
  sButtonState[Idx_TRANSFER_INIT          ] := BoolToChar((iMask and  ENABLE_TRANSFER_INIT           )= ENABLE_TRANSFER_INIT          );
  sButtonState[Idx_SINGLE_STEP_TRANSFER   ] := BoolToChar((iMask and  ENABLE_SINGLE_STEP_TRANSFER    )= ENABLE_SINGLE_STEP_TRANSFER   );
{}
  Result := StrPas(sButtonState);
end;


end.

