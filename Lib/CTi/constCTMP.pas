{ **************************************************************************** }
{                                                                              }
{  설명 : 상수을 선언.                                                         }
{                                                                              }
{  작성자 : 백순종                                                             }
{  작성일자 : 2007-10-09                                                       }
{                                                                              }
{ **************************************************************************** }

unit constCTMP;

interface

uses
    WinTypes, WinProcs, Messages, SysUtils, Classes, variants, ActiveX;

const
    ctmpNormal                 =  1;
    ctmpAPIVersion             =  $30;
    ctmpNetWorkType            =  'TCPIP';
    ctmpAppName                =  'CTMPV3.0';
    ctmpDefPbx                 =  0;
    ctmpInvok                  =  0;
    TNotReady                  : array[1..9] of String = ('작업', '이석', '식사',
                                                          '휴식', '회의', '교육',
                                                          '', '', '');     //cccm을 통해서 설정한다.
    arraystart                 =  0;
    ctmpMaxAccountInfoLen      =  64;
    ctmpMaxApplLen             =  64;
    ctmpMaxAgentId             =  10;
    ctmpMaxDeviceLen           =  24;
    ctmpMaxErrorMSGLen         =  256;
    ctmpMaxIPAddrLen           =  15;
    ctmpMaxLogIDLen            =  16;
    ctmpMaxManufacturerLen     =  24;
    ctmpMaxNameLen             =  16;
    ctmpMaxNetLen              =  16;
    ctmpMaxPrivateDataElements =  3;
    ctmpMaxPrivateRawDataLen   =  128;
    ctmpMaxTimeStamp           =  15;
    ctmpMaxAttDataLen          =  1024;
    ctmpMaxSysDataLen          =  256;

    MAX_COUNT		               =  10;

    {  Function Code  }
    ctmpF_SwitchFN             = $41;		{ 'A' }
    ctmpF_ReportFN				     = $42;		{ 'B' }
    ctmpF_ComputingFN			     = $43;		{ 'C' }
    ctmpF_BidirectionFN		     = $44;		{ 'D' }
    ctmpF_PrivateFN				     = $45;		{ 'E' }
    ctmpF_ServerControlFN	     = $46;		{ 'F' }
    ctmpF_EventFN			   	     = $47;		{ 'G' }
    ctmpF_InputOutputFN		     = $48;		{ 'H' }
    ctmpF_VoiceUnitFN			     = $49;		{ 'I' }


    {  Service Code	 }
    { Switching }
    ctmpF_AlternateCall				 = 10;
    ctmpF_AnswerCall				   = 20;
    ctmpF_CallCompletion			 = 30;
    ctmpF_ClearCall					   = 31;{ ASAI }
    ctmpF_ClearConnection			 = 40;
    ctmpF_ConferenceCall			 = 50;
    ctmpF_ConsultationCall		 = 60;
    ctmpF_DivertDeflect				 = 81;
    ctmpF_DivertPickup				 = 82;
    ctmpF_DivertDirect				 = 83;
    ctmpF_HoldCall					   = 90;
    ctmpF_MakeCall					   = 101;
    ctmpF_MakePredictiveCall	 = 102;
    ctmpF_ReconnectCall				 = 110;
    ctmpF_RetrieveCall				 = 120;
    ctmpF_TransferCall				 = 130;
    ctmpF_AssociateData				 = 140;{ CSTA }
    ctmpF_ParkCall					   = 150;{ CSTA }
    ctmpF_SendDTMF						 = 160;{ CSTA }
    ctmpF_SingleStepConference = 171;{ CSTA }
    ctmpF_SingleStepTransfer	 = 172;{ CSTA }
    ctmpF_QueryAgentStatus		 = 201;
    ctmpF_QueryForward				 = 202;
    ctmpF_QueryDND						 = 203;
    ctmpF_QueryMessageWaiting	 = 204;
    ctmpF_QueryEnableRouting	 = 205;{ CSTA }
    ctmpF_QueryAutoAnswer			 = 206;{ CSTA }
    ctmpF_QueryMicroPhoneMute	 = 207;{ CSTA }
    ctmpF_QuerySpeakerMute		 = 208;{ CSTA }
    ctmpF_QuerySpeakerVolume	 = 209;{ CSTA }
    ctmpF_QueryDeviceInfo			 = 210;
    ctmpF_QueryLastNumber			 = 211;
    ctmpF_SetFeatureAgentStatus= 221;
    ctmpF_SetFeatureForward		 = 222;
    ctmpF_SetFeatureDND				 = 223;
    ctmpF_SetFeatureMessageWaiting	= 224;
    ctmpF_SetFeatureEnableRouting		= 225;{ CSTA }
    ctmpF_SetFeatureAutoAnswer			= 226;{ CSTA }
    ctmpF_SetFeatureMicroPhoneMute	= 227;{ CSTA }
    ctmpF_SetFeatureSpeakerMute			= 228;{ CSTA }
    ctmpF_SetFeatureSpeakerVolume		= 229;{ CSTA }

    { Reporting }
    ctmpF_ChangeMonitorFilter		  	= 10;
    ctmpF_GetEvent					    	  = 20;
    ctmpF_MonitorStart					    = 30;
    ctmpF_MonitorCall				        = 31; { ASAI }
    ctmpF_MonitorCallsViaDevice	    = 32; { ASAI }
    ctmpF_MonitorStop					      = 40;
    ctmpF_SnapshotCall				      = 50;
    ctmpF_SnapshotDevice			      = 60;
    ctmpF_GetMonitor					      = 70; { CSTA }
    ctmpF_GetApiCaps					      = 80; { ASAI }
    ctmpF_GetDeviceList				      = 90; { ASAI }
    ctmpF_QueryCallMonitor		      = 100;{ ASAI }

    { Computing }
    ctmpF_RouteRequest			        = 10; { CSTA }
    ctmpF_ReRoute						        = 20; { CSTA }
    ctmpF_RouteSelect				        = 30; { CSTA }
    ctmpF_RouteUsed					        = 40; { CSTA }
    ctmpF_RouteEnd					        = 50;
    ctmpF_RouteRegisterReg	        = 60; { ASAI }
    ctmpF_RouteRegisterCancel	   		= 70; { ASAI }

    { BiDirectional }
    ctmpF_Escape					   	      = 10;
    ctmpF_EscapeServiceConf		      = 11; { ASAI }
    ctmpF_SystemStatus				      = 20; { CSTA }
    ctmpF_SysStatReg					      = 21; { ASAI }
    ctmpF_SysStatStart				      = 22; { ASAI }
    ctmpF_SysStatStop					      = 23; { ASAI }
    ctmpF_ChangeSysStatFilter	      = 24; { ASAI }
    ctmpF_SysStatRegConf			      = 25; { ASAI }
    ctmpF_SysStatEvent				      = 26; { ASAI }
    ctmpF_SendPrivateEvent		      = 30; { ASAI }

    { Private }
    ctmpF_AddDevice						      = 10; { CSTA }
    ctmpF_CloseServer					      = 30;
    ctmpF_CurrentDn						      = 40; { CSTA }
    ctmpF_ErrMsg						        = 50; { CSTA }
    ctmpF_OpenServer				        = 70;
    ctmpF_RemoveDevice			        = 80; { CSTA }
    ctmpF_SetAgentFlag			        = 90;  //==> Api 에서는 Switch로 바꿈
    ctmpF_AgentReadyGet			        = 91;  //==> Api 에서는 Switch로 바꿈
    ctmpF_CallToCNID				        = 95; { CSTA }
    ctmpF_MultiAddDevice		        = 100;{ CSTA }
    ctmpF_QueryAgentStatusEx        = 110; //==> Api 에서는 Switch로 바꿈
    ctmpF_AttachData				        = 120;{ CSTA }
    ctmpF_WaitTimeGet				        = 130;{ CSTA }
    ctmpF_SystemData				        = 140;{ CSTA }
    ctmpF_AvortStream				        = 150;{ ASAI }

    { Server Control }
    ctmpF_SetLink						        = 10; { CSTA }
    ctmpF_SetMaxDevice			        = 20; { CSTA }
    ctmpF_SetTrace					        = 30; { CSTA }
    ctmpF_ShowClient				        = 40; { CSTA }
    ctmpF_ShowLink					        = 50; { CSTA }
    ctmpF_ShowVersion				        = 60; { CSTA }

    { Input / Output }
    ctmpF_StartDataPath			        = 10; { CSTA }
    ctmpF_StopDataPath			        = 20; { CSTA }
    ctmpF_SendData					        = 30; { CSTA }
    ctmpF_SendMulticastData	        = 40; { CSTA }
    ctmpF_SendBroadcaseData	        = 50; { CSTA }
    ctmpF_SuspendDataPath		        = 60; { CSTA }
    ctmpF_DataPathSuspended	        = 70; { CSTA }
    ctmpF_ResumeDataPath		        = 80; { CSTA }
    ctmpF_DataPathResume		        = 90; { CSTA }
    ctmpF_FastData					        = 100;{ CSTA }

    { Voice Unit }
    ctmpF_ConcatenateMessage        = 10; { CSTA }
    ctmpF_DeleteMessage			        = 20; { CSTA }
    ctmpF_PlayMessage				        = 30; { CSTA }
    ctmpF_QueryVoiceAttribute	      = 40; { CSTA }
    ctmpF_RecordMessage				      = 50; { CSTA }
    ctmpF_Reposition					      = 60; { CSTA }
    ctmpF_Resume						        = 70; { CSTA }
    ctmpF_Review						        = 80; { CSTA }
    ctmpF_SetVoiceAttributeSpeed		= 91; { CSTA }
    ctmpF_SetVoiceAttributeSpeakerVolume   = 92; { CSTA }
    ctmpF_SetVoiceAttributeRecordingLevel  = 93; { CSTA }
    ctmpF_Stop							        = 100;{ CSTA }
    ctmpF_Suspend						        = 110;{ CSTA }
    ctmpF_SynthesizeMessage		      = 120;{ CSTA }

