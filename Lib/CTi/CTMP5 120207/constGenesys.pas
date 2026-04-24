{ **************************************************************************** }
{                                                                              }
{  설명 : 상수을 선언.                                                         }
{                                                                              }
{  작성자 : 이현호                                                             }
{  작성일자 : 2009-08-01                                                       }
{                                                                              }
{ **************************************************************************** }

unit constGENESYS;

interface

uses
    WinTypes, WinProcs, Messages, SysUtils, Classes, ActiveX;

type
    GenesysEventKind_Def = TOleEnum;

const
  RequestRegisterClient                    = 0;    // 0
  RequestQueryServer                       = 1;    // 1
  RequestQueryAddress                      = 2;    // 2
  RequestRegisterAddress                   = 3;    // 3
  RequestUnregisterAddress                 = 4;    // 4
  RequestRegisterAll                       = 5;    // 5
  RequestUnregisterAll                     = 6;    // 6
  RequestSetInputMask                      = 7;    // 7
  RequestAgentLogin                        = 8;    // 8
  RequestAgentLogout                       = 9;    // 9
  RequestAgentReady                        = 10;   // 10
  RequestAgentNotReady                     = 11;   // 11
  RequestSetDNDOn                          = 12;   // 12
  RequestSetDNDOff                         = 13;   // 13
  RequestMakeCall                          = 14;   // 14
  RequestMakePredictiveCall                = 15;   // 15
  RequestAnswerCall                        = 16;   // 16
  RequestReleaseCall                       = 17;   // 17
  RequestHoldCall                          = 18;   // 18
  RequestRetrieveCall                      = 19;   // 19
  RequestInitiateConference                = 20;   // 20
  RequestCompleteConference                = 21;   // 21
  RequestDeleteFromConference              = 22;   // 22
  RequestInitiateTransfer                  = 23;   // 23
  RequestMuteTransfer                      = 24;   // 24
  RequestSingleStepTransfer                = 25;   // 25 
  RequestCompleteTransfer                  = 26;   // 26
  RequestMergeCalls                        = 27;   // 27
  RequestAlternateCall                     = 28;  // 28
  RequestReconnectCall                     = 29;  // 29
  RequestAttachUserData                    = 30;  // 30
  RequestUpdateUserData                    = 31;  // 31
  RequestDeleteUserData                    = 32;  // 32
  RequestDeletePair                        = 33;  // 33
  RequestCallForwardSet                    = 34;  // 34
  RequestCallForwardCancel                 = 35;  // 35
  RequestRouteCall                         = 36;  // 36
  RequestGiveMusicTreatment                = 37;  // 37
  RequestGiveSilenceTreatment              = 38;  // 38
  RequestGiveRingBackTreatment             = 39;  // 39
  RequestLoginMailBox                      = 40;  // 40
  RequestLogoutMailBox                     = 41;  // 41
  RequestOpenVoiceFile                     = 42;  // 42
  RequestCloseVoiceFile                    = 43;  // 43
  RequestPlayVoiceFile                     = 44;  // 44
  RequestCollectDigits                     = 45;  // 45
  RequestSetMessageWaitingOn               = 46;  // 46
  RequestSetMessageWaitingOff              = 47;  // 47
  RequestDistributeUserEvent               = 48;  // 48
  RequestDistributeEvent                   = 49;  // 49
  EventServerConnected                     = 50;  // 50
  EventServerDisconnected                  = 51;  // 51
  EventError                               = 52;  // 52
  EventRegistered                          = 53;  // 53
  EventUnregistered                        = 54;  // 54
  EventRegisteredAll                       = 55;  // 55
  EventUnregisteredAll                     = 56;  // 56
  EventQueued                              = 57;  // 57
  EventDiverted                            = 58;  // 58
  EventAbandoned                           = 59;  // 59
  EventRinging                             = 60;  // 60
  EventDialing                             = 61;  // 61
  EventNetworkReached                      = 62;  // 62
  EventDestinationBusy                     = 63;  // 63
  EventEstablished                         = 64;  // 64
  EventReleased                            = 65;  // 65
  EventHeld                                = 66;  // 66
  EventRetrieved                           = 67;  // 67
  EventPartyChanged                        = 68;  // 68
  EventPartyAdded                          = 69;  // 69
  EventPartyDeleted                        = 70;  // 70
  EventRouteRequest                        = 71;  // 71
  EventRouteUsed                           = 72;  // 72
  EventAgentLogin                          = 73;  // 73
  EventAgentLogout                         = 74;  // 74
  EventAgentReady                          = 75;  // 75
  EventAgentNotReady                       = 76;  // 76
  EventDNDOn                               = 77;  // 77
  EventDNDOff                              = 78;  // 78
  EventMailBoxLogin                        = 79;  // 79
  EventMailBoxLogout                       = 80;  // 80
  EventVoiceFileOpened                     = 81;  // 81
  EventVoiceFileClosed                     = 82;  // 82
  EventVoiceFileEndPlay                    = 83;  // 83
  EventDigitsCollected                     = 84;  // 84
  EventAttachedDataChanged                 = 85;  // 85
  EventOffHook                             = 86;  // 86
  EventOnHook                              = 87;  // 87
  EventForwardSet                          = 88;  // 88
  EventForwardCancel                       = 89;  // 89
  EventMessageWaitingOn                    = 90;  // 90
  EventMessageWaitingOff                   = 91;  // 91
  EventAddressInfo                         = 92;  // 92
  EventServerInfo                          = 93;  // 93
  EventLinkDisconnected                    = 94;  // 94
  EventLinkConnected                       = 95;  // 95
  EventUserEvent                           = 96;  // 96   
  RequestSendDTMF                          = 97;  // 97
  EventDTMFSent                            = 98;  // 98
  EventResourceAllocated                   = 99;  // 99
  EventResourceFreed                       = 100; // 100
  EventRemoteConnectionSuccess             = 101; // 101
  EventRemoteConnectionFailed              = 102; // 102
  RequestRedirectCall                      = 103; // 103
  RequestListenDisconnect                  = 104; // 104
  RequestListenReconnect                   = 105; // 105
  EventListenDisconnected                  = 106; // 106
  EventListenReconnected                   = 107; // 107
  RequestQueryCall                         = 108; // 108
  EventPartyInfo                           = 109; // 109
  RequestClearCall                         = 110; // 110
  RequestSetCallInfo                       = 111; // 111
  EventCallInfoChanged                     = 112; // 112
  RequestApplyTreatment                    = 113; // 113
  EventTreatmentApplied                    = 114; // 114
  EventTreatmentNotApplied                 = 115; // 115
  EventTreatmentEnd                        = 116; // 116
  EventHardwareError                       = 117; // 117
  EventAgentAfterCallWork                  = 118; // 118
  EventTreatmentRequired                   = 119; // 119
  RequestSingleStepConference              = 120; // 120
  RequestQuerySwitch                       = 121; // 121
  EventSwitchInfo                          = 122; // 122
  RequestGetAccessNumber                   = 123; // 123
  RequestCancelReqGetAccessNumber          = 124;  //124
  EventAnswerAccessNumber                  = 125;  //125
  EventReqGetAccessNumberCanceled          = 126;  //126
  RequestReserveAgent                      = 127;  //127
  EventAgentReserved                       = 128;  //128
  RequestReserveAgentAndGetAccessNumber    = 129;  //129
  RequestAgentSetIdleReason                = 130;              //130
  EventAgentIdleReasonSet                  = 131;              //131
  EventRestoreConnection                   = 132;              //132
  EventPrimaryChanged                      = 133;              //133
  RequestLostBackupConnection              = 134;              //134
  RequestSetDNInfo                         = 135;              //135
  RequestQueryLocation                     = 136;              //136
  EventLocationInfo                        = 137;              //137
  EventACK                                 = 138;              //138
  RequestMonitorNextCall                   = 139;              //139
  RequestCancelMonitoring                  = 140;              //140
  EventMonitoringNextCall                  = 141;              //141
  EventMonitoringCancelled                 = 142;              //142
  RequestSetMuteOn                         = 143;              //143
  RequestSetMuteOff                        = 144;              //144
  EventMuteOn                              = 145;              //145
  EventMuteOff                             = 146;              //146
  EventDNOutOfService                      = 147;              //147
  EventDNBackInService                     = 148;              //148
  RequestPrivateService                    = 149;              //149
  EventPrivateInfo                         = 150;              //150
  MessageIDMAX                             = 151;              //151


