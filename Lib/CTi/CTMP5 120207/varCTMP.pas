{ **************************************************************************** }
{                                                                              }
{  설명 : 각종 레코드및 배열 선언                                              }
{                                                                              }
{  작성자 : 백순종                                                             }
{  작성일자 : 2007-10-09                                                       }
{                                                                              }
{ **************************************************************************** }

unit varCTMP;

interface

uses
    WinTypes, WinProcs, Messages, SysUtils, Classes, constCTMP;

type

  //AgwentStatusEx
  TAgentRec = Record
          eAgentID        : ctmpINT;
          eAgentMode      : ctmpAgentMode_Def;
          eAgentDN        : ctmpINT;
          eAgentBlendMode : ctmpMode_Def;
          eAgentBlockMode : ctmpMode_Def;
          eAgentTime      : ctmpINT;
          eAgentType      : ctmpAgentType_Def;
  end;


  //이벤트가 발생한 시간
  ctmpTimeStamp = record
      year     :short;
      month    :short;
      day      :short;
      hour     :short;
      minute   :short;
      second   :short;
      millisec :short;
      mindiff  :short;
      utc      :longint;
  end;

  //교환기의 Private Data
  ctmpPrivDataArray = record
      manufacturerID      :ctmpDeviceString;
      dataLength          :u_int;
      data                :ctmpPrivateString;
  end;

  ctmpMonitorFilter = record
      callFilter          :ctmpCallFilter_Def;
      featureFilter       :ctmpFeatureFilter_Def;
      agentFilter         :ctmpAgentFilter_Def;
      maintenanceFilter   :ctmpMaintenanceFilter_Def;
      voiceUnitFilter     :ctmpVoiceUnitFilter_Def;
      privateFilter       :float;
  end;

  //교환기 Queue Data.
  ctmpQueueData = record
      queueDN     :u_int;
      queueWait   :u_int;
      replyCall   :u_int;
      abandonCall :u_int;
  end;

  ctmpDeviceData = record
      refId       :u_int;
      state       :u_int;
  end;

  ctmpOpenData = record
      deviceType      :ctmpGateMode_Def;
      APIversion      :ctmpServerVersion_Def;
      APIextensions   :ctmpCTILink_Def;
      deviceDn        :ctmpDeviceString;
  end;

  ctmpClientData = record
      gate            :ctmpGateID;
      protocolType    :u_int;
      clientIPAddr    :ctmpIpAddr;
      openData        :ctmpOpenData;
  end;

  ctmpLinkData = record
      protocolType        :u_int;
      connectionProtocol  :ctmpProtocolType_Def;
      switchAddr          :ctmpIpAddr;
      switchPort          :short;
      linkState           :u_int;
      normalTrace         :ctmpMode_Def;
      normalFile          :ctmpApplString;
      networkTrace        :ctmpMode_Def;
      networkFile         :ctmpApplString;
      fullTrace           :ctmpMode_Def;
      fullFile            :ctmpApplString;
      maxMonitors         :short;
      curMonitors         :short;
  end;

  ctmpReadyAgent  = record
      agentId      :u_int;
      dn           :u_int;
      blendMode    :ctmpMode_Def;
      continueTime :u_short;
  end;
  pctmpReadyAgent = array[0..100] of ctmpReadyAgent;

  ctmpPrivateData = record
      vendor       :array[0..31] of u_char;
      length       :ctmpSHORT;
      data         :array[0..1023] of u_char;
  end;

  ctmpConnectionID = record
      callID      :ctmpINT;
      deviceID    :ctmpDeviceString;
      devIDType   :ctmpConnectionID_Def;
  end;

  ctmpConnectionList = record
      count       :ctmpINT;
      connection  :array[0..MAX_COUNT-1] of ctmpConnectionID;
  end;

  ctmpExtendedDeviceID = record
      deviceID        :ctmpDeviceString;
      deviceIDType    :ctmpDeviceIDType_Def;
      deviceIDStatus  :ctmpDeviceIDStatus_Def;
  end;

  ctmpSnapshotCallResponseInfo = record
      deviceOnCall            :ctmpExtendedDeviceID;
      callIdentifier          :ctmpConnectionID;
      localConnectionState    :ctmpLocalConnectState_Def;
  end;

  ctmpSnapshotCallData = record
      count   :ctmpINT;
      info    :array[0..MAX_COUNT-1] of ctmpSnapshotCallResponseInfo;
  end;

  ctmpCallState = record
      count   :ctmpINT;
      state   :array[0..MAX_COUNT-1] of ctmpLocalConnectState_Def;
  end;

  ctmpSnapshotDeviceResponseInfo = record
      callIdentifier      :ctmpConnectionID;
      localCallState      :ctmpCallState;
  end;

  ctmpSnapshotDeviceData = record
      count   :ctmpINT;
      info    :array[0..MAX_COUNT-1] of ctmpSnapshotDeviceResponseInfo;
  end;

  //현재 호에 대한 User Extends Information Data.
  ctmpUEI = record
      UEILen      :ctmpINT;
      UEIData     :ctmpDataString;
  end;

  //현재 호에 대한 Campaign Information Data.
  ctmpCI = record
      CILen       :ctmpINT;
      CIData      :ctmpDataString;
  end;

  //이벤트 데이터 구조
  ctmpEventData = record
    event                   :ctmpEventKind_Def;
    callRefId               :ctmpINT; //OB->campaignid
    priOldCallRefId         :ctmpINT; //OB->sequenceno
    secOldCallRefId         :ctmpINT; //OB->tokenid
    localConnState          :ctmpLocalConnectState_Def;
    eventCause              :ctmpEventCauses_Def;
    typee                   :ctmpINT; //OB->scriptid
    agentMode               :ctmpAgentMode_Def;
    agentId                 :ctmpDeviceString; //OB->agentid
    agentGroup              :ctmpDeviceString;
    agentData               :ctmpDeviceString;
    logicalAgent            :ctmpDeviceString;
    monitorParty            :ctmpDeviceString; //OB->telno
    UUI                     :ctmpApplString;
    accountCode             :ctmpApplString;
    authorisationCode       :ctmpApplString;
    dtmfDigit               :ctmpDeviceString;
    numberOfQueue           :ctmpINT;
    otherPartyType          :ctmpINT;
    otherPartyCause         :ctmpEventCallCause_Def;
    otherParty              :ctmpDeviceString;
    otherPartyTrunk         :ctmpINT;
    otherPartyGroup         :ctmpINT;
    thirdPartyType          :ctmpINT;
    thirdPartyCause         :ctmpEventCallCause_Def;
    thirdParty              :ctmpDeviceString;
    thirdPartyTrunk         :ctmpINT;
    thirdPartyGroup         :ctmpINT;
    calledPartyType         :ctmpINT;
    calledPartyCause        :ctmpEventCallCause_Def;
    calledParty             :ctmpDeviceString;
    calledPartyTrunk        :ctmpINT;
    calledPartyGroup        :ctmpINT;
    originatingPartyType    :ctmpINT;
    originatingPartyCause   :ctmpEventCallCause_Def;
    originatingParty        :ctmpDeviceString;
    originatingPartyTrunk   :ctmpINT;
    originatingPartyGroup   :ctmpINT;
    connectionList1         :ctmpDeviceString;
    connectionList2         :ctmpDeviceString;
    connectionList3         :ctmpDeviceString;
    DNDMode                 :ctmpMode_Def;
    forwardType             :ctmpForward_Def;
    forwardDn               :ctmpDeviceString;
    messageInvDn            :ctmpDeviceString;
    messageWaitingMode      :ctmpMode_Def;
    autoAnswerMode          :ctmpMode_Def;
    microphoneMuteMode      :ctmpMode_Def;
    speakerMuteMode         :ctmpMode_Def;
    speakerVolume           :ctmpINT;
    timeStamp               :ctmpTimeStamp;
    privData                :ctmpPrivDataArray;
    queueData               :ctmpQueueData;
    resaonCode              :ctmpINT;
    UEI                     :ctmpUEI; //OB->customerkey
    CI                      :ctmpCI;

    { 2000.6.25 Add }
    gate                    :ctmpGateID;
    monitorID               :ctmpMonitorCrossID;
    privateData             :ctmpPrivateData;
    voiceLength             :ctmpINT; //OB->waittime
    voicePosition           :ctmpINT; //OB->dialgap
    voiceSpeed              :ctmpCHAR;
    voiceLevel              :ctmpCHAR;
    voiceVolume             :ctmpCHAR;
    sysStatus               :ctmpCHAR;
    routeRegReqID           :ctmpINT;
    routingCrossID          :ctmpINT;
    errorValue              :ctmpCHAR;
    ServerID                :ctmpCHAR;
    PbxType                 :ctmpCHAR;
    callKind                :ctmpCHAR;
    workMode                :ctmpWorkMode_Def;
  end;


  { used Async Mode }

  ctmpCallID_rtn = record
      callID      :ctmpCallID;
  end;

  ctmpCall_rtn = record
      call        :ctmpConnectionID;
      privateData :ctmpPrivateData;
  end;

  ctmpCallList_rtn = record
      call        :ctmpConnectionID;
      callList    :ctmpConnectionList;
      privateData :ctmpPrivateData;
  end;

  ctmpQueryAgentStatus_rtn = record
      agentMode       :ctmpAgentMode_Def;
      agentID         :ctmpDeviceString;
      reasonCode      :ctmpINT;
      privateData     :ctmpPrivateData;
  end;

  ctmpQueryDeviceForward_rtn = record
      forwardMode     :ctmpMode_Def;
      forwardDn       :ctmpDeviceString;
      privateData     :ctmpPrivateData;
  end;

  ctmpMode_rtn = record
      Mode            :ctmpMode_Def;
      privateData     :ctmpPrivateData;
  end;

  ctmpQuerySpeakerVolume_rtn = record
      speakerVolume   :ctmpSHORT;
  end;

  ctmpQueryDeviceInfo_rtn = record
      queryDN         :ctmpDeviceString;
      deviceType      :ctmpDeviceType_Def;
      deviceClass     :ctmpDeviceClass_Def;
      privateData     :ctmpPrivateData;
  end;

  ctmpQueryLastNumber_rtn = record
      lastNumber      :ctmpDeviceString;
      privateData     :ctmpPrivateData;
  end;

  ctmpChangeMonitorFilter_rtn = record
      filter          :ctmpMonitorFilter;
      privateData     :ctmpPrivateData;
  end;

  ctmpMonitorFilter_rtn = record
      monitorID       :ctmpMonitorCrossID;
      filter          :ctmpMonitorFilter;
      privateData     :ctmpPrivateData;
  end;

  ctmpSnapshotCall_rtn = record
      snapshotCallData    :ctmpSnapshotCallData;
      privateData         :ctmpPrivateData;
  end;

  ctmpSnapshotDevice_rtn = record
      deviceData          :ctmpDeviceData;
      snapshotDevice      :ctmpSnapshotDeviceData;
      numberOfCalls       :ctmpINT;
      privateData         :ctmpPrivateData;
  end;

  ctmpReRoute_rtn = record
      routeRegisterReqID      :ctmpINT;
      routingCrossRefID       :ctmpINT;
      privateData             :ctmpPrivateData;
  end;

  ctmpRouteRegister_rtn = record
      routeRegisterReqID      :ctmpRoutingCrossID;
      privateData             :ctmpPrivateData;
  end;

  ctmpEscape_rtn = record
      privData        :ctmpPrivDataArray;
      privateData     :ctmpPrivateData;
  end;

  ctmpSysStatReq_rtn = record
      systemStatus    :ctmpSystemStatus_Def;
      privateData     :ctmpPrivateData;
  end;

  ctmpSysStatStart_rtn = record
      systemStatus    :ctmpSystemStatus_Def;
      systemFilter    :ctmpINT;
      privateData     :ctmpPrivateData;
  end;

  ctmpChangeSysStatFilter_rtn = record
      systemFilterSelected        :ctmpINT;
      systemFilterActive          :ctmpINT;
      privateData                 :ctmpPrivateData;
  end;

  ctmpErrMsg_rtn = record
      errorContent    :ctmpErrorMSG;
  end;

  ctmpAgentReadyGet_rtn = record
      readyAgent      :^ctmpReadyAgent;
      readCount       :ctmpINT;
  end;

  ctmpCallToCNID_rtn = record
      CNID    :ctmpINT;
  end;

  ctmpQueryAgentStatusEx_rtn = record
      queryAgentID        :ctmpINT;
      queryAgentMode      :ctmpAgentMode_Def;
      queryAgentDN        :ctmpINT;
      queryAgentblendMode :ctmpMode_Def;
      queryAgentBlockMode :ctmpMode_Def;
      queryAgentTime      :ctmpINT;
  end;

  ctmpWaitTimeGet_rtn = record
      waitTime    :ctmpSHORT;
  end;

  ctmpShowClient_rtn = record
      clientData      :ctmpClientData;
      readCount       :ctmpSHORT;
  end;

  ctmpShowLink_rtn = record
      linkData    :ctmpLinkData;
  end;

  ctmpShowVer_rtn = record
      swVersion       :ctmpINT;
      licenseKey      :ctmpDeviceString;
  end;

  ctmpStartDataPath_rtn = record
      noCharToCollect     :ctmpINT;
      terminalChar        :ctmpDeviceString;
      timeout             :ctmpINT;
      ioRefId             :ctmpIoRefID;
  end;

  ctmpMsgID_rtn = record
      messageID       :ctmpMessageID;
  end;

  ctmpQueryVocAtt_rtn = record
      encodingAlgorithm       :ctmpEncodingAlgorithm_Def;
      sampleRate              :ctmpDeviceString;
      durations               :ctmpINT;
      fileName                :ctmpDeviceString;
      position                :ctmpINT;
      speed                   :ctmpINT;
      volume                  :ctmpINT;
      level                   :ctmpINT;
      state                   :ctmpState_Def;
  end;

  ctmpResponseData = record
    callID                  :ctmpCallID_rtn;                // ctmpConsultationCall / ctmpSingleStepConferenceCall /
                                      // ctmpSingleStepTransferCall
    call                    :ctmpCall_rtn;		            // ctmpMakeCall / ctmpMakePredictiveCall
    callList                :ctmpCallList_rtn;	            // ctmpConferenceCall / ctmpTransferCall
    agentStatus             :ctmpQueryAgentStatus_rtn;
    forwards                :ctmpQueryDeviceForward_rtn;
    mode                    :ctmpMode_rtn;			        // ctmpQueryDeviceDND / ctmpQueryDeviceMessageWaitting
                                      // ctmpQueryEnableRouting / ctmpQueryAutoAnswer
                                      // ctmpQueryMicrophoneMute / ctmpQuerySpeakerMute
                                      // ctmpGetMonitor
    speakVolume             :ctmpQuerySpeakerVolume_rtn;
    deviceInfo              :ctmpQueryDeviceInfo_rtn;
    lastNum                 :ctmpQueryLastNumber_rtn;
    filter                  :ctmpChangeMonitorFilter_rtn;
    monitorfilter           :ctmpMonitorFilter_rtn;	        // ctmpMonitorStart / ctmpMonitorCall / ctmpMonitorCallsViaDevice
    eventData               :ctmpEventData;
    snapshotCall            :ctmpSnapshotCall_rtn;
    snapshotDevice          :ctmpSnapshotDevice_rtn;
    reRoute                 :ctmpReRoute_rtn;
    routeRegist             :ctmpRouteRegister_rtn;	        // ctmpRouteRegisterReq / ctmpRouteRegisterCancel
    escape                  :ctmpEscape_rtn;
    sysStat                 :ctmpSysStatReq_rtn;
    sysStart                :ctmpSysStatStart_rtn;
    sysFilter               :ctmpChangeSysStatFilter_rtn;
    errMsg                  :ctmpErrMsg_rtn;
    readyGet                :ctmpAgentReadyGet_rtn;
    CNID                    :ctmpCallToCNID_rtn;
    agentEx                 :ctmpQueryAgentStatusEx_rtn;
    waitGet                 :ctmpWaitTimeGet_rtn;
    showClient              :ctmpShowClient_rtn;
    showLink                :ctmpShowLink_rtn;
    showVer                 :ctmpShowVer_rtn;
    concatMsg               :ctmpMsgID_rtn;		            // ctmpConcatenateMessage / ctmpRecordMessage / ctmpSynthesizeMessage
    VoiceAttr               :ctmpQueryVocAtt_rtn;
    privateData             :ctmpPrivateData;	            // ctmpEscapeServiceConf / ctmpSysStatStop
                                      // ctmpSysStatReqConf
    errorValue              :ctmpINT;
  end;

  ctmpResponseInfo_rtn = record
    gate            :ctmpGateID;
    invoke          :ctmpInvokeID;
    functionCode    :ctmpCHAR;
    serviceCode     :ctmpCHAR;
  end;

  TReadyAgent = array[0..100] of ctmpReadyAgent;

  TReadyBusy = array[0..100] of ctmpReadyAgent;

  //녹취서버 정보
  TRecServRec = record
    RecMode : Integer;  //[0:No|1:동방|2:Nice]
    RecIP   : String;
    RecPort : String;
  end;

  //녹취서버 정보
  TCTIServRec = record
    CTIIP   : String;
    CTIPort : String;
    CTIType : Integer;
  end;

  //상담원 로긴정보
  TTmrRec = record
    TmrID       : String;  //상담원ID   //USER_NO로 대체
    TmrNM       : String;  //상담원명   //USER_NM으로 대체
    TmrPW       : String;  //패스워드
    TmrJU       : String;  //주민번호
    AgentCD     : String;  //설계사코드
    PartCD      : String;  //소속, 파트
    PartSCD     : String;  //파트
    AcdID       : String;  //avaya acdID
    CTiID       : String;  //AGENT_ID
    CID         : String;  //식별자
    InDT        : String;  //입사일자
    OutDT       : String;  //퇴사일자
    TmLvCD      : String;  //기술등급
    TmrGB       : String;  //직급코드   //RIGHT로 대체
    IP          : String;  //IP
    RemoteLogin : Boolean; // 원격로긴
    Device      : String;  //내선번호
    OLASID      : String;  //OLAS 아이디
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
    RESP_CD    : String;
    KIND_CD    : String;

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
    RecStatus  : String;       //
    Trans_DT   : string;       //전송일자
    Trans_Tm   : string;       //전송시간
    Trans_GB   : string;       //전송구분
    Contract   : String;       //Contract 여부[Y|N|X]
    InOutFlag  : String;       //인바운드/아웃바운드 구분 [0:비정상처리|1:인바운드|2:아웃바운드]
    //imsi-fias
    Receive_Rel: String;
    WD_Indicator: String;      // WYDN, WADN(W: 활용동의, D: 전화수신, Y:Yes, N:No, A:변동없음
    SAMPLEYN    : String;      //샘플발송YN
    SAMPLEMEMO  : string;      //샘플발송메모
    MAGAZINEYN  : string;      //잡지발송YN
    MAGAZINEMEMO: string;      //잡지발송메모
    GIFTYN      : string;      //GIFT발송YN
    CLAIM       : string;      //클레임 0: n/a  1:강  2:중   3:약
    
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
  gAgentMode: Integer;
  WorkStateCD: Integer;
  gbHold: Boolean;


implementation


end.
