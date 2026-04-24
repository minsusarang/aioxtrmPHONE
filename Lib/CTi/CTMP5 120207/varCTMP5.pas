{ **************************************************************************** }
{                                                                              }
{  설명 : 각종 레코드및 배열 선언                                              }
{                                                                              }
{  작성자 : 백순종                                                             }
{  작성일자 : 2007-10-09                                                       }
{                                                                              }
{ **************************************************************************** }
unit varCTMP5;


interface

uses
    WinTypes, WinProcs, Messages, SysUtils, Classes, constCTMP5;

type

  //AgwentStatusEx
  TAgentRec = Record
//          eAgentID        : ctmpINT;
          eAgentID        : ctmpDeviceString; //2011.03.03
          eAgentMode      : ctmpAgentMode_Def;
          eAgentDN        : ctmpINT;
          eAgentBlendMode : ctmpMode_Def;
          eAgentBlockMode : ctmpMode_Def;
          eAgentTime      : ctmpINT;
          eAgentType      : ctmpAgentType_Def;
  end;

  {}
  //20110303 추가
  /////////////////////////////////////////////////////////////////////////////*/
  ctmpTenantMaster = Record
         pos               : short         ;
         tenant_id         : short         ;
         tenant_name       : ctmpNameString;
  end;


   ctmpGroupMaster = Record
         pos       : short         ;
         tenant_id : short         ;
         group_id  : ctmpINT       ;
         group_name: ctmpNameString;
   end;


  {}

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
  TReadyAgent = array[0..100] of ctmpReadyAgent;


  ctmpReadyAgentEx = record
      agentId      :u_int;
      agentName    :array[0..29] of u_char;
      agentGroup   :u_int;
      groupName    :array[0..29] of u_char;
      agentPart    :u_int;
      partName     :array[0..29] of u_char;
      deviceDN     :u_int;
      blendMode    :ctmpMode_Def;
      continueTime :u_short;
  end;
  pctmpReadyAgentEx = array[0..100] of ctmpReadyAgentEx;
  TReadyAgentEx = array[0..100] of ctmpReadyAgentEx;

  ctmpBusyAgent = record
      agentId      :u_int;
      deviceDN     :u_int;
      blendMode    :ctmpMode_Def;
      continueTime :u_short;
  end;
  pctmpBusyAgent = array[0..100] of ctmpBusyAgent;
  TReadyBusy = array[0..100] of ctmpReadyAgent;

  ctmpSkillAgent = record
      agentGroup   :u_int;
      agentPart    :u_int;
      agentId      :u_int;
      agentMode    :ctmpMode_def;
      agenttime    :u_int;
  end;

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

  ctmpQuery = record
      QueryLen    :u_int;
      QueryData   :array[0..511] of char;
  end;

  ctmpCampaignMaster = record
     uiCampId     :ctmpINT;                                       // 캠페인 ID
     ucCampaignName :array[0..30] of char;                        // 캠페인을 알아볼 수 있는 이름
     ucCampaignDesc :array[0..255] of char;                       // 캠페인의 속성 등을 설명
     uiCampaignSiteCode: ctmpINT;
     uiCampaignSVCODE  : ctmpINT;                                 // Callback 캠페인 사용시에 각각의
     ubCampaignMode    : ctmpSHORT;                               // 아웃바운드 발신방법을 정의
     iStartFlag        : ctmpCHAR;                                // 캠페인 현재 상태
     ucCampENFL        : ctmpCHAR;                                // 캠페인 완료 여부
     ucCampCallBack    : ctmpCHAR;                                // 해당 캠페인을 Callback 캠페인으로
     ucCampDLFL        : ctmpCHAR;                                // 캠페인 삭제 여부
     uiCampListCnt     : ctmpINT;                                 // 캠페인 발신데이터 건 수
     ucCampListQuery   : array[0..255] of char;                   // 재발신 조건문
     ucCampListFile    : array[0..100] of char;                   // 발신데이터 파일
     uiCampNextCamp    : ctmpINT;                                 // Power 모드 캠페인 사용 시에
     uiCampTokenId     : ctmpINT;
     ucCampPhoneOrder  : array[0..10] of char;                    // 각 고객 별로 최대 5개의 전화번호
     unCampMaxFreq1    : ctmpSHORT;	                            // 고객전화 1번(TNO1)의 시도 횟수
     unCampMaxFreq2    : ctmpSHORT;	                            // 고객전화 2번(TNO2)의 시도 횟수
     unCampMaxFreq3    : ctmpSHORT;	                            // 고객전화 3번(TNO3)의 시도 횟수
     unCampMaxFreq4    : ctmpSHORT;	                            // 고객전화 4번(TNO4)의 시도 횟수
     unCampMaxFreq5    : ctmpSHORT;	                            // 고객전화 5번(TNO5)의 시도 횟수
     uiCampInterval    : ctmpINT;	                            // 이전 콜이 실패한 동일한 고객에게
     ucCampTACode      : array[0..5] of char;                       // 외부 접속코드(Trunck Access Code)
     ucCampDDDNum      : array[0..4] of char;                       // 고객전화번호 중, 발신 시 지역번호를
     ucCampQueue       : ctmpINT;
     unCampMaxRing     : ctmpSHORT;	                            // 최대 링 횟수, 지정된 링 횟수이상이
     ucCampMachine     : ctmpCHAR;	                            // Detection 방법 지정
     unCampAutoDialTM  : ctmpSHORT;                                 // Auto-Preview 모드의 캠페인 사용시,
     uiCampCRID        : ctmpINT;	                            // 캠페인 생성자 ID
     ucCampCRTM        : array[0..19] of char;                      // 캠페인 생성 시간
     ucCampCRIP        : array[0..16] of char;                      // 캠페인 생성자 IP
     uiCampUPID        : ctmpINT;	                            // 캠페인 최종 수정자 ID
     ucCampUPTM        : array[0..19] of char;                      // 캠페인 최종 수정 시간
     ucCampUPIP        : array[0..16] of char;	                    // 캠페인 최종 수정자 IP
     unCampCustId      : ctmpSHORT;	                            // 고객특성 Master ID
     unCampPhoneId     : ctmpSHORT;	                            // 전화번호설명 Master ID
     uiCampScriptId    : ctmpINT;	                            // 응대 Script ID
     uiCampMentId      : ctmpINT;	                            // 사용하지 않음
     uiCampCIOD_ID     : ctmpINT;	                            // CIOD ID
     uiCampAnswerCnt   : ctmpINT;	                            // 사용하지 않음
     uiCampDialSpeed   : ctmpINT;	                            // 발신할 Call수를 비율로 지정함
     uiCampParentId    : ctmpINT;	                            // 사용하지 않음
     unCampLevel       : ctmpSHORT;	                            // 사용하지 않음
     unCampOVTime      : ctmpSHORT;	                            // 사용하지 않음
     uiCampALCnt       : ctmpINT;	                            // 발신데이터가 일정 수 이하가 남았을
     ucCampSPTel       : array[0..15] of char;                      // 관리자 전화번호
     unCampRDCnt       : ctmpSHORT;	                            // 재발신 횟수
     ucCampOBSE        : array[0..25] of char;                      // 발신순서조건
     uiCampGroupId     : ctmpINT;
     unUsfl            : ctmpSHORT;
  end;

  // PACKETNO_POPUP_EVENT
  ctmpPopUpEvent = record
     uiAgentId         : u_int;
     uiCampaignId      : u_int;				//campaign ID=분배대상 agent
     uiSequenceNo      : u_int;				//campaignList sequence No

     sCustomerTelNo    : array[0..19] of char;			//고객전화번호
     uiTokenId         : u_int;					//고객정보 key

     // 고객키
     sCSKE             : array[0..29] of char;					// 고객정보(Designer가 Insert)
     unScriptId        : u_short;					// 상담 스크립트 ID(Designer가 Insert)
     unWaitTime        : u_short;					// 고객 대기 시간.(Dialer가 Insert)
     unDialGap         : u_short;					// 발신주기(Dialer가 Insert)
  end;

  //이벤트 데이터 구조
  ctmpEventData = record
    event                   :ctmpEventKind_Def;
    cnid                    :ctmpINT;
    cnsq                    :ctmpSHORT;
    ctype                   :ctmpCHAR;
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
    eDivide                 :ctmpINT;
    eUnAttend               :ctmpINT;

    //2011.03.22추가  -- union 을 temp array로 임시 사이즈 맞춤
    pumpdata                 :ctmpTempArray;

  end;


