unit MainForm;
interface
uses
  Windows,  Classes,   JSON,    SysUtils, IniFiles, System.Types,
  System.UITypes,  System.Net.URLClient,  Vcl.Controls,  Vcl.Dialogs,  Vcl.ExtCtrls,
  Vcl.Forms,  Vcl.Graphics,  Vcl.StdCtrls,  Vcl.Menus,  CallListForm,
  sgcWebSocket,  sgcWebSocket_Classes,  sgcWebSocket_Client,  DebugLib, CurvyControls, GradientLabel, Shader, AdvGlowButton, AdvGlassButton, AdvSmoothButton;

type
  TFrmMain = class(TForm)
    PingTimer: TTimer;
    StateTimer: TTimer;
    ReconnectTimer: TTimer;
    pan_lbLog: TPanel;
    lbLog: TListBox;
    lblStatus: TLabel;
    pmBreak: TPopupMenu;
    miBreakAway: TMenuItem;
    miBreakRest: TMenuItem;
    miBreakLunch: TMenuItem;
    miBreakMeeting: TMenuItem;
    miBreakSeminar: TMenuItem;
    miBreakEtc: TMenuItem;
    Shader1: TShader;
    CurvyPanel2: TCurvyPanel;
    btn_Board: TAdvGlowButton;
    AdvGlowButton1: TAdvGlowButton;
    CurvyPanel3: TCurvyPanel;
    edtDialNumber: TCurvyEdit;
    CurvyPanel4: TCurvyPanel;
    CurvyPanel6: TCurvyPanel;
    CurvyPanel7: TCurvyPanel;
    lab_Status_NM: TCurvyEdit;
    lab_Status_Time: TCurvyEdit;
    CurvyPanel5: TCurvyPanel;
    BtnBreak: TAdvSmoothButton;
    btnDial: TAdvSmoothButton;
    btnAnswer: TAdvSmoothButton;
    btnTransfer: TAdvSmoothButton;
    btnTx3Connect: TAdvSmoothButton;
    btnHold: TAdvSmoothButton;
    btnHangup: TAdvSmoothButton;
    btnInbound: TAdvSmoothButton;
    btnNotReady: TAdvSmoothButton;
    btnConnect: TAdvSmoothButton;
    btnDisconnect: TAdvSmoothButton;
    btnClose: TAdvSmoothButton;
    edtDuration: TCurvyEdit;
    edtSrtTime: TCurvyEdit;
    edtEndTime: TCurvyEdit;
    edtRec: TCurvyEdit;
    edtInOut: TCurvyEdit;
    edtAni: TCurvyEdit;
    panStrTime: TCurvyPanel;
    panEndTime: TCurvyPanel;
    panDuration: TCurvyPanel;
    panInOut: TCurvyPanel;
    panRec: TCurvyPanel;
    panAni: TCurvyPanel;
    CurvyPanel14: TCurvyPanel;
    CurvyPanel1: TCurvyPanel;
    lblWebSocket: TLabel;
    lblUserId: TLabel;
    lblPhoneId: TLabel;
    lblInitMode: TLabel;
    lblTransferNumber: TLabel;
    edtWebSocketUrl: TEdit;
    edtUserId: TEdit;
    edtPhoneId: TEdit;
    btnCampaign: TButton;
    btnRecord: TButton;
    btnHijack: TButton;
    cbInitMode: TComboBox;
    chkOverrideLogin: TCheckBox;
    chkAutoReconnect: TCheckBox;
    btnGetState: TButton;
    btnClearLog: TButton;
    btnOutbound: TButton;
    edtTransferNumber: TEdit;
    btnTransferCold: TButton;
    btnTransferWarm: TButton;
    btnTxComplete: TButton;
    btnTxCancel: TButton;
    btnTxToggle: TButton;
    btnIvrSsn: TButton;
    btnIvrAcc: TButton;
    btnIvrRet: TButton;
    edtQueueName: TEdit;
    btnQueueAdd: TButton;
    btnQueueSub: TButton;
    btnQueueRun: TButton;
    btnQueuePause: TButton;
    btnQueueState: TButton;
    btnTeamAgents: TButton;
    btnGroupAgents: TButton;
    btnCenterAgents: TButton;
    btn_CallList: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnBreakClick(Sender: TObject);
    procedure btn_CallListClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnInboundClick(Sender: TObject);
    procedure btnOutboundClick(Sender: TObject);
    procedure btnDialClick(Sender: TObject);
    procedure btnAnswerClick(Sender: TObject);
    procedure btnHangupClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure btnTransferColdClick(Sender: TObject);
    procedure btnTransferWarmClick(Sender: TObject);
    procedure btnHoldClick(Sender: TObject);
    procedure btnNotReadyClick(Sender: TObject);
    procedure btnTxCompleteClick(Sender: TObject);
    procedure btnTxCancelClick(Sender: TObject);
    procedure btnTx3ConnectClick(Sender: TObject);
    procedure btnTxToggleClick(Sender: TObject);
    procedure btnGetStateClick(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnCampaignClick(Sender: TObject);
    procedure btnRecordClick(Sender: TObject);
    procedure btnHijackClick(Sender: TObject);
    procedure btnIvrSsnClick(Sender: TObject);
    procedure btnIvrAccClick(Sender: TObject);
    procedure btnIvrRetClick(Sender: TObject);
    procedure btnQueueAddClick(Sender: TObject);
    procedure btnQueueSubClick(Sender: TObject);
    procedure btnQueueRunClick(Sender: TObject);
    procedure btnQueuePauseClick(Sender: TObject);
    procedure btnQueueStateClick(Sender: TObject);
    procedure btnTeamAgentsClick(Sender: TObject);
    procedure btnGroupAgentsClick(Sender: TObject);
    procedure btnCenterAgentsClick(Sender: TObject);
    procedure PingTimerTimer(Sender: TObject);
    procedure StateTimerTimer(Sender: TObject);
    procedure ReconnectTimerTimer(Sender: TObject);
    procedure pmBreakPopup(Sender: TObject);
    procedure BreakMenuItemClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FClient: TsgcWebSocketClient;
    FLoggedIn: Boolean;
    FConnecting: Boolean;
    FMode: string;
    FState: string;
    FRole: string;
    FUid: string;
    FSession: string;
    FCallTime: string;
    FCallType: string;
    FAChan: string;
    FCChan: string;
    FTChan: string;
    FAgentPhone: string;
    FCPhone: string;
    FTPhone: string;
    FIniFileName: string;
    FLastWebSocketUrl: string;
    FConnectAttemptUrl: string;
    FConnectedWebSocketUrl: string;
    FPendingMode: string;
    FPendingDialNumber: string;
    FPendingDialCallType: string;
    FPrevHoldMode: string;
    FRecordRunning: Boolean;
    FStateStartedAt: TDateTime;
    FCallStartedAt: TDateTime;
    FCallEndedAt: TDateTime;
    FLastCallDuration: string;
    FTrackedStatusName: string;
    procedure AddLog(const AText: string);
    procedure ApplyWebSocketConfiguration(const AUrl: string);
    function NormalizeWebSocketUrl(const AUrl: string): string;
    procedure CreateWebSocketClient;
    procedure DoConnect;
    procedure DoDisconnect;
    function BuildLoginPayload: string;
    function BuildLogoutPayload: string;
    function BuildPingPayload: string;
    function BuildGetStatePayload: string;
    function BuildRecordPayload: string;
    function BuildSetModePayload(const AMode: string): string;
    function BuildDialPayload(const ANumber, ACallType: string): string;
    function BuildAnswerPayload: string;
    function BuildHangupPayload: string;
    function BuildTransferPayload(const ANumber: string): string;
    function BuildTransferColdPayload(const ANumber: string): string;
    function BuildTransferWarmPayload(const ANumber: string): string;
    function BuildTxCompletePayload: string;
    function BuildTxCancelPayload: string;
    function BuildTx3ConnectPayload: string;
    function BuildTxTogglePayload: string;
    function BuildToggleModePayload(const ARequestName: string): string;
    function BuildQueueActionPayload(const ARequest, AQueueName: string; APauseFlag: Boolean): string;
    function BuildIvrRedirectPayload(const AExten: string; AIncludeExtra: Boolean): string;
    function ExtractJsonValue(AJson: TJSONObject; const AName: string): string;
    function EnsureClientReady: Boolean;
    function EnsureSocketConnected: Boolean;
    function IsAnyState(const AStates: array of string): Boolean;
    function IsAnyMode(const AModes: array of string): Boolean;
    function MapToggleRequestToMode(const ARequestName: string): string;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure ApplyTheme;
    function SendJson(const APayload: string): Boolean;
    procedure HandleIncomingText(const AText: string);
    procedure ResetCallContext;
    procedure QueueReconnect;
    function GetCtiStatusName: string;
    function IsSocketConnected: Boolean;
    function IsConnectedCallState(const AState: string): Boolean;
    function FormatElapsedTime(const AStartTime: TDateTime): string;
    procedure UpdateStateElapsedTime;
    procedure UpdateCallInfo;
    procedure UpdateBreakMenuItems;
    procedure UpdateButtons;
    procedure UpdateStatus;
    procedure WebSocketClientConnect(Connection: TsgcWSConnection);
    procedure WebSocketClientDisconnect(Connection: TsgcWSConnection; Code: Integer);
    procedure WebSocketClientError(Connection: TsgcWSConnection; const Error: string);
    procedure WebSocketClientMessage(Connection: TsgcWSConnection; const Text: string);
    procedure Initialize;
    procedure fn_Deletefiles(APath, AFileSpec: string);
  public
  end;
var
  FrmMain: TFrmMain;
implementation
uses xtrmPHONELib;
{$R *.dfm}
{$WARN IMPLICIT_STRING_CAST OFF}
procedure TFrmMain.AddLog(const AText: string);
begin
  lbLog.Items.Add(FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '  ' + AText);
  lbLog.ItemIndex := lbLog.Items.Count - 1;
end;
procedure TFrmMain.ApplyWebSocketConfiguration(const AUrl: string);
var
  LUri: TURI;
  LNormalizedUrl: string;
begin
  LNormalizedUrl := NormalizeWebSocketUrl(AUrl);
  LUri := TURI.Create(LNormalizedUrl);
  if Trim(LUri.Host) = '' then
    raise Exception.Create('Enter WebSocket URL in ws://, wss://, http://, or https:// format.');
  FClient.URL := LNormalizedUrl;
end;
function TFrmMain.NormalizeWebSocketUrl(const AUrl: string): string;
var
  LValue: string;
  LUri: TURI;
  LPort: Integer;
begin
  LValue := Trim(AUrl);
  if SameText(Copy(LValue, 1, 6), 'wss://') or SameText(Copy(LValue, 1, 5), 'ws://') then
    Exit(LValue);
  if SameText(Copy(LValue, 1, 8), 'https://') or SameText(Copy(LValue, 1, 7), 'http://') then
  begin
    LUri := TURI.Create(LValue);
    LPort := LUri.Port;
    if SameText(LUri.Scheme, 'https') then
    begin
      if LPort = 5011 then
        LPort := 8012
      else if LPort = 5012 then
        LPort := 5012
      else if LPort <= 0 then
        LPort := 8012;
      Exit(Format('wss://%s:%d', [LUri.Host, LPort]));
    end;
    if SameText(LUri.Scheme, 'http') then
    begin
      if LPort = 5001 then
        LPort := 5002
      else if LPort <= 0 then
        LPort := 5002;
      Exit(Format('ws://%s:%d', [LUri.Host, LPort]));
    end;
  end;
  Result := LValue;
end;
function TFrmMain.BuildAnswerPayload: string;
var
  LJson: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    if SameText(FState, 'TxRing') then
      LJson.AddPair('req', 'txAnswer')
    else
      LJson.AddPair('req', 'answer');
    LJson.AddPair('uid', FUid);
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    LJson.AddPair('tchan', FTChan);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildDialPayload(const ANumber, ACallType: string): string;
var
  LJson: TJSONObject;
begin
  if not SameText(FState, 'Idle') then
    raise Exception.Create('Dial is only allowed when state is Idle.');
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'dial');
    LJson.AddPair('userid', Trim(edtUserId.Text));
    LJson.AddPair('num', ANumber);
    LJson.AddPair('call_type', ACallType);
    LJson.AddPair('cid', 'useDefault');
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildHangupPayload: string;
var
  LJson: TJSONObject;
  LReq: string;
