unit varCisco;

interface

Uses
  Classes, Activex;

type
  //녹취서버 정보
  TRecServRec = record
    RecMode : Integer;  //[0:No|1:동방|2:Nice]
    RecIP   : String;
    RecPort : String;
  end;

  //CTI서버 정보
  TCTIServRec = record
    CTIIP   : String;
    CTIPort : String;
    CTIType : Integer;
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
    OLASID  : String;  //OLAS 아이디
  end;

  //고객정보
  TCustRec = record
    CustID    : String;  //고객ID
    CustNM    : String;  //고객명
    CampID    : String;  //캠페인ID
    CompanyCD : String;  //회사구분코드
    CompanyNM : String;  //회사명
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
    OUT_TELNO  : String;       //아웃바운드 전화번호


    StateCD    : String;       //상태코드
    StateSCD   : String;       //세부상태코드
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
    bPopup     : Boolean;
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

const
  AGENT_X     = 0;
  AGENT_LO    = 1;
  AGENT_R     = 2;
  AGENT_AUX   = 3;
  AGENT_ACW   = 4;

  DEVICE_X    = 0;
  DEVICE_IDLE = 1;
  DEVICE_BUSY = 2;

  CtiReturnOK = 1;

  arNotReady: array[1..9] of String = ('작업', '이석', '식사',
                                       '휴식', '회의', '교육',
                                       '', '', '후처리');
type
    CTIOS_AgentState = TOleEnum;
const
    agent_Login = 0;          // 로그인     0
    agent_Logout = 1;         // 로그아웃   0
    agent_NotReady = 2;       // 휴식       0  1~6, 9
    agent_Available = 3;      // 대기       0
    agent_Talking = 4;        // 통화중     0
    agent_WorkNotReady = 5;   // 휴식
    agent_WorkReady = 6;      // 대기
    agent_BusyOther = 7;      //
    agent_Reserved = 8;       //
    agent_Unknown = 9;        //
    agent_Hold = 10;          // 보류       0

type
    CTIOS_CallType = TOleEnum;
const
  CallType_ACDIn               = 01;    // (1;직통IB)
  CallType_PreRouteACDIn       = 02;    // (2;라우팅을 통한IB)
  CallType_PreRouteDirectAgent = 03;    //
  CallType_TransferIn          = 04;    //
  CallType_OverflowIn          = 05;    //
  CallType_OtherIn             = 06;    //
  CallType_AutoOut             = 07;    //
  CallType_AgentOut            = 08;    //
  CallType_Out                 = 09;    // (9;국선OB)
  CallType_AgentInside	       = 10;    // (10;내선OB)
  CallType_Consult             = 12;    // (12;3자통화,호전환시도시)
  CallType_Conference          = 15;    // (15;3자통화성립시)
  CallType_Unmonitored         = 16;    //
  CallType_Preview             = 17;    //
  CallType_Reservation         = 18;    //
  CallType_Assist              = 19;    //
  CallType_Emergency           = 20;    //

type
    CTIOS_ButtonEnable = TOleEnum;
const
    ENABLE_LOGIN = 16777216                  ;
    ENABLE_LOGOUT = 33554432                 ;
    ENABLE_READY = 134217728                 ;
    ENABLE_NOTREADY = 268435456              ;
    ENABLE_ANSWER = 1                        ;
    ENABLE_MAKECALL = 16                     ;
    ENABLE_HOLD = 4                          ;
    ENABLE_RETRIEVE = 8                      ;
    ENABLE_RELEASE = 2                       ;
    ENABLE_RECONNECT = 4096                  ;
    ENABLE_CONFERENCE_COMPLETE = 512         ;
    ENABLE_CONFERENCE_INIT = 256             ;
    ENABLE_SINGLE_STEP_CONFERENCE = 1024     ;
    ENABLE_TRANSFER_COMPLETE = 64            ;
    ENABLE_TRANSFER_INIT = 32                ;
    ENABLE_SINGLE_STEP_TRANSFER = 12         ;

type
   CTIOS_FailureCode = TOleEnum;
const
  eDriverOutOfService       = 1;
  eServiceNotSupported      = eDriverOutOfService + 1;
  eOperationNotSupported    = eServiceNotSupported + 1;
  eInvalidPriviledge        = eOperationNotSupported + 1;
  eUnknownRequestID         = eInvalidPriviledge + 1;
  eUnknownEventID           = eUnknownRequestID + 1;
  eUnknownObjectID          = eUnknownEventID + 1;
  eRequiredArgMissing       = eUnknownObjectID + 1;
  eInvalidObjectState       = eRequiredArgMissing + 1;
  eServerConnectionStatus   = eInvalidObjectState + 1;
  eInconsistentAgentData    = eServerConnectionStatus + 1;

type
    CTIOS_SystemEventID = TOleEnum;
const
  eSysCentralControllerOnline       = 1;
  eSysCentralControllerOffline      = 2;
  eSysPeripheralOnline              = 3;
  eSysPeripheralOffline             = 4;
  eSysTextFYI                       = 5;
  eSysPeripheralGatewayOffline      = 6;
  eSysCtiServerOffline              = 7;
  eSysCtiServerOnline               = 8;
  eSysHalfHourChange                = 9;
  eSysInstrumentOutOfService        = 10;
  eSysInstrumentBackInService       = 11;
  eSysCtiServerDriverOnline         = eSysInstrumentBackInService+ 1;
  eSysCtiServerDriverOffline        = eSysCtiServerDriverOnline +1;
  eSysCTIOSServerOffline            = eSysCtiServerDriverOffline + 1;
  eSysCTIOSServerOnline             = eSysCTIOSServerOffline + 1;

var
  RecServRec: TRecServRec;
  CTIServRec: TCTIServRec;
  TmrRec: TTmrRec;
  ACDRec: TACDRec;
  CallListRec: TCallListRec;
  DirectListRec: TCallListRec;
  ReservOldRec: TReservOldRec;
  ReservSetRec: TReservSetRec;
  CallRec: TCallRec;
  OutBoundRec: TOutBoundRec;
  CallerInfoRec: TCallerInfoRec;
  WorkStateCD: Integer;


const
    Idx_LOGIN                   = 00;
    Idx_LOGOUT                  = 01;
    Idx_READY                   = 02;
    Idx_NOTREADY                = 03;
    Idx_ANSWER                  = 04;
    Idx_MAKECALL                = 05;
    Idx_HOLD                    = 06;
    Idx_RETRIEVE                = 07;
    Idx_RELEASE                 = 08;
    Idx_RECONNECT               = 09;
    Idx_CONFERENCE_COMPLETE     = 10;
    Idx_CONFERENCE_INIT         = 11;
    Idx_SINGLE_STEP_CONFERENCE  = 12;
    Idx_TRANSFER_COMPLETE       = 13;
    Idx_TRANSFER_INIT           = 14;
    Idx_SINGLE_STEP_TRANSFER    = 15;


implementation

end.