type
    u_int   =  Cardinal; {1.0 :2바이트 2.0이후 4바이트}
    u_char  =  Byte;     {1바이트}
    short   =  Smallint; {signed 2바이트}
    u_short =  Word;     {2바이트}
    float   =  Single;   {실수형 4바이트}

    ctmpINT             = u_int;
    ctmpSHORT           = short;
    ctmpCHAR            = u_char;
    ctmpFLOAT           = float;
    ctmpGateID          = u_int;
    ctmpCallID          = u_int;
    ctmpInvokeID        = u_short;
    ctmpMonitorCrossID  = u_int;
    ctmpRoutingCrossID  = u_int;
    ctmpError           = u_int;
    ctmpIoRefID         = u_int;
    ctmpMessageID       = u_int;

type
    ctmpACSLevel_Def = TOleEnum;
const
    ACS_LEVEL1 = 1;
    ACS_LEVEL2 = 2;
    ACS_LEVEL3 = 3;
    ACS_LEVEL4 = 4;

//Call연결 예약
//연결되지 못한 Call을 수신자가 받을 수 있는 상황에 재 연결하는 기능이다.
type
    ctmpAction_Def = TOleEnum;
const
      ctmpK_BargeIn  = 100;
	    ctmpK_RingBack = 101;
	    ctmpK_capmOn   = 102;