begin
  if SameText(FState, 'Connect') then
    LReq := 'hangup'
  else if SameText(FState, 'TxConnect') or SameText(FState, 'TxConnectC') or SameText(FState, 'Tx3Connect') then
  begin
    if SameText(FRole, 't') then
      LReq := 'txDeny'
    else if SameText(FRole, 'a') or (Trim(FRole) = '') then
      LReq := 'hangup'
    else
      LReq := 'txCancel';
  end
  else if SameText(FState, 'Ring') or SameText(FState, 'TxRing') then
  begin
    if SameText(FRole, 't') then
      LReq := 'txRingDeny'
    else
      LReq := 'reject';
  end
  else if SameText(FState, 'Dial') then
    LReq := 'cancel'
  else if SameText(FState, 'TxDial') then
    LReq := 'txComplete'
  else
    raise Exception.CreateFmt('Hangup is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', LReq);
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    LJson.AddPair('tchan', FTChan);
    if Trim(FUid) <> '' then
      LJson.AddPair('uid', FUid);
    if SameText(LReq, 'txDialCancel') then
      LJson.AddPair('tphone', FTPhone);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildLoginPayload: string;
var
  LJson: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'login');
    LJson.AddPair('override', TJSONBool.Create(chkOverrideLogin.Checked));
    LJson.AddPair('version', '1.0.1');
    LJson.AddPair('userid', Trim(edtUserId.Text));
    LJson.AddPair('passwd', Trim(edtUserId.Text));
    LJson.AddPair('mode', cbInitMode.Text);
    LJson.AddPair('state', 'Idle');
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildGetStatePayload: string;
var
  LJson: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'getState');
    LJson.AddPair('version', '1.0.1');
    LJson.AddPair('userid', Trim(edtUserId.Text));
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildIvrRedirectPayload(const AExten: string; AIncludeExtra: Boolean): string;
var
  LReq: TJSONObject;
  LArg: TJSONObject;
begin
  if not SameText(FState, 'Connect') then
    raise Exception.Create('IVR action is only allowed while connected.');
  LReq := TJSONObject.Create;
  try
    LArg := TJSONObject.Create;
    LArg.AddPair('Channel', FCChan);
    LArg.AddPair('Context', 'IvrGetInput');
    LArg.AddPair('Exten', AExten);
    LArg.AddPair('Priority', TJSONNumber.Create(1));
    if AIncludeExtra then
    begin
      LArg.AddPair('extraChannel', FAChan);
      LArg.AddPair('extraContext', 'ConfAgent');
      LArg.AddPair('extraExten', 'A' + FUid);
      LArg.AddPair('extraPriority', TJSONNumber.Create(1));
    end;
    LReq.AddPair('req', 'genAction');
    LReq.AddPair('action', 'Redirect');
    LReq.AddPair('argObj', LArg);
    Result := LReq.ToJSON;
  finally
    LReq.Free;
  end;
end;
function TFrmMain.BuildQueueActionPayload(const ARequest, AQueueName: string; APauseFlag: Boolean): string;
var
  LJson: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', ARequest);
    LJson.AddPair('userid', Trim(edtUserId.Text));
    if Trim(AQueueName) <> '' then
      LJson.AddPair('queue', AQueueName);
    if SameText(ARequest, 'queuePause') then
    begin
      LJson.AddPair('phone', Trim(edtPhoneId.Text));
      LJson.AddPair('pauseFlag', TJSONBool.Create(APauseFlag));
    end;
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildRecordPayload: string;
var
  LJson: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'record');
    LJson.AddPair('uid', FUid);
    if FRecordRunning then
      LJson.AddPair('sub', 'stop')
    else
      LJson.AddPair('sub', 'start');
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildLogoutPayload: string;
var
  LJson: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'logout');
    LJson.AddPair('userid', Trim(edtUserId.Text));
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildPingPayload: string;
begin
  Result := '{"req":"ping"}';