{  systemEventIE    = record
    case with:(0..12) of

  end;
{}

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

  ctmpQueryMailAgentStatus_rtn = record
      eAgentMode      :ctmpeAgentMode_Def;
      reasonCode      :ctmpINT;
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

  ctmpAgentReadyGetEx_rtn = record
      readyAgentEx    :^ctmpReadyAgentEx;
      readCount       :ctmpINT;
  end;

  ctmpAgentBusyGet_rtn = record
      BusyAgent       :^pctmpBusyAgent;
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
      queryAgentType      :ctmpAgentType_Def;
  end;

  ctmpWaitTimeGet_rtn = record
      waitTime    :ctmpINT;
      waitCount   :ctmpSHORT;
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

  ctmpCallbackCampaign_ = record
      ciodID                  : ctmpINT;
      campaignID              : ctmpINT;
      svcCode                 : ctmpINT;
      cbCount                 : ctmpINT;
  end;
  pctmpCallbackCampaign_ = ctmpCallbackCampaign_;

  ctmpCallbackCampign_rtn = record
      count                   : ctmpINT;
      Campaign                : array[0..99] of ctmpCallbackCampaign_;
  end;

  ctmpCallbackData_rtn = record
      ciodID                  : ctmpINT;
      campaignID              : ctmpINT;
      campaignSeq             : ctmpINT;
      rtnValue                : ctmpINT; //1:callback insert success
					 //2:callback insert error
  end;

  ctmpCallbackData = record
      uiCmId                  : ctmpINT;
      uiCmSq                  : u_int;
      strCustKey              : array[0..29] of char;	// 고객키
      strCustName             : array[0..19] of char;	// 고객명
      strCustKey2             : array[0..29] of char;	// 고객키2
      strCustKey3             : array[0..29] of char;	// 고객키3
      strCustChar1            : array[0..19] of char;	// 고객특성1
      strCustChar2            : array[0..19] of char;	// 고객특성2
      strCustChar3            : array[0..19] of char;	// 고객특성3
      strCustChar4            : array[0..19] of char;	// 고객특성4
      strCustChar5            : array[0..19] of char;	// 고객특성5
      strCustChar6            : array[0..19] of char;	// 고객특성6
      strCustChar7            : array[0..19] of char;	// 고객특성7
      strTelNo1               : array[0..19] of char;	// 전화번호1
      strTelNo2               : array[0..19] of char;	// 전화번호2
      strTelNo3               : array[0..19] of char;	// 전화번호3
      strTelNo4               : array[0..19] of char;	// 전화번호4
      strTelNo5               : array[0..19] of char;	// 전화번호5
      strTkData               : array[0..1023] of char;	// 토큰 데이타
      strMailAdd              : array[0..99] of char;	// 고객의 메일 주소
      strSMSPhone             : array[0..14] of char;	// SMS Phone Number
      iBlackFlag              : ctmpINT;              	// BLACK List구분
      strReCallTime           : array[0..19] of char;   // 예약 시간
      strRecallTelNo          : array[0..19] of char;   // 예약 전화번호
      uiFileIndex             : u_int;
      uiAgentID               : u_int;                  //AgentID
      uiCallKind              : u_int;                  //재콜종류
  end;

  ctmpConselResult = record
    uiCampaignId              : u_int;			// campaign ID=분배대상 agent
    uiSequenceNo              : u_int;			// campaignList sequence No
    uiGroup                   : u_int;			// 상담원 group
    uiTeam                    : u_int;			// 상담원 team
    uiAgentId                 : u_int;			// 상담원 agentId
    BlackList                 : u_int;			// Black List
    CallKind                  : u_int;			// Call 구분
    sResvDate                 : array[0..19] of char;	// 예약일자(재콜)
    sResvTelNo                : array[0..19] of char;	// 예약 전화번호
    sConsultResult            : array[0..19] of char;	// 상담결과 code
    uiConsultTime             : u_int;
  end;

  ctmpAgentBlocking_rtn = record
    Result                    : ctmpINT;
  end;

  ctmpAsyncPubResult_rtn = record
    Result                    : ctmpINT;
  end;

  ctmpCampaignListHandle = record
    uiCampaignId              : u_int;
    ubListKind                : u_int;
    ucListMode                : u_char;
    ubAppKind                 : u_int;
    ucListFileName            : array[0..255] of char;
    uiListCount               : u_int;
  end;

  ctmpBlackList = record
    cpid                      : ctmpINT;
    cskey                     : array[0..30] of char;
    csname                    : array[0..30] of char;
    csdate                    : array[0..19] of char;
    agentid                   : ctmpINT;
    cstel                     : array[0..19] of char;
  end;

  ctmpBlackListII = record
    uiCampaignId              : u_int;
    uiSeq                     : u_int; //UINT
    bBlockRow                 : u_int; //BOOL
    szTno1                    : array[0..19] of char;
    szTno2                    : array[0..19] of char;
    szTno3                    : array[0..19] of char;
    szTno4                    : array[0..19] of char;
    szTno5                    : array[0..19] of char;
    ucOpFlag                  : ctmpCHAR;
    ucExtFlag                 : ctmpCHAR;
    szStartDate               : array[0..15] of char;
    szEndDate                 : array[0..15] of char;
    szCske1                   : array[0..30] of char;
    szCske2                   : array[0..30] of char;
  end;

  ctmpPreviewDial = record
    uiCampaignId              : u_int;
    uiSequenceNo              : u_int;
    dialKind                  : ctmpDialKind_def;
  end;

  ctmpAgentStatus = record
    group                     : ctmpINT;
    part                      : ctmpINT;
    agentid                   : ctmpINT;
    mode                      : ctmpINT;
    szName                    : ctmpNameString;
    Dn                        : ctmpINT;
    szGrName                  : ctmpNameString;
    szPtName                  : ctmpNameString;
  end;

  ctmpHAInfo = record
    nResult                   : ctmpINT;
    nNewHostId                : ctmpINT;
    sNewHostIP                : ctmpNameString;
  end;



  ctmpResponseData = record
    errorValue              :ctmpINT;
    callID                  :ctmpCallID_rtn;              // ctmpConsultationCall / ctmpSingleStepConferenceCall /
                                                          // ctmpSingleStepTransferCall
    call                    :ctmpCall_rtn;		  // ctmpMakeCall / ctmpMakePredictiveCall
    callList                :ctmpCallList_rtn;	          // ctmpConferenceCall / ctmpTransferCall
    agentStatus             :ctmpQueryAgentStatus_rtn;
    mailAgentStatus         :ctmpQueryMailAgentStatus_rtn;
    forwards                :ctmpQueryDeviceForward_rtn;
    mode                    :ctmpMode_rtn;		  // ctmpQueryDeviceDND / ctmpQueryDeviceMessageWaitting
                                                          // ctmpQueryEnableRouting / ctmpQueryAutoAnswer
                                                          // ctmpQueryMicrophoneMute / ctmpQuerySpeakerMute
                                                          // ctmpGetMonitor
    speakVolume             :ctmpQuerySpeakerVolume_rtn;
    deviceInfo              :ctmpQueryDeviceInfo_rtn;
    lastNum                 :ctmpQueryLastNumber_rtn;
    filter                  :ctmpChangeMonitorFilter_rtn;
    monitorfilter           :ctmpMonitorFilter_rtn;	  // ctmpMonitorStart / ctmpMonitorCall / ctmpMonitorCallsViaDevice
    eventData               :ctmpEventData;
    snapshotCall            :ctmpSnapshotCall_rtn;
    snapshotDevice          :ctmpSnapshotDevice_rtn;
    reRoute                 :ctmpReRoute_rtn;
    routeRegist             :ctmpRouteRegister_rtn;	  // ctmpRouteRegisterReq / ctmpRouteRegisterCancel
    escape                  :ctmpEscape_rtn;
    sysStat                 :ctmpSysStatReq_rtn;
    sysStart                :ctmpSysStatStart_rtn;
    sysFilter               :ctmpChangeSysStatFilter_rtn;
    errMsg                  :ctmpErrMsg_rtn;
    readyGet                :ctmpAgentReadyGet_rtn;
    BusyGet                 :ctmpAgentBusyGet_rtn;
    CNID                    :ctmpCallToCNID_rtn;
    agentEx                 :ctmpQueryAgentStatusEx_rtn;
    waitGet                 :ctmpWaitTimeGet_rtn;
    showClient              :ctmpShowClient_rtn;
    showLink                :ctmpShowLink_rtn;
    showVer                 :ctmpShowVer_rtn;
    concatMsg               :ctmpMsgID_rtn;		  // ctmpConcatenateMessage / ctmpRecordMessage / ctmpSynthesizeMessage
    VoiceAttr               :ctmpQueryVocAtt_rtn;
    privateData             :ctmpPrivateData;	          // ctmpEscapeServiceConf / ctmpSysStatStop
                                                          // ctmpSysStatReqConf
    cbCampaign              :ctmpCallbackCampign_rtn;
    callback                :ctmpCallbackData_rtn;
    agentblocking           :ctmpAgentBlocking_rtn;
    HAInfo                  :ctmpHAInfo;		  // edited by hrlee 2006.09.11 HAactivity
  end;

  ctmpResponseInfo_rtn = record
    gate            :ctmpGateID;
    invoke          :ctmpInvokeID;
    functionCode    :ctmpCHAR;
    serviceCode     :ctmpCHAR;
  end;

  ctmpRemoteCenter = record
    ccseid          : ctmpSHORT;
    alias           : array[0..63] of char;
    tacode          : ctmpSHORT;
    groupcode       : ctmpSHORT;
  end;

  ctmpRoutePointInfoEX = record
    RP              : ctmpINT;
    RPName          : array[0..29] of char;
  end;

  ctmpDNISInfo = record
    DNIS            : ctmpINT;
    DNISName        : array[0..29] of char;
  end;

  ctmpPreviewCampaignDesc = record
    ciodid          : ctmpINT;
    campaignid      : ctmpINT;
    servicecode     : ctmpINT;
    dialcount       : ctmpINT;
    totalcout       : ctmpINT;
    namelen         : ctmpINT;
    camname         : array[0..30] of char;
    desclen         : ctmpINT;
    campdesc        : array[0..255] of char;
  end;

  ctmpPreviewData = record
    agentid         : ctmpINT;
    campaignid      : ctmpINT;
    sequenceno      : ctmpINT;
    customertelno   : array[0..19] of char;
    tokenid         : ctmpINT;
    cskelen         : ctmpINT;
    cske            : array[0..1023] of char;
    scriptid        : ctmpSHORT;
    waittime        : ctmpSHORT;
    dialgab         : ctmpSHORT;
    mode            : ctmpINT;
    callkind        : ctmpINT;
    campanmelen     : ctmpINT;
    campname        : array[0..30] of char;
    campdesclen     : ctmpINT;
    campdesc        : array[0..255] of char;
    custnamelen     : ctmpINT;
    custname        : array[0..19] of char;
    custkey1len     : ctmpINT;
    custkey1        : array[0..29] of char;
    custkey2len     : ctmpINT;
    custkey2        : array[0..29] of char;
    custkey3len     : ctmpINT;
    custkey3        : array[0..29] of char;
    trycount        : ctmpINT;
    dialtelseq      : ctmpINT;
    teldesclen      : ctmpINT;
    teldesc         : array[0..20] of char;
  end;

  ctmpCounselResultExMaster = record
    resultid        : ctmpINT;
    resultcodelen   : ctmpINT;
    resultcode      : array[0..20] of char;
    resultnamelen   : ctmpINT;
    resultname      : array[0..100] of char;
  end;

  ctmpCounselResultEx = record
    ciodid          : ctmpINT;
    campaignid      : ctmpINT;
    seq             : ctmpINT;
    agentid         : ctmpINT;
    agentdn         : ctmpINT;
    customertelno   : array[0..19] of char;
    telseq          : ctmpINT;
    dialresult      : ctmpINT;
    resultid        : ctmpINT;
    resultcodelen   : ctmpINT;
    resultcode      : array[0..20] of char;
    resultnamelen   : ctmpINT;
    resultname      : array[0..100] of char;
    dialdate        : ctmpINT;   // long
  end;

  ctmpAnalogDn = record
    station         : ctmpINT;
    status          : ctmpINT;
  end;

  //녹취서버 정보
  TRecServRec = record
    RecMode : Integer;  //[0:No|1:동방|2:Nice]
    RecIP   : String;
    RecPort : String;
  end;

  //녹취서버 정보
  TCTIServRec = record
{$IFDEF avaya_ctmp5}
    CTIIP   : String;
    CTIIP2  : string; // pjw ctmp5 서버이중화 때문에 추가 20110518
    CTIPort : String;
    CTIPort2 : String; // 이중화 포트를 위해 작성하였으나 실제 사용하지는 않음.!!
    HAUSE   : Integer; // 이중화 : 1 ,  단일화 0
{$ELSE}
    CTIIP   : String;
    CTIPort : String;
{$ENDIF}
    CTIType : Integer;
  end;

  //상담원 로긴정보
  TTmrRec = record
    TmrID       : String;  //상담원ID   //USER_NO로 대체
    TmrNM       : String;  //상담원명   //USER_NM으로 대체
    TmrPW       : String;  //패스워드
    TmrJU       : String;  //주민번호
    AgentCD     : String;  //설계사코드  (웹의ID로 임시사용)
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
    OLASID      : String;  //OLAS 아이디  (웹의PW로 임시사용)
  end;

  //고객정보
  TCustRec = record
    CustID    : String;  //고객ID
    CustNM    : String;  //고객명
    JuID      : String; //주민번호 2011.06.01 msPark.
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

    StateCD    : String;       //상태코드
    StateSCD   : String;       //세부상태코드

    StateDT    : String;       //일자.

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