type
    { Agent Filter (12XX) }
    ctmpAgentFilter_Def = TOleEnum;
const
	    ctmpF_LoggedOn              = 1;
	    ctmpF_LoggedOff             = 2;
	    ctmpF_NotReady              = 4;
	    ctmpF_Ready                 = 8;
	    ctmpF_WorkNotReady          = 16; { CSTA2 Removed }
	    ctmpF_WorkReady             = 32;
	    ctmpF_WorkingAfterCall      = 64;	{ CSTA2 Added }
	    ctmpF_Busy                  = 128;

//상담원 작업상태(ReasonCode)
type
    ctmpAgentMode_Def = TOleEnum;
const
	    ctmpV_AgentLogin            = 0;
	    ctmpV_AgentLogout           = 1;
	    ctmpV_AgentNotReady         = 2;
	    ctmpV_AgentReady            = 3;
	    ctmpV_AgentOtherWork        = 4;
	    ctmpV_AgentAfterCallWork    = 5;

type
    { MakePredictiveCall }
    ctmpAllocationState_Def = TOleEnum;
const
	    ctmpP_CallDelivered         = 0;
	    ctmpP_Established           = 1;

type
    ctmpAttributeToQuery_Def = TOleEnum;
const
	    ctmpV_EncodingAlgorithm     = 0;
	    ctmpV_SampleRate            = 1;
	    ctmpV_Duration              = 2;
	    ctmpV_FileName              = 3;
	    ctmpV_CurrentPosition       = 4;
	    ctmpV_CurrentSpeed          = 5;
	    ctmpV_CurrentVolume         = 6;
	    ctmpV_CurrentLevel          = 7;
	    ctmpV_CurrentState          = 8;

type
    { Call Filter (10XX) }
    ctmpCallFilter_Def = TOleEnum;
const
	    ctmpF_CallCleared           = 1;
	    ctmpF_Conferenced           = 2;
	    ctmpF_ConnectionCleared     = 4;
	    ctmpF_Delivered             = 8;
	    ctmpF_Diverted              = 16;
	    ctmpF_Established           = 32;
	    ctmpF_Failed                = 64;
	    ctmpF_Held                  = 128;
	    ctmpF_NetworkReached        = 256;
	    ctmpF_Originated            = 512;
	    ctmpF_Queued                = 1024;
	    ctmpF_Retrieved             = 2048;
	    ctmpF_ServiceInitiated      = 4096;
	    ctmpF_Transferrd            = 8192;

type
    ctmpConnectionID_Def = TOleEnum;
const
        STATIC_ID       = 0;
        DYNAMIC_ID      = 1;

type
    ctmpCTILink_Def = TOleEnum;
const
	    ctmpV_None      = 0;
	    ctmpV_ASAI      = 1;
	    ctmpV_Meridian  = 2;
	    ctmpV_CSTA1     = 3;
	    ctmpV_CSTA2     = 4;
	    ctmpV_CSTA3     = 5;

type
    ctmpDataPathDirection_Def = TOleEnum;
const
    	ctmpV_FromRequestor     = 0;
	    ctmpV_ToRequestor       = 1;
	    ctmpV_BiDirectional     = 2;

type
    ctmpDataPathType_Def = TOleEnum;
const
	    ctmpV_Text          = 0;
	    ctmpV_DigitalVoice  = 1;

type
    ctmpDeviceClass_Def = TOleEnum;
const
	    ctmpV_Voice         = $80;
	    ctmpV_Data          = $40;
	    ctmpV_Image         = $20;
	    ctmpV_OtherDevice   = $10;
	    ctmpV_Audio         = $08;
      ctmpV_Transfer      = 0;
      ctmpV_Conference    = 1;

type
    ctmpDeviceIDStatus_Def = TOleEnum;
const
        ID_PROVIDED         = 0;
        ID_NOT_KNOWN        = 1;
        ID_NOT_REQUIRED     = 2;

type
    ctmpDeviceIDType_Def = TOleEnum;