end;
function TFrmMain.BuildSetModePayload(const AMode: string): string;
var
  LJson: TJSONObject;
begin
  if not SameText(FState, 'Idle') then
    raise Exception.CreateFmt('Mode change is only allowed when state is Idle. Current state: %s', [FState]);
  if SameText(FMode, AMode) then
    raise Exception.CreateFmt('Mode is already %s.', [AMode]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'setMode');
    LJson.AddPair('userid', Trim(edtUserId.Text));
    LJson.AddPair('mode', AMode);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildTransferPayload(const ANumber: string): string;
var
  LJson: TJSONObject;
  LReq: string;
begin
  if SameText(FState, 'Connect') then
    LReq := 'transfer'
  else if SameText(FState, 'TxConnect') or SameText(FState, 'TxConnectC') then
    LReq := 'reTransfer'
  else
    raise Exception.CreateFmt('Transfer is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', LReq);
    LJson.AddPair('num', ANumber);
    LJson.AddPair('uid', FUid);
    LJson.AddPair('cid', 'useDefault');
    LJson.AddPair('achan', FAChan);
    if SameText(LReq, 'transfer') then
      LJson.AddPair('cchan', FCChan)
    else
      LJson.AddPair('tchan', FTChan);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildTransferColdPayload(const ANumber: string): string;
var
  LJson: TJSONObject;
begin
  if not SameText(FState, 'Connect') then
    raise Exception.CreateFmt('Cold transfer is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'transferCold');
    LJson.AddPair('num', ANumber);
    LJson.AddPair('uid', FUid);
    LJson.AddPair('cid', 'useDefault');
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    LJson.AddPair('cphone', FCPhone);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildTransferWarmPayload(const ANumber: string): string;
var
  LJson: TJSONObject;
begin
  if not SameText(FState, 'Connect') then
    raise Exception.CreateFmt('Warm transfer is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'transferWarm');
    LJson.AddPair('num', ANumber);
    LJson.AddPair('uid', FUid);
    LJson.AddPair('cid', 'useDefault');
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildTx3ConnectPayload: string;
var
  LJson: TJSONObject;
begin
  if not (SameText(FState, 'TxConnect') or SameText(FState, 'TxConnectC')) then
    raise Exception.CreateFmt('Tx3Connect is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'tx3Connect');
    LJson.AddPair('uid', FUid);
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    LJson.AddPair('tchan', FTChan);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildTxCancelPayload: string;
var
  LJson: TJSONObject;
  LReq: string;
begin
  if SameText(FState, 'TxDial') then
    LReq := 'txDialCancel'
  else if SameText(FState, 'TxConnect') or SameText(FState, 'Tx3Connect') or SameText(FState, 'TxConnectC') then
    LReq := 'txCancel'
  else
    raise Exception.CreateFmt('TxCancel is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', LReq);
    LJson.AddPair('uid', FUid);
    LJson.AddPair('cchan', FCChan);
    if SameText(LReq, 'txDialCancel') then
    begin
      LJson.AddPair('achan', FAChan);
      LJson.AddPair('tphone', FTPhone);
    end
    else
    begin
      LJson.AddPair('achan', FAChan);
      LJson.AddPair('tchan', FTChan);
    end;
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildTxCompletePayload: string;
var
  LJson: TJSONObject;
  LReq: string;
begin
  if SameText(FState, 'TxConnect') or SameText(FState, 'TxConnectC') then
    LReq := 'txComplete'
  else if SameText(FState, 'Tx3Connect') then
    LReq := 'tx3Complete'
  else
    raise Exception.CreateFmt('TxComplete is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', LReq);
    LJson.AddPair('uid', FUid);
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    LJson.AddPair('tchan', FTChan);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
function TFrmMain.BuildTxTogglePayload: string;
var
  LJson: TJSONObject;
begin
  if not (SameText(FState, 'TxConnect') or SameText(FState, 'TxConnectC')) then
    raise Exception.CreateFmt('TxToggle is not allowed in current state [%s/%s].', [FMode, FState]);
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', 'txToggle');
    LJson.AddPair('uid', FUid);
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    LJson.AddPair('tchan', FTChan);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;


function TFrmMain.BuildToggleModePayload(const ARequestName: string): string;
var
  LJson: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('req', ARequestName);
    LJson.AddPair('userid', Trim(edtUserId.Text));
    LJson.AddPair('uid', FUid);
    LJson.AddPair('achan', FAChan);
    LJson.AddPair('cchan', FCChan);
    LJson.AddPair('tchan', FTChan);
    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;
procedure TFrmMain.btnAnswerClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildAnswerPayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnConnectClick(Sender: TObject);
begin
  try
    DoConnect;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      FConnecting := False;
      UpdateButtons;
    end;
  end;
end;
procedure TFrmMain.BtnBreakClick(Sender: TObject);
var
  LPoint: TPoint;
begin
  if not BtnBreak.Enabled then
    Exit;
  UpdateBreakMenuItems;
  LPoint := BtnBreak.ClientToScreen(Point(0, BtnBreak.Height));
  pmBreak.Popup(LPoint.X, LPoint.Y);
end;
procedure TFrmMain.btnDialClick(Sender: TObject);
begin
  try
    if Trim(edtDialNumber.Text) = '' then
      raise Exception.Create('Enter dial number.');
    if EnsureClientReady then
    begin
      if SameText(FMode, 'Outbound') then
      begin
        SendJson(BuildDialPayload(Trim(edtDialNumber.Text), 'Outbound'));
      end
      else
      begin
        FPendingDialNumber := Trim(edtDialNumber.Text);
        FPendingDialCallType := 'Outbound';
        FPendingMode := 'Outbound';
        SendJson(BuildSetModePayload('Outbound'));
      end;
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnDisconnectClick(Sender: TObject);
begin
  try
    DoDisconnect;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnHangupClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildHangupPayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnClearLogClick(Sender: TObject);
begin
  lbLog.Items.Clear;
  AddLog('Log cleared');
end;
procedure TFrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.btn_CallListClick(Sender: TObject);
var
  LForm: TFrmCallList;
begin
  LForm := TFrmCallList.Create(Self);
  try
    LForm.ShowModal;
  finally
    LForm.Free;
  end;
end;
procedure TFrmMain.btnGetStateClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildGetStatePayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnHoldClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      if not SameText(FMode, 'Hold') then
        FPrevHoldMode := FMode;
      SendJson(BuildToggleModePayload('hold'));
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnInboundClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      FPendingMode := 'Inbound';
      SendJson(BuildSetModePayload('Inbound'));
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnNotReadyClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildToggleModePayload('notReady'));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnOutboundClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      FPendingMode := 'Outbound';
      SendJson(BuildSetModePayload('Outbound'));
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTransferClick(Sender: TObject);
begin
  try
    if Trim(edtTransferNumber.Text) = '' then
      raise Exception.Create('Enter transfer number.');
    if EnsureClientReady then
      SendJson(BuildTransferPayload(Trim(edtTransferNumber.Text)));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTransferColdClick(Sender: TObject);
begin
  try
    if Trim(edtTransferNumber.Text) = '' then
      raise Exception.Create('Enter transfer number.');
    if EnsureClientReady then
      SendJson(BuildTransferColdPayload(Trim(edtTransferNumber.Text)));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTransferWarmClick(Sender: TObject);
begin
  try
    if Trim(edtTransferNumber.Text) = '' then
      raise Exception.Create('Enter transfer number.');
    if EnsureClientReady then
      SendJson(BuildTransferWarmPayload(Trim(edtTransferNumber.Text)));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTx3ConnectClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildTx3ConnectPayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTxCancelClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildTxCancelPayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTxCompleteClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildTxCompletePayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTxToggleClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildTxTogglePayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnCampaignClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      FPendingMode := 'Campaign';
      SendJson(BuildSetModePayload('Campaign'));
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnCenterAgentsClick(Sender: TObject);
begin
  AddLog('CenterAgents is not implemented in websocket sample wsCapi.js');
end;
procedure TFrmMain.btnGroupAgentsClick(Sender: TObject);
begin
  AddLog('GroupAgents is not implemented in websocket sample wsCapi.js');
end;
procedure TFrmMain.btnHijackClick(Sender: TObject);
begin
  AddLog('Hijack is not implemented in websocket sample wsCapi.js');
end;
procedure TFrmMain.btnIvrAccClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      FSession := 'Account';
      SendJson(BuildIvrRedirectPayload(FCPhone + '^account^get-account^1^1^3', True));
      UpdateStatus;
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnIvrRetClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      FSession := 'Init';
      SendJson(BuildIvrRedirectPayload('ret', False));
      UpdateStatus;
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnIvrSsnClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      FSession := 'Ssn';
      SendJson(BuildIvrRedirectPayload(FCPhone + '^ssn^get-ssn^13^14^3', True));
      UpdateStatus;
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnLoginClick(Sender: TObject);
begin
  try
    if EnsureSocketConnected then
      SendJson(BuildLoginPayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnLogoutClick(Sender: TObject);
begin
  try
    if EnsureSocketConnected then
      SendJson(BuildLogoutPayload);
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnQueueAddClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildQueueActionPayload('queueAdd', Trim(edtQueueName.Text), False));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnQueuePauseClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildQueueActionPayload('queuePause', Trim(edtQueueName.Text), True));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnQueueRunClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildQueueActionPayload('queuePause', Trim(edtQueueName.Text), False));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnQueueStateClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildQueueActionPayload('getUserQueuesList', '', False));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnQueueSubClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
      SendJson(BuildQueueActionPayload('queueSub', Trim(edtQueueName.Text), False));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnRecordClick(Sender: TObject);
