////////////////////////////////////////////////////////////////////////////////
//                              Nagi's defSCplus5                             //
////////////////////////////////////////////////////////////////////////////////
// Ver. 1.0.0.0                                                               //
// Last Update : 2004. 04. 20                                                 //
////////////////////////////////////////////////////////////////////////////////
unit defSCplus5;

interface

uses
  Windows;

const
  DLLNAME  = 'smartcall.dll';

//------------------------------------------------------------------------------
//호 제어 관련 함수
//------------------------------------------------------------------------------
  function CTI_Login(hCallingWnd: HWND; strAgentID, strDevice: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Logout: Integer; stdcall; External DLLNAME;
  function CTI_Break(nOption: Integer): Integer; stdcall; External DLLNAME;
  function CTI_DND(bDND: WordBool): Integer; stdcall; External DLLNAME;
  function CTI_SetDeviceState(nOption: Integer): Integer; stdcall; External DLLNAME;
  function CTI_AutoAnswer(bAuto: WordBool): Integer; stdcall; External DLLNAME;
  function CTI_MakeCall(strDevice: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Answer: Integer; stdcall; External DLLNAME;
  function CTI_Disconnect: Integer; stdcall; External DLLNAME;
  function CTI_Hold: Integer; stdcall; External DLLNAME;
  function CTI_Retrieve: Integer; stdcall; External DLLNAME;
  function CTI_ConsultEx(nRemote: Integer; lpszDevice, lpszSvcName, lpszReserved: PChar): Integer; stdcall; External DLLNAME;
  function CTI_TransferEx(nMode: Integer; lpszDest, lpszSvcName, lpszReserved: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Transfer(nRemote: Integer; strDevice, strMessage: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Reconnect: Integer; stdcall; External DLLNAME;
  function CTI_Alternate: Integer; stdcall; External DLLNAME;
  function CTI_Conference: Integer; stdcall; External DLLNAME;
  function CTI_PickUp(strDevice: PChar): Integer; stdcall; External DLLNAME;
  function CTI_DTMF(strData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Forward(strDevice: PChar; bTrue: WordBool; nType: Integer): Integer; stdcall; External DLLNAME;
  function CTI_EndReady: Integer; stdcall; External DLLNAME;
  function CTI_GetPassword(bCheck: WordBool; nMin, nMax: Integer; szArg, szPasswd: PChar; nTime: Integer): Integer; stdcall; External DLLNAME;
  function CTI_VoicePop(strInfoCode: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Join(strDevice: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Intrude(strDevice: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Listen(szLogID: PChar): Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//상담원 정보 관련 함수
//------------------------------------------------------------------------------
  function CTI_GetAgentState: Integer; stdcall; External DLLNAME;
  function CTI_GetMyInfo(szInfo: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetErrorMessage(szMessage: PChar): Integer; stdcall; External DLLNAME;
  function CTI_WhoIsCaller(szCaller: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Messages(nCheck: Integer; szDestIP, szData: PChar): Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//각종 정보 요청 관련 함수
//------------------------------------------------------------------------------
  function CTI_SetMyMode(szMode: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetGroups(szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetParts(szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetRemote(szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetAgents(nOption: Integer; szTarget, szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Booking(nOption: Integer; szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Callback(nOption: Integer; nCount: Integer; szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetCallbackCounts(lpszData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Abandoned(nOption: Integer; nCount: Integer; szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetQueued(szData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Recall(nOption: Integer; szData, szFlag: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetSharedMemory(lpszData: PChar): Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//초기 설정 관련 및 기타 함수
//------------------------------------------------------------------------------
  function CTI_GetVersion(bDlgShow: Boolean; lpszCVer, lpszSVer: PChar; nBufSize: Integer; nResvervd: Integer): Integer; stdcall; External DLLNAME;
//  function CTI_AgentState(): Integer; stdcall; External DLLNAME;//imsi인자값 설정
  function CTI_GetCallID(lpszCallID: PChar): Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//OutBound 관련 함수
//------------------------------------------------------------------------------
  function CTI_GetOutBoundScrData(lpszOutBoundData: PChar; nBufSize: Integer): Integer; stdcall; External DLLNAME;
  function CTI_SetOutBoundType(cType: Char; lpszBuffer: PChar; nBuffSize: Integer): Integer; stdcall; External DLLNAME;
  function CTI_PreviewListStatus(nOption, nCount: Integer; lpszData: PChar; nBufSize: Integer): Integer; stdcall; External DLLNAME;
  function CTI_ReservedDataList(nOption: Integer; lpszData: PChar; nBufSize: Integer): Integer; stdcall; External DLLNAME;
  function CTI_GetReservedCallerInfo(lpszRsCallerInfo: PChar; nBufSize: Integer): Integer; stdcall; External DLLNAME;
  function CTI_ReservedCallDone(lpszRsCallerInfo: PChar; nBufSize: Integer): Integer; stdcall; External DLLNAME;
  function CTI_GetProgressStatus(lpszData: PChar; pBufSize: PINT): Integer; stdcall; External DLLNAME;
  function CTI_GetCampaignType(lpszData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetCampaignList(lpszType, lpszData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_CampaignLogin(nOption: Integer; lpszAgentID, lpszData: PChar): Integer; stdcall; External DLLNAME;
  function CTI_CampaignLogout(lpszAgentID: PChar; bOption:Boolean): Integer; stdcall; External DLLNAME;
  function CTI_DoNotCall(nOption: Integer; szData: PChar): Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//WCS 관련 함수
//------------------------------------------------------------------------------
  function CTI_Emailback(nOption, nCount: Integer; szData: PChar): Integer; stdcall; External DLLNAME;
  function WCS_GetEmailbody(szEmailLogTime, szCustEmailAddr, szEmail: PChar): Integer; stdcall; External DLLNAME;
  function WCS_ReplyEmail(szEmailLogTime, szCustEmailAddr, szFromAddr, szReplyBody: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetCustomerID(szCustID: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetCustomerIP(szCustIP: PChar): Integer; stdcall; External DLLNAME;
  function CTI_GetEmailbackCounts(szData: PChar): Integer; stdcall; External DLLNAME;


//------------------------------------------------------------------------------
//미확인 함수(책자에 나오지 않음)
//------------------------------------------------------------------------------
  function CTI_Consult(nRemote: Integer; strDevice, strMessage: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Reset: Integer; stdcall; External DLLNAME;
  function CTI_GetPort(szPort: PChar): Integer; stdcall; External DLLNAME;
  function CTI_Packet(sIP: PChar; nPort: Integer; sClass, sReserve, sData: PChar; nWait: Integer): Integer; stdcall; External DLLNAME;
  function CTI_SocketListen(nPort: Integer): Integer; stdcall; External DLLNAME;
  function CTI_SetPreviewListStatus(nOption, nCount: Integer; lpszStrData: PChar; nBufSize: Integer): Integer; stdcall; External DLLNAME;
  function CTI_GetPreviewData(lpszBuffer: PChar; nBuffSize: Integer): Integer; stdcall; External DLLNAME;


implementation

end.