const
        DEVICE_IDENTIFIER                           = 0;
        IMPLICIT_PUBLIC                             = 20;
        EXPLICIT_PUBLIC_UNKNOWN                     = 30;
        EXPLICIT_PUBLIC_INTERNATIONAL               = 31;
        EXPLICIT_PUBLIC_NATIONAL                    = 32;
        EXPLICIT_PUBLIC_NETWORK_SPECIFIC            = 33;
        EXPLICIT_PUBLIC_SUBSCRIBER                  = 34;
        EXPLICIT_PUBLIC_ABBREVIATED                 = 35;
        IMPLICIT_PRIVATE                            = 40;
        EXPLICIT_PRIVATE_UNKNOWN                    = 50;
        EXPLICIT_PRIVATE_LEVEL3_REGIONAL_NUMBER     = 51;
        EXPLICIT_PRIVATE_LEVEL2_REGIONAL_NUMBER     = 52;
        EXPLICIT_PRIVATE_LEVEL1_REGIONAL_NUMBER     = 53;
        EXPLICIT_PRIVATE_PTN_SPECIFIC_NUMBER        = 54;
        EXPLICIT_PRIVATE_LOCAL_NUMBER               = 55;
        EXPLICIT_PRIVATE_ABBREVIATED                = 56;
        OTHER_PLAN                                  = 60;
        TRUNK_IDENTIFIER                            = 70;
        TRUNK_GROUP_IDENTIFIER                      = 71;

type
    { QueryDevice }
    ctmpDeviceType_Def = TOleEnum;
const
	    ctmpV_Station           = 0;
	    ctmpV_Line              = 1;
	    ctmpV_Button            = 2;
	    ctmpV_ACD               = 3;
	    ctmpV_Trunk             = 4;
	    ctmpV_Operator          = 5;
	    ctmpV_Other             = 6;
	    ctmpV_StationGroup      = 16;
	    ctmpV_LineGroup         = 17;
	    ctmpV_ButtonGroup       = 18;
	    ctmpV_ACDGroup          = 19;
	    ctmpV_TrunkGroup        = 20;
	    ctmpV_OperatorGroup     = 21;
	    ctmpV_OtherGroup        = 255;
	    ctmpV_ParkingDevice     = 22;	{ CSTA2 Added }

type
    ctmpEncodingAlgorithm_Def = TOleEnum;
const
	    ctmpV_ADPCM6K       = 0;
	    ctmpV_ADPCM8K       = 1;
	    ctmpV_MuLawPCM6K    = 2;
	    ctmpV_ALawPCM6K     = 3;

type
    ctmpError_Def = TOleEnum;