begin
  try
    if EnsureClientReady then
    begin
      SendJson(BuildRecordPayload);
      FRecordRunning := not FRecordRunning;
      if FRecordRunning then
        btnRecord.Caption := #48512#48516#45453#52712 + ' ' + #51333#47308
      else
        btnRecord.Caption := #48512#48516#45453#52712 + ' ' + #49884#51089;
    end;
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.btnTeamAgentsClick(Sender: TObject);
begin
  AddLog('TeamAgents is not implemented in websocket sample wsCapi.js');
end;
procedure TFrmMain.CreateWebSocketClient;
begin
  FreeAndNil(FClient);
  FClient := TsgcWebSocketClient.Create(Self);
  FClient.Options.RaiseDisconnectExceptions := False;
  FClient.OnConnect := WebSocketClientConnect;
  FClient.OnDisconnect := WebSocketClientDisconnect;
  FClient.OnError := WebSocketClientError;
  FClient.OnMessage := WebSocketClientMessage;
end;
procedure TFrmMain.DoConnect;
var
  LCandidates: TStringList;
  LInputUrl: string;
  LUrl: string;
  I: Integer;
  LConnected: Boolean;
  procedure AddCandidate(const AUrl: string);
  begin
    if (Trim(AUrl) <> '') and (LCandidates.IndexOf(AUrl) < 0) then
      LCandidates.Add(AUrl);
  end;
begin
  if Trim(edtWebSocketUrl.Text) = '' then
    raise Exception.Create('Enter WebSocket URL.');
  if Trim(edtUserId.Text) = '' then
    raise Exception.Create('Enter userid.');
  if Trim(edtPhoneId.Text) = '' then
    raise Exception.Create('Enter phoneid.');
  CreateWebSocketClient;
  ResetCallContext;
  btnRecord.Caption := #48512#48516#45453#52712 + ' ' + #49884#51089;
  FConnecting := True;
  FLoggedIn := False;
  FConnectedWebSocketUrl := '';
  FConnectAttemptUrl := '';
  UpdateButtons;
  UpdateStatus;
  AddLog('Connect button clicked');
  FAgentPhone := Trim(edtPhoneId.Text);
  AddLog(Format('userid: %s / phoneid: %s',
    [Trim(edtUserId.Text), Trim(edtPhoneId.Text)]));
  AddLog(Format('Initial mode: %s / Override: %s / AutoReconnect: %s',
    [cbInitMode.Text, BoolToStr(chkOverrideLogin.Checked, True), BoolToStr(chkAutoReconnect.Checked, True)]));
  AddLog('WebSocket URL fallback rule: 5011 -> 8012 -> 5012 -> 5011');
  LCandidates := TStringList.Create;
  try
    LInputUrl := Trim(edtWebSocketUrl.Text);
    FLastWebSocketUrl := NormalizeWebSocketUrl(LInputUrl);
    AddCandidate(FLastWebSocketUrl);
    if SameText(Copy(LInputUrl, 1, 8), 'https://') then
    begin
      AddCandidate(StringReplace(FLastWebSocketUrl, ':8012', ':5012', []));
      AddCandidate(StringReplace(FLastWebSocketUrl, ':8012', ':5011', []));
    end
    else if SameText(Copy(LInputUrl, 1, 7), 'http://') then
      AddCandidate(StringReplace(FLastWebSocketUrl, ':5002', ':5001', []));
    LConnected := False;
    for I := 0 to LCandidates.Count - 1 do
    begin
      LUrl := LCandidates[I];
      FConnectAttemptUrl := LUrl;
      AddLog(Format('Trying WebSocket connection: %s', [LUrl]));
      try
        ApplyWebSocketConfiguration(LUrl);
        FClient.ConnectTimeout := 5000;
        FClient.ReadTimeout := 5000;
        FClient.WriteTimeout := 5000;
        if FClient.Connect(5000) then
        begin
          FLastWebSocketUrl := LUrl;
          LConnected := True;
          Break;
        end;
        AddLog('Connection timeout or handshake failure');
      except
        on E: Exception do
        begin
          AddLog('Connect attempt failed: ' + E.Message);
        end;
      end;
      if Assigned(FClient) and FClient.Active then
        FClient.Active := False;
    end;
    if not LConnected then
    begin
      FConnecting := False;
      UpdateButtons;
      UpdateStatus;
      raise Exception.Create('WebSocket connection failed. Check server port/state. Tried: ' + StringReplace(LCandidates.CommaText, ',', ', ', [rfReplaceAll]));
    end;
  finally
    LCandidates.Free;
  end;
end;
procedure TFrmMain.DoDisconnect;
begin
  PingTimer.Enabled := False;
  if Assigned(FClient) and FClient.Active then
  begin
    if FLoggedIn then
      SendJson(BuildLogoutPayload);
    AddLog('Disconnect button clicked');
    FClient.Active := False;
  end;
  FConnecting := False;
  FLoggedIn := False;
  FConnectedWebSocketUrl := '';
  FConnectAttemptUrl := '';
  FPendingMode := '';
  FPendingDialNumber := '';
  FPendingDialCallType := '';
  FPrevHoldMode := '';
  ResetCallContext;
  btnRecord.Caption := #48512#48516#45453#52712 + ' ' + #49884#51089;
  UpdateButtons;
  UpdateStatus;
end;
function TFrmMain.EnsureClientReady: Boolean;
begin
  Result := Assigned(FClient) and FClient.Active and FClient.Connected and FLoggedIn;
  if not Result then
    raise Exception.Create('Connect and login first.');
end;
function TFrmMain.EnsureSocketConnected: Boolean;
begin
  Result := Assigned(FClient) and FClient.Active and FClient.Connected;
  if not Result then
    raise Exception.Create('Connect WebSocket first.');
