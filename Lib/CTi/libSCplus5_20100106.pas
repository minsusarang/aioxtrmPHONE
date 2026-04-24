////////////////////////////////////////////////////////////////////////////////
//                              Nagi's libSCplus5                             //
////////////////////////////////////////////////////////////////////////////////
// Ver. 1.0.0.0                                                               //
// Last Update : 2004. 04. 29                                                 //
////////////////////////////////////////////////////////////////////////////////
unit libSCplus5;//[DebugCode:31xxx]

interface

uses
  Sysutils, windows, forms, ComCtrls, Dialogs, Classes;

//------------------------------------------------------------------------------
//호 제어 관련 함수
//------------------------------------------------------------------------------
    function fCtiLogin(hCallingWnd: HWND; sCtiID, sDevice: String): Integer;
    function fCtiLogOut: Integer;
    function fCtiBreak(nOption: Integer): Integer;
//    function CTI_DND(bDND : WordBool) : Integer; stdcall; External DLLNAME;
    function fCtiSetDeviceState(nOption: Integer): Integer;
    function fCtiAutoAnswer(bAuto: boolean): Integer;
    function fCtiMakeCall(sDevice: String): Integer;
    function fCtiAnswer: Integer;
    function fCtiDisconnect: Integer;
    function fCtiHold: Integer;
    function fCtiRetrieve: Integer;
//    function CTI_Hold : Integer; stdcall; External DLLNAME;
//    function CTI_Retrieve : Integer; stdcall; External DLLNAME;
    function fCtiConsultEx(nRemote: Integer; sDevice, sSvcName, sReserved: String): Integer;
//    function CTI_TransferEx(nMode : Integer; lpszDest, lpszSvcName, lpszReserved : PChar) : Integer; stdcall; External DLLNAME;
    function fCtiTransfer(nRemote: Integer; sDevice: String=''; sMessage: String=''): Integer;
    function fCtiReconnect: Integer;
//    function CTI_Alternate : Integer; stdcall; External DLLNAME;
//    function CTI_Conference : Integer; stdcall; External DLLNAME;
//    function CTI_PickUp(strDevice : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_DTMF(strData : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_Forward(strDevice : PChar; bTrue : WordBool; nType : Integer) : Integer; stdcall; External DLLNAME;
    function fCtiEndReady: Integer;
//    function CTI_GetPassword(bCheck : WordBool; nMin : Integer; nMax : Integer; szArg : PChar; szPasswd : PChar; nTime : Integer) : Integer; stdcall; External DLLNAME;
//    function CTI_VoicePop(strInfoCode : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_Join(strDevice : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_Intrude(strDevice : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_Listen(szLogID : PChar) : Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//상담원 정보 관련 함수
//------------------------------------------------------------------------------
    function fCtiGetAgentState(tForm: TCustomForm=nil; tBar: TStatusBar=nil; Index: Integer=0): Integer;
    function fCtiGetMyInfo(nOption: Integer): Integer;
    function fCtiGetErrorMsg: Integer;
    function fCtiWhoIsCaller: Integer;
    function fCtiMessages(nCheck: Integer; sDest, sData: String): Integer;
//    function CTI_Messages(nCheck : Integer; szDestIP : PChar; szData : PChar) : Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//각종 정보 요청 관련 함수
//------------------------------------------------------------------------------
    function fCtiSetMyMode(sMode: String): Integer;
    function fCtiGetGroups(var GroupList: String): Integer;
    function fCtiGetParts(var PartList: String): Integer;
//    function CTI_GetRemote(szData : PChar) : Integer; stdcall; External DLLNAME;
    function fCtiGetAgents(nOption: Integer; sTarget: String): Integer;
//    function CTI_Booking(nOption : Integer; szData : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_Callback(nOption : Integer; nCount : Integer; szData : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_GetCallbackCounts(lpszData : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_Abandoned(nOption : Integer; nCount : Integer; szData : PChar) : Integer; stdcall; External DLLNAME;
    function fCtiGetQueued: Integer;
//    function CTI_Recall(nOption : Integer; szData : PChar; szFlag : PChar) : Integer; stdcall; External DLLNAME;
    function fCtiGetSharedMemory: Integer;

//------------------------------------------------------------------------------
//초기 설정 관련 및 기타 함수
//------------------------------------------------------------------------------
//    function CTI_GetVersion(bDlgShow : Boolean; lpszCVer : PChar; lpszSVer : PChar; nBufSize : Integer; nResvervd : Integer) : Integer; stdcall; External DLLNAME;
//    function CTI_AgentState() : Integer; stdcall; External DLLNAME;//imsi인자값 설정
//    function CTI_GetCallID(lpszCallID : PChar) : Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//OutBound 관련 함수
//------------------------------------------------------------------------------
    function fCtiGetOutBoundScrData: Integer;
//    function CTI_SetOutBoundType(cType : Char; lpszBuffer : PChar; nBuffSize : Integer) : Integer; stdcall; External DLLNAME;
//    function CTI_PreviewListStatus(nOption : Integer; nCount : Integer; lpszData : PChar; nBufSize : Integer) : Integer; stdcall; External DLLNAME;
//    function CTI_ReservedDataList(nOption : Integer; lpszData : PChar; nBufSize : Integer) : Integer; stdcall; External DLLNAME;
//    function CTI_GetReservedCallerInfo(lpszRsCallerInfo : PChar; nBufSize : Integer) : Integer; stdcall; External DLLNAME;
//    function CTI_ReservedCallDone(lpszRsCallerInfo : PChar; nBufSize : Integer) : Integer; stdcall; External DLLNAME;
//    function CTI_GetProgressStatus(lpszData : PChar; pBufSize : PINT) : Integer; stdcall; External DLLNAME;
//    function CTI_GetCampaignType(lpszData : PChar) : Integer; stdcall; External DLLNAME;
//    function CTI_GetCampaignList(lpszType : PChar; lpszData : PChar) : Integer; stdcall; External DLLNAME;
    function fCtiCampaignLogin(nOption: Integer; sAgentID: String; sData: String=''): Integer;
    function fCtiCampaignLogout(sAgentID: String; bOption: Boolean): Integer;