const
	    ctmpPbxErr                      = 1000;
	    ctmpUnspecCstaErr               = 1001;
	    ctmpCstaBadErr                  = 1002;
	    ctmpOpGeneric                   = 1101;
	    ctmpReqIncomWithObj             = 1102;
	    ctmpValueOutOfRange             = 1103;
	    ctmpObjectNotKnown              = 1104;
	    ctmpInvCallingDevice            = 1105;
	    ctmpInvCalledDevice             = 1106;
	    ctmpInvForwardingDest           = 1107;
	    ctmpPrivViolSpecDev             = 1108;
	    ctmpPrivViolCalledDev           = 1109;
	    ctmpPrivViolCallingDev          = 1110;
	    ctmpInvCallIdentifier           = 1111;
	    ctmpInvDevIdentifier            = 1112;
	    ctmpInvConnIdentifier           = 1113;
	    ctmpInvalidDest                 = 1114;
	    ctmpInvalidFeature              = 1115;
	    ctmpInvAllocState               = 1116;
	    ctmpInvCrossRefId               = 1117;
	    ctmpInvObjectType               = 1118;
	    ctmpSecurityViol                = 1119;
	    ctmpInvCSTAAppCor               = 1120;			{ CSTA2 Added }
	    ctmpAccountCode                 = 1121;
	    ctmpAuthCode                    = 1122;
	    ctmpReqIncCallingDev            = 1123;
	    ctmpReqIncCalledDev             = 1124;
	    ctmpInvMessageID                = 1125;
	    ctmpMessageIDReq                = 1126;
	    ctmpMediaIncompatible           = 1127;
	    ctmpStGeneric                   = 1201;
	    ctmpBadObjState                 = 1202;
	    ctmpInvConnIdActCall            = 1203;
	    ctmpNoActiveCall                = 1204;
	    ctmpNoHeldCall                  = 1205;
	    ctmpNoCallToClear               = 1206;
	    ctmpNoConnToClear               = 1207;
	    ctmpNoCallToAnswer              = 1208;
	    ctmpNoCallToComplete            = 1209;
	    ctmpNoAbleToPlay                = 1210;		  { CSTA2 Added }
	    ctmpNoAbleToResume              = 1211;
	    ctmpEndOfMessage                = 1212;
	    ctmpBeginOfMessage              = 1213;
	    ctmpMessageSuspended            = 1214;
	    ctmpSysGeneric                  = 1301;
	    ctmpServiceBusy                 = 1302;
	    ctmpResourceBusy                = 1303;
	    ctmpResOutOfServ                = 1304;
	    ctmpNetBusy                     = 1305;
	    ctmpNetOutOfServ                = 1306;
	    ctmpOverallMonLimEx             = 1307;
	    ctmpConfMemberLimEx             = 1308;
	    ctmpSubsGeneric                 = 1401;
	    ctmpObjMonLimEx                 = 1402;
	    ctmpExTrunkLimEx                = 1403;
	    ctmpOutstandReqLimEx            = 1404;
	    ctmpPerfGeneric                 = 1501;
	    ctmpPerfLimEx                   = 1502;
	    ctmpUnspecified                 = 1600;
	    ctmpSeqNumErr                   = 1601;
	    ctmpTimeStampErr                = 1602;
	    ctmpPacErr                      = 1603;
	    ctmpSealErr                     = 1604;
	    ctmpAlreadyAdded                = 2001;
	    ctmpAsn1DecodeErr               = 2002;
	    ctmpAsn1EncodeErr               = 2003;
	    ctmpDupOpenServer               = 2004;
	    ctmpFileOpenError               = 2005;
	    ctmpInvLicenseKey               = 2006;
	    ctmpIsCurrentDn                 = 2007;
	    ctmpIsOpenDn                    = 2008;
	    ctmpLibFail                     = 2009;
	    ctmpLinkConnectFail             = 2010;
	    ctmpLinkDown                    = 2011;
	    ctmpNotMemberDn                 = 2012;
	    ctmpNotOpen                     = 2013;
	    ctmpOpenLimitReached            = 2014;
	    ctmpTimeout                     = 2015;
	    ctmpTooManyOpens                = 2016;
	    ctmpUnknownErrCode              = 2017;
	    ctmpNotSupport                  = 2018;	//20000714
      ctmpCCSEFail                    = 2020; //20071018
      ctmpCCSELinkFailPbx             = 2021; //20071018
      ctmpCCSENoActPbx                = 2022; //20071018
	    ctmpAlreadyOpen                 = 3001;
	    ctmpBodyErr                     = 3002;
	    ctmpHeadErr                     = 3003;
	    ctmpInvAgentMode                = 3004;
	    ctmpInvDeviceType               = 3005;
	    ctmpInvDNDMode                  = 3006;
	    ctmpInvGate                     = 3007;
	    ctmpInvNetType                  = 3008;
	    ctmpInvParam                    = 3009;
	    ctmpNoEvent                     = 3010;
	    ctmpNotOn                       = 3011;
	    ctmpRpcConnectFail              = 3012;
	    ctmpServerTimeOut               = 3013;
	    ctmpServerUnknown               = 3014;
	    ctmpUnsupAPIversion             = 3015;
	    ctmpUnsupProc                   = 3016;
	    ctmpAcseTimeout                 = 3017;
	    ctmpNotCicrLoad                 = 3018;
	    ctmpAgentIdNotFound             = 3019;
	    ctmpInvalidInvokeId             = 3020;
	    ctmpDataNotFound                = 3021;
	    ctmpDifferentData               = 3022;
	    ctmpExistData                   = 3023;
	    ctmpUsingData                   = 3024;
	    ctmpDataFull                    = 3025;
	    ctmpInvDN                       = 3026;	//20000714
	    ctmpTooManyMultiAddDeviceDn     = 3040;
	    ctmpStartReceiveErr             = 3041;
      ctmpEtc                         = 9999; //20071120 추가

//콜이벤트 발생 원인
type
    ctmpEventCallCause_Def = TOleEnum;
const
	    ctmpV_AddedParty            = 1;
	    ctmpV_AlertingDevice        = 2;
	    ctmpV_AnsweringDevice       = 3;
	    ctmpV_CalledNumber          = 4;
	    ctmpV_CallingDevice         = 5;
	    ctmpV_ConfController        = 6;
	    ctmpV_DivertingDevice       = 7;
	    ctmpV_FailedDevice          = 8;
	    ctmpV_HoldingDevice         = 9;
	    ctmpV_LastRedirection       = 10;
	    ctmpV_ReleasingDevice       = 11;
	    ctmpV_RetrievingDevice      = 12;
	    ctmpV_TransferringDevice    = 13;
	    ctmpV_TrunkUsed             = 14;

//이벤트 발생원인
type
    ctmpEventCauses_Def = TOleEnum;
