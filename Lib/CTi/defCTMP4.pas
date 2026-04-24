{ **************************************************************************** }
{                                                                              }
{  설명 : dll을 선언.                                                          }
{                                                                              }
{  작성자 : 백순종                                                             }
{  작성일자 : 2007-10-09                                                       }
{                                                                              }
{ **************************************************************************** }

unit defCTMP4;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Graphics, StdCtrls, Dialogs, syncobjs, winsock, varCTMP4, constCTMP4;

const
  DLLNAME='CAPI4.DLL';

{ CTMP API}

{  Switching Service }

//*	CAPI끼리 msg전달용 */
function ctmpSendMsg( gate            : ctmpGateID;
                      invokeID        : ctmpInvokeID;
                      appName         : ctmpApplString;
                      var UEI         : ctmpUEI;
                      var CI          : ctmpCI;
                      var privateData : ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpAgentReadyGet( gate            : ctmpGateID;
                            invokeID        : ctmpInvokeID;
                            AgentGroup      : ctmpSHORT;
                            AgentPart       : ctmpSHORT;
                            MaxCount        : ctmpSHORT;
                            var readyAgent  : TReadyAgent;
                            var pReadCount  : u_int) :u_int; stdcall; external DLLNAME;

function ctmpAgentReadyGetEx( gate            : ctmpGateID;
                              invokeID        : ctmpInvokeID;
                              AgentGroup      : ctmpSHORT;
                              AgentPart       : ctmpSHORT;
                              MaxCount        : ctmpSHORT;
                              var readyAgent  : TReadyAgentEx;
                              var pReadCount  : u_int) :u_int; stdcall; external DLLNAME;

function ctmpAgentReadyGetCount(gate            : ctmpGateID;
				invokeID        : ctmpInvokeID;
				AgentGroup      : ctmpSHORT;
				AgentPart       : ctmpSHORT;
				maxCount        : ctmpSHORT;
                                var readCount   : ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpAgentReadyGetValue (gate            : ctmpGateID;
				invokeID         : ctmpInvokeID;
				count            : ctmpSHORT;
                                var agentId      : ctmpINT;
			        var deviceDN     : ctmpINT;
			        var blendMode    : ctmpMode_Def;
			        var continueTime : ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpAlternateCall( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            var heldCall        :ctmpConnectionID;
                            var activeCall      :ctmpConnectionID;
                            var ctmpPrivateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


function ctmpAnswerCall( gate               :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var alertingCall   :ctmpConnectionID;
                         var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;



{ CSTA only }

function ctmpAssociateData( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            var call        :ctmpConnectionID;
                            UUI             :ctmpApplString;
                            accountCode     :ctmpApplString;
                            authCode        :ctmpApplString) :u_int; stdcall; external DLLNAME;

function ctmpAgentBusyGet ( gate             : ctmpGateID;
                            invokeID         : ctmpInvokeID;
                            AgentGroup       : ctmpSHORT;
                            AgentPart        : ctmpSHORT;
                            MaxCount         : ctmpSHORT;
                            var busyAgent    : TReadyBusy;
                            var pReadCount   : u_int) :u_int; stdcall; external DLLNAME;

function ctmpAgentBusyGetCount( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                AgentGroup      :ctmpSHORT;
                                AgentPart       :ctmpSHORT;
                                MaxCount        :ctmpSHORT;
                                var readCount   :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpAgentBusyGetValue( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                count           :ctmpSHORT;
                                var agentID     :ctmpINT;
                                var deviceDN    :ctmpINT;
                                var blendMode   :ctmpMode_Def;
                                var continueTime  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpCallCompletion( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
//                             feature            :ctmpFeature_Def;
                             var call           :ctmpConnectionID;
                             action             :ctmpAction_Def;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpClearCall( gate            :ctmpGateID;
                        invokeID        :ctmpInvokeID;
                        var call        :ctmpConnectionID;
                        var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpClearConnection( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              var call          :ctmpConnectionID;
                              var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpConferenceCall( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             var heldCall       :ctmpConnectionID;
                             var activeCall     :ctmpConnectionID;
                             var newCall        :ctmpConnectionID;
                             var callList       :ctmpConnectionList;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpConsultationCall( gate                 :ctmpGateID;
                               invokeID             :ctmpInvokeID;
                               var call             :ctmpConnectionID;
                               calledNumber         :ctmpDeviceString;
                               calledClass          :ctmpDeviceClass_Def;
                               UUI                  :ctmpApplString;
                               accountCode          :ctmpApplString;
                               authCode             :ctmpApplString;
                               var newCall          :ctmpCallID;
                               var UEI              :ctmpUEI;
                               var CI               :ctmpCI;
                               var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


function ctmpDivertDeflect( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            var call        :ctmpConnectionID;
                            divertDn        :ctmpDeviceString;
                            UUI             :ctmpApplString;
                            var UEI         :ctmpUEI;
                            var CI          :ctmpCI;
                            var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpDivertDirect( gate                 :ctmpGateID;
                           invokeID             :ctmpInvokeID;
                           var call             :ctmpConnectionID;
                           divertedDn           :ctmpDeviceString;
                           UUI                  :ctmpApplString;
                           var UEI              :ctmpUEI;
                           var CI               :ctmpCI;
                           var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpDivertPickup( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           var call         :ctmpConnectionID;
                           divertDn         :ctmpDeviceString;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpDivertNoRet( gate                 :ctmpGateID;
                          invokeID             :ctmpInvokeID;
                          divertedDn           :ctmpINT;
                          UUI                  :ctmpApplString;
                          agentID              :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpHoldCall( gate                 :ctmpGateID;
                       invokeID             :ctmpInvokeID;
                       var call             :ctmpConnectionID;
                       reservation          :ctmpCHAR;
                       var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpMakeCall( gate                 :ctmpGateID;
                       invokeID             :ctmpInvokeID;
                       callingNumber        :ctmpDeviceString;
                       calledNumber         :ctmpDeviceString;
                       UUI                  :ctmpApplString;
                       accountCode          :ctmpApplString;
                       authCode             :ctmpApplString;
                       var newCall          :ctmpConnectionID;
                       var UEI              :ctmpUEI;
                       var CI               :ctmpCI;
                       var privateData      :ctmpPrivateData) :u_int ; stdcall; external DLLNAME;

function ctmpMakePredictiveCall( gate                   :ctmpGateID;
                                 invokeID               :ctmpInvokeID;
                                 callingNumber          :ctmpDeviceString;
                                 calledNumber           :ctmpDeviceString;
                                 calledClass            :ctmpDeviceClass_Def;
                                 allocation             :ctmpAllocationState_Def;
                                 numberOfRings          :ctmpINT;
                                 UUI                    :ctmpApplString;
                                 accountCode            :ctmpApplString;
                                 authCode               :ctmpApplString;
                                 var newCall            :ctmpConnectionID;
                                 var privateData        :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpObservationCall(gate           :ctmpGateID;
                             invokeID       :ctmpInvokeID;
			     callingNumber  :ctmpDeviceString;
			     calledNumber   :ctmpDeviceString;
                             UUI            :ctmpApplString;
                             accountCode    :ctmpApplString;
			     authCode       :ctmpApplString;
			     var newCall    :ctmpConnectionID;
			     var UEI        :ctmpUEI;
			     var CI         :ctmpCI;
			     var privateData:ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpObservationTalkCall(gate           :ctmpGateID;
				 invokeID       :ctmpInvokeID;
				 callingNumber  :ctmpDeviceString;
				 calledNumber   :ctmpDeviceString;
                                 UUI            :ctmpApplString;
				 accountCode    :ctmpApplString;
				 authCode       :ctmpApplString;
				 var newCall    :ctmpConnectionID;
				 var UEI        :ctmpUEI;
                                 var CI         :ctmpCI;
				 var privateData:ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpOneStepTransfer( gate                 :ctmpGateID;
                              invokeID             :ctmpInvokeID;
                              var call             :ctmpConnectionID;
                              calledNumber         :ctmpDeviceString;
                              UUI                  :ctmpApplString;
                              var newCall          :ctmpConnectionID;
                              var UEI              :ctmpUEI;
                              var CI               :ctmpCI;
                              var privateData      :ctmpPrivateData) :u_int ; stdcall; external DLLNAME;

function ctmpOneStepConference( gate                 :ctmpGateID;
                                invokeID             :ctmpInvokeID;
                                var call             :ctmpConnectionID;
                                calledNumber         :ctmpDeviceString;
                                calledClass          :ctmpDeviceClass_Def;
                                UUI                  :ctmpApplString;
                                var newCall          :ctmpConnectionID;
                                var UEI              :ctmpUEI;
                                var CI               :ctmpCI;
                                var privateData      :ctmpPrivateData) :u_int ; stdcall; external DLLNAME;

{ CSTA only }

function ctmpParkCall( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       var call         :ctmpConnectionID;
                       parkCall         :ctmpDeviceString;
                       parkDeviceClass  :ctmpDeviceClass_Def;
                       UUI              :ctmpApplString) :u_int; stdcall; external DLLNAME;


function ctmpQueryAgentStatus( gate             :ctmpGateID;
                               invokeID         :ctmpInvokeID;
                               deviceDN         :ctmpDeviceString;
                               var agentMode    :ctmpAgentMode_Def;
                               agentID          :ctmpDeviceString;
                               var reasonCode   :ctmpINT;
                               var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpQueryMailAgentStatus( gate             :ctmpGateID;
                                   invokeID         :ctmpInvokeID;
                                   var agentMode    :ctmpAgentMode_Def;
                                   agentID          :ctmpDeviceString;
                                   var reasonCode   :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpQueryAgentStatusEx( gate                       :ctmpGateID;
                                 invokeID                   :ctmpInvokeID;
				 agentID                    :ctmpINT;
                                 deviceDN                   :ctmpINT;
                                 var queryAgentID           :ctmpINT;
                                 var queryAgentMode         :ctmpAgentMode_Def;
                                 var queryAgentDN           :ctmpINT;
                                 var queryAgentblendMode    :ctmpMode_Def;
                                 var queryAgentblockMode    :ctmpMode_Def;
                                 var queryAgentTime         :ctmpINT;
                                 var queryAgentType         :ctmpAgentType_Def;
                                 centerid                   :ctmpCHAR=0) :u_int; stdcall; external DLLNAME;

function ctmpQueryAutoAnswer( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              deviceDN          :ctmpDeviceString;
                              var answerMode    :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpQueryDeviceDND( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             deviceDN           :ctmpDeviceString;
                             var DNDMode        :ctmpMode_Def;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpQueryDeviceForward( gate               :ctmpGateID;
                                 invokeID           :ctmpInvokeID;
                                 deviceDN           :ctmpDeviceString;
                                 var forwardMode    :ctmpMode_Def;
                                 forwardDn          :ctmpDeviceString;
                                 var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


function ctmpQueryDeviceInfo( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              deviceDN          :ctmpDeviceString;
                              queryDN           :ctmpDeviceString;
                              var deviceType    :ctmpDeviceType_Def;
                              var deviceClass   :ctmpDeviceClass_Def;
                              var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpQueryMessageWaiting( gate                      :ctmpGateID;
                                  invokeID                  :ctmpInvokeID;
                                  deviceDN                  :ctmpDeviceString;
                                  var messageWaitingMode    :ctmpMode_Def;
                                  var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpEnableRouting( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            deviceDN            :ctmpDeviceString;
                            var routeMode       :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpQueryLastNumber( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              deviceDN          :ctmpDeviceString;
                              lastNumber        :ctmpDeviceString;
                              var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpQueryMicrophoneMute( gate              :ctmpGateID;
                                  invokeID          :ctmpInvokeID;
                                  deviceDN          :ctmpDeviceString;
                                  var micmuteMode   :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpQuerySpeakerMute( gate                 :ctmpGateID;
                               invokeID             :ctmpInvokeID;
                               deviceDN             :ctmpDeviceString;
                               var speakmuteMode    :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpQuerySpeakerVolume( gate               :ctmpGateID;
                                 invokeID           :ctmpInvokeID;
                                 deviceDN           :ctmpDeviceString;
                                 var speakerVolume  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpReconnectCall( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            var heldCall        :ctmpConnectionID;
                            var activeCall      :ctmpConnectionID;
                            var privateData     :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpRetrieveCall( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           var call         :ctmpConnectionID;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ CSTA only }
function ctmpSendDTMF( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       var call         :ctmpConnectionID;
                       DTMFdigits       :ctmpDeviceString;
                       ToneDuration     :ctmpINT;
                       PauseDuration    :ctmpINT) :u_int; stdcall; external DLLNAME;

{ CSTA only }
function ctmpSetAgentFlag( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           agentID          :ctmpINT;
                           waitMode         :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureAgentStatus( gate            :ctmpGateID;
                                    invokeID        :ctmpInvokeID;
                                    deviceDN        :ctmpDeviceString;
                                    agentMode       :ctmpAgentMode_Def;
                                    agentID         :ctmpDeviceString;
                                    agentData       :ctmpDeviceString;
                                    agentGroup      :ctmpDeviceString;
                                    reasoncode      :ctmpINT;
                                    workMode        :ctmpWorkMode_Def;
                                    var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureMailAgentStatus( gate            :ctmpGateID;
                                        invokeID        :ctmpInvokeID;
                                        deviceDN        :ctmpDeviceString;
                                        agentMode       :ctmpAgentMode_Def;
                                        agentGroup      :ctmpDeviceString;
                                        agentPart       :ctmpDeviceString;
                                        reasoncode      :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureAutoAnswer( gate             :ctmpGateID;
                                   invokeID         :ctmpInvokeID;
                                   deviceDN         :ctmpDeviceString;
                                   answerMode       :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureDND( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            deviceDN        :ctmpDeviceString;
                            DNDMode         :ctmpMode_Def;
                            var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureEnableRouting(gate           :ctmpGateID;
                                     invokeID       :ctmpInvokeID;
                                     deviceDN       :ctmpDeviceString;
                                     routeMode      :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureForward( gate                :ctmpGateID;
                                invokeID            :ctmpInvokeID;
                                deviceDN            :ctmpDeviceString;
                                forwardMode         :ctmpForward_Def;
                                forwardOn           :ctmpMode_Def;
                                forwardDn           :ctmpDeviceString;
                                var privateData     :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureMessageWaiting( gate                 :ctmpGateID;
                                       invokeID             :ctmpInvokeID;
                                       deviceDN             :ctmpDeviceString;
                                       messageWaitingMode   :ctmpMode_Def;
                                       var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureMicrophoneMute( gate             :ctmpGateID;
                                       invokeID         :ctmpInvokeID;
                                       deviceDN         :ctmpDeviceString;
                                       micmuteMode      :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureSpeakerMute( gate                :ctmpGateID;
                                    invokeID            :ctmpInvokeID;
                                    deviceDN            :ctmpDeviceString;
                                    speakmuteMode       :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

function ctmpSetFeatureSpeakerVolume( gate                :ctmpGateID;
                                      invokeID            :ctmpInvokeID;
                                      deviceDN            :ctmpDeviceString;
                                      speakerVolume       :ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpSingleStepConference( gate                 :ctmpGateID;
                                   invokeID             :ctmpInvokeID;
                                   var call             :ctmpConnectionID;
                                   calledNumber         :ctmpDeviceString;
                                   mode                 :ctmpMode_Def;
                                   var newCall          :ctmpCallID) :u_int; stdcall; external DLLNAME;

function ctmpSingleStepTransfer( gate               :ctmpGateID;
                                 invokeID           :ctmpInvokeID;
                                 var call           :ctmpConnectionID;
                                 calledNumber       :ctmpDeviceString;
                                 mode               :ctmpMode_Def;
                                 var newCall        :ctmpCallID;
                                 UUI                :ctmpApplString;
                                 AccountCode        :ctmpApplString;
                                 AuthCode           :ctmpApplString;
                                 UEI                :ctmpUEI;
                                 CI                 :ctmpCI) :u_int; stdcall; external DLLNAME;

function ctmpTransferCall( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           var heldCall         :ctmpConnectionID;
                           var activeCall       :ctmpConnectionID;
                           var newCall      :ctmpConnectionID;
                           var callList     :ctmpConnectionList;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{  Reporting Service  }

function ctmpChangeMonitorFilter( gage              :ctmpGateID;
                                  invokeID          :ctmpInvokeID;
                                  monitorID         :ctmpMonitorCrossID;
                                  var monitorFilter :ctmpMonitorFilter;
                                  var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpGetAPICaps( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpGetDeviceList( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            index           :ctmpINT;
                            level           :ctmpLevel_Def) :u_int; stdcall; external DLLNAME;

function ctmpGetEvent( gate             :ctmpGateID;
                       var eventData    :ctmpEventData;
                       dontWait         :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpGetMonitor( gate               :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var monitorMode    :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpMonitorCall( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          var call          :ctmpConnectionID;
                          var monitorID     :ctmpMonitorCrossID;
                          var monitorFilter :ctmpMonitorFilter;
                          var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpMonitorCallsViaDevice( gate                :ctmpGateID;
                                    invokeID            :ctmpInvokeID;
                                    deviceDN            :ctmpDeviceString;
                                    var monitorID       :ctmpMonitorCrossID;
                                    var monitorFilter   :ctmpMonitorFilter;
                                    var privateData     :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpMonitorStart( gate     :ctmpGateID;
                           invokeID :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

function ctmpMonitorStop( gate      :ctmpGateID;
                          invokeID  :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpQueryCallMonitor( gate         :ctmpGateID;
                               invokeID     :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpSnapshotCall( gate                 :ctmpGateID;
                           invokeID             :ctmpInvokeID;
                           var snapshotCall     :ctmpConnectionID;
                           var snapshotCallData :ctmpSnapshotCallData;
                           var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpSnapshotDevice( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             deviceDN           :ctmpDeviceString;
                             var deviceData     :ctmpDeviceData;
                             var snapshotDevice :ctmpSnapshotDeviceData;
                             var numberOfCalls  :ctmpINT;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ Computing Service }

{ CSTA Only }
function ctmpReRoute( gate                      :ctmpGateID;
                      invokeID                  :ctmpInvokeID;
                      routeID                   :ctmpRoutingCrossID;
                      var routeRegisterReqID    :ctmpINT;
                      var routingCrossRefID     :ctmpINT;
                      var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpRouteEnd( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       routeRegisterID  :ctmpRoutingCrossID;
                       routeID          :ctmpRoutingCrossID;
                       errorValue       :ctmpError_Def;
                       var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpRouteRegisterCancel( gate                      :ctmpGateID;
                                  invokeID                  :ctmpInvokeID;
                                  routeRegisterID           :ctmpRoutingCrossID;
                                  var routeRegisterReqID    :ctmpRoutingCrossID;
                                  var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpRouteRegisterReq( gate                     :ctmpGateID;
                               invokeID                 :ctmpInvokeID;
                               deviceID                 :ctmpDeviceString;
                               var routeRegisterReqID   :ctmpRoutingCrossID;
                               var privateData          :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ CSTA Only }
function ctmpRouteRequest( gate                 :ctmpGateID;
                           invokeID             :ctmpInvokeID;
                           routeID              :ctmpRoutingCrossID;
                           calledDeviceID       :ctmpDeviceString;
                           callingDeviceID      :ctmpDeviceString;
                           routingDeviceID      :ctmpDeviceString;
                           routedCall           :ctmpCallID;
                           routeSelAlgorithm    :ctmpINT;
                           priority             :ctmpMode_Def;
                           deviceClass          :ctmpDeviceClass_Def;
                           UUI                  :ctmpApplString) :u_int; stdcall; external DLLNAME;


{ CSTA Only }
function ctmpRouteSelect( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          routeID           :ctmpRoutingCrossID;
                          calledDeviceID    :ctmpDeviceString;
                          remainRetry       :ctmpINT;
                          deviceClass       :ctmpDeviceClass_Def;
                          routeUsedFlag     :ctmpMode_Def;
                          UUI               :ctmpApplString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpRouteUsed( gate                :ctmpGateID;
                        invokeID            :ctmpInvokeID;
                        routeID             :ctmpRoutingCrossID;
                        calledDeviceID      :ctmpDeviceString;
                        callingDeviceID     :ctmpDeviceString;
                        domainValue         :ctmpINT;
                        UUI                 :ctmpApplString) :u_int; stdcall; external DLLNAME;

{ Bi-Directional Service }

{ ASAI Only }
function ctmpChangeSysStatFilter( gate                      :ctmpGateID;
                                  invokeID                  :ctmpInvokeID;
                                  systemFilter              :ctmpINT;
                                  var systemFilterSelected  :ctmpINT;
                                  var systemFilterActive    :ctmpINT;
                                  var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

function ctmpEscape( gate               :ctmpGateID;
                     invokeID           :ctmpInvokeID;
                     var privData       :ctmpPrivDataArray;
                     var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ ASAI Only }
function ctmpEscapeServiceConf( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                errorValue      :ctmpError_Def;
                                var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ ASAI Only }
function ctmpSendPrivateEvent( gate             :ctmpGateID;
                               invokeID         :ctmpInvokeID;
                               var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpSysStatEvent( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           systemStatus     :ctmpSystemStatus_Def;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpSysStatReq( gate               :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var systemStatus   :ctmpSystemStatus_Def;
                         var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ ASAI Only }
function ctmpSysStatReqConf( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             systemStatus       :ctmpSystemStatus_Def;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpSysStatStart( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           sysFilter        :ctmpINT;
                           var systemStatus :ctmpSystemStatus_Def;
                           var systemFilter :ctmpINT;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
function ctmpSysStatStop( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSystemStatus( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           systemStatus     :ctmpSystemStatus_Def) :u_int; stdcall; external DLLNAME;

{ CTMP Private Service }


{ ASAI Only}
function ctmpAbortStream( gate             :ctmpGateID;
                          var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpAddDevice( gate            :ctmpGateID;
                        invokeID        :ctmpInvokeID;
                        var openData    :ctmpOpenData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpCallToCNID( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         callID         :ctmpCallID;
                         deviceDN       :ctmpINT;
                         var CNID       :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpCampaignInfo( gate         :ctmpGateID;
                           invokeID     :ctmpInvokeID;
                           callID       :ctmpCallID;
                           var CI       :ctmpCI) :u_int; stdcall; external DLLNAME;

function ctmpCloseServer( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID) :u_int; stdcall; external DLLNAME;


{ CSTA Only }
function ctmpCurrentDN( gate            :ctmpGateID;
                        invokeID        :ctmpInvokeID;
                        deviceDn        :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpErrMsg( gate           :ctmpGateID;
                     invokeID       :ctmpInvokeID;
                     errorCode      :ctmpError;
                     errorContent   :ctmpErrorMSG) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpMultiAddDevice( gate           :ctmpGateID;
                             invokeID       :ctmpInvokeID;
                             var openData   :ctmpOpenData;
                             multyDNCount   :ctmpSHORT;
                             var multyDN    :ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpSetPbxID( gate           :ctmpGateID;
                       invokeID       :ctmpInvokeID;
                       pbxid          :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpGetCurrentPbxID() :u_int; stdcall; external DLLNAME;

function ctmpOpenServer( var gate           :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var openData       :ctmpOpenData;
                         serverName         :ctmpNameString;
                         portNo             :ctmpINT;
                         networkType        :ctmpNetString;
                         appName            :ctmpApplString;
                         mode               :ctmpSyncMode_Def;
                         defPbx             :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpOpenServerHA( var gate           :ctmpGateID;
                           invokeID           :ctmpInvokeID;
                           var openData       :ctmpOpenData;
                           serverName1        :ctmpNameString;
                           serverName2        :ctmpNameString;
                           portNo             :ctmpINT;
                           networkType        :ctmpNetString;
                           appName            :ctmpApplString;
                           mode               :ctmpSyncMode_Def;
                           defPbx             :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpSQLExecute( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         var query      :ctmpQuery)  :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpRemoveDevice( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           deviceDn         :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpUserExInfoData( gate       :ctmpGateID;
                             invokeID   :ctmpInvokeID;
                             callID     :ctmpCallID;
                             UEI        :ctmpUEI) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpWaitTimeGet( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID;
                          callID        :ctmpCallID;
                          queueDN       :ctmpINT;
                          var waitTime  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{ CTMP Server Control Service }

{ CSTA Only }
function ctmpSetLink( gate          :ctmpGateID;
                      invokeID      :ctmpInvokeID;
                      state         :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSetMaxDevice( gate         :ctmpGateID;
                           invokeID     :ctmpInvokeID;
                           maxCount     :ctmpINT;
                           licenseKey   :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSetTrace( gate         :ctmpGateID;
                       invokeID     :ctmpInvokeID;
                       state        :ctmpMode_Def;
                       level        :ctmpServerTrace_Def;
                       fileName     :ctmpApplString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpShowClient( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         maxCount       :ctmpSHORT;
                         var clientData :ctmpClientData;
                         var readCount  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpShowLink( gate         :ctmpGateID;
                       invokeID     :ctmpInvokeID;
                       var linkData :ctmpLinkData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpShowVersion( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID;
                          var swVersion :ctmpINT;
                          licenseKey    :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CTMP Input/Output Control Service }

{ CSTA Only }
function ctmpDataPathResum( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            ioRefID         :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpDataPathSuspended( gate        :ctmpGateID;
                                invokeID    :ctmpInvokeID;
                                ioRefID     :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpFastData( gate                 :ctmpGateID;
                       invokeID             :ctmpInvokeID;
                       ioRefID              :ctmpIoRefID;
                       ioData               :ctmpIOData;
                       dataPathDirection    :ctmpDataPathDirection_Def;
                       dataPathType         :ctmpDataPathType_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpResumeDataPath( gate       :ctmpGateID;
                             invokeID   :ctmpInvokeID;
                             ioRefID    :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSendBroadcaseData( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                ioData          :ctmpIOData;
                                dataPathType    :ctmpDataPathType_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSendData( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       ioRefID          :ctmpIoRefID;
                       ioData           :ctmpIOData;
                       eventCause       :ctmpEventCauses_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSendMulticastData( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                ioData          :ctmpIOData;
                                var ioRefIdList :ctmpINT;
                                ioRefIdCount    :ctmpINT) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpStartDataPath( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            callID              :ctmpCallID;
                            dataPathDirection   :ctmpDataPathDirection_Def;
                            dataPathType        :ctmpDataPathType_Def;
                            var noCharToCollect :ctmpINT;
                            terminalChar        :ctmpDeviceString;
                            var timeout         :ctmpINT;
                            var ioRefId         :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpStopDataPath( gate         :ctmpGateID;
                           invokeID     :ctmpInvokeID;
                           ioRefID      :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSuspendDataPath( gate          :ctmpGateID;
                              invokeID      :ctmpInvokeID;
                              ioRefID       :ctmpIoRefID) :u_int; stdcall; external DLLNAME;


{ CTMP Voice Unit Service }

{ CSTA Only }
function ctmpConcatenateMessage( gate               :ctmpGateID;
                                 invokeID           :ctmpInvokeID;
                                 var messageIdList  :ctmpINT;
                                 messageIdCount     :ctmpINT;
                                 var messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpDeleteMessage( gate        :ctmpGateID;
                            invokeID    :ctmpInvokeID;
                            messageID   :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpPlayMessage( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          messageID         :ctmpMessageID;
                          callID            :ctmpCallID;
                          duration          :ctmpINT;
                          termination       :ctmpTermination_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpQueryVoiceAttribute( gate                  :ctmpGateID;
                                  invokeID              :ctmpInvokeID;
                                  messageID             :ctmpMessageID;
                                  attributeToQuery      :ctmpAttributeToQuery_Def;
                                  callID                :ctmpCallID;
                                  var encodingAlgorithm :ctmpEncodingAlgorithm_Def;
                                  sampleRate            :ctmpDeviceString;
                                  var durations         :ctmpINT;
                                  fileName              :ctmpDeviceString;
                                  var position          :ctmpINT;
                                  var speed             :ctmpINT;
                                  var volume            :ctmpINT;
                                  var level             :ctmpINT;
                                  var state             :ctmpState_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpRecordMessage( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            callID          :ctmpCallID;
                            encodingAlgorithm   :ctmpEncodingAlgorithm_Def;
                            maxDuration         :ctmpINT;
                            termination         :ctmpTermination_Def;
                            var messageID       :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpReposition( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         callID         :ctmpCallID;
                         position       :ctmpINT;
                         messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpResume( gate               :ctmpGateID;
                     invokeID           :ctmpInvokeID;
                     callID             :ctmpCallID;
                     messageID          :ctmpMessageID;
                     duration           :ctmpINT) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpReview( gate           :ctmpGateID;
                     invokeID       :ctmpInvokeID;
                     callID         :ctmpCallID;
                     period         :ctmpINT;
                     messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSetVoiceAttributeRecordingLevel( gate              :ctmpGateID;
                                              invokeID          :ctmpInvokeID;
                                              callID            :ctmpCallID;
                                              recordingLevel    :ctmpINT;
                                              messageID         :ctmpMessageID) :u_int; stdcall; external DLLNAME;
{ CSTA Only }
function ctmpSetVoiceAttributeSpeakerVolume( gate           :ctmpGateID;
                                             invokeID       :ctmpInvokeID;
                                             callID         :ctmpCallID;
                                             speakerVolume  :ctmpINT;
                                             messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;
{ CSTA Only }
function ctmpSetVoiceAttributeSpeed( gate           :ctmpGateID;
                                     invokeID       :ctmpInvokeID;
                                     callID         :ctmpCallID;
                                     speed          :ctmpINT;
                                     messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpStop( gate         :ctmpGateID;
                   invokeID     :ctmpInvokeID;
                   callID       :ctmpCallID;
                   messageID    :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSuspend( gate          :ctmpGateID;
                      invokeID      :ctmpInvokeID;
                      callID        :ctmpCallID;
                      messageID     :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
function ctmpSynthesizeMessage( gate                :ctmpGateID;
                                invokeID            :ctmpInvokeID;
                                textToSynthesizer   :ctmpIOData;
                                sex                 :ctmpSex_Def;
                                language            :ctmpDeviceString;
                                var messageID       :ctmpMessageID) :u_int; stdcall; external DLLNAME;


{ CTMP Function Add	}

function ctmpEventNotify( gate          :ctmpGateID;
                          hWnd          :HWND;
                          messageid     :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpGetEventPoll( gate         :ctmpGateID;
                           var responsInfo  :ctmpResponseInfo_rtn;
                           var responsData  :ctmpResponseData) :u_int; stdcall; external DLLNAME;

function ctmpCallBackCampaign( gate                :ctmpGateID;
                               invokeID            :ctmpInvokeID;
                               ciodID              :ctmpINT;
                               count               :ctmpINT;
                               var callbackCamp    :ctmpCallbackCampaign_) :u_int; stdcall; external DLLNAME;

function ctmpCallBackListInsert( gate                :ctmpGateID;
                                 invokeID            :ctmpInvokeID;
                                 ciodID              :ctmpINT;
                                 var callback        :ctmpCallbackData;
                                 var callbackRtn     :ctmpCallbackData_rtn) :u_int; stdcall; external DLLNAME;

// 캠페인 생성 함수
function ctmpCreateCampaign( gate                :ctmpINT;
                             invokeID            :ctmpSHORT;
                             var campaignId      :ctmpINT;
                             var campaign        :ctmpCampaignMaster) :u_int; stdcall; external DLLNAME;

//// 8월 9일 수요일  대기율 구하는 함수
function ctmpReadyRateGet( gate                :ctmpINT;
                           invokeID            :ctmpSHORT;
                           QueueDn             :ctmpINT;
                           var readyrate       :ctmpFLOAT) :u_int; stdcall; external DLLNAME;

function ctmpCounselResult( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            var coulselResult   :ctmpConselResult) :u_int; stdcall; external DLLNAME;

function ctmpAgentSkillGet( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            maxCount            :ctmpSHORT;
                            nSkill              :ctmpINT;
                            var skillAgent      :ctmpSkillAgent;
                            var readCount       :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpSetAgentBlocking( gate                :ctmpGateID;
                               invokeID            :ctmpInvokeID;
                               agentID             :ctmpINT) :u_int; stdcall; external DLLNAME;

//*상담원이 "이석"을 미리 예약하므로써, 해당 상담원을 예측 Dialing에서 제외한다.*/
function ctmpSetAgentLeavingFlag( gate                :ctmpGateID;          //Gate ID
                                  invokeID            :ctmpInvokeID;        //Invoke ID
                                  deviceDN            :ctmpDeviceString;    //사용 안 함.(확장용)
                                  agentLeavingFlag    :ctmpINT;             //0:예약취소, 1:이석예약
                                  uiTimeOut           :ctmpINT;             //자동이석 예정시간(초단위)
                                  agentId             :ctmpDeviceString;    //Agent ID
                                  agentData           :ctmpDeviceString;    //사용안함.(확장용)
                                  agentGroup          :ctmpDeviceString;    //사용안함.(확장용)
                                  reasoncode          :ctmpINT              //사용안함.(확장용)
                                ) :u_int; stdcall; external DLLNAME;

function ctmpGetMaxCPSQ( gate                :ctmpINT;          //Gate ID
                         invokeID            :ctmpSHORT;        //Invoke ID
                         ciodID              :ctmpINT;
                         cpid                :ctmpINT;
                         maxcpsq             :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpBlackListInsert( gate                :ctmpINT;          //Gate ID
                              invokeID            :ctmpSHORT;        //Invoke ID
                              ciod                :ctmpINT;
                              var blst            :ctmpBlackList) :u_int; stdcall; external DLLNAME;

function ctmpPreviewMakeCall( gate                :ctmpGateID;
                              invokeID            :ctmpSHORT;
                              ciod                :ctmpINT;
                              cpid                :ctmpINT;
                              cpsq                :ctmpINT;
                              agentId             :ctmpINT;
                              dialkind            :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpSetUEIData( gate                :ctmpGateID;
                         invokeID            :ctmpSHORT;
                         ServerID            :ctmpCHAR;
                         var ActiveCall      :ctmpConnectionID;
                         var UEI             :ctmpUEI) :u_int; stdcall; external DLLNAME;

function ctmpAgentStatusGet( gate                :ctmpGateID;
                             invokeID            :ctmpSHORT;
                             mode                :ctmpINT;
                             maxcnt              :ctmpINT;
                             group               :ctmpINT;
                             part                :ctmpINT;
                             var status          :ctmpAgentStatus;
                             var rtnCount        :ctmpINT;
                             orderby             :ctmpINT = 0) :u_int; stdcall; external DLLNAME;

function ctmpWaitAgentInQueueGet( gate                :ctmpGateID;
                                  invokeID            :ctmpSHORT;
                                  queueDN             :ctmpINT;
                                  var waitAgentCnt    :ctmpINT;
                                  var waitTime        :ctmpINT;
                                  var waitCount       :ctmpSHORT) :u_int; stdcall; external DLLNAME;



// Softphone (callmanager) API
// 당분간 함수 제외



//  Extended Switching Service
function ctmpRemoteCentersGet( gate               :ctmpGateID;
                               invokeID           :ctmpInvokeID;
                               var remoteCenter   :ctmpRemoteCenter;
                               remoteCenterCount  :ctmpSHORT;
                               var centerCount    :ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpAgentBusyGetII( gate               :ctmpGateID;
                             center             :ctmpCenterID;
                             invokeID           :ctmpInvokeID;
                             AgentGroup         :ctmpSHORT;
                             AgentPart          :ctmpSHORT;
                             maxCount           :ctmpSHORT;
                             var BusyAgent      :TReadyBusy;
                             var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpAgentBusyGetCountII( gate               :ctmpGateID;
                                  center             :ctmpCenterID;
                                  invokeID           :ctmpInvokeID;
                                  AgentGroup         :ctmpSHORT;
                                  AgentPart          :ctmpSHORT;
                                  maxCount           :ctmpSHORT;
                                  var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpAgentBusyGetValueII( gate               :ctmpGateID;
                                  center             :ctmpCenterID;
                                  invokeID           :ctmpInvokeID;
                                  count              :ctmpSHORT;
                                  var agentId        :ctmpINT;
                                  var deviceDN       :ctmpINT;
                                  var blendMode      :ctmpMode_Def;
                                  var countinueTime  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpAgentReadyGetII( gate               :ctmpGateID;
                              center             :ctmpCenterID;
                              invokeID           :ctmpInvokeID;
                              AgentGroup         :ctmpSHORT;
                              AgentPart          :ctmpSHORT;
                              maxCount           :ctmpSHORT;
                              var readyAgent     :TReadyAgent;
                              var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpAgentReadyGetCountII( gate               :ctmpGateID;
                                   center             :ctmpCenterID;
                                   invokeID           :ctmpInvokeID;
                                   AgentGroup         :ctmpSHORT;
                                   AgentPart          :ctmpSHORT;
                                   maxCount           :ctmpSHORT;
                                   var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpQueryAgentStatusExII( gate               :ctmpGateID;
                                   center             :ctmpCenterID;
                                   invokeID           :ctmpInvokeID;
                                   agentID            :ctmpINT;
                                   deviceDN           :ctmpINT;
                                   var queryAgentID   :ctmpINT;
                                   var queryAgentMode :ctmpAgentMode_Def;
                                   var queryAgentDN   :ctmpINT;
                                   var queryAgentblendMode:ctmpMode_Def;
                                   var queryAgentblockMode:ctmpMode_Def;
                                   var queryAgentTime :ctmpINT;
                                   var queryAgentType :ctmpAgentType_Def) : u_int; stdcall; external DLLNAME;

function ctmpWaitTimeGetEx( gate               :ctmpgateID;
                            invokeID           :ctmpInvokeID;
                            groupDN            :ctmpINT;
                            queueDN            :ctmpINT;
                            var waitTime       :ctmpINT;
                            var waitCount      :ctmpSHORT) :u_int; stdcall; external DLLNAME;

function ctmpPwdConfirm( gate              :ctmpGateID;
                         invokeID          :ctmpInvokeID;
                         deviceDN          :ctmpINT;
                         confirm           :ctmpINT;
                         confirmDesc       :ctmpIOData) :u_int; stdcall; external DLLNAME;

function ctmpLoginPwd( gate           :ctmpGateID;
                       invokeID       :ctmpInvokeID;
                       agentid        :ctmpINT;
                       pwd            :ctmpPwdString;
                       agnetname      :ctmpNameString) :u_int; stdcall; external DLLNAME;

function ctmpQueryRoutePointInfoEx( gate               :ctmpGateID;
                                    invokeID           :ctmpInvokeID;
                                    maxcnt             :ctmpINT;
                                    RoutePoint         :ctmpINT;
                                    var RoutePointInfo :ctmpRoutePointInfoEx) :u_int; stdcall; external DLLNAME;

function ctmpQueryDNISInfo( gate             :ctmpGateID;
                            invokeID         :ctmpInvokeID;
                            maxcnt           :ctmpINT;
                            DNIS             :ctmpINT;
                            var DNISInfo     :ctmpDNISInfo;
                            var count        :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpPreviewCampaignDescGet( gate                :ctmpGateID;
                                     invokeID            :ctmpInvokeID;
                                     ciodID              :ctmpINT;
                                     campaignID          :ctmpINT;
                                     var PreviewCampaign :ctmpPreviewCampaignDesc;
                                     var rtnCount        :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpPreviewDataHandle( gate                   :ctmpGateID;
                                invokeID               :ctmpInvokeID;
                                ciodID                 :ctmpINT;
                                campaignID             :ctmpINT;
                                readmode               :ctmpINT;
                                var ctmpPreviewData    :ctmpPreviewData) :u_int; stdcall; external DLLNAME;

function ctmpCounselMasterCode( gate                   :ctmpGateID;
                                invokeID               :ctmpInvokeID;
                                var counselresult      :ctmpCounselResultExMaster;
                                var readcount          :ctmpINT) :u_int; stdcall; external DLLNAME;

function ctmpPreviewResultEx( gate                   :ctmpGateID;
                              invokeID               :ctmpInvokeID;
                              var counselresult      :ctmpCounselResultEx) :u_int; stdcall; external DLLNAME;

function ctmpBlackListIIInsert( gate                  :ctmpINT;
                                invokeID              :ctmpSHORT;
                                ciod                  :ctmpINT;
                                var blst              :ctmpBlackListII) :u_int; stdcall; external DLLNAME;

function ctmpSendUserData( gate                  :ctmpGateID;
                           invokeID              :ctmpInvokeID;
                           deviceDN              :ctmpINT;
                           myDn                  :ctmpINT;
                           code                  :ctmpINT;
                           appName               :ctmpApplString;
                           var privateData       :ctmpPrivateData;
                           var UEI               :ctmpUEI) :u_int; stdcall; external DLLNAME;

function ctmpQueryAnalogDnStatus( gate                :ctmpGateID;
                                  invokeID            :ctmpInvokeID;
                                  var analogdn        :ctmpAnalogDn;
                                  var readcnt         :ctmpINT) :u_int; stdcall; external DLLNAME;



implementation

end.