//    function CTI_DoNotCall(nOption : Integer; szData : PChar) : Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//WCS 관련 함수
//------------------------------------------------------------------------------
//    function CTI_Emailback(nOption, nCount: Integer; szData: PChar): Integer; stdcall; External DLLNAME;
//    function WCS_GetEmailbody(szEmailLogTime, szCustEmailAddr, szEmail: PChar): Integer; stdcall; External DLLNAME;
//    function WCS_ReplyEmail(szEmailLogTime, szCustEmailAddr, szFromAddr, szReplyBody: PChar): Integer; stdcall; External DLLNAME;
//    function CTI_GetCustomerID(szCustID: PChar): Integer; stdcall; External DLLNAME;
//    function CTI_GetCustomerIP(szCustIP: PChar): Integer; stdcall; External DLLNAME;
//    function CTI_GetEmailbackCounts(szData: PChar): Integer; stdcall; External DLLNAME;

//------------------------------------------------------------------------------
//기타 함수
//------------------------------------------------------------------------------
    procedure prGetMyInfo(nOption: Integer; aInfo: String);
    function GetAgents(nOption: Integer; sAgentInfo: String): Boolean;
    function SetAgentState(sState: String): String;

//------------------------------------------------------------------------------
// 레코드 클리어 함수
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
    procedure prClearSharedMemoryRec;
    procedure prClearGetMyInfoRec;
    procedure prClearGetMyInfoModifiedRec;
    procedure prClearGetGroupsRec;
    procedure prClearGetPartsRec;
    procedure prClearGetAgentsGup1Rec;
    procedure prClearGetAgentsGup2Rec;
    procedure prClearGetAgentsGup3Rec;
    procedure prClearGetAgentsGup4Rec;


implementation

uses defSCplus5, varSCplus5, DebugLib, UtilLib;