const
	    ctmpEC_ActiveMonitor                = 1;
	    ctmpEC_Alternate                    = 2;
	    ctmpEC_Busy                         = 3;
	    ctmpEC_CallBack                     = 4;
	    ctmpEC_CallCancelled                = 5;
	    ctmpEC_CallForwardAlways            = 6;
	    ctmpEC_CallForwardBusy              = 7;
	    ctmpEC_CallForwardNoAnswer          = 8;
	    ctmpEC_CallForward                  = 9;
	    ctmpEC_CallNotAnswered              = 10;
	    ctmpEC_CallPickup                   = 11;
	    ctmpEC_CampOn                       = 12;
	    ctmpEC_DestNotObtainable            = 13;
	    ctmpEC_DoNotDisturb                 = 14;
	    ctmpEC_IncompatibleDestination      = 15;
	    ctmpEC_InvalidAccountCode           = 16;
	    ctmpEC_KeyConference                = 17;
	    ctmpEC_Lockout                      = 18;
	    ctmpEC_Maintenance                  = 19;
	    ctmpEC_NetworkCongestion            = 20;
	    ctmpEC_NetworkNotObtainable         = 21;
	    ctmpEC_NewCall                      = 22;
	    ctmpEC_NoAvailableAgents            = 23;
	    ctmpEC_Override                     = 24;
	    ctmpEC_Park                         = 25;
	    ctmpEC_Overflow                     = 26;
	    ctmpEC_Recall                       = 27;
	    ctmpEC_Redirected                   = 28;
	    ctmpEC_ReorderTone                  = 29;
	    ctmpEC_ResourcesNotAvailable        = 30;
	    ctmpEC_SilentMonitor                = 31;
	    ctmpEC_Transfer                     = 32;
	    ctmpEC_TrunksBusy                   = 33;
	    ctmpEC_VoiceUnitInitiator           = 34;
	    ctmpEC_Blocked                      = 35;{CSTA2 Added }
	    ctmpEC_CharCountReached             = 36;
	    ctmpEC_Consultation                 = 37;
	    ctmpEC_Distributed                  = 38;
	    ctmpEC_DTMFToneDetected             = 39;
	    ctmpEC_DurationExceeded             = 40;
	    ctmpEC_EndOfDataDetected            = 41;
	    ctmpEC_EnteringDistribution         = 42;
	    ctmpEC_ForcedPause                  = 43;
	    ctmpEC_MakeCall                     = 44;
	    ctmpEC_MessageSizeExceeded          = 45;
	    ctmpEC_NetworkSignal                = 46;
	    ctmpEC_NextMessage                  = 47;
	    ctmpEC_NormalClearing               = 48;
	    ctmpEC_NoSpeechDetected             = 49;
	    ctmpEC_NumberChanged                = 50;
	    ctmpEC_SingleStepConference         = 51;
	    ctmpEC_SingleStepTransfer           = 52;
	    ctmpEC_SpeechDetected               = 53;
	    ctmpEC_SwitchTerminated             = 54;
	    ctmpEC_TerminationChangeReceived    = 55;
	    ctmpEC_TimeOut                      = 56;

//이벤트 종류
type
    ctmpEventKind_Def = TOleEnum;
const
	    ctmpEK_CallCleared              = 1;
	    ctmpEK_Confernced               = 2;
	    ctmpEK_ConnectionCleared        = 3;
	    ctmpEK_Delivered                = 4;
	    ctmpEK_Diverted                 = 5;
            ctmpEK_Popup                    = 254;
	    ctmpEK_Established              = 6;
	    ctmpEK_Failed                   = 7;
	    ctmpEK_Held                     = 8;
	    ctmpEK_NetworkReached           = 9;
	    ctmpEK_Originated               = 10;
	    ctmpEK_Queued                   = 11;
	    ctmpEK_Retrieved                = 12;
	    ctmpEK_ServiceInitated          = 13;
	    ctmpEK_Transferred              = 14;
	    ctmpEK_CallInformation          = 101;
	    ctmpEK_DoNotDisturb             = 102;
	    ctmpEK_Forwarding               = 103;
	    ctmpEK_MessageWaiting           = 104;
	    ctmpEK_AutoAnswer               = 105;{CSTA2}
	    ctmpEK_MicrophoneMute           = 106;{CSTA2}
	    ctmpEK_SpeakerMute              = 107;{CSTA2}
	    ctmpEK_SpeakerVolume            = 108;{CSTA2}
	    ctmpEK_LoggedOn                 = 201;
	    ctmpEK_LoggedOff                = 202;
	    ctmpEK_NotReady                 = 203;
	    ctmpEK_Ready                    = 204;
	    ctmpEK_OtherWork                = 205;
	    ctmpEK_AfterCallWork            = 206;
	    ctmpEK_BackInService            = 23;{CSTA2}
	    ctmpEK_OutOfService             = 24;{CSTA2}
	    ctmpEK_Private                  = 25;{CSTA2}
	    ctmpEK_VoiceUnitPlay            = 41;{CSTA2}
	    ctmpEK_VoiceUnitRecord          = 42;{CSTA2}
	    ctmpEK_VoiceUnitReview          = 43;{CSTA2}
	    ctmpEK_VoiceUnitStop            = 44;{CSTA2}
	    ctmpEK_VoiceUnitSuspendPlay     = 45;{CSTA2}
	    ctmpEK_VoiceUnitSuspendRecord   = 46;{CSTA2}
	    ctmpEK_VoiceUnitAttributeChange = 47;{CSTA2}
	    ctmpEK_MonitorEnded             = 61;{ASAI}
	    ctmpEK_PrivateStatus            = 63;{ASAI}
	    ctmpEK_SysStat                  = 65;{ASAI}
	    ctmpEK_SysStatEnded             = 66;{ASAI}
	    ctmpEK_RouteRegisterAbort       = 71;{ASAI}
            ctmpEK_RouteRequest             = 72;{ASAI}
	    ctmpEK_RouteEnd                 = 73;{ASAI}
            ctmpEK_PwdConfirm               = 252;  //* 2008.07.07 skkim add ars event make */
	    ctmpEK_CCSEDown                 = 999;{ for CCSE Down by dwlim 990127 req kcpark }