type
  GenesysCallType_Def = TOleEnum;
const
  CallTypeUnknown    = 0; // 0
  CallTypeInternal   = 1; // 1
  CallTypeInbound    = 2; // 2
  CallTypeOutbound   = 3; // 3
  CallTypeConsult    = 4;  // 4


type
  GenesysWorkMode_Def = TOleEnum;
const
  AgentWorkModeUnknown  = 0; // 0
  AgentManualIn         = 1; // 1
  AgentAutoIn           = 2; // 2
  AgentAfterCallWork    = 3; // 3  AgentSetWork
  AgentAuxWork          = 4; // 4  AgentSetNotReady
  AgentNoCallDisconnect = 5; // 5

type
  GenesysStatus_Def = TOleEnum;
const
  Device_NotBusy  = 0; // 0
  Device_Busy    = 3; // 3  통화중

type
  GenesysCallState_Def = TOleEnum;
const
  CallStateOk                          =0;      // 0
  CallStateTransferred                 =1;      // 1
  CallStateConferenced                 =2;      // 2
  CallStateGeneralError                =3;      // 3
  CallStateSystemError                 =4;      // 4
  CallStateRemoteRelease               =5;      // 5
  CallStateBusy                        =6;      // 6
  CallStateNoAnswer                    =7;      // 7
  CallStateSitDetected                 =8;      // 8
  CallStateAnsweringMachineDetected    =9;      // 9
  CallStateAllTrunksBusy               =10;     // 10
  CallStateSitInvalidnum               =11;     // 11
  CallStateSitVacant                   =12;     // 12
  CallStateSitIntercept                =13;     // 13
  CallStateSitUnknown                  =14;     // 14
  CallStateSitNocircuit                =15;     // 15
  CallStateSitReorder                  =16;     // 16
  CallStateFaxDetected                 =17;     // 17
  CallStateQueueFull                   =18;     // 18
  CallStateCleared                     =19;     // 19
  CallStateOverflowed                  =20;     // 20
  CallStateAbandoned                   =21;     // 21
  CallStateRedirected                  =22;     // 22
  CallStateForwarded                   =23;     // 23
  CallStateConsult                     =24;     // 24
  CallStatePickedup                    =25;     // 25
  CallStateDropped                     =26;     // 26
  CallStateDroppednoanswer             =27;     // 27
  CallStateUnknown                     =28;     // 28
  CallStateCovered                     =29;     // 29 /* 5/5/98 */
  CallStateConverseOn                  =30;     // 30
  CallStateBridged                      =31;   // 31
  CallStateDeafened                     = 49; // added 9/15/99 by epi */   //32
  CallStateHeld                         = 50;  // (see common/gcti.h)  */   //33

implementation

end.




