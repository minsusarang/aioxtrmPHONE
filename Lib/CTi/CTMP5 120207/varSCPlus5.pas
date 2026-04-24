////////////////////////////////////////////////////////////////////////////////
//                              Nagi's varSCplus5                             //
////////////////////////////////////////////////////////////////////////////////
// Ver. 1.0.0.0                                                               //
// Last Update : 2004. 04. 29                                                 //
////////////////////////////////////////////////////////////////////////////////
unit varSCplus5;

interface

Uses
  Classes;

type
  //녹취서버 정보
  TRecServRec = record
    RecMode : Integer;  //[0:No|1:동방|2:Nice]
    RecIP   : String;
    RecPort : String;
  end;

  //상담원 로긴정보
  TTmrRec = record
    TmrID   : String;  //상담원ID   //USER_NO로 대체
    TmrNM   : String;  //상담원명   //USER_NM으로 대체
    TmrPW   : String;  //패스워드
    TmrJU   : String;  //주민번호
    AgentCD : String;  //설계사코드
    PartCD  : String;  //소속, 파트
    PartSCD : String;  //파트
    AcdID   : String;  //avaya acdID
    CTiID   : String;  //AGENT_ID
    CID     : String;  //식별자
    InDT    : String;  //입사일자
    OutDT   : String;  //퇴사일자
    TmLvCD  : String;  //기술등급
    TmrGB   : String;  //직급코드   //RIGHT로 대체
    IP      : String;  //IP
    Device  : String;  //내선번호
    OLASID  : String;
  end;

  //고객정보
  TCustRec = record
    CustID    : String;  //고객ID
    CustNM    : String;  //고객명
    CampID    : String;  //캠페인ID
    CompanyCD : String;  //회사구분코드
    CompanyNM : String;  //회사명
    JU_ID     : String;  //주민번호
  end;

  //전화정보
  TTelInfoRec = record
    TelSNO     : String;  //전화순번
    TelGB      : String;  //전화구분
    Tel0       : String;  //연결전화번호(지역번호)
    Tel1       : String;  //연결전화번호(국번호 + 전화번호)
    Tel2       : String;  //연결전화번호(교환번호)
    ContactCD  : String;  //상위관계 연결구분
    RelationCD : String;  //본인과의관계
  end;

  //기존예약정보
  TReservOldRec = record
    ReservID : String;  //기존예약ID
    LateCNT  : String;  //연장횟수(예약의 연장)
    OCallID  : String;  //원예약콜ID
    ReservMM : String;  //예약메모
  end;

  //새예약정보
  TReservSetRec = record
    ReservTel    : TTelInfoRec;  //예약전화정보
    ReservDT     : String;       //예약일자
    ReservTM     : String;       //예약시간
    ReservCustGB : String;       //예약구분
  end;

  //상담상태정보
  TStateRec = record
    StateCD    : String;       //상태코드
    StateSCD   : String;       //세부상태코드
  end;

  //통화정보
  TCallRec = record
    bSaved     : Boolean;      //콜저장여부
    bDialed    : Boolean;      //다이얼링 여부
    bCallStart : Boolean;
    bConnected : Boolean;      //전화연결 여부
    bRecord    : Boolean;      //녹취진행 여부
    bReConnected : Boolean;    //호전환취소 여부
    bWDChecked : Boolean;      //WD체크 여부
    bWDTrans   : Boolean;      //WD전송 여부
    CallID     : String;       //콜ID [YYMMDDHHNNSSCID]
    CustRec    : TCustRec;     //고객정보
    CallDT     : String;       //상담일자
    CallDDT    : String;       //다이얼링시간
    CallDDT1   : TDateTime;    //다이얼링시간
    CallBDT    : String;       //시작시간
    CallBDT1   : TDateTime;    //시작시간
    CallDialTM : String;       //다이얼링시간 [Second]
    CallEDT    : String;       //종료시간
    CallEDT1   : TDateTime;    //종료시간
    CallTM     : String;       //통화시간 [Second]
    CallSDT    : String;       //저장시간
    CallSDT1   : TDateTime;    //저장시간
    CallSaveTM : String;       //후처리시간 [Second]
    CallFormCD : String;       //입력화면구분[000:정상통화|999:가상생성통화]
    TelInfoRec : TTelInfoRec;  //통화정보
    ReceiverNM : String;       //통화자명
    JuminID    : String;       //고객주민번호
    RESP_CD    : String;
    KIND_CD    : String;
    OUT_TELNO  : String;


    StateCD    : String;       //상태코드
    StateSCD   : String;       //세부상태코드
    StateDT    : String;       //
    OtherCD    : String;       //기타코드
    OtherSCD   : String;       //세부기타코드