{
  case fCTIGetAgentState of
    STATE_I :begin
    end;
    STATE_R :begin
    end;
    STATE_N :begin
    end;
    STATE_D :begin
    end;
    STATE_H :begin
    end;
    STATE_A :begin
    end;
    STATE_O :begin
    end;
    STATE_V :begin
    end;
    STATE_C :begin
    end;
    STATE_U :begin
    end;
    STATE_F :begin
    end;
    STATE_P :begin
    end;
    STATE_L :begin
    end;
    else begin
    end;
  end;
{}

//==============================================================================
// CTI 제어 함수
//------------------------------------------------------------------------------
//호 제어 관련 함수
//------------------------------------------------------------------------------
// CTI_Login----------------------------------------------------------
function fCtiLogin(hCallingWnd: HWND; sCtiID, sDevice: String): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiLogin :"Start", sCtiID :"'+sCtiID+'", sDevice :"'+sDevice+'"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := CTI_Login(hCallingWnd, PChar(sCtiID), PChar(sDevice));
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiLogin :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Logout---------------------------------------------------------
function fCtiLogOut: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiLogOut :"Start"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := 0;
    end;
    STATE_D, STATE_R, STATE_O :begin
      nReturn := CTI_Logout;
      if nReturn <> 0 then fCTIGetErrorMsg
      else prClearTmrRec;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiLogOut :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Break(Flags)---------------------------------------------------
function fCtiBreak(nOption: Integer): Integer;
var
  nReturn: Integer;
  chkState: Integer;
begin
  Debug.Write(1, 31100, 'fCtiBreak :"Start", nOption :"'+IntToStr(nOption)+'"');
  nReturn := 999;
  if WorkStateCD <> nOption then begin
    chkState := fCTIGetAgentState;
    case chkState of
      STATE_D, STATE_R, STATE_O :begin
        nReturn := CTI_Break(nOption);
        if nReturn <> 0 then fCTIGetErrorMsg
        else begin
          case nOption of // 상담원 휴식중 상태 - 화면처리
            0 :fCtiSetDeviceState(3);
            1 :begin
              if (chkState = STATE_O) and not(WorkStateCD in [0, 1]) then fCtiSetDeviceState(3);
              fCtiSetDeviceState(4);
            end;
            2..6 :fCtiSetDeviceState(2);
          end;{}
          WorkStateCD := nOption;
        end;                                   
        fCTIGetAgentState;
      end;
    end;
  end
  else nReturn := 0;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiBreak :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_SetDeviceState-------------------------------------------------
function fCtiSetDeviceState(nOption: Integer): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiSetDeviceState :"Start", nOption :"'+IntToStr(nOption)+'"');
  nReturn := CTI_SetDeviceState(nOption);
  if nReturn <> 0 then fCTIGetErrorMsg;
  fCTIGetAgentState;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiSetDeviceState :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_AutoAnswer-----------------------------------------------------
function fCtiAutoAnswer(bAuto: boolean): Integer;
var
  nReturn: Integer;
begin
  if bAuto then Debug.Write(1, 31100, 'fCtiAutoAnswer :"Start", bAuto :"True"')
  else Debug.Write(1, 31100, 'fCtiAutoAnswer :"Start", bAuto :"False"');
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := 999;
    end;
    else begin
      nReturn := CTI_AutoAnswer(bAuto);
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiAutoAnswer :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_MakeCall-------------------------------------------------------
function fCtiMakeCall(sDevice: String): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiMakeCall :"Start", sDevice :"'+sDevice+'"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_D, STATE_R, STATE_O :begin
      nReturn := CTI_MakeCall(PChar(sDevice));
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiMakeCall :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Answer---------------------------------------------------------
function fCtiAnswer: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiAnswer :"Start"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_N :begin
      nReturn := CTI_Answer;
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiAnswer :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Disconnect-----------------------------------------------------
function fCtiDisconnect: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiDisconnect :"Start"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_H, STATE_N, STATE_A, STATE_U :begin
      nReturn := CTI_Disconnect;
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiDisconnect :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Hold-----------------------------------------------------------
function fCtiHold: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiHold :"Start"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_A :begin
      nReturn := CTI_Hold;
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiHold :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Retrieve-------------------------------------------------------
function fCtiRetrieve: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiRetrieve :"Start"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_V :begin
      nReturn := CTI_Retrieve;
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiRetrieve :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_ConsultEx------------------------------------------------------
function fCtiConsultEx(nRemote: Integer; sDevice, sSvcName, sReserved: String): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiConsultEx :"Start", nRemote :"'+IntToStr(nRemote)+
                                             '", sDevice :"'+sDevice+
                                             '", sSvcName :"'+sSvcName+
                                             '", sReserved :"'+sReserved+'"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_A :begin
      nReturn := CTI_ConsultEx(nRemote, PChar(sDevice), PChar(sSvcName), PChar(sReserved));
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiConsultEx :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Transfer-------------------------------------------------------
function fCtiTransfer(nRemote: Integer; sDevice: String=''; sMessage: String=''): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiTransfer :"Start", nRemote :"'+IntToStr(nRemote)+
                                            '", sDevice :"'+sDevice+
                                            '", sMessage :"'+sMessage+'"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_C :begin
      nReturn := CTI_Transfer(nRemote, PChar(sDevice), PChar(sMessage));
      if nReturn <> 0 then fCtiGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiTransfer :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Reconnect------------------------------------------------------
function fCtiReconnect: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiReconnect :"Start"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_L, STATE_C :begin
      nReturn := CTI_Reconnect;
      if nReturn <> 0 then fCtiGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiReconnect :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_EndReady-------------------------------------------------------
function fCtiEndReady: Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiEndReady :"Start"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_D, STATE_R :begin
      nReturn := CTI_EndReady;
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiEndReady :"End", Return :"'+IntToStr(nReturn)+'"');
end;


//------------------------------------------------------------------------------
//상담원 정보 관련 함수
//------------------------------------------------------------------------------
// CTI_GetAgentState--------------------------------------------------
function fCtiGetAgentState(tForm: TCustomForm; tBar: TStatusBar;
  Index: Integer): Integer;
var
  nReturn: Integer;
  Msg: String;
begin
  nReturn := CTI_GetAgentState;
  case nReturn of
    STATE_I :Msg := '초기상태';// 'STATE_I'; // 초기상태(로그인 하지 않은 상태)
    STATE_D :Msg := '수신대기';// 'STATE_D'; // 로그인 직후 수신 대기 상태
    STATE_N :Msg := '응대대기';// 'STATE_N'; // 전화가 오는상태(아직 응답하지 않은 상태)
    STATE_H :Msg := '발신대기';// 'STATE_H'; // 전화 끊기만 가능한 상태, 일반적으로 전화 발신 중 상태
    STATE_A :Msg := '통화중';  // 'STATE_A'; // 통화중 상태
    STATE_R :Msg := '처리중';  // 'STATE_R'; // 통화 완료 후 후처리 하는 상태(호 분배 X)
    STATE_O :Msg := arBreak[WorkStateCD];// 'STATE_O' // 상담원 휴식중 상태
    STATE_V :Msg := '보류중'; // 'STATE_V';  // 현재 통화 보류중인 상태
    STATE_L :Msg := '(2)요청';// 'STATE_L';  // 상담요청중인 상태, 2차 상담원이 전화를 받지 않은 상태
    STATE_C :Msg := '(2)통화';// 'STATE_C';  // 상담중인 상태, 2차 상담원과 통화중인 상태
    STATE_U :Msg := '3자통화';// 'STATE_U';  // 3자 통화 중 상태
  end;
  if Assigned(tForm) and Assigned(tBar) then begin
    with tForm do
      tBar.Panels[Index].Text := Msg;
  end;
  Result := nReturn;
end;

// CTI_GetMyInfo------------------------------------------------------
function fCtiGetMyInfo(nOption: Integer): Integer;
var
  GetMyInfo_Arr : array[0..85] of Char;//GetMyInfo_Arr : array[0..2047] of Char;
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiGetMyInfo :"Start", nOption :"'+IntToStr(nOption)+'"');
  case fCTIGetAgentState of
    STATE_I :nReturn := 999;
    else begin
      case nOption of
       1 :prClearGetMyInfoRec;
       2 :prClearGetMyInfoModifiedRec;
      end;
      nReturn := CTI_GetMyInfo(GetMyInfo_Arr);
      if nReturn <> 0 then fCTIGetErrorMsg
      else prGetMyInfo(nOption, StrPas(GetMyInfo_Arr));
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiGetMyInfo :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_GetErrorMessage------------------------------------------------
function fCTIGetErrorMsg: Integer;
var
  nReturn: Integer;
  Msg: array[0..256] of Char;
begin
  Debug.Write(1, 31100, 'fCTIGetErrorMsg :"Start"');
  nReturn := CTI_GetErrorMessage(Msg);
  //ShowMessage('- CTi ErrorMessage -'#13 + String(Msg));
  Debug.Write(9, 999,'- CTi ErrorMessage -'#13 + String(Msg));
  Result := nReturn;
  Debug.Write(1, 31100, 'fCTIGetErrorMsg :"End", Return :"'+IntToStr(nReturn)+
                                             '", Msg :"'+String(Msg)+'"');
end;

// CTI_WhoIsCaller----------------------------------------------------
function fCtiWhoIsCaller: Integer;
var
  CallerInfo_Arr : array[0..2047] of Char;
  Rtl: TStringArray;
  r, nReturn: Integer;
  Str: String;
begin
  Debug.Write(1, 31100, 'fCtiWhoIsCaller :"Start"');
  prClearCallerInfoRec;
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := 999;
    end;
    else begin
      nReturn := CTI_WhoIsCaller(CallerInfo_Arr);
      if nReturn <> 0 then fCTIGetErrorMsg
      else
      begin
        Str := StrPas(CallerInfo_Arr);
        with CallerInfoRec do
        begin
          CustID        := Trim(Copy(Str, 1, 20));    //고객ID
          CustTel       := Trim(Copy(Str, 21, 20));   //고객전화번호
          if (length(CustTel) > 6) and (CustTel[1] <> '0') then CustTel := '0'+CustTel;
          r := GetField(FormatPhone('-',CustTel), '-', Rtl);
          case r of
          1:CustTel1 := Rtl[0];
          2:if length(Rtl[1])=4 then CustTel1 := Rtl[0]+Rtl[1];
          3:if length(Rtl[2])=4 then begin CustTel0 := Rtl[0]; CustTel1 := Rtl[1]+Rtl[2]; end;
          end;
          CustTelGB := CheckTelArea(CustTel0);
          CustLV        := Trim(Copy(Str, 41, 1));    //고객등급
          ServiceCD     := Trim(Copy(Str, 42, 10));   //서비스코드
          CallGB        := Trim(Copy(Str, 52, 2));    //콜구분
          TmrRequestDT  := Trim(Copy(Str, 54, 14));   //상담원요청시간
          TmrConnectDT  := Trim(Copy(Str, 68, 14));   //상담원연결시간
          WindowID      := Trim(Copy(Str, 82, 2));    //윈도우ID
          TabID         := Trim(Copy(Str, 84, 2));    //탭ID
          ServiceTYPE   := Trim(Copy(Str, 86, 1));    //서비스타임
          //Char(200)  Copy(Data, 87, 200);   //Reserved1-예약1------------------
          ReservInfo111 := Trim(Copy(Str, 87, 30));   //Reserved1-예약1(서비스코드에 대한 명)
          ReservInfo112 := Trim(Copy(Str, 117, 170)); //Reserved1-예약1(보낸 데이타)
          //---------------------------------------------------------------------
          //Char(100)  Copy(Data, 287, 100);  //Reserved1-예약2------------------
          ReservInfo121 := Trim(Copy(Str, 287, 1));   //Reserved1-예약2(수신 예약시 여부)
          ReservInfo122 := Trim(Copy(Str, 288, 8));   //Reserved1-예약2(수신 예약 상담원)
          ReservInfo123 := Trim(Copy(Str, 296, 10));  //Reserved1-예약2(수신 예약 상담원명)
          ReservInfo124 := Trim(Copy(Str, 306, 81));  //Reserved1-예약2(수신 예약 데이타)
          //---------------------------------------------------------------------
          ReservInfo210 := Trim(Copy(Str, 387, 16));  //Reserved2(유일한 콜ID 부여)
          ReservInfo310 := Trim(Copy(Str, 403, 20));  //Reserved3
          ReservInfo410 := Trim(Copy(Str, 423, 50));  //Reserved4
          Debug.Write(1, 31100, 'CallerInfoRec.CustTel='+CustTel);
          Debug.Write(1, 31100, 'CallerInfoRec.CustTel0='+CustTel0);
          Debug.Write(1, 31100, 'CallerInfoRec.CustTel1='+CustTel1);
        end;
      end;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiWhoIsCaller :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Messages-------------------------------------------------------
function fCtiMessages(nCheck: Integer; sDest, sData: String): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiMessages :"Start", nCheck :"'+IntToStr(nCheck)+'"');
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := 999;
    end;
    else begin
      case nCheck of
        0 :begin
          nReturn := CTI_Messages(nCheck, PChar(sDest), PChar(sData));
          if nReturn <> 0 then fCTIGetErrorMsg;
          fCTIGetAgentState;
        end;
        1 :begin
          nReturn := CTI_Messages(nCheck, PChar(sDest), PChar(sData));
          if nReturn <> 0 then fCTIGetErrorMsg;
          fCTIGetAgentState;
        end;
      end;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiMessages :"End", Return :"'+IntToStr(nReturn)+'"');
end;


//------------------------------------------------------------------------------
//각종 정보 요청 관련 함수
//------------------------------------------------------------------------------
// CTI_SetMyMode------------------------------------------------------
function fCtiSetMyMode(sMode: String): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiSetMyMode :"Start", sMode :"'+sMode+'"');
  case fCTIGetAgentState of
    STATE_I :nReturn := 999;
    else begin
      nReturn := CTI_SetMyMode(PChar(sMode));
      if nReturn <> 0 then fCTIGetErrorMsg;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiSetMyMode :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_GetGroups------------------------------------------------------
function fCtiGetGroups(var GroupList: String): Integer;
var
  GetGroups_Arr: Array[0..65535] of Char;
  sList: String;
  iLoop: Integer;
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiGetGroups :"Start"');
  case fCTIGetAgentState of
    STATE_I :nReturn := 999;
    else begin
      nReturn := CTI_GetGroups(GetGroups_Arr);
      if nReturn <> 0 then fCtiGetErrorMsg
      else begin
        prClearGetGroupsRec;
        sList := StrPas(GetGroups_Arr);
        GetGroupsRec.ListCount := StrToIntDef(Copy(sList, 1, 4), 0);
        Delete(sList, 1, 4);
        if GetGroupsRec.ListCount > 0 then
          for iLoop := 1 to GetGroupsRec.ListCount do begin
            GroupList :=  GroupList + '"' + Copy(sList, 1, 43) + '"';
            if iLoop <> GetGroupsRec.ListCount then GroupList := GroupList + ',';
            Delete(sList, 1, 43);
          end;
      end;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiGetGroups :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_GetParts-------------------------------------------------------
function fCtiGetParts(var PartList: String): Integer;
var
  GetParts_Arr: Array[0..65535] of Char;
  sList: String;
  iLoop: Integer;
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiGetParts :"Start"');
  case fCTIGetAgentState of
    STATE_I :nReturn := 999;
    else begin
      nReturn := CTI_GetParts(GetParts_Arr);
      if nReturn <> 0 then fCtiGetErrorMsg
      else begin
        prClearGetPartsRec;
        sList := StrPas(GetParts_Arr);
        GetPartsRec.ListCount := StrToIntDef(Copy(sList, 1, 4), 0);
        Delete(sList, 1, 4);
        if GetPartsRec.ListCount > 0 then
          for iLoop := 1 to GetPartsRec.ListCount do begin
            PartList :=  PartList + '"' + Copy(sList, 1, 42) + '"';
            if iLoop <> GetPartsRec.ListCount then PartList := PartList + ',';
            Delete(sList, 1, 42);
          end;
      end;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiGetParts :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_GetAgents------------------------------------------------------
function fCtiGetAgents(nOption: Integer; sTarget: String):Integer;//; Data: String): Integer;
var
  GetAgents_Arr: Array[0..4095] of Char;
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiGetAgents :"Start", nOption :"'+IntToStr(nOption)+
                                             '", sTarget :"'+sTarget+'"');
  case fCTIGetAgentState of
    STATE_I :nReturn := 999;
    else begin
      nReturn := CTI_GetAgents(nOption, PChar(sTarget), GetAgents_Arr);
      if nReturn <> 0 then fCtiGetErrorMsg
      else GetAgents(nOption, StrPas(GetAgents_Arr));
      Debug.Write(5, 999, StrPas(GetAgents_Arr));
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiGetAgents :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_GetQueued------------------------------------------------------
function fCtiGetQueued: Integer;
var
  GetQueue_Arr: Array[0..22] of Char;
  nReturn: Integer;
begin
//  Debug.Write(1, 31100, 'fCtiGetQueued :"Start"');
  //GetQueuedRec.QueuedCount := '0';
  case fCTIGetAgentState of
    STATE_I :nReturn := 999;
    else begin
      nReturn := CTI_GetQueued(GetQueue_Arr);
      if nReturn <> 0 then //fCtiGetErrorMsg
        GetQueuedRec.QueuedCount := '0'
      else
        GetQueuedRec.QueuedCount := IntToStr(StrToIntDef(StrPas(GetQueue_Arr), 0));
    end;
  end;
  Result := nReturn;
//  Debug.Write(1, 31100, 'fCtiGetQueued :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_GetSharedMemory------------------------------------------------
function fCtiGetSharedMemory: Integer;
var
  GetShared_Arr: Array[0..103] of Char;
  nReturn: Integer;
  Str: String;
begin
//  Debug.Write(1, 31100, 'fCtiGetSharedMemory :"Start"');
  case fCTIGetAgentState of
    STATE_I :nReturn := 999;
    else begin
      StrPCopy(GetShared_Arr, TmrRec.CTiID);
      prClearSharedMemoryRec;
      nReturn := CTI_GetSharedMemory(GetShared_Arr);
      if nReturn <> 0 then //fCtiGetErrorMsg
      else begin
        Str :=StrPas(GetShared_Arr);
        with SharedMemoryRec do begin
          InAnswer1      := Trim(Copy(Str, 1, 4));   //Inbound 응답호 내선
          InAnswer2      := Trim(Copy(Str, 5, 4));   //Inbound 응답호 국선
          InAnswer3      := Trim(Copy(Str, 9, 4));   //Inbound 응답호 Direct 국선
          InDisConnect1  := Trim(Copy(Str, 13, 4));  //Inbound Ringing중 DisConnect 내선
          InDisConnect2  := Trim(Copy(Str, 17, 4));  //Inbound Ringing중 DisConnect 국선
          InDisConnect3  := Trim(Copy(Str, 21, 4));  //Inbound Ringing중 DisConnect Direct 국선
          InConnect1     := Trim(Copy(Str, 25, 4));  //Inbound Connect후 특정시간 내 끊어진 Call 내선
          InConnect2     := Trim(Copy(Str, 29, 4));  //Inbound Connect후 특정시간 내 끊어진 Call 국선
          InConnect3     := Trim(Copy(Str, 33, 4));  //Inbound Connect후 특정시간 내 끊어진 Call Direct 국선
          InConsult      := Trim(Copy(Str, 37, 4));  //Inbound consult incoming 내선(only)
          InPassword     := Trim(Copy(Str, 41, 4));  //Inbound password
          OutPhone1      := Trim(Copy(Str, 45, 4));  //Outbound 수동(전화기) 내선
          OutPhone2      := Trim(Copy(Str, 49, 4));  //Outbound 수동(전화기) 국선
          OutCommand1    := Trim(Copy(Str, 53, 4));  //Outbound 화면(Command) 내선
          OutCommand2    := Trim(Copy(Str, 57, 4));  //Outbound 화면(Command) 국선
          OutDisConnect1 := Trim(Copy(Str, 61, 4));  //Outbound Ringing중 DisConnect 수동내선
          OutDisConnect2 := Trim(Copy(Str, 65, 4));  //Outbound Ringing중 DisConnect 수동국선
          OutDisConnect3 := Trim(Copy(Str, 69, 4));  //Outbound Ringing중 DisConnect 화면내선
          OutDisConnect4 := Trim(Copy(Str, 73, 4));  //Outbound Ringing중 DisConnect 화면국선
          OutProgressive := Trim(Copy(Str, 77, 4));  //Outbound Progressive 국선(only)
          OutPreictive   := Trim(Copy(Str, 81, 4));  //Outbound Preictive 국선(only)
          OutConvert     := Trim(Copy(Str, 85, 4));  //Outbound 전환호 내선(only)
          OutConference  := Trim(Copy(Str, 89, 4));  //Outbound Conference 내선(only)
          OutReadyMake   := Trim(Copy(Str, 93, 4));  //Outbound Ready_make
          OutChatting    := Trim(Copy(Str, 97, 4));  //Outbound Chatting
          OutEMailback   := Trim(Copy(Str, 101, 4)); //Outbound E-mailback
        end;
      end;
    end;
  end;
  Result := nReturn;
//  Debug.Write(1, 31100, 'fCtiGetSharedMemory :"End", Return :"'+IntToStr(nReturn)+'"');
end;


//------------------------------------------------------------------------------
//OutBound 관련 함수
//------------------------------------------------------------------------------
// CTI_GetOutBoundScrData---------------------------------------------
function fCtiGetOutBoundScrData: Integer;
var
  nBufSize: Integer;
  hMem: HGLOBAL;
  pBuffer: PChar;
  nReturn: Integer;
  Str: String;
begin
  Debug.Write(1, 31100, 'fCtiGetOutBoundScrData :"Start"');
  prClearOutBoundRec;
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := 999;
    end;
    else begin
      nReturn  := 999;
      nBufSize := CTI_GetOutBoundScrData(nil, 0);
      if nBufSize > 0 then
      begin
        hMem    := GlobalAlloc(GHND, nBufSize + 1);
        pBuffer := GlobalLock(hMem);
        nReturn := CTI_GetOutBoundScrData(pBuffer, nBufSize + 1);
        if nReturn <> 0 then fCTIGetErrorMsg
        else
        begin
          Str := StrPas(pBuffer);
          with OutBoundRec do
          begin
            CampSeqNO  := Trim(Copy(Str, 1, 8));    //캠페인 일련번호
            CampaignID := Trim(Copy(Str, 9, 12));   //캠페인 번호
            CallMode   := Trim(Copy(Str, 21, 2));   //콜 모드
            CustID     := Trim(Copy(Str, 23, 24));  //고객ID       WFM상 자릿수(11)
            CustTel    := Trim(Copy(Str, 47, 24));  //고객전화번호 WFM상 자릿수(12)
            CustInfo1  := Trim(Copy(Str, 71, 32));  //고객정보1    WFM상 자릿수(12)
            CustInfo2  := Trim(Copy(Str, 103, 32)); //고객정보2    WFM상 자릿수(15)
            CustInfo3  := Trim(Copy(Str, 135, 32)); //고객정보3    WFM상 자릿수(15)
            CustInfo4  := Trim(Copy(Str, 167, 32)); //고객정보4    WFM상 자릿수(15)
            CustInfo5  := Trim(Copy(Str, 199, 32)); //고객정보5    WFM상 자릿수(15)
            CustInfo6  := Trim(Copy(Str, 231, 32)); //고객정보6
            CallResult := Trim(Copy(Str, 263, 2));  //전화결과
            ReservedGB := Trim(Copy(Str, 265, 1));  //예약호 여부
            CallLogID  := Trim(Copy(Str, 266, 16)); //콜 로그ID
            ReservedDT := Trim(Copy(Str, 282, 14)); //예약날짜
          end;
        end;
        GlobalUnlock(hMem);
        GlobalFree(hMem);
        fCTIGetAgentState;
      end
      else fCTIGetErrorMsg;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiGetOutBoundScrData :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Campaignlogin--------------------------------------------------
function fCtiCampaignLogin(nOption: Integer; sAgentID: String; sData: String=''): Integer;
var
  nReturn: Integer;
begin
  Debug.Write(1, 31100, 'fCtiCampaignLogin :"Start", nOption :"'+IntToStr(nOption)+
                                                 '", sAgentID :"'+sAgentID+
                                                 '", sData :"'+sData+'"');
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := 999;
    end;
    else begin
      nReturn := CTI_CampaignLogin(nOption, PChar(sAgentID), PChar(sData));
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiCampaignLogin :"End", Return :"'+IntToStr(nReturn)+'"');
end;

// CTI_Campaignlogout-------------------------------------------------
function fCtiCampaignLogout(sAgentID: String; bOption: Boolean): Integer;
var
  nReturn: Integer;
begin
  if bOption then Debug.Write(1, 31100, 'fCtiCampaignLogout :"Start", sAgentID :"'+sAgentID+'", bOption :"True"')
  else Debug.Write(1, 31100, 'fCtiCampaignLogout :"Start", sAgentID :"'+sAgentID+'", bOption :"False"');
  nReturn := 999;
  case fCTIGetAgentState of
    STATE_I :begin
      nReturn := 0;
    end;
    else begin
      nReturn := CTI_CampaignLogout(PChar(sAgentID), bOption);
      if nReturn <> 0 then fCTIGetErrorMsg;
      fCTIGetAgentState;
    end;
  end;
  Result := nReturn;
  Debug.Write(1, 31100, 'fCtiCampaignLogout :"End", Return :"'+IntToStr(nReturn)+'"');
end;


//==============================================================================


//==============================================================================
// 데이터 가져오기 함수
//------------------------------------------------------------------------------
// GetMyInfo----------------------------------------------------------
procedure prGetMyInfo(nOption: Integer; aInfo: String);
begin
  Debug.Write(1, 31200, 'prGetMyInfo :"Start", nOption :"'+IntToStr(nOption)+
                                           '", aInfo :"'+aInfo+'"');
  case nOption of //1:상담원CTI정보확인시, 2:My Info Changed메세지가 온경우
    1 :begin //used
      prClearGetMyInfoRec;
      with GetMyInfoRec do begin
        TmrMode         := Copy(aInfo, 1, 1);   //상담원의 모드[1:수동Out, 2:자동Out, 3:Inbound]
        TmrCallCenterID := Copy(aInfo, 2, 2);   //상담원의 콜 센터 ID
        TmrAreaCD       := Copy(aInfo, 4, 2);   //상담원의 지역 코드
        TmrCampaignID   := Copy(aInfo, 6, 5);   //상담원의 캠페인 ID
        TmrGroupID      := Copy(aInfo, 11, 5);  //상담원의 그룹 ID
        TmrPartID       := Copy(aInfo, 16, 12); //상담원의 파트 ID
        TmrLoginDT      := Copy(aInfo, 28, 14); //서버의 시간(로그인 시점)
        CampaignID      := Copy(aInfo, 42, 12); //캠페인 ID
        CampaignNM      := Copy(aInfo, 54, 32); //캠패인 Name
      end;
    end;
    2 :begin //hWND
      prClearGetMyInfoModifiedRec;
      with GetMyInfoModifiedRec do begin
        OldCallCenterID := Copy(aInfo, 1, 2);   //전 콜 센터 ID
        OldAreaCD       := Copy(aInfo, 3, 2);   //전 지역 코드
        OldUpperGroup   := Copy(aInfo, 5, 5);   //전 상위 그룹
        OldLowerGroup   := Copy(aInfo, 10, 5);  //전 하위 그룹
        NowCallCenterID := Copy(aInfo, 15, 2);  //현 콜 센터 ID
        NowAreaCD       := Copy(aInfo, 17, 2);  //현 지역 코드
        NowUpperGroup   := Copy(aInfo, 19, 5);  //현 상위 그룹
        NowLowerGroup   := Copy(aInfo, 24, 5);  //현 하위 그룹
        NowTmrMode      := Copy(aInfo, 29, 1);  //상담원의 모드[1:수동Out, 2:자동Out, 3:Inbound]
        BlindSubject    := Copy(aInfo, 30, 1);  //블랜딩 주체
        CampaignID      := Copy(aInfo, 31, 12); //캠페인 ID
        CampaignNM      := Copy(aInfo, 43, 32); //캠패인 Name
      end;
    end;
  end;
  Debug.Write(1, 31200, 'prGetMyInfo :"End"');
end;

// GetAgents----------------------------------------------------------
function GetAgents(nOption: Integer; sAgentInfo: String): Boolean;
  function GetList(nCount: Integer; sList: String): String;
  var
    nLoop: Integer;
    nRow: Integer;
    sObjList: String;
  begin
    Debug.Write(1, 31100, 'GetAgents-GetList :"Start", nCount :"'+IntToStr(nCount)+
                                                   '", sList :"'+sList+'"');
    case nOption of
      10..20 :nRow := 23;
      30..32 :nRow := 79;
      40 :nRow := Length(Trim(sList));
      else nRow := 0;
    end;
    sObjList := '';
    for nLoop := 1 to nCount do begin
      sObjList :=  sObjList + '"' + Copy(sList, 1, nRow) + '"';
      if nLoop <> nCount then sObjList := sObjList + ',';
      Delete(sList, 1, nRow);
    end;
    Result := sObjList;
    Debug.Write(1, 31100, 'GetAgents-GetList :"End", Return :"True"');
  end;
begin
  Debug.Write(1, 31100, 'GetAgents :"Start", nOption :"'+IntToStr(nOption)+
                                         '", sInfo :"'+sAgentInfo+'"');
  Result := False;
  case nOption of
    10 :begin
      prClearGetAgentsGup1Rec;
      with GetAgentsGup1 do begin
        CallCenterID := Trim(Copy(sAgentInfo, 1, 2));
        AreaCD       := Trim(Copy(sAgentInfo, 3, 2));
        CampaignID   := Trim(Copy(sAgentInfo, 5, 5));
        GroupID      := Trim(Copy(sAgentInfo, 10, 5));
        ListCount    := StrToIntDef(Copy(sAgentInfo, 15, 4), 0);
        Delete(sAgentInfo, 1, 18);
        if ListCount <> 0 then List := GetList(ListCount, sAgentInfo);
      end;
    end;
    20 :begin
      prClearGetAgentsGup2Rec;
      with GetAgentsGup2 do begin
        PartID := Trim(Copy(sAgentInfo, 1, 12));
        ListCount := StrToIntDef(Copy(sAgentInfo, 13, 4), 0);
        Delete(sAgentInfo, 1, 16);
        if ListCount <> 0 then List := GetList(ListCount, sAgentInfo);
      end;
    end;{}
    30..32 :begin
      prClearGetAgentsGup3Rec;
      with GetAgentsGup3 do begin
        ListCount := StrToIntDef(Copy(sAgentInfo, 1, 4), 0);
        Delete(sAgentInfo, 1, 4);
        if ListCount <> 0 then List := GetList(ListCount, sAgentInfo);
      end;
    end;
    40 :begin
      prClearGetAgentsGup4Rec;
      GetAgentsGup4.TmrIP := Trim(sAgentInfo);
    end;
  end;
  Result := True;
  Debug.Write(1, 31100, 'GetAgents :"End", Return :"True"');
end;

function SetAgentState(sState: String): String;
begin
  case sState[1] of
    'W' :Result := '대기중';
    'S' :Result := '후처리';
    'P' :Result := arBreak[StrToInt(Copy(sState, 2, 1))];
    'Z' :Result := '로그아웃';
    'O' :Result := 'DND';
    'U' :Result := '통화불가';
    'K' :Result := '통화설정';
    'B' :Result := '통화중';
    else Result := '통화중';
  end;
end;
//==============================================================================


//==============================================================================
// 레코드 클리어 함수
//------------------------------------------------------------------------------
//All Rec-------------------------------------------------------------
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
  prClearCallerInfoRec;
  prClearSharedMemoryRec;
  prClearGetMyInfoRec;
  prClearGetMyInfoModifiedRec;
  prClearGetPartsRec;
  prClearGetAgentsGup1Rec;
  prClearGetAgentsGup2Rec;
  prClearGetAgentsGup3Rec;
  prClearGetAgentsGup4Rec;
end;

//RecServRec----------------------------------------------------------
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

//TmrRec--------------------------------------------------------------
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
  with CallRec.TelInfoRec do
  begin
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
    InOutFlag  := 'O';
  end;
  Debug.Write(1, 31200, 'prClearCallRec :"End"');
end;

procedure prClearOutBoundRec;
begin
  Debug.Write(1, 31200, 'prClearOutBoundRec :"Start"');
  with OutBoundRec do begin
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
  with CallerInfoRec do begin
    CustID        := '';
    CustTel       := '';
    CustTel0      := '';
    CustTel1      := '';
    CustTelGB     := '';
    CustLV        := '';
    ServiceCD     := '';
    CallGB        := '';
    TmrRequestDT  := '';
    TmrConnectDT  := '';
    WindowID      := '';
    TabID         := '';
    ServiceTYPE   := '';
    ReservInfo111 := '';
    ReservInfo112 := '';
    ReservInfo121 := '';
    ReservInfo122 := '';
    ReservInfo123 := '';
    ReservInfo124 := '';
    ReservInfo210 := '';
    ReservInfo310 := '';
    ReservInfo410 := '';
  end;
  Debug.Write(1, 31200, 'prClearCallerInfoRec :"End"');
end;

procedure prClearSharedMemoryRec;
begin
  Debug.Write(1, 31200, 'prClearSharedMemoryRec :"Start"');
  with SharedMemoryRec do begin
    InAnswer1      := '0';
    InAnswer2      := '0';
    InAnswer3      := '0';
    InDisConnect1  := '0';
    InDisConnect2  := '0';
    InDisConnect3  := '0';
    InConnect1     := '0';
    InConnect2     := '0';
    InConnect3     := '0';
    InConsult      := '0';
    InPassword     := '0';
    OutPhone1      := '0';
    OutPhone2      := '0';
    OutCommand1    := '0';
    OutCommand2    := '0';
    OutDisConnect1 := '0';
    OutDisConnect2 := '0';
    OutDisConnect3 := '0';
    OutDisConnect4 := '0';
    OutProgressive := '0';
    OutPreictive   := '0';
    OutConvert     := '0';
    OutConference  := '0';
    OutReadyMake   := '0';
    OutChatting    := '0';
    OutEMailback   := '0';
  end;
  Debug.Write(1, 31200, 'prClearSharedMemoryRec :"End"');
end;

procedure prClearGetMyInfoRec;
begin
  Debug.Write(1, 31200, 'prClearGetMyInfoRec :"Start"');
  with GetMyInfoRec do begin
    TmrMode         := '';
    TmrCallCenterID := '';
    TmrAreaCD       := '';
    TmrCampaignID   := '';
    TmrGroupID      := '';
    TmrPartID       := '';
    TmrLoginDT      := '';
    CampaignID      := '';
    CampaignNM      := '';
  end;
  Debug.Write(1, 31200, 'prClearGetMyInfoRec :"End"');
end;

procedure prClearGetMyInfoModifiedRec;
begin
  Debug.Write(1, 31200, 'prClearGetMyInfoModifiedRec :"Start"');
  with GetMyInfoModifiedRec do begin
    OldCallCenterID := '';
    OldAreaCD       := '';
    OldUpperGroup   := '';
    OldLowerGroup   := '';
    NowCallCenterID := '';
    NowAreaCD       := '';
    NowUpperGroup   := '';
    NowLowerGroup   := '';
    NowTmrMode      := '';
    BlindSubject    := '';
    CampaignID      := '';
    CampaignNM      := '';
  end;
  Debug.Write(1, 31200, 'prClearGetMyInfoModifiedRec :"End"');
end;

procedure prClearGetGroupsRec;
begin
  Debug.Write(1, 31200, 'prClearGetGroupsRec :"Start"');
  with GetGroupsRec do begin
    ListCount := 0;
    List      := '';
  end;
  Debug.Write(1, 31200, 'prClearGetGroupsRec :"End"');
end;

procedure prClearGetPartsRec;
begin
  Debug.Write(1, 31200, 'prClearGetPartsRec :"Start"');
  with GetPartsRec do begin
    ListCount := 0;
    List      := '';
  end;
  Debug.Write(1, 31200, 'prClearGetPartsRec :"End"');
end;

procedure prClearGetAgentsGup1Rec;
begin
  Debug.Write(1, 31200, 'prClearGetAgentsGup1Rec :"Start"');
  with GetAgentsGup1 do begin
    CallCenterID := '';
    AreaCD       := '';
    CampaignID   := '';
    GroupID      := '';
    ListCount    := 0;
    List         := '';
  end;
  Debug.Write(1, 31200, 'prClearGetAgentsGup1Rec :"End"');
end;

procedure prClearGetAgentsGup2Rec;
begin
  Debug.Write(1, 31200, 'prClearGetAgentsGup2Rec :"Start"');
  with GetAgentsGup2 do begin
    PartID    := '';
    ListCount := 0;
    List      := '';
  end;
  Debug.Write(1, 31200, 'prClearGetAgentsGup2Rec :"End"');
end;

procedure prClearGetAgentsGup3Rec;
begin
  Debug.Write(1, 31200, 'prClearGetAgentsGup3Rec :"Start"');
  with GetAgentsGup3 do begin
    ListCount := 0;
    List      := '';
  end;
  Debug.Write(1, 31200, 'prClearGetAgentsGup3Rec :"End"');
end;

procedure prClearGetAgentsGup4Rec;
begin
  Debug.Write(1, 31200, 'prClearGetAgentsGup4Rec :"Start"');
  with GetAgentsGup4 do begin
    TmrIP := '';
  end;
  Debug.Write(1, 31200, 'prClearGetAgentsGup4Rec :"End"');
end;

end.

//==============================================================================
// Nice Rec 제어 함수
//------------------------------------------------------------------------------
// ClsConnectionOpen--------------------------------------------------
//function fConnectionOpen(IP: String; Port: Longint): Longint;
//var nReturn: Longint;
//begin
//  nReturn := clsConnectionOpen(PChar(IP), Port);
//  Result := nReturn;
//end;

// ClsConnectionClose-------------------------------------------------
//function fConnectionClose: Longint;
//var nReturn: Longint;
//begin
//  nReturn := clsConnectionClose;
//  Result  := nReturn;
//end;

//function fStartCallEx: Longint;
//var
//  nReturn: Longint;
//  Cls_Call_Information_Ex_Rec: PCls_Call_Information_Ex_Rec;
//  Cls_Call_Resp_Rec: PCls_Call_Resp_Rec;
//begin
//  nReturn := clsCallInfoExInitial(@Cls_Call_Information_Ex_Rec);
//  Result  := nReturn;

//	int i;

//	//API 에 변수,구조체 선언
//	CLS_CALL_INFORMATION_EX MyCall;		//콜정보 객체선언
//	CLS_CALL_RESP CallResponse;		//리턴되는 아웃풋 파라메타
//	i =  clsCallInfoExInitial( &MyCall);		//콜초기화

//	time_t DummyEventTime;

//	time( &DummyEventTime );  //시간값을 넣어준다.

//	//AgentID 와 Extension(내선번호) 는 필수로 들어가야 함

//	//콜정보 넣기
//	MyCall.lSwitchId = 1;
//	MyCall.lCallId = atoi(Station);		//정수값을 넣어준다. 일반적으로 내선번호를 넣는다. (현재 녹음중인콜끼리는 이 id 가 중복되어서는 안된다.)
//	MyCall. lAgentId = AgentId;		//AgnetID
//	strcpy ( MyCall.cStation, Station);	//내선번호
//	strcpy(MyCall.cDirection, "O");		//통화방향 인바운드 'I' , 아웃바운드 'O' , 내선통화 'INTRN' 중 해당값을 넣어준다.
//	strcpy(MyCall.cPhoneNumber, "0245675245");	//전화번호 발신 혹은 수신전화번호
//	MyCall.lEventTime = DummyEventTime; 		//앞에서 구한 현재 시간을 구한값을 넣어준다.

//	//API 함수 호출
//	i = clsStartCallEx ( &MyCall, &CallResponse );		//성공하면 0을 반환한다. 통신에러 -2, 문법에러의경우 -1을 반환한다.
//	return i;
//end;

//function fEndCallEx: Longint;
//begin
//  //
//end;

