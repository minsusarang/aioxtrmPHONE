unit defAvaya;

interface

uses
  Windows;

const
  DLLNAME  = 'LCTDesk.dll';

//------------------------------------------------------------------------------
//CTIBridge Application API - Initialize
//------------------------------------------------------------------------------
  function Init(hWnd: HWND): LongInt; stdcall; External DLLNAME;
  function CleanUp: LongInt; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//CTIBridge Application API - Status
//------------------------------------------------------------------------------
  function LogIn(agentID, stationID, acdID: PChar): LongInt; stdcall; External DLLNAME;
  function LogOut: LongInt; stdcall; External DLLNAME;
  function Ready: LongInt; stdcall; External DLLNAME;
  function PGReady: LongInt; stdcall; External DLLNAME;
  function NotReady(reasonCode: Integer): LongInt; stdcall; External DLLNAME;
  function ACW: LongInt; stdcall; External DLLNAME;
  function SetStatus(agentID, stationID, acdID: PChar; agentMode, workMode, reasonCode, bPending: Integer): LongInt; stdcall; External DLLNAME;
  function SetCVStatus(agentID, stationID, acdID: PChar; agentMode, workMode, reasonCode, bPending: Integer): LongInt; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//CTIBridge Application API - Event
//------------------------------------------------------------------------------
  function SetUUI(custInfo, ivrServiceCode, password: PChar): LongInt; stdcall; External DLLNAME;
  function GetUUI(custInfo, ivrServiceCode, password: PChar; callSource, callType: Integer; ani, siteData: PChar): LongInt; stdcall; External DLLNAME;
  function GetPassword(password: PChar): LongInt; stdcall; External DLLNAME;
  function AlternateCall: LongInt; stdcall; External DLLNAME;
  function AnswerCall: LongInt; stdcall; External DLLNAME;
  function BlindTransferCall(dest, custNo, ivrCode, pass, siteData: PChar): LongInt; stdcall; External DLLNAME;
  function ClearCall: LongInt; stdcall; External DLLNAME;
  function ClearConnection: LongInt; stdcall; External DLLNAME;
  function ConferenceCall: LongInt; stdcall; External DLLNAME;
  function ConsultationCall(dest, custNo, ivrCode, pass, siteData: PChar): LongInt; stdcall; External DLLNAME;
  function DeflectCall(dest: PChar): LongInt; stdcall; External DLLNAME;
  function HoldCall: LongInt; stdcall; External DLLNAME;
  function MakeCall(dest: PChar): LongInt; stdcall; External DLLNAME;
  function PickUpCall(dest: PChar): LongInt; stdcall; External DLLNAME;
  function ReconnectCall: LongInt; stdcall; External DLLNAME;
  function RetrieveCall: LongInt; stdcall; External DLLNAME;
  function SendDTMFTone(tone: PChar): LongInt; stdcall; External DLLNAME;
  function SetDoNotDisturb(xOn: Integer): LongInt; stdcall; External DLLNAME;
  function SetForwarding(dest: PChar; xOn: Integer): LongInt; stdcall; External DLLNAME;
  function SetMSGInd(xOn: Integer): LongInt; stdcall; External DLLNAME;
  function SingleStepConferenceCall(dest: PChar; xType: Integer; custNo, ivrCode, pass, siteData: PChar): LongInt; stdcall; External DLLNAME;
  function TransferCall: LongInt; stdcall; External DLLNAME;
  function SelectiveListeningHold: LongInt; stdcall; External DLLNAME;
  function SelectiveListeningRetrieve: LongInt; stdcall; External DLLNAME;
  function AskPassword(custNo: PChar): LongInt; stdcall; External DLLNAME;
  function CancelPassword: LongInt; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//CTIBridge Application API - Query
//------------------------------------------------------------------------------
  function QueryACD(acd: PChar; avail, wait, logged: Integer): LongInt; stdcall; External DLLNAME;
  function QueryACDList(count: Integer; list: PChar): LongInt; stdcall; External DLLNAME;
  function QueryAgentList(acd: PChar; status, count: Integer; list: PChar): LongInt; stdcall; External DLLNAME;
  function QueryAgentOfStation(station, agent: PChar): LongInt; stdcall; External DLLNAME;
  function QueryAgentStatus(station, agent, acd: PChar; status: Integer): LongInt; stdcall; External DLLNAME;
  function QueryStationOfAgent(agent, station: PChar): LongInt; stdcall; External DLLNAME;
  function QueryCVStatus(station, agent, acd: PChar; status: Integer): LongInt; stdcall; External DLLNAME;
  function QueryDeviceInfo(device: PChar; xType, xClass: Integer; dn: PChar): LongInt; stdcall; External DLLNAME;
  function QueryDeviceName(device: PChar; xType: Integer; name: PChar): LongInt; stdcall; External DLLNAME;
  function QueryDND(station: PChar; OnOff: Integer): LongInt; stdcall; External DLLNAME;
  function QueryForwarding(station: PChar; OnOff, xType: Integer; fDN: PChar): LongInt; stdcall; External DLLNAME;
  function MsgInd(station: PChar; OnOff, xType: Integer): LongInt; stdcall; External DLLNAME;{check}
  function QueryAlertingList(acd: PChar; count: Integer; list:PChar): LongInt; stdcall; External DLLNAME;
  function QueryTimeOfDay(date, time: PChar): LongInt; stdcall; External DLLNAME;
  function QueryUCID(ucid: PChar): LongInt; stdcall; External DLLNAME;


implementation

end.