{
    OldState   : TStateRec;    //기존상태코드
    NewState   : TStateRec;    //상담상태코드
    EtcState   : TStateRec;    //기타상태코드
{}
    OrigID     : String;       //발생콜ID  [YYMMDDHHMMSSCID] 예약,미처리에서 콜이 발생하였을때
    CallMM     : String;       //상담메모
    ReservID   : String;       //예약ID    [YYMMDDHHMMSSCID] 예약,미처리가 발생하였을때
    RecID      : String;       //녹취ID [YYMMDDHHNNSSCID]
    RecStatus  : String;
    Trans_DT   : string;       //전송일자
    Trans_Tm   : string;       //전송시간
    Trans_GB   : string;       //전송구분
    Contract   : String;       //Contract 여부[Y|N|X]
    InOutFlag  : String;       //인바운드/아웃바운드 구분 [0:비정상처리|1:인바운드|2:아웃바운드]
    //imsi-fias
    Receive_Rel: String;
    WD_Indicator: String;      // WYDN, WADN(W: 활용동의, D: 전화수신, Y:Yes, N:No, A:변동없음
  end;

  // PDS정보
  TOutBoundRec = record
    CampSeqNO  : String;  //Char(8)  Copy(Data, 1, 8);                     //캠페인 일련번호
    CampaignID : String;  //Char(12) Copy(Data, 9, 12);                    //캠페인 번호
    CallMode   : String;  //Char(2)  Copy(Data, 21, 2);                    //콜 모드
    CustID     : String;  //Char(24) Copy(Data, 23, 24);  WFM상 자릿수(11) //고객ID
    CustTel    : String;  //Char(24) Copy(Data, 47, 24);  WFM상 자릿수(12) //고객전화번호
    CustInfo1  : String;  //Char(32) Copy(Data, 71, 32);  WFM상 자릿수(12) //고객정보1
    CustInfo2  : String;  //Char(32) Copy(Data, 103, 32); WFM상 자릿수(15) //고객정보2
    CustInfo3  : String;  //Char(32) Copy(Data, 135, 32); WFM상 자릿수(15) //고객정보3
    CustInfo4  : String;  //Char(32) Copy(Data, 167, 32); WFM상 자릿수(15) //고객정보4
    CustInfo5  : String;  //Char(32) Copy(Data, 199, 32); WFM상 자릿수(15) //고객정보5
    CustInfo6  : String;  //Char(32) Copy(Data, 231, 32);                  //고객정보6
    CallResult : String;  //Char(2)  Copy(Data, 263, 2);                   //전화결과
    ReservedGB : String;  //Char(1)  Copy(Data, 265, 1);                   //예약호 여부
    CallLogID  : String;  //Char(16) Copy(Data, 266, 16);                  //콜 로그ID
    ReservedDT : String;  //Char(14) Copy(Data, 282, 14);                  //예약날짜
  end;

  // CallerInfo정보(인바운드/듀얼콜)
  TCallerInfoRec = record
    CustID       : String;  //Char(20)  Copy(Data, 1, 20);    //고객ID
    CustTel      : String;  //Char(20)  Copy(Data, 21, 20);   //고객전화번호
    CustTel0     : String;  //Char(20)  Copy(Data, 21, 20);   //고객전화번호
    CustTel1     : String;  //Char(20)  Copy(Data, 21, 20);   //고객전화번호
    CustTelGB    : String;  //Char(20)  Copy(Data, 21, 20);   //고객전화번호
    CustLV       : String;  //Char(1)   Copy(Data, 41, 1);    //고객등급
    ServiceCD    : String;  //Char(10)  Copy(Data, 42, 10);   //서비스코드
    CallGB       : String;  //Char(2)   Copy(Data, 52, 2);    //콜구분
    TmrRequestDT : String;  //Char(14)  Copy(Data, 54, 14);   //상담원요청시간
    TmrConnectDT : String;  //Char(14)  Copy(Data, 68, 14);   //상담원연결시간
    WindowID     : String;  //Char(2)   Copy(Data, 82, 2);    //윈도우ID
    TabID        : String;  //Char(2)   Copy(Data, 84, 2);    //탭ID
    ServiceTYPE  : String;  //Char(1)   Copy(Data, 86, 1);    //서비스타임
    //Char(200)  Copy(Data, 87, 200);   //Reserved1-예약1------------------
    ReservInfo111: String;  //Char(30)  Copy(Data, 87, 30);   //Reserved1-예약1(서비스코드에 대한 명)
    ReservInfo112: String;  //Char(170) Copy(Data, 117, 170); //Reserved1-예약1(보낸 데이타)
    //---------------------------------------------------------------------
    //Char(100)  Copy(Data, 287, 100);  //Reserved1-예약2------------------
    ReservInfo121: String;  //Char(1)   Copy(Data, 287, 1);   //Reserved1-예약2(수신 예약시 여부)
    ReservInfo122: String;  //Char(8)   Copy(Data, 288, 8);   //Reserved1-예약2(수신 예약 상담원)
    ReservInfo123: String;  //Char(10)  Copy(Data, 296, 10);  //Reserved1-예약2(수신 예약 상담원명)
    ReservInfo124: String;  //Char(81)  Copy(Data, 306, 81);  //Reserved1-예약2(수신 예약 데이타)
    //---------------------------------------------------------------------
    ReservInfo210: String;  //Char(16)  Copy(Data, 387, 16);  //Reserved2(유일한 콜ID 부여)
    ReservInfo310: String;  //Char(20)  Copy(Data, 403, 20);  //Reserved3
    ReservInfo410: String;  //Char(50)  Copy(Data, 423, 50);  //Reserved4
  end;

  // CTI 로그인 상담원 SharedMemory 정보
  TSharedMemoryRec = record
    InAnswer1      : String;  //char(4)  Copy(Data, 1, 4);   //Inbound 응답호 내선
    InAnswer2      : String;  //char(4)  Copy(Data, 5, 4);   //Inbound 응답호 국선
    InAnswer3      : String;  //char(4)  Copy(Data, 9, 4);   //Inbound 응답호 Direct 국선
    InDisConnect1  : String;  //char(4)  Copy(Data, 13, 4);  //Inbound Ringing중 DisConnect 내선
    InDisConnect2  : String;  //char(4)  Copy(Data, 17, 4);  //Inbound Ringing중 DisConnect 국선
    InDisConnect3  : String;  //char(4)  Copy(Data, 21, 4);  //Inbound Ringing중 DisConnect Direct 국선
    InConnect1     : String;  //char(4)  Copy(Data, 25, 4);  //Inbound Connect후 특정시간 내 끊어진 Call 내선
    InConnect2     : String;  //char(4)  Copy(Data, 29, 4);  //Inbound Connect후 특정시간 내 끊어진 Call 국선
    InConnect3     : String;  //char(4)  Copy(Data, 33, 4);  //Inbound Connect후 특정시간 내 끊어진 Call Direct 국선
    InConsult      : String;  //char(4)  Copy(Data, 37, 4);  //Inbound consult incoming 내선(only)
    InPassword     : String;  //char(4)  Copy(Data, 41, 4);  //Inbound password
    OutPhone1      : String;  //char(4)  Copy(Data, 45, 4);  //Outbound 수동(전화기) 내선
    OutPhone2      : String;  //char(4)  Copy(Data, 49, 4);  //Outbound 수동(전화기) 국선
    OutCommand1    : String;  //char(4)  Copy(Data, 53, 4);  //Outbound 화면(Command) 내선
    OutCommand2    : String;  //char(4)  Copy(Data, 57, 4);  //Outbound 화면(Command) 국선
    OutDisConnect1 : String;  //char(4)  Copy(Data, 61, 4);  //Outbound Ringing중 DisConnect 수동내선
    OutDisConnect2 : String;  //char(4)  Copy(Data, 65, 4);  //Outbound Ringing중 DisConnect 수동국선
    OutDisConnect3 : String;  //char(4)  Copy(Data, 69, 4);  //Outbound Ringing중 DisConnect 화면내선
    OutDisConnect4 : String;  //char(4)  Copy(Data, 73, 4);  //Outbound Ringing중 DisConnect 화면국선
    OutProgressive : String;  //char(4)  Copy(Data, 77, 4);  //Outbound Progressive 국선(only)
    OutPreictive   : String;  //char(4)  Copy(Data, 81, 4);  //Outbound Preictive 국선(only)
    OutConvert     : String;  //char(4)  Copy(Data, 85, 4);  //Outbound 전환호 내선(only)
    OutConference  : String;  //char(4)  Copy(Data, 89, 4);  //Outbound Conference 내선(only)
    OutReadyMake   : String;  //char(4)  Copy(Data, 93, 4);  //Outbound Ready_make
    OutChatting    : String;  //char(4)  Copy(Data, 97, 4);  //Outbound Chatting
    OutEMailback   : String;  //char(4)  Copy(Data, 101, 4); //Outbound E-mailback
  end;

  // CTI 로그인 상담원 현재 정보
  TGetMyInfoRec = record
    TmrMode        : String;  //Char(1)  Copy(Data, 1, 1);   //상담원의 모드[1:수동Out, 2:자동Out, 3:Inbound]
    TmrCallCenterID: String;  //Char(2)  Copy(Data, 2, 2);   //상담원의 콜 센터 ID
    TmrAreaCD      : String;  //Char(2)  Copy(Data, 4, 2);   //상담원의 지역 코드
    TmrCampaignID  : String;  //Char(5)  Copy(Data, 6, 5);   //상담원의 캠페인 ID
    TmrGroupID     : String;  //Char(5)  Copy(Data, 11, 5);  //상담원의 그룹 ID
    TmrPartID      : String;  //Char(12) Copy(Data, 16, 12); //상담원의 파트 ID
    TmrLoginDT     : String;  //Char(14) Copy(Data, 28, 14); //서버의 시간(로그인 시점)
    CampaignID     : String;  //Char(12) Copy(Data, 42, 12); //캠페인 ID
    CampaignNM     : String;  //Char(32) Copy(Data, 54, 32); //캠패인 Name
  end;

  // CTI 로그인 상담원 현재 정보(My Info Changed메세지가 온 경우)
  TGetMyInfoModifiedRec = record
    OldCallCenterID: String;  //Char(2)   Copy(Data, 1, 2);   //전 콜 센터 ID
    OldAreaCD      : String;  //Char(2)   Copy(Data, 3, 2);   //전 지역 코드
    OldUpperGroup  : String;  //Char(5)   Copy(Data, 5, 5);   //전 상위 그룹
    OldLowerGroup  : String;  //Char(5)   Copy(Data, 10, 5);  //전 하위 그룹
    NowCallCenterID: String;  //Char(2)   Copy(Data, 15, 2);  //현 콜 센터 ID
    NowAreaCD      : String;  //Char(2)   Copy(Data, 17, 2);  //현 지역 코드
    NowUpperGroup  : String;  //Char(5)   Copy(Data, 19, 5);  //현 상위 그룹
    NowLowerGroup  : String;  //Char(5)   Copy(Data, 24, 5);  //현 하위 그룹
    NowTmrMode     : String;  //Char(1)   Copy(Data, 29, 1);  //상담원의 모드[1:수동Out, 2:자동Out, 3:Inbound]
    BlindSubject   : String;  //Char(1)    Copy(Data, 30, 1);   //블랜딩 주체
    CampaignID     : String;  //Char(12)   Copy(Data, 31, 12);  //캠페인 ID
    CampaignNM     : String;  //Char(32)   Copy(Data, 43, 32);  //캠패인 Name
  end;

  // 그룹 리스트
  TGetGroupsRec = record
    ListCount : Integer;
    List      : String;
  end;

  // 파트 리스트
  TGetPartsRec = record
    ListCount : Integer;
    List      : String;
  end;

  // CTI ID에 따른 상담원 정보1
  TGetAgentsGup1Rec = record
    CallCenterID : String;
    AreaCD       : String;
    CampaignID   : String;
    GroupID      : String;
    ListCount    : Integer;
    List         : String;
  end;
  // CTI ID에 따른 상담원 정보2
  TGetAgentsGup2Rec = record
    PartID    : String;
    ListCount : Integer;
    List      : String;
  end;
  // CTI ID에 따른 상담원 정보3
  TGetAgentsGup3Rec = record
    ListCount : Integer;
    List      : String;
  end;
  // CTI ID에 따른 상담원 정보4
  TGetAgentsGup4Rec = record
    TmrIP : String;
  end;

  // CTI ID에 따른 그룹 대기호
  TGetQueuedRec = record
    QueuedCount : String;
  end;

  TACDRec = record
    IsViewACDGroup    : Boolean;
    ViewInterval      : Integer;
    HurryCount        : Integer;
    GroupCount        : Integer;
    GroupList         : array of String;
    GroupTitleList    : array of String;
    ViewTimezoneCount : Integer;
    TimezoneValueList : array of String;
    TimezoneGroupList : array of String;
    ACDValue_AT       : array of Integer;
    ACDValue_AC       : array of Integer;
    ACDValue_LO       : array of Integer;
  end;

  TCallListRec = record
    IsCallList        : Boolean;
    CallListCount     : Integer;
    CallNameList      : array of String;
    CallList          : array of String;
  end;
  
const
  S_INCOMINGCALL      = 'Incoming Call';
  S_OUTGOINGCALL      = 'Outgoing Call';
  S_CALLCONNECTED     = 'Call Connected';
  S_CALLDISCONNECTED  = 'Call Disconnected';
  S_CAMPAIGNREADY     = 'Campaign Ready';
  S_CAMPAIGNSTART     = 'Campaign Start';
  S_CAMPAIGNEND       = 'Campaign End';
  S_LETTERARRIVED     = 'Letter Arrived';
  S_CALLTRANSFERRED   = 'Call Transferred';
  S_CALLCONSULTED     = 'Call Consulted';
  S_CALLRESERVED      = 'Call Reserved';
  S_ERRORARRIVED      = 'Error Arrived';
  S_CALLABANDONED     = 'Call Abandoned';
  S_LOGGEDOUT         = 'Logged Out';
  S_SCREENUPDATE      = 'Screen Update';
  S_PASSWORDARRIVED   = 'Password Arrived';

  STATE_I             = Ord('I');
  STATE_R             = Ord('R');
  STATE_N             = Ord('N');
  STATE_D             = Ord('D');
  STATE_H             = Ord('H');
  STATE_A             = Ord('A');
  STATE_O             = Ord('O');
  STATE_V             = Ord('V');
  STATE_C             = Ord('C');
  STATE_U             = Ord('U');
  STATE_F             = Ord('F');
  STATE_P             = Ord('P');
  STATE_L             = Ord('L');

  MSG_CODE_DND        = 73;
  TASK_DND            = String('T019');

  arBreak: array[0..6] of String = ('대기', '작업', '이석', '식사',
                                    '휴식', '회의', '교육');

var
  m_uMsgIncomingCall      : Integer;
  m_uMsgOutgoingCall      : Integer;
  m_uMsgCallConnected     : Integer;
  m_uMsgCallDisconnected  : Integer;
  m_uMsgCallConsulted     : Integer;
  m_uMsgCallTransferred   : Integer;
  m_uMsgCallConferenced   : Integer;
  m_uMsgCallHeld          : Integer;
  m_uMsgCallRetrieved     : Integer;

  m_uMsgCallerInfoArrived : Integer;
  m_uMsgMyInfoChanged     : Integer;
  m_uMsgScreenUpdate      : Integer;
  m_uMsgPasswordArrived   : Integer;
  m_uMsgCampaignStart     : Integer;
  m_uMsgCampaignEnd       : Integer;

  m_uMsgErrorArrived      : Integer;
  m_uMsgLoggedOut         : Integer;
  m_uMsgTimeOut           : Integer;
  m_uMsgLetterArrived     : Integer;
  m_uMsgPortArrived       : Integer;

  m_uMsgOutBoundPacket    : Integer;
  m_uMsgCallListArrived   : Integer;

  m_uMsgRsvCallerInfoAr   : Integer;
  m_uMsgNoMorePrevwData   : Integer;
  m_uProgressEventArrived : Integer;

  ACDRec: TACDRec;  
  RecServRec: TRecServRec;
  TmrRec: TTmrRec;
  ReservOldRec: TReservOldRec;
  ReservSetRec: TReservSetRec;
  CallRec: TCallRec;
  OutBoundRec: TOutBoundRec;
  CallerInfoRec: TCallerInfoRec;
  SharedMemoryRec: TSharedMemoryRec;
  GetMyInfoRec: TGetMyInfoRec;
  GetMyInfoModifiedRec: TGetMyInfoModifiedRec;
  GetGroupsRec: TGetGroupsRec;
  GetPartsRec: TGetPartsRec;
  GetAgentsGup1: TGetAgentsGup1Rec;
  GetAgentsGup2: TGetAgentsGup2Rec;
  GetAgentsGup3: TGetAgentsGup3Rec;
  GetAgentsGup4: TGetAgentsGup4Rec;
  GetQueuedRec: TGetQueuedRec;
  gAgentMode: Integer;
  WorkStateCD: Integer;
  CallListRec: TCallListRec;
  DirectListRec: TCallListRec;


implementation

end.