end;
function TFrmMain.IsAnyMode(const AModes: array of string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(AModes) to High(AModes) do
    if SameText(FMode, AModes[I]) then
      Exit(True);
end;
function TFrmMain.MapToggleRequestToMode(const ARequestName: string): string;
begin
  if SameText(ARequestName, 'notReady') then
    Exit('NotReady');
  if SameText(ARequestName, 'away') then
    Exit('Away');
  if SameText(ARequestName, 'rest') then
    Exit('Rest');
  if SameText(ARequestName, 'lunch') then
    Exit('Lunch');
  if SameText(ARequestName, 'meeting') then
    Exit('Meeting');
  if SameText(ARequestName, 'seminar') then
    Exit('Seminar');
  if SameText(ARequestName, 'etc') then
    Exit('Etc');
  if SameText(ARequestName, 'hold') then
    Exit('Hold');
  Result := '';
end;
function TFrmMain.IsAnyState(const AStates: array of string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(AStates) to High(AStates) do
    if SameText(FState, AStates[I]) then
      Exit(True);
end;
function TFrmMain.ExtractJsonValue(AJson: TJSONObject; const AName: string): string;
var
  LValue: TJSONValue;
begin
  Result := '';
  LValue := AJson.GetValue(AName);
  if Assigned(LValue) then
    Result := LValue.Value;
end;
procedure TFrmMain.Initialize;
begin
  Caption := 'CTI WebSocket Sample for Delphi 11.3';
  ApplyTheme;
  cbInitMode.Items.Clear;
  cbInitMode.Items.Add('Inbound');
  cbInitMode.Items.Add('Outbound');
  cbInitMode.Items.Add('Campaign');
  cbInitMode.Items.Add('Callback');
  cbInitMode.ItemIndex := 1;
  FIniFileName := ChangeFileExt(Application.ExeName, '.ini');
  edtWebSocketUrl.Text := 'https://172.28.224.230:5011';
  edtUserId.Text := '743000';
  edtPhoneId.Text := '7031';
  edtDialNumber.Text := '';
  edtTransferNumber.Text := '';
  FClient := nil;
  FLoggedIn := False;
  FConnecting := False;
  FSession := 'None';
  FCallTime := '00:00:00';
  FCallType := 'Idle';
  FLastWebSocketUrl := '';
  FConnectAttemptUrl := '';
  FConnectedWebSocketUrl := '';
  FPendingMode := '';
  FPendingDialNumber := '';
  FPendingDialCallType := '';
  FPrevHoldMode := '';
  FRecordRunning := False;
  FStateStartedAt := 0;
  FCallStartedAt := 0;
  FCallEndedAt := 0;
  FLastCallDuration := '';
  FTrackedStatusName := '';
  PingTimer.Interval := 30000;
  PingTimer.Enabled := False;
  StateTimer.Interval := 1000;
  StateTimer.Enabled := False;
  ReconnectTimer.Interval := 3000;
  ReconnectTimer.Enabled := False;
  ResetCallContext;
  LoadSettings;
  UpdateButtons;
  UpdateStatus;
  AddLog('Sample initialized');
end;
procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  sDateTime  : TDateTime;
  iDay : Integer;
  sIniFileName : string;
begin

  sIniFileName := ExtractFilePath(Application.ExeName) + 'IPCCPHONE.ini';
  if not PhoneLib.fn_GetOption(sIniFileName) then
  begin
    AddLog('PhoneLib.GetOption failed');
    exit;
  end;

  Initialize;

  Debug.Start(1, ExtractFilePath(Application.ExeName) + '/Log/' + 'callhis_' + FormatDateTime('YYYYMMDD', Now) + '.dbgc');
  //Log 파일
  Debug.Start(1, ExtractFilePath(Application.ExeName) + '/Log/' + 'dbgp_' + FormatDateTime('YYYYMMDD', Now) + '.dbgc');

  for iDay := OptionRec.IsPhoneBookHisDay to 31 do
  begin
    sDateTime := Now - iDay;
    fn_Deletefiles( ExtractFilePath(Application.ExeName)+ '/Log/', 'callhis_' + FormatDateTime('YYYYMMDD', sDateTime) + '.dbgc');
    fn_Deletefiles( ExtractFilePath(Application.ExeName)+ '/Log/', 'dbgp_' + FormatDateTime('YYYYMMDD', sDateTime) + '.dbgc');
  end;
end;

procedure TFrmMain.fn_Deletefiles(APath, AFileSpec: string);
var
  lSearchRec:TSearchRec;
  lFind:integer;
  lPath:string;
begin
  lPath := IncludeTrailingPathDelimiter(APath);
  lFind := FindFirst(lPath+AFileSpec,faAnyFile,lSearchRec);
  while lFind = 0 do
  begin
    DeleteFile(lPath+lSearchRec.Name);
    lFind := FindNext(lSearchRec);
  end;
  FindClose(lSearchRec);
end;
procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  PingTimer.Enabled := False;
  StateTimer.Enabled := False;
  ReconnectTimer.Enabled := False;
  SaveSettings;
  FreeAndNil(FClient);
end;

procedure TFrmMain.LoadSettings;
var
  LIni: TIniFile;
begin
  if not FileExists(FIniFileName) then
    Exit;
  LIni := TIniFile.Create(FIniFileName);
  try
    edtWebSocketUrl.Text := OptionRec.IsWebSocketURL1;
    cbInitMode.Text      := OptionRec.IsInitMode;
    chkOverrideLogin.Checked := OptionRec.IsOverrideLogin;
    chkAutoReconnect.Checked := OptionRec.IsAutoReconnect;

    edtUserId.Text       := OptionRec.IsUserID;
    edtPhoneId.Text      := OptionRec.IsPhoneID;

    edtDialNumber.Text     := LIni.ReadString('Call', 'DialNumber', edtDialNumber.Text);
    edtTransferNumber.Text := LIni.ReadString('Call', 'TransferNumber', edtTransferNumber.Text);
  finally
    LIni.Free;
  end;
end;
procedure TFrmMain.ApplyTheme;
begin
  DoubleBuffered := True;
  Color := RGB(238, 242, 247);
  Font.Name := 'Segoe UI';
  Font.Size := 9;
 
  lbLog.Color := RGB(246, 248, 251);
  lbLog.Font.Name := 'Consolas';
  lbLog.Font.Size := 9;
  lblStatus.Font.Name := 'Segoe UI Semibold';
  lblStatus.Font.Size := 9;
  lblStatus.AutoSize := False;
  lblStatus.WordWrap := True;
  lblStatus.Width := 790;
  lblStatus.Height := 36;
end;
procedure TFrmMain.HandleIncomingText(const AText: string);
var
  LJson: TJSONObject;
  LReq: string;
  LEvt: string;
  LRes: string;
  LValue: string;
  LPrevMode: string;
  LPrevState: string;
begin
  AddLog('RECV ' + AText);
  LJson := TJSONObject.ParseJSONValue(AText) as TJSONObject;
  try
    if not Assigned(LJson) then
      Exit;
    LPrevMode := FMode;
    LPrevState := FState;
    LValue := ExtractJsonValue(LJson, 'mode');
    if Trim(LValue) <> '' then
    begin
      if SameText(LValue, 'Hold') and not SameText(LPrevMode, 'Hold') then
        FPrevHoldMode := LPrevMode;
      if not SameText(LValue, 'Hold') and SameText(LPrevMode, 'Hold') then
        FPrevHoldMode := '';
      FMode := LValue;
    end;
    LValue := ExtractJsonValue(LJson, 'state');
    if Trim(LValue) <> '' then
      FState := LValue;
    LValue := ExtractJsonValue(LJson, 'role');
    if Trim(LValue) <> '' then
      FRole := LValue;
    LValue := ExtractJsonValue(LJson, 'uid');
    if Trim(LValue) <> '' then
      FUid := LValue;
    LValue := ExtractJsonValue(LJson, 'time');
    if Trim(LValue) <> '' then
      FCallTime := LValue;
    LValue := ExtractJsonValue(LJson, 'call_type');
    if Trim(LValue) <> '' then
      FCallType := LValue;
    LValue := ExtractJsonValue(LJson, 'achan');
    if Trim(LValue) <> '' then
      FAChan := LValue;
    LValue := ExtractJsonValue(LJson, 'cchan');
    if Trim(LValue) <> '' then
      FCChan := LValue;
    LValue := ExtractJsonValue(LJson, 'tchan');
    if Trim(LValue) <> '' then
      FTChan := LValue;
    LValue := ExtractJsonValue(LJson, 'cphone');
    if Trim(LValue) <> '' then
      FCPhone := LValue;
    LValue := ExtractJsonValue(LJson, 'tphone');
    if Trim(LValue) <> '' then
      FTPhone := LValue;
    LReq := ExtractJsonValue(LJson, 'req');
    LEvt := ExtractJsonValue(LJson, 'evt');
    LRes := ExtractJsonValue(LJson, 'res');
    if not IsConnectedCallState(LPrevState) and IsConnectedCallState(FState) then
    begin
      FCallStartedAt := Now;
      FCallEndedAt := 0;
      FLastCallDuration := '';
    end
    else if IsConnectedCallState(LPrevState) and not IsConnectedCallState(FState) then
    begin
      FCallEndedAt := Now;
      if FCallStartedAt > 0 then
        FLastCallDuration := FormatElapsedTime(FCallStartedAt)
      else
        FLastCallDuration := FCallTime;
    end;
    if SameText(LReq, 'login') and SameText(LRes, 'success') then
    begin
      FLoggedIn := True;
      PingTimer.Enabled := True;
      if SameText(FMode, 'Logout') or (Trim(FMode) = '') then
        FMode := cbInitMode.Text;
      if Trim(FState) = '' then
        FState := 'Idle';
      FSession := 'None';
      AddLog(Format('Login success: mode=%s, state=%s', [FMode, FState]));
    end
    else if SameText(LReq, 'setMode') and SameText(LRes, 'success') then
    begin
      if (Trim(ExtractJsonValue(LJson, 'mode')) = '') and (Trim(FPendingMode) <> '') then
        FMode := FPendingMode;
      if Trim(ExtractJsonValue(LJson, 'state')) = '' then
        FState := 'Idle';
      AddLog(Format('SetMode success: mode=%s, state=%s', [FMode, FState]));
      if (Trim(FPendingDialNumber) <> '') and SameText(FMode, FPendingDialCallType) and SameText(FState, 'Idle') then
      begin
        SendJson(BuildDialPayload(FPendingDialNumber, FPendingDialCallType));
        FPendingDialNumber := '';
        FPendingDialCallType := '';
      end;
      FPendingMode := '';
    end
    else if SameText(LRes, 'success') and (MapToggleRequestToMode(LReq) <> '') then
    begin
      if Trim(ExtractJsonValue(LJson, 'mode')) = '' then
        FMode := MapToggleRequestToMode(LReq);
      if Trim(ExtractJsonValue(LJson, 'state')) = '' then
      begin
        if SameText(FMode, 'Hold') then
          FState := 'Hold'
        else
          FState := 'Idle';
      end;
      AddLog(Format('Toggle mode success: req=%s, mode=%s, state=%s', [LReq, FMode, FState]));
    end
    else if SameText(LReq, 'logout') and SameText(LRes, 'success') then
    begin
      FLoggedIn := False;
      PingTimer.Enabled := False;
      FSession := 'None';
      FPendingMode := '';
      FPendingDialNumber := '';
      FPendingDialCallType := '';
      AddLog('Logout success');
    end
    else if SameText(LReq, 'ping') then
      AddLog('Ping response received')
    else if SameText(LRes, 'error') then
    begin
      if SameText(LReq, 'setMode') then
        FPendingMode := '';
      if SameText(LReq, 'setMode') then
      begin
        FPendingDialNumber := '';
        FPendingDialCallType := '';
      end;
      AddLog('Server error: ' + ExtractJsonValue(LJson, 'msg'))
    end
    else if Trim(LEvt) <> '' then
      AddLog(Format('Event received: evt=%s, mode=%s, state=%s, sub=%s',
        [LEvt, FMode, FState, ExtractJsonValue(LJson, 'sub')]));
  finally
    LJson.Free;
    UpdateButtons;
    UpdateStatus;
  end;
end;
procedure TFrmMain.PingTimerTimer(Sender: TObject);
begin
  if Assigned(FClient) and FClient.Active and FClient.Connected and FLoggedIn then
    SendJson(BuildPingPayload);
end;
procedure TFrmMain.StateTimerTimer(Sender: TObject);
begin
  UpdateStateElapsedTime;
end;
procedure TFrmMain.QueueReconnect;
begin
  if not chkAutoReconnect.Checked then
    Exit;
  if Trim(FLastWebSocketUrl) = '' then
    Exit;
  if FConnecting then
    Exit;
  if Assigned(FClient) and FClient.Active and FClient.Connected then
    Exit;
  AddLog('Auto reconnect scheduled in 3 seconds');
  FConnecting := True;
  UpdateButtons;
  ReconnectTimer.Enabled := True;
end;
procedure TFrmMain.ReconnectTimerTimer(Sender: TObject);
begin
  ReconnectTimer.Enabled := False;
  if not chkAutoReconnect.Checked then
  begin
    FConnecting := False;
    UpdateButtons;
    Exit;
  end;
  try
    AddLog('Trying auto reconnect');
    DoConnect;
  except
    on E: Exception do
    begin
      FConnecting := False;
      AddLog('Auto reconnect error: ' + E.Message);
      UpdateButtons;
    end;
  end;
end;
procedure TFrmMain.ResetCallContext;
begin
  FMode := 'Logout';
  FState := 'Idle';
  FRole := '';
  FUid := '';
  FSession := 'None';
  FCallTime := '00:00:00';
  FCallType := 'Idle';
  FAgentPhone := Trim(edtPhoneId.Text);
  FPrevHoldMode := '';
  FRecordRunning := False;
  FAChan := '';
  FCChan := '';
  FTChan := '';
  FCPhone := '';
  FTPhone := '';
  FPendingDialNumber := '';
  FPendingDialCallType := '';
  FStateStartedAt := 0;
  FCallStartedAt := 0;
  FCallEndedAt := 0;
  FLastCallDuration := '';
  FTrackedStatusName := '';
  if Assigned(btnRecord) then
    btnRecord.Caption := '부분녹취 시작';
end;
procedure TFrmMain.SaveSettings;
var
  LIni: TIniFile;
begin
  if Trim(FIniFileName) = '' then
    Exit;
  LIni := TIniFile.Create(FIniFileName);
  try
    LIni.WriteString('Connection' ,'WebSocketUrl'  ,Trim(edtWebSocketUrl.Text));
    LIni.WriteString('Connection' ,'UserId'        ,Trim(edtUserId.Text));
    LIni.WriteString('Connection' ,'PhoneId'       ,Trim(edtPhoneId.Text));
    LIni.WriteString('Connection' ,'InitMode'      ,cbInitMode.Text);
    LIni.WriteBool('Connection'   ,'OverrideLogin' ,chkOverrideLogin.Checked);
    LIni.WriteBool('Connection'   ,'AutoReconnect' ,chkAutoReconnect.Checked);
    LIni.WriteString('Call'       ,'DialNumber'    ,Trim(edtDialNumber.Text));
    LIni.WriteString('Call'       ,'TransferNumber',Trim(edtTransferNumber.Text));
  finally
    LIni.Free;
  end;
end;
function TFrmMain.SendJson(const APayload: string): Boolean;
var
  LJson: TJSONObject;
  LText: string;
begin
  Result := Assigned(FClient) and FClient.Active;
  if not Result then
    raise Exception.Create('WebSocket is not connected.');
  LText := APayload;
  LJson := TJSONObject.ParseJSONValue(APayload) as TJSONObject;
  try
    if Assigned(LJson) then
    begin
      if (LJson.GetValue('req') <> nil) and (LJson.GetValue('userid') = nil) then
      begin
        LJson.AddPair('userid', Trim(edtUserId.Text));
        LText := LJson.ToJSON;
      end;
    end;
  finally
    LJson.Free;
  end;
  AddLog('SEND ' + LText);
  FClient.WriteData(LText);
end;
procedure TFrmMain.pmBreakPopup(Sender: TObject);
begin
  UpdateBreakMenuItems;
end;
procedure TFrmMain.BreakMenuItemClick(Sender: TObject);
var
  LRequestName: string;
begin
  try
    if not (Sender is TMenuItem) then
      Exit;
    LRequestName := Trim(TMenuItem(Sender).Hint);
    if LRequestName = '' then
      Exit;
    if EnsureClientReady then
      SendJson(BuildToggleModePayload(LRequestName));
  except
    on E: Exception do
    begin
      AddLog('ERROR ' + E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;
procedure TFrmMain.UpdateBreakMenuItems;
begin
  miBreakAway.Enabled := BtnBreak.Enabled and (not SameText(FMode, 'Away'));
  miBreakRest.Enabled := BtnBreak.Enabled and (not SameText(FMode, 'Rest'));
  miBreakLunch.Enabled := BtnBreak.Enabled and (not SameText(FMode, 'Lunch'));
  miBreakMeeting.Enabled := BtnBreak.Enabled and (not SameText(FMode, 'Meeting'));
  miBreakSeminar.Enabled := BtnBreak.Enabled and (not SameText(FMode, 'Seminar'));
  miBreakEtc.Enabled := BtnBreak.Enabled and (not SameText(FMode, 'Etc'));
  miBreakAway.Checked := SameText(FMode, 'Away');
  miBreakRest.Checked := SameText(FMode, 'Rest');
  miBreakLunch.Checked := SameText(FMode, 'Lunch');
  miBreakMeeting.Checked := SameText(FMode, 'Meeting');
  miBreakSeminar.Checked := SameText(FMode, 'Seminar');
  miBreakEtc.Checked := SameText(FMode, 'Etc');
end;
procedure TFrmMain.UpdateButtons;
var
  LReady: Boolean;
  LIdleReady: Boolean;
  LConnectRoleA: Boolean;
  LTxConnectRoleA: Boolean;
  LTx3ConnectRoleA: Boolean;
  LRingState: Boolean;
begin
  if SameText(FMode, 'Hold') then
    btnHold.Caption := '보류해제'
  else
    btnHold.Caption := '통화보류';
  btnConnect.Enabled := not FConnecting and ((not Assigned(FClient)) or (not FClient.Active));
  btnDisconnect.Enabled := Assigned(FClient) and FClient.Active;
  LReady := Assigned(FClient) and FClient.Active and FLoggedIn;
  LIdleReady := LReady and SameText(FState, 'Idle');
  LConnectRoleA := LReady and SameText(FState, 'Connect') and SameText(FRole, 'a');
  LTxConnectRoleA := LReady and IsAnyState(['TxConnect', 'TxConnectC']) and SameText(FRole, 'a');
  LTx3ConnectRoleA := LReady and SameText(FState, 'Tx3Connect') and SameText(FRole, 'a');
  LRingState := LReady and IsAnyState(['Ring', 'TxRing']);
  btnInbound.Enabled := False;
  btnOutbound.Enabled := False;
  btnCampaign.Enabled := False;
  btnDial.Enabled := False;
  btnAnswer.Enabled := False;
  btnHangup.Enabled := False;
  btnRecord.Enabled := False;
  btnHijack.Enabled := False;
  btnTransfer.Enabled := False;
  btnTransferCold.Enabled := False;
  btnTransferWarm.Enabled := False;
  btnHold.Enabled := False;
  btnNotReady.Enabled := False;
  BtnBreak.Enabled := False;
  btnTxComplete.Enabled := False;
  btnTxCancel.Enabled := False;
  btnTx3Connect.Enabled := False;
  btnTxToggle.Enabled := False;
  btnGetState.Enabled := LReady;
  btnIvrSsn.Enabled := False;
  btnIvrAcc.Enabled := False;
  btnIvrRet.Enabled := False;
  btnQueueAdd.Enabled := LReady;
  btnQueueSub.Enabled := LReady;
  btnQueueRun.Enabled := LReady;
  btnQueuePause.Enabled := LReady;
  btnQueueState.Enabled := LReady;
  btnTeamAgents.Enabled := False;
  btnGroupAgents.Enabled := False;
  btnCenterAgents.Enabled := False;
  if not LReady then
  begin
    btnClearLog.Enabled := True;
    Exit;
  end;
  if SameText(FMode, 'Error') or SameText(FMode, 'Logout') then
  begin
    btnClearLog.Enabled := True;
    Exit;
  end;
  if IsAnyMode(['NotReady', 'Hold', 'Away', 'Rest', 'Lunch', 'Meeting', 'Seminar', 'Etc']) then
  begin
    if SameText(FMode, 'Hold') then
    begin
      btnHold.Enabled := True
    end
    else
    begin
      btnNotReady.Enabled := not SameText(FMode, 'NotReady');
      BtnBreak.Enabled := True;
      btnDial.Enabled := True;
    end;
    btnClearLog.Enabled := True;
    UpdateBreakMenuItems;
    Exit;
  end;
  if SameText(FState, 'Idle') then
  begin
    btnNotReady.Enabled := True;
    BtnBreak.Enabled := True;
    if IsAnyMode(['Inbound', 'IDirect', 'Internal']) then
    begin
      btnDial.Enabled := True;
    end
    else if SameText(FMode, 'Outbound') then
    begin
      btnDial.Enabled := True;
    end
    else if SameText(FMode, 'Campaign') then
    begin
      btnDial.Enabled := True;
    end;
    btnInbound.Enabled := not SameText(FMode, 'Inbound');
    btnOutbound.Enabled := not SameText(FMode, 'Outbound');
    btnCampaign.Enabled := not SameText(FMode, 'Campaign');
  end
  else if SameText(FState, 'Ring') then
  begin
    btnAnswer.Enabled := True;
    btnHangup.Enabled := True;
  end
  else if SameText(FState, 'Dial') then
  begin
    btnHangup.Enabled := True;
  end
  else if SameText(FState, 'Connect') then
  begin
    if SameText(FRole, 'a') or (Trim(FRole) = '') then
    begin
      btnHold.Enabled := True;
      btnHangup.Enabled := True;
      btnTransferCold.Enabled := True;
      btnTransferWarm.Enabled := True;
      btnTransfer.Enabled := True;
      btnIvrSsn.Enabled := True;
      btnIvrAcc.Enabled := True;
      btnIvrRet.Enabled := True;
      btnRecord.Enabled := True;
    end
    else
      btnHangup.Enabled := True;
  end
  else if SameText(FState, 'Hold') then
  begin
    btnHold.Enabled := True;
    btnHangup.Enabled := True;
  end
  else if SameText(FState, 'TxDial') then
  begin
    btnTxCancel.Enabled := True;
  end
  else if SameText(FState, 'TxRing') then
  begin
    btnHangup.Enabled := True;
    btnAnswer.Enabled := True;
  end
  else if SameText(FState, 'TxWait') then
  begin
    btnHangup.Enabled := True;
  end
  else if IsAnyState(['TxConnect', 'TxConnectC']) then
  begin
    if SameText(FRole, 'a') then
    begin
      btnHangup.Enabled := True;
      btnTxComplete.Enabled := True;
      btnTxCancel.Enabled := True;
      btnTxToggle.Enabled := True;
      btnTx3Connect.Enabled := True;
    end
    else
      btnHangup.Enabled := True;
  end
  else if SameText(FState, 'Tx3Connect') then
  begin
    if SameText(FRole, 'a') then
    begin
      btnHangup.Enabled := True;
      btnTxComplete.Enabled := True;
      btnTxCancel.Enabled := True;
    end
    else
      btnHangup.Enabled := True;
  end;
  btnClearLog.Enabled := True;
  UpdateBreakMenuItems;
end;
function TFrmMain.IsSocketConnected: Boolean;
begin
  Result := Assigned(FClient) and FClient.Active and FClient.Connected;
end;
function TFrmMain.IsConnectedCallState(const AState: string): Boolean;
begin
  Result := SameText(AState, 'Connect')
    or SameText(AState, 'TxConnect')
    or SameText(AState, 'TxConnectC')
    or SameText(AState, 'Tx3Connect');
end;
function TFrmMain.GetCtiStatusName: string;
begin
  if not IsSocketConnected then
    Exit(#47196#44536#50500#50883);
  if IsAnyState(['Connect', 'TxConnect', 'TxConnectC', 'Tx3Connect', 'TxWait']) then
    Exit(#53685#54868#51473);
  if IsAnyState(['Ring', 'Dial', 'TxRing', 'TxDial']) then
    Exit(#53685#54868#51473);
  if SameText(FMode, 'Away') then
    Exit(#51088#47532#48708#50880);
  if SameText(FMode, 'Rest') then
    Exit(#55092#49885);
  if SameText(FMode, 'Lunch') then
    Exit(#49885#49324);
  if SameText(FMode, 'Meeting') then
    Exit(#54924#51032);
  if SameText(FMode, 'Seminar') then
    Exit(#44368#50977);
  if SameText(FMode, 'Etc') then
    Exit(#44592#53440);
  if SameText(FMode, 'NotReady') then
    Exit(#54980#52376#47532);
  if SameText(FMode, 'Hold') then
    Exit(#53685#54868#51473);
  Exit(#45824#44592);
end;
function TFrmMain.FormatElapsedTime(const AStartTime: TDateTime): string;
var
  LElapsedSeconds: Int64;
  LHours: Int64;
  LMinutes: Int64;
  LSeconds: Int64;
begin
  if AStartTime <= 0 then
    Exit('00:00:00');
  LElapsedSeconds := Trunc((Now - AStartTime) * 86400);
  if LElapsedSeconds < 0 then
    LElapsedSeconds := 0;
  LHours := LElapsedSeconds div 3600;
  LMinutes := (LElapsedSeconds mod 3600) div 60;
  LSeconds := LElapsedSeconds mod 60;
  Result := Format('%.2d:%.2d:%.2d', [LHours, LMinutes, LSeconds]);
end;
procedure TFrmMain.UpdateStateElapsedTime;
var
  LCtiStatusName: string;
begin
  if not IsSocketConnected then
  begin
    StateTimer.Enabled := False;
    lab_Status_Time.Caption := '00:00:00';
    Exit;
  end;
  LCtiStatusName := GetCtiStatusName;
  if not SameText(FTrackedStatusName, LCtiStatusName) then
  begin
    FTrackedStatusName := LCtiStatusName;
    FStateStartedAt := Now;
  end;
  if FStateStartedAt <= 0 then
    FStateStartedAt := Now;
  StateTimer.Enabled := True;
  lab_Status_Time.Caption := FormatElapsedTime(FStateStartedAt);
end;
procedure TFrmMain.UpdateCallInfo;
var
  LDirection: string;
begin
  if IsConnectedCallState(FState) and (FCallStartedAt > 0) then
    edtDuration.Text := FormatElapsedTime(FCallStartedAt)
  else if Trim(FLastCallDuration) <> '' then
    edtDuration.Text := FLastCallDuration
  else
    edtDuration.Text := '00:00:00';

  if FCallStartedAt > 0 then
    edtSrtTime.Text := FormatDateTime('hh:nn:ss', FCallStartedAt)
  else
    edtSrtTime.Text := '';

  if FCallEndedAt > 0 then
    edtEndTime.Text := FormatDateTime('hh:nn:ss', FCallEndedAt)
  else
    edtEndTime.Text := '';

  if SameText(FCallType, 'Inbound') then
    LDirection := 'Inbound'
  else if SameText(FCallType, 'Outbound') then
    LDirection := 'OutBound'
  else
    LDirection := '';
  edtInOut.Text := LDirection;

  edtRec.Text := '';
end;
procedure TFrmMain.UpdateStatus;
var
  LCtiStatusName: string;
begin
  if SameText(FState, 'Connect') and SameText(FSession, 'None') then
    FSession := 'Init'
  else if not SameText(FState, 'Connect') and not SameText(FSession, 'Ssn') and not SameText(FSession, 'Account') then
    FSession := 'None';
  lblStatus.Caption := Format(
    'UserID=%s  Phone=%s  Mode=%s  State=%s  Session=%s  Time=%s  CallType=%s  Role=%s  UID=%s  WS=%s',
    [Trim(edtUserId.Text),
     Trim(edtPhoneId.Text),
     FMode,
     FState,
     FSession,
     FCallTime,
     FCallType,
     FRole,
     FUid,
     FConnectedWebSocketUrl]);
  UpdateCallInfo;
  LCtiStatusName := GetCtiStatusName;
  lab_Status_NM.Caption := LCtiStatusName;
  if LCtiStatusName = #45824#44592 then
    lab_Status_NM.Font.Color := RGB(38, 87, 163)
  else if LCtiStatusName = #53685#54868#51473 then
    lab_Status_NM.Font.Color := RGB(17, 115, 75)
  else if LCtiStatusName = #54980#52376#47532 then
    lab_Status_NM.Font.Color := RGB(180, 102, 0)
  else if LCtiStatusName = #51088#47532#48708#50880 then
    lab_Status_NM.Font.Color := RGB(124, 72, 163)
  else if LCtiStatusName = #55092#49885 then
    lab_Status_NM.Font.Color := RGB(87, 96, 111)
  else if LCtiStatusName = #49885#49324 then
    lab_Status_NM.Font.Color := RGB(160, 87, 35)
  else if LCtiStatusName = #54924#51032 then
    lab_Status_NM.Font.Color := RGB(121, 78, 46)
  else if LCtiStatusName = #44368#50977 then
    lab_Status_NM.Font.Color := RGB(0, 122, 204)
  else if LCtiStatusName = #44592#53440 then
    lab_Status_NM.Font.Color := RGB(109, 109, 109)
  else if LCtiStatusName = #47196#44536#50500#50883 then
    lab_Status_NM.Font.Color := RGB(160, 52, 52)
  else
    lab_Status_NM.Font.Color := RGB(43, 58, 85);
  UpdateStateElapsedTime;
  if not IsSocketConnected then
  begin
    lblStatus.Font.Color := RGB(160, 52, 52)
  end
  else if SameText(FState, 'Connect') or SameText(FState, 'TxConnect') or SameText(FState, 'TxConnectC') or SameText(FState, 'Tx3Connect') then
  begin
    lblStatus.Font.Color := RGB(17, 115, 75)
  end
  else if SameText(FState, 'Ring') or SameText(FState, 'TxRing') then
  begin
    lblStatus.Font.Color := RGB(180, 102, 0)
  end
  else
  begin
    lblStatus.Font.Color := RGB(43, 58, 85);
  end;
end;
procedure TFrmMain.WebSocketClientConnect(Connection: TsgcWSConnection);
begin
  FConnecting := False;
  FConnectedWebSocketUrl := FConnectAttemptUrl;
  AddLog('WebSocket connected: ' + FConnectedWebSocketUrl);
  SendJson(BuildLoginPayload);
  UpdateButtons;
  UpdateStatus;
end;
procedure TFrmMain.WebSocketClientDisconnect(Connection: TsgcWSConnection; Code: Integer);
begin
  PingTimer.Enabled := False;
  FConnecting := False;
  FLoggedIn := False;
  AddLog(Format('WebSocket disconnected: code=%d / url=%s', [Code, FConnectedWebSocketUrl]));
  FConnectedWebSocketUrl := '';
  UpdateButtons;
  UpdateStatus;
  QueueReconnect;
end;
procedure TFrmMain.WebSocketClientError(Connection: TsgcWSConnection; const Error: string);
begin
  FConnecting := False;
  AddLog('WebSocket error: ' + Error + ' / url=' + FConnectAttemptUrl);
  UpdateButtons;
  UpdateStatus;
end;
procedure TFrmMain.WebSocketClientMessage(Connection: TsgcWSConnection; const Text: string);
begin
  HandleIncomingText(Text);
end;
end.