type
    ctmpFailCall_Def = TOleEnum;
const
	    ctmpV_CampOn    = 0;
	    ctmpV_RingBack  = 1;
	    ctmpV_Intrude   = 2;


type
    ctmpFeature_Def = TOleEnum;
const
        FT_CAMP_ON      = 0;
        FT_CALL_BACK    = 1;
        FT_INTRUDE      = 2;

type
    { Feature Filter (11XX) }
    ctmpFeatureFilter_Def = TOleEnum;
const
	    ctmpF_CallInformation   = 1;
	    ctmpF_DoNotDisturb      = 2;
	    ctmpF_Forwarding        = 4;
	    ctmpF_MessageWaiting    = 8;
	    ctmpF_AutoAnswer        = 16;{ CSTA2 Added }
	    ctmpF_MicrophoneMute    = 32;
	    ctmpF_SpeakerMute       = 64;
	    ctmpF_SpeakerVolume     = 128;

//착신전환 변경
type
    ctmpForward_Def = TOleEnum;
const
	    ctmpC_ImmediateOn       = 0;
	    ctmpC_ImmediateOff      = 1;
	    ctmpC_BusyOn            = 2;
	    ctmpC_BusyOff           = 3;
	    ctmpC_NoAnsOn           = 4;
	    ctmpC_NoAnsOff          = 5;
	    ctmpC_BusyIntOn         = 6;
	    ctmpC_BusyIntOff        = 7;
	    ctmpC_BusyExtOn         = 8;
	    ctmpC_BusyExtOff        = 9;
	    ctmpC_NoAnsIntOn        = 10;
	    ctmpC_NoAnsIntOff       = 11;
	    ctmpC_NoAnsExtOn        = 12;
	    ctmpC_NoAnsExtOff       = 13;
	    ctmpC_ImmIntOn          = 14;{ CSTA2 Added }
	    ctmpC_ImmIntOff         = 15;
	    ctmpC_ImmExtOn          = 16;
	    ctmpC_ImmExtOff         = 17;

type
    ctmpGateMode_Def = TOleEnum;
const
	    ctmpV_Dn            = 0;
	    ctmpV_RoutePoint    = 1;
	    ctmpV_MonitorGate   = 2;
	    ctmpV_Manager       = 9;

type
    ctmpInvokeIDType_Def = TOleEnum;
const
	    APP_GEN_ID = 0;{ application will provide invokeIDs; any 4-byte value is legal  }
	    LIB_GEN_ID = 1;{ library will generate invokeIDs in the range 1-32767           }

type
    ctmpLevel_Def = TOleEnum;
const
        ctmp_HOME_WORK_TOP          = 1;
        ctmp_AWAY_WORK_TOP          = 2;
        ctmp_DEVICE_DEVICE_MONITOR  = 3;
        ctmp_CALL_DEVICE_MONITOR    = 4;
        ctmp_CALL_CONTROL           = 5;
        ctmp_ROUTING                = 6;
        ctmp_CALL_CALL_MONITOR      = 7;

//전화기 상태
type
    ctmpLocalConnectState_Def = TOleEnum;
const
	    ctmpES_Null         = 0;     //
	    ctmpES_Initiate     = 1;
	    ctmpES_Altering     = 2;
	    ctmpES_Connect      = 3;
	    ctmpES_Hold         = 4;
	    ctmpES_Queued       = 5;
	    ctmpES_Fail         = 6;

type
    { Maintenance Filter (13XX) }
    ctmpMaintenanceFilter_Def = TOleEnum;
const
	    ctmpF_BackInService = 1;
	    ctmpF_OutOfService  = 2;

//상담원 Blending Mode.
type
    ctmpMode_Def = TOleEnum;
const
	    ctmpV_Off   = 0;
	    ctmpV_On    = 1;

type
    { SingleStepConference }
    ctmpParticipationType_Def = TOleEnum;
const
	    ctmpV_Slient = 0;
	    ctmpV_Active = 1;

type
    ctmpProtocolType_Def = TOleEnum;
const
	    ctmpK_None          = 0;
	    ctmpK_MeridianLink  = 1;
	    ctmpK_CstaPrivate   = 2;

type
    ctmpQueryDeviceFeature_Def = TOleEnum;
const
	    ctmpV_MsgWaitingOn      = 0;
	    ctmpV_DoNotDisturbOn    = 1;
	    ctmpV_Forward           = 2;
	    ctmpV_LastDialed        = 3;
	    ctmpV_DeviceInfo        = 4;
	    ctmpV_AgentState        = 5;
	    ctmpV_RoutingEnabled    = 6; {CSTA2}
	    ctmpV_AutoAnswer        = 7; {CSTA2}
	    ctmpV_MicrophoneMuteOn  = 8; {CSTA2}
	    ctmpV_SpeakerMuteOn     = 9; {CSTA2}
	    ctmpV_SpeakerVolume     = 10;{CSTA2}

type
    ctmpServerTrace_Def = TOleEnum;
const
	    ctmpV_NormalTrace   = 1;
	    ctmpV_NetworkTrace  = 2;
	    ctmpV_FullTrace     = 3;

type
    ctmpServerVersion_Def = TOleEnum;
