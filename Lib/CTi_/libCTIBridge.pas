unit libCTIBridge;

interface
uses
  Sysutils, windows, forms, ComCtrls, Dialogs, Classes, BRIDGEXLib_TLB, BRIDGECLIENTXLib_TLB, varAvaya;

//------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------
procedure CTIAva_Initialize;
function CTIAva_State(var TmrState: Integer; var DeviceState: Integer): Integer;
function CTIAva_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;

var
  cxBridge: TBridgeClientX;
  cxCTIBridge: TBridgeX;


implementation
uses DebugLib;

 //------------------------------------------------------------------------------
//Etc
//------------------------------------------------------------------------------

procedure CTIAva_Initialize;
var nRtn: Integer;
begin
//  cxBridge.cxSetConnection('192.168.1.50', 8010, 8020, 3, 100);
//  cxBridge.cxCreateServerThread(8020);

  cxCTIBridge.ctSetServerConfig('192.168.1.150', 8010); //소켓연결

end;

function CTIAva_State(var TmrState: Integer; var DeviceState: Integer): Integer;
var
  nRtn: Integer;
  sStatus: String;

begin

//  sStatus := cxBridge.cxGetAgentState(TmrRec.Device, TmrRec.CTiID);

//  sSkill := cxCTIBridge.ctGetSkillInfo(TmrRec.AcdID);
   
  sStatus := '1111111111';


  nRtn := StrToInt(Copy(sStatus, 1, 4));
  DeviceState := StrToInt(Copy(sStatus, 5, 1));
  TmrState := StrToInt(Copy(sStatus, 6, 1));
  Result := nRtn;
end;

function CTIAva_SetState(tForm: TCustomForm; tBar: TStatusBar; Index: Integer): Integer;
var
  sTmr, sDevice: String;
  nRtn, nTmr, nDevice: Integer;
begin
  nRtn := CTIAva_State(nTmr, nDevice);
  gAgentMode := nTmr;
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
    DEVICE_BUSY :begin
                   sDevice := '통화중';
                   gAgentMode := AGENT_OW;
                 end;
  end;
  if Assigned(tForm) and Assigned(tBar) then
  begin
    with tForm do
      tBar.Panels[Index].Text := sTmr+'/'+sDevice;
  end;
  Result := nTmr*10+nDevice;
end;

end.