const
	    ctmpV_CTMPV20 = $20;
	    ctmpV_CTMPV30 = $30;

type
    ctmpSex_Def = TOleEnum;
const
	    ctmpV_Male      = 0;
	    ctmpV_Female    = 1;

type
    ctmpSimpleCallState_Def = TOleEnum;
const
	    ctmpSS_CallNull                 = 0;
	    ctmpSS_CallPending              = 1;
	    ctmpSS_CallOriginated           = 3;
	    ctmpSS_CallDelivered            = 35;
	    ctmpSS_CallDeliveredHeld        = 36;
	    ctmpSS_CallReceived             = 50;
	    ctmpSS_CallEstablished          = 51;
	    ctmpSS_CallEstablishedHeld      = 52;
	    ctmpSS_CallReceivedOnHold       = 66;
	    ctmpSS_CallEstablishedOnHold    = 67;
	    ctmpSS_CallQueued               = 83;
	    ctmpSS_CallQueuedHeld           = 84;
	    ctmpSS_CallFailed               = 99;
	    ctmpSS_CallFailedHeld           = 100;

type
    ctmpState_Def = TOleEnum;
const
	    ctmpV_Stop              = 0;
	    ctmpV_Play              = 1;
	    ctmpV_Record            = 2;
	    ctmpV_SuspendPlay       = 3;
	    ctmpV_SuspendRecord     = 4;
	    ctmpV_Review            = 5;

type
    ctmpStreamType_Def = TOleEnum;
const
        ST_CSTA         = 1;
        ST_OAM          = 2;
        ST_DIRECTORY    = 3;
        ST_NMSRV        = 4;

type
    ctmpSyncMode_Def = TOleEnum;
const
	    ctmpV_SYNC  = 1;
	    ctmpV_ASYNC = 2;

type
    ctmpSystemStatus_Def = TOleEnum;
const
	    ctmpV_Initaliziong      = 0;
	    ctmpV_Enabled           = 1;
	    ctmpV_Normal            = 2;
	    ctmpV_MessageLost       = 3;
	    ctmpV_Disabled          = 4;
	    ctmpV_OverloadImminent  = 5;
	    ctmpV_OverloadReached   = 6;
	    ctmpV_Relieved          = 7;

type
    ctmpTermination_Def = TOleEnum;
const
	    ctmpV_DurationExceeded  = 0;
	    ctmpV_DTMFDetected      = 1;
	    ctmpV_EndOfDataDetected = 2;
	    ctmpV_SpeechDetected    = 3;

type
    { Voice Unit Filter (14XX)    CSTA2 Added }
    ctmpVoiceUnitFilter_Def = TOleEnum;
const
	    ctmpF_VoiceStop         = 1;{ CSTA2 Addend }
	    ctmpF_Play              = 2;
	    ctmpF_SuspendPlay       = 4;
	    ctmpF_Record            = 8;
	    ctmpF_SuspendRecord     = 16;
	    ctmpF_VoiceReview       = 32;
	    ctmpF_VoiceAttrChange   = 64;

//로그온 후 어떠한 작업모드를 가질지를 결정한다. 교환기에서 직접 설정하는 경우도 있다.
type
    ctmpWorkMode_Def = TOleEnum;
const
        ctmp_AUX_WORK   = 1;
        ctmp_AFTCAL_WK  = 2;    //After Call Work 상태
        ctmp_AUTO_IN    = 3;    //Ready 상태.
        ctmp_MANUAL_IN  = 4;    //Not Ready 상태

const
	ctmpV_BeginingOfMessage	 = 0;
    ctmpV_EndOfMessage		 = 1;

type
    ctmpAgentType_Def = TOleEnum;
const
        ctmpV_NotUse  = 0;
        ctmpV_PSTN    = 1;
        ctmpV_WEB     = 2;
        ctmpV_PSTNWEB = 3;


type
    
    ctmpAccountInfo        = array[0..ctmpMaxAccountInfoLen-1] of    u_char;
    ctmpApplString         = array[0..ctmpMaxApplLen-1] of           Ansichar;
    ctmpApplStringbyte     = array[0..ctmpMaxApplLen-1] of           byte;
    ctmpDeviceString       = array[0..ctmpMaxDeviceLen-1] of         Ansichar;
    ctmpErrorMSG           = array[0..ctmpMaxErrorMSGLen-1] of       Ansichar;
    ctmpIpAddr             = array[0..ctmpMaxIPAddrLen-1] of         Ansichar;
    ctmpLogIdString        = array[0..ctmpMaxLogIDLen-1] of          Ansichar;
    ctmpManufacturerString = array[0..ctmpMaxManufacturerLen-1] of   Ansichar;
    ctmpNameString         = array[0..ctmpMaxNameLen-1] of           Ansichar;
    ctmpNetString          = array[0..ctmpMaxNetLen-1] of            Ansichar;
    ctmpPrivateString      = array[0..ctmpMaxPrivateRawDataLen-1] of Ansichar;
    ctmpIOData             = array[0..ctmpMaxErrorMSGLen-1] of       Ansichar;
    ctmpDataString         = array[0..ctmpMaxAttDataLen-1] of        Ansichar;

var
    ctmpMyDn  :string;

implementation

end.




