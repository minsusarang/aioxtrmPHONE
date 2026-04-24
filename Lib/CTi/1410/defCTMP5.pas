{ **************************************************************************** }
{                                                                              }
{  설명 : dll을 선언.                                                          }
{                                                                              }
{  작성자 : 백순종                                                             }
{  작성일자 : 2007-10-09                                                       }
{  수정자 : 박정완                                                             }
{  수정일자 : 2011.03.03                                                       }
{                                                                              }
{ **************************************************************************** }
unit defCTMP5;

interface
uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Graphics, StdCtrls, Dialogs, syncobjs, winsock, varCTMP5, constCTMP5;

const
  DLLNAME='nxcapi.dll';

{ CTMP API}

{  Switching Service }

//*	CAPI끼리 msg전달용 */
{}
{
function nxcapiSendMsg( gate            : ctmpGateID;
                      invokeID        : ctmpInvokeID;
                      appName         : ctmpApplString;
                      var UEI         : ctmpUEI;
                      var CI          : ctmpCI;
                      var privateData : ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentReadyGet( gate            : ctmpGateID;
                            invokeID        : ctmpInvokeID;
                            AgentGroup      : ctmpSHORT;
                            AgentPart       : ctmpSHORT;
                            MaxCount        : ctmpSHORT;
                            var readyAgent  : TReadyAgent;
                            var pReadCount  : u_int) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentReadyGetEx( gate            : ctmpGateID;
                              invokeID        : ctmpInvokeID;
                              AgentGroup      : ctmpSHORT;
                              AgentPart       : ctmpSHORT;
                              MaxCount        : ctmpSHORT;
                              var readyAgent  : TReadyAgentEx;
                              var pReadCount  : u_int) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentReadyGetCount(gate            : ctmpGateID;
				invokeID        : ctmpInvokeID;
				AgentGroup      : ctmpSHORT;
				AgentPart       : ctmpSHORT;
				maxCount        : ctmpSHORT;
                                var readCount   : ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentReadyGetValue (gate            : ctmpGateID;
				invokeID         : ctmpInvokeID;
				count            : ctmpSHORT;
                                var agentId      : ctmpDeviceString;  //ctmpINT; 2011.03.03
			        var deviceDN     : ctmpINT;
			        var blendMode    : ctmpMode_Def;
			        var continueTime : ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAlternateCall( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            var heldCall        :ctmpConnectionID;
                            var activeCall      :ctmpConnectionID;
                            var ctmpPrivateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}

function nxcapiAnswerCall( gate             :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var alertingCall   :ctmpConnectionID;
                         var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ CSTA only }

{}
{
function nxcapiAssociateData( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            var call        :ctmpConnectionID;
                            UUI             :ctmpApplString;
                            accountCode     :ctmpApplString;
                            authCode        :ctmpApplString) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentBusyGet ( gate             : ctmpGateID;
                            invokeID         : ctmpInvokeID;
                            AgentGroup       : ctmpSHORT;
                            AgentPart        : ctmpSHORT;
                            MaxCount         : ctmpSHORT;
                            var busyAgent    : TReadyBusy;
                            var pReadCount   : u_int) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentBusyGetCount( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                AgentGroup      :ctmpSHORT;
                                AgentPart       :ctmpSHORT;
                                MaxCount        :ctmpSHORT;
                                var readCount   :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentBusyGetValue( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                count           :ctmpSHORT;
//                                var agentID     :ctmpINT;  2011.03.03
                                var agentID     :ctmpDeviceString;
                                var deviceDN    :ctmpINT;
                                var blendMode   :ctmpMode_Def;
                                var continueTime  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiCallCompletion( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
//                             feature            :ctmpFeature_Def;
                             var call           :ctmpConnectionID;
                             action             :ctmpAction_Def;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiClearCall( gate            :ctmpGateID;
                        invokeID        :ctmpInvokeID;
                        var call        :ctmpConnectionID;
                        var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}

function nxcapiClearConnection( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              var call          :ctmpConnectionID;
                              var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}

function nxcapiConferenceCall( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             var heldCall       :ctmpConnectionID;
                             var activeCall     :ctmpConnectionID;
                             var newCall        :ctmpConnectionID;
                             var callList       :ctmpConnectionList;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}

function nxcapiConsultationCall( gate                 :ctmpGateID;
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


{}
{
function nxcapiDivertDeflect( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            var call        :ctmpConnectionID;
                            divertDn        :ctmpDeviceString;
                            UUI             :ctmpApplString;
                            var UEI         :ctmpUEI;
                            var CI          :ctmpCI;
                            var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiDivertDirect( gate                 :ctmpGateID;
                           invokeID             :ctmpInvokeID;
                           var call             :ctmpConnectionID;
                           divertedDn           :ctmpDeviceString;
                           UUI                  :ctmpApplString;
                           var UEI              :ctmpUEI;
                           var CI               :ctmpCI;
                           var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiDivertPickup( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           var call         :ctmpConnectionID;
                           divertDn         :ctmpDeviceString;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiDivertNoRet( gate                 :ctmpGateID;
                          invokeID             :ctmpInvokeID;
                          divertedDn           :ctmpINT;
                          UUI                  :ctmpApplString;
                          agentID              :ctmpDeviceString) :u_int; stdcall; external DLLNAME;  //ctmpINT) :u_int; stdcall; external DLLNAME;   2011.03.03

{}

function nxcapiHoldCall( gate                 :ctmpGateID;
                       invokeID             :ctmpInvokeID;
                       var call             :ctmpConnectionID;
                       reservation          :ctmpCHAR;
                       var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}

function nxcapiMakeCall( gate                 :ctmpGateID;
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

{}
{
function nxcapiMakePredictiveCall( gate                   :ctmpGateID;
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
{}
{
function nxcapiObservationCall(gate           :ctmpGateID;
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
{}
{
function nxcapiObservationTalkCall(gate           :ctmpGateID;
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

{}

function nxcapiOneStepTransfer( gate                 :ctmpGateID;
                              invokeID             :ctmpInvokeID;
                              var call             :ctmpConnectionID;
                              calledNumber         :ctmpDeviceString;
                              UUI                  :ctmpApplString;
                              var newCall          :ctmpConnectionID;
                              var UEI              :ctmpUEI;
                              var CI               :ctmpCI;
                              var privateData      :ctmpPrivateData) :u_int ; stdcall; external DLLNAME;

{}

function nxcapiOneStepConference( gate                 :ctmpGateID;
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

{}
{
function nxcapiParkCall( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       var call         :ctmpConnectionID;
                       parkCall         :ctmpDeviceString;
                       parkDeviceClass  :ctmpDeviceClass_Def;
                       UUI              :ctmpApplString) :u_int; stdcall; external DLLNAME;


{}

function nxcapiQueryAgentStatus( gate             :ctmpGateID;
                               invokeID         :ctmpInvokeID;
                               deviceDN         :ctmpDeviceString;
                               var agentMode    :ctmpAgentMode_Def;
                               agentID          :ctmpDeviceString;
                               var reasonCode   :ctmpINT;
                               var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryMailAgentStatus( gate             :ctmpGateID;
                                   invokeID         :ctmpInvokeID;
                                   var agentMode    :ctmpAgentMode_Def;
                                   agentID          :ctmpDeviceString;
                                   var reasonCode   :ctmpINT) :u_int; stdcall; external DLLNAME;

{}

function nxcapiQueryAgentStatusEx( gate                       :ctmpGateID;
                                 invokeID                   :ctmpInvokeID;
                                 agentID                    :ctmpDeviceString ;// agentID           :ctmpINT; 2011.03.03
                                 deviceDN                   :ctmpINT;
                                 var queryAgentID           :ctmpDeviceString; // var queryAgentID  :ctmpINT; 2011.03.03
                                 var queryAgentMode         :ctmpAgentMode_Def;
                                 var queryAgentDN           :ctmpINT;
                                 var queryAgentblendMode    :ctmpMode_Def;
                                 var queryAgentblockMode    :ctmpMode_Def;
                                 var queryAgentTime         :ctmpINT;
                                 var queryAgentType         :ctmpAgentType_Def;
                                 centerid                   :ctmpCHAR=0) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryAutoAnswer( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              deviceDN          :ctmpDeviceString;
                              var answerMode    :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryDeviceDND( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             deviceDN           :ctmpDeviceString;
                             var DNDMode        :ctmpMode_Def;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryDeviceForward( gate               :ctmpGateID;
                                 invokeID           :ctmpInvokeID;
                                 deviceDN           :ctmpDeviceString;
                                 var forwardMode    :ctmpMode_Def;
                                 forwardDn          :ctmpDeviceString;
                                 var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{}
{
function nxcapiQueryDeviceInfo( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              deviceDN          :ctmpDeviceString;
                              queryDN           :ctmpDeviceString;
                              var deviceType    :ctmpDeviceType_Def;
                              var deviceClass   :ctmpDeviceClass_Def;
                              var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryMessageWaiting( gate                      :ctmpGateID;
                                  invokeID                  :ctmpInvokeID;
                                  deviceDN                  :ctmpDeviceString;
                                  var messageWaitingMode    :ctmpMode_Def;
                                  var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiEnableRouting( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            deviceDN            :ctmpDeviceString;
                            var routeMode       :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryLastNumber( gate              :ctmpGateID;
                              invokeID          :ctmpInvokeID;
                              deviceDN          :ctmpDeviceString;
                              lastNumber        :ctmpDeviceString;
                              var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryMicrophoneMute( gate              :ctmpGateID;
                                  invokeID          :ctmpInvokeID;
                                  deviceDN          :ctmpDeviceString;
                                  var micmuteMode   :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQuerySpeakerMute( gate                 :ctmpGateID;
                               invokeID             :ctmpInvokeID;
                               deviceDN             :ctmpDeviceString;
                               var speakmuteMode    :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQuerySpeakerVolume( gate               :ctmpGateID;
                                 invokeID           :ctmpInvokeID;
                                 deviceDN           :ctmpDeviceString;
                                 var speakerVolume  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiReconnectCall( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            var heldCall        :ctmpConnectionID;
                            var activeCall      :ctmpConnectionID;
                            var privateData     :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}

function nxcapiRetrieveCall( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           var call         :ctmpConnectionID;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ CSTA only }
{}
{
function nxcapiSendDTMF( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       var call         :ctmpConnectionID;
                       DTMFdigits       :ctmpDeviceString;
                       ToneDuration     :ctmpINT;
                       PauseDuration    :ctmpINT) :u_int; stdcall; external DLLNAME;

{ CSTA only }
{}
{
function nxcapiSetAgentFlag( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           agentID          :ctmpDeviceString; // :ctmpINT; 2011.03.03
                           waitMode         :ctmpINT) :u_int; stdcall; external DLLNAME;

{}

function nxcapiSetFeatureAgentStatus( gate            :ctmpGateID;
                                    invokeID        :ctmpInvokeID;
                                    deviceDN        :ctmpDeviceString;
                                    agentMode       :ctmpAgentMode_Def;
                                    agentID         :ctmpDeviceString;
                                    agentData       :ctmpDeviceString;
                                    agentGroup      :ctmpDeviceString;
                                    reasoncode      :ctmpINT;
                                    workMode        :ctmpWorkMode_Def;
                                    var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureMailAgentStatus( gate            :ctmpGateID;
                                        invokeID        :ctmpInvokeID;
                                        deviceDN        :ctmpDeviceString;
                                        agentMode       :ctmpAgentMode_Def;
                                        agentGroup      :ctmpDeviceString;
                                        agentPart       :ctmpDeviceString;
                                        reasoncode      :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureAutoAnswer( gate             :ctmpGateID;
                                   invokeID         :ctmpInvokeID;
                                   deviceDN         :ctmpDeviceString;
                                   answerMode       :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureDND( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            deviceDN        :ctmpDeviceString;
                            DNDMode         :ctmpMode_Def;
                            var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureEnableRouting(gate           :ctmpGateID;
                                     invokeID       :ctmpInvokeID;
                                     deviceDN       :ctmpDeviceString;
                                     routeMode      :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureForward( gate                :ctmpGateID;
                                invokeID            :ctmpInvokeID;
                                deviceDN            :ctmpDeviceString;
                                forwardMode         :ctmpForward_Def;
                                forwardOn           :ctmpMode_Def;
                                forwardDn           :ctmpDeviceString;
                                var privateData     :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureMessageWaiting( gate                 :ctmpGateID;
                                       invokeID             :ctmpInvokeID;
                                       deviceDN             :ctmpDeviceString;
                                       messageWaitingMode   :ctmpMode_Def;
                                       var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureMicrophoneMute( gate             :ctmpGateID;
                                       invokeID         :ctmpInvokeID;
                                       deviceDN         :ctmpDeviceString;
                                       micmuteMode      :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureSpeakerMute( gate                :ctmpGateID;
                                    invokeID            :ctmpInvokeID;
                                    deviceDN            :ctmpDeviceString;
                                    speakmuteMode       :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetFeatureSpeakerVolume( gate                :ctmpGateID;
                                      invokeID            :ctmpInvokeID;
                                      deviceDN            :ctmpDeviceString;
                                      speakerVolume       :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSingleStepConference( gate                 :ctmpGateID;
                                   invokeID             :ctmpInvokeID;
                                   var call             :ctmpConnectionID;
                                   calledNumber         :ctmpDeviceString;
                                   mode                 :ctmpMode_Def;
                                   var newCall          :ctmpCallID) :u_int; stdcall; external DLLNAME;

{}

function nxcapiSingleStepTransfer( gate               :ctmpGateID;
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

{}

function nxcapiTransferCall( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           var heldCall         :ctmpConnectionID;
                           var activeCall       :ctmpConnectionID;
                           var newCall      :ctmpConnectionID;
                           var callList     :ctmpConnectionList;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{  Reporting Service  }

{}
{
function nxcapiChangeMonitorFilter( gage              :ctmpGateID;
                                  invokeID          :ctmpInvokeID;
                                  monitorID         :ctmpMonitorCrossID;
                                  var monitorFilter :ctmpMonitorFilter;
                                  var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiGetAPICaps( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiGetDeviceList( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            index           :ctmpINT;
                            level           :ctmpLevel_Def) :u_int; stdcall; external DLLNAME;

{}

function nxcapiGetEvent( gate             :ctmpGateID;
                       var eventData    :ctmpEventData;
                       dontWait         :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiGetMonitor( gate               :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var monitorMode    :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiMonitorCall( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          var call          :ctmpConnectionID;
                          var monitorID     :ctmpMonitorCrossID;
                          var monitorFilter :ctmpMonitorFilter;
                          var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiMonitorCallsViaDevice( gate                :ctmpGateID;
                                    invokeID            :ctmpInvokeID;
                                    deviceDN            :ctmpDeviceString;
                                    var monitorID       :ctmpMonitorCrossID;
                                    var monitorFilter   :ctmpMonitorFilter;
                                    var privateData     :ctmpPrivateData) :u_int; stdcall; external DLLNAME;
{}

function nxcapiMonitorStart( gate     :ctmpGateID;
                           invokeID :ctmpInvokeID) :u_int; stdcall; external DLLNAME;


function nxcapiMonitorStop( gate      :ctmpGateID;
                          invokeID  :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiQueryCallMonitor( gate         :ctmpGateID;
                               invokeID     :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiSnapshotCall( gate                 :ctmpGateID;
                           invokeID             :ctmpInvokeID;
                           var snapshotCall     :ctmpConnectionID;
                           var snapshotCallData :ctmpSnapshotCallData;
                           var privateData      :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSnapshotDevice( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             deviceDN           :ctmpDeviceString;
                             var deviceData     :ctmpDeviceData;
                             var snapshotDevice :ctmpSnapshotDeviceData;
                             var numberOfCalls  :ctmpINT;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ Computing Service }

{ CSTA Only }
{}
{
function nxcapiReRoute( gate                      :ctmpGateID;
                      invokeID                  :ctmpInvokeID;
                      routeID                   :ctmpRoutingCrossID;
                      var routeRegisterReqID    :ctmpINT;
                      var routingCrossRefID     :ctmpINT;
                      var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiRouteEnd( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       routeRegisterID  :ctmpRoutingCrossID;
                       routeID          :ctmpRoutingCrossID;
                       errorValue       :ctmpError_Def;
                       var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiRouteRegisterCancel( gate                      :ctmpGateID;
                                  invokeID                  :ctmpInvokeID;
                                  routeRegisterID           :ctmpRoutingCrossID;
                                  var routeRegisterReqID    :ctmpRoutingCrossID;
                                  var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiRouteRegisterReq( gate                     :ctmpGateID;
                               invokeID                 :ctmpInvokeID;
                               deviceID                 :ctmpDeviceString;
                               var routeRegisterReqID   :ctmpRoutingCrossID;
                               var privateData          :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ CSTA Only }
{}
{
function nxcapiRouteRequest( gate                 :ctmpGateID;
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
{}
{
function nxcapiRouteSelect( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          routeID           :ctmpRoutingCrossID;
                          calledDeviceID    :ctmpDeviceString;
                          remainRetry       :ctmpINT;
                          deviceClass       :ctmpDeviceClass_Def;
                          routeUsedFlag     :ctmpMode_Def;
                          UUI               :ctmpApplString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiRouteUsed( gate                :ctmpGateID;
                        invokeID            :ctmpInvokeID;
                        routeID             :ctmpRoutingCrossID;
                        calledDeviceID      :ctmpDeviceString;
                        callingDeviceID     :ctmpDeviceString;
                        domainValue         :ctmpINT;
                        UUI                 :ctmpApplString) :u_int; stdcall; external DLLNAME;

{ Bi-Directional Service }

{ ASAI Only }
{}
{
function nxcapiChangeSysStatFilter( gate                      :ctmpGateID;
                                  invokeID                  :ctmpInvokeID;
                                  systemFilter              :ctmpINT;
                                  var systemFilterSelected  :ctmpINT;
                                  var systemFilterActive    :ctmpINT;
                                  var privateData           :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiEscape( gate               :ctmpGateID;
                     invokeID           :ctmpInvokeID;
                     var privData       :ctmpPrivDataArray;
                     var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ ASAI Only }
{}
{
function nxcapiEscapeServiceConf( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                errorValue      :ctmpError_Def;
                                var privateData :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ ASAI Only }
{}
{
function nxcapiSendPrivateEvent( gate             :ctmpGateID;
                               invokeID         :ctmpInvokeID;
                               var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiSysStatEvent( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           systemStatus     :ctmpSystemStatus_Def;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiSysStatReq( gate               :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var systemStatus   :ctmpSystemStatus_Def;
                         var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;


{ ASAI Only }
{}
{
function nxcapiSysStatReqConf( gate               :ctmpGateID;
                             invokeID           :ctmpInvokeID;
                             systemStatus       :ctmpSystemStatus_Def;
                             var privateData    :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiSysStatStart( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           sysFilter        :ctmpINT;
                           var systemStatus :ctmpSystemStatus_Def;
                           var systemFilter :ctmpINT;
                           var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ ASAI Only }
{}
{
function nxcapiSysStatStop( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          var privateData   :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSystemStatus( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           systemStatus     :ctmpSystemStatus_Def) :u_int; stdcall; external DLLNAME;

{ CTMP Private Service }


{ ASAI Only}
{}
{
function nxcapiAbortStream( gate             :ctmpGateID;
                          var privateData  :ctmpPrivateData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiAddDevice( gate            :ctmpGateID;
                        invokeID        :ctmpInvokeID;
                        var openData    :ctmpOpenData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiCallToCNID( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         callID         :ctmpCallID;
                         deviceDN       :ctmpINT;
                         var CNID       :ctmpINT) :u_int; stdcall; external DLLNAME;

{ 2011.03.03 삭제
{}
{
function nxcapiCampaignInfo( gate         :ctmpGateID;
                           invokeID     :ctmpInvokeID;
                           callID       :ctmpCallID;
                           var CI       :ctmpCI) :u_int; stdcall; external DLLNAME;
{}

{}

function nxcapiCloseServer( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID) :u_int; stdcall; external DLLNAME;

{2011.03.03 추가 }
{}
//이중화시 사용
function nxcapiCloseServerHA( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID) :u_int; stdcall; external DLLNAME;


{ CSTA Only }
{}
{
function nxcapiCurrentDN( gate            :ctmpGateID;
                        invokeID        :ctmpInvokeID;
                        deviceDn        :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiErrMsg( gate           :ctmpGateID;
                     invokeID       :ctmpInvokeID;
                     errorCode      :ctmpError;
                     errorContent   :ctmpErrorMSG) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiMultiAddDevice( gate           :ctmpGateID;
                             invokeID       :ctmpInvokeID;
                             var openData   :ctmpOpenData;
                             multyDNCount   :ctmpSHORT;
                             var multyDN    :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetPbxID( gate           :ctmpGateID;
                       invokeID       :ctmpInvokeID;
                       pbxid          :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiGetCurrentPbxID() :u_int; stdcall; external DLLNAME;

{}
function nxcapiOpenServer( var gate           :ctmpGateID;
                         invokeID           :ctmpInvokeID;
                         var openData       :ctmpOpenData;
                         serverName         :ctmpNameString;
                         portNo             :ctmpINT;
                         networkType        :ctmpNetString;
                         appName            :ctmpApplString;
                         mode               :ctmpSyncMode_Def;
                         defPbx             :ctmpINT) :u_int; stdcall; external DLLNAME;

{}

function nxcapiOpenServerHA( var gate           :ctmpGateID;
                           invokeID           :ctmpInvokeID;
                           var openData       :ctmpOpenData;
                           primaryIP          :ctmpNameString; //2011.03.03 serverName1        :ctmpNameString; //
                           secondaryIP        :ctmpNameString; //2011.03.03 serverName2        :ctmpNameString; //
                           portNo             :ctmpINT;
                           networkType        :ctmpNetString;
                           appName            :ctmpApplString;
                           mode               :ctmpSyncMode_Def;
                           defPbx             :ctmpINT) :u_int; stdcall; external DLLNAME;

{ 2011.03.03 삭제
{}
{
function nxcapiSQLExecute( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         var query      :ctmpQuery)  :u_int; stdcall; external DLLNAME;
{}
{ CSTA Only }
{}
{
function nxcapiRemoveDevice( gate             :ctmpGateID;
                           invokeID         :ctmpInvokeID;
                           deviceDn         :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiUserExInfoData( gate       :ctmpGateID;
                             invokeID   :ctmpInvokeID;
                             callID     :ctmpCallID;
                             UEI        :ctmpUEI) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
{function nxcapiWaitTimeGet( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID;
                          callID        :ctmpCallID;
                          queueDN       :ctmpINT;
                          var waitTime  :ctmpSHORT) :u_int; stdcall; external DLLNAME;
{}
{
function nxcapiWaitTimeGet( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID;
                          tenantID      :ctmpINT; //2011.03.03
                          queueDN       :ctmpDataString;
                          var waitTime  : ctmpINT;
                          var waitCount : ctmpSHORT ) :u_int; stdcall; external DLLNAME;

{                          callID        :ctmpCallID;
                          queueDN       :ctmpINT;
                          var waitTime  :ctmpSHORT) :u_int; stdcall; external DLLNAME;
2011.03.03 {}

{ CTMP Server Control Service }

{ CSTA Only }
{}
{
function nxcapiSetLink( gate          :ctmpGateID;
                      invokeID      :ctmpInvokeID;
                      state         :ctmpMode_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSetMaxDevice( gate         :ctmpGateID;
                           invokeID     :ctmpInvokeID;
                           maxCount     :ctmpINT;
                           licenseKey   :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSetTrace( gate         :ctmpGateID;
                       invokeID     :ctmpInvokeID;
                       state        :ctmpMode_Def;
                       level        :ctmpServerTrace_Def;
                       fileName     :ctmpApplString) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiShowClient( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         maxCount       :ctmpSHORT;
                         var clientData :ctmpClientData;
                         var readCount  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiShowLink( gate         :ctmpGateID;
                       invokeID     :ctmpInvokeID;
                       var linkData :ctmpLinkData) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiShowVersion( gate          :ctmpGateID;
                          invokeID      :ctmpInvokeID;
                          var swVersion :ctmpINT;
                          licenseKey    :ctmpDeviceString) :u_int; stdcall; external DLLNAME;

{ CTMP Input/Output Control Service }

{ CSTA Only }
{}
{
function nxcapiDataPathResum( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            ioRefID         :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiDataPathSuspended( gate        :ctmpGateID;
                                invokeID    :ctmpInvokeID;
                                ioRefID     :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiFastData( gate                 :ctmpGateID;
                       invokeID             :ctmpInvokeID;
                       ioRefID              :ctmpIoRefID;
                       ioData               :ctmpIOData;
                       dataPathDirection    :ctmpDataPathDirection_Def;
                       dataPathType         :ctmpDataPathType_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiResumeDataPath( gate       :ctmpGateID;
                             invokeID   :ctmpInvokeID;
                             ioRefID    :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSendBroadcaseData( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                ioData          :ctmpIOData;
                                dataPathType    :ctmpDataPathType_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSendData( gate             :ctmpGateID;
                       invokeID         :ctmpInvokeID;
                       ioRefID          :ctmpIoRefID;
                       ioData           :ctmpIOData;
                       eventCause       :ctmpEventCauses_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSendMulticastData( gate            :ctmpGateID;
                                invokeID        :ctmpInvokeID;
                                ioData          :ctmpIOData;
                                var ioRefIdList :ctmpINT;
                                ioRefIdCount    :ctmpINT) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiStartDataPath( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            callID              :ctmpCallID;
                            dataPathDirection   :ctmpDataPathDirection_Def;
                            dataPathType        :ctmpDataPathType_Def;
                            var noCharToCollect :ctmpINT;
                            terminalChar        :ctmpDeviceString;
                            var timeout         :ctmpINT;
                            var ioRefId         :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiStopDataPath( gate         :ctmpGateID;
                           invokeID     :ctmpInvokeID;
                           ioRefID      :ctmpIoRefID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSuspendDataPath( gate          :ctmpGateID;
                              invokeID      :ctmpInvokeID;
                              ioRefID       :ctmpIoRefID) :u_int; stdcall; external DLLNAME;


{ CTMP Voice Unit Service }

{ CSTA Only }
{}
{
function nxcapiConcatenateMessage( gate               :ctmpGateID;
                                 invokeID           :ctmpInvokeID;
                                 var messageIdList  :ctmpINT;
                                 messageIdCount     :ctmpINT;
                                 var messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiDeleteMessage( gate        :ctmpGateID;
                            invokeID    :ctmpInvokeID;
                            messageID   :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiPlayMessage( gate              :ctmpGateID;
                          invokeID          :ctmpInvokeID;
                          messageID         :ctmpMessageID;
                          callID            :ctmpCallID;
                          duration          :ctmpINT;
                          termination       :ctmpTermination_Def) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiQueryVoiceAttribute( gate                  :ctmpGateID;
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
{}
{
function nxcapiRecordMessage( gate            :ctmpGateID;
                            invokeID        :ctmpInvokeID;
                            callID          :ctmpCallID;
                            encodingAlgorithm   :ctmpEncodingAlgorithm_Def;
                            maxDuration         :ctmpINT;
                            termination         :ctmpTermination_Def;
                            var messageID       :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiReposition( gate           :ctmpGateID;
                         invokeID       :ctmpInvokeID;
                         callID         :ctmpCallID;
                         position       :ctmpINT;
                         messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiResume( gate               :ctmpGateID;
                     invokeID           :ctmpInvokeID;
                     callID             :ctmpCallID;
                     messageID          :ctmpMessageID;
                     duration           :ctmpINT) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiReview( gate           :ctmpGateID;
                     invokeID       :ctmpInvokeID;
                     callID         :ctmpCallID;
                     period         :ctmpINT;
                     messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSetVoiceAttributeRecordingLevel( gate              :ctmpGateID;
                                              invokeID          :ctmpInvokeID;
                                              callID            :ctmpCallID;
                                              recordingLevel    :ctmpINT;
                                              messageID         :ctmpMessageID) :u_int; stdcall; external DLLNAME;
{ CSTA Only }
{}
{
function nxcapiSetVoiceAttributeSpeakerVolume( gate           :ctmpGateID;
                                             invokeID       :ctmpInvokeID;
                                             callID         :ctmpCallID;
                                             speakerVolume  :ctmpINT;
                                             messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;
{ CSTA Only }
{}
{
function nxcapiSetVoiceAttributeSpeed( gate           :ctmpGateID;
                                     invokeID       :ctmpInvokeID;
                                     callID         :ctmpCallID;
                                     speed          :ctmpINT;
                                     messageID      :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiStop( gate         :ctmpGateID;
                   invokeID     :ctmpInvokeID;
                   callID       :ctmpCallID;
                   messageID    :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSuspend( gate          :ctmpGateID;
                      invokeID      :ctmpInvokeID;
                      callID        :ctmpCallID;
                      messageID     :ctmpMessageID) :u_int; stdcall; external DLLNAME;

{ CSTA Only }
{}
{
function nxcapiSynthesizeMessage( gate                :ctmpGateID;
                                invokeID            :ctmpInvokeID;
                                textToSynthesizer   :ctmpIOData;
                                sex                 :ctmpSex_Def;
                                language            :ctmpDeviceString;
                                var messageID       :ctmpMessageID) :u_int; stdcall; external DLLNAME;


{ CTMP Function Add	}
{}
{

function nxcapiEventNotify( gate          :ctmpGateID;
                          hWnd          :HWND;
                          messageid     :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiGetEventPoll( gate         :ctmpGateID;
                           var responsInfo  :ctmpResponseInfo_rtn;
                           var responsData  :ctmpResponseData) :u_int; stdcall; external DLLNAME;

{}
{
function ctmpCallBackCampaign( gate                :ctmpGateID;
                               invokeID            :ctmpInvokeID;
                               ciodID              :ctmpINT;
                               count               :ctmpINT;
                               var callbackCamp    :ctmpCallbackCampaign_) :u_int; stdcall; external DLLNAME;

{}
{
function ctmpCallBackListInsert( gate                :ctmpGateID;
                                 invokeID            :ctmpInvokeID;
                                 ciodID              :ctmpINT;
                                 var callback        :ctmpCallbackData;
                                 var callbackRtn     :ctmpCallbackData_rtn) :u_int; stdcall; external DLLNAME;

// 캠페인 생성 함수
{}
{
function ctmpCreateCampaign( gate                :ctmpINT;
                             invokeID            :ctmpSHORT;
                             var campaignId      :ctmpINT;
                             var campaign        :ctmpCampaignMaster) :u_int; stdcall; external DLLNAME; //2011.03.03 이름 그대로임
{}
//// 8월 9일 수요일  대기율 구하는 함수
{}
{
function nxcapiReadyRateGet( gate                :ctmpINT;
                           invokeID            :ctmpSHORT;
                           QueueDn             :ctmpINT;
                           var readyrate       :ctmpFLOAT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiCounselResult( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            var coulselResult   :ctmpConselResult) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentSkillGet( gate                :ctmpGateID;
                            invokeID            :ctmpInvokeID;
                            maxCount            :ctmpSHORT;
                            nSkill              :ctmpINT;
                            var skillAgent      :ctmpSkillAgent;
                            var readCount       :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetAgentBlocking( gate                :ctmpGateID;
                               invokeID            :ctmpInvokeID;
                               agentID             :ctmpDeviceString;
                               btime               :ctmpINT ) :u_int; stdcall; external DLLNAME;  //agentID 변경, btime추가            :ctmpINT 2011.03.03

//*상담원이 "이석"을 미리 예약하므로써, 해당 상담원을 예측 Dialing에서 제외한다.*/
{}
{
function nxcapiSetAgentLeavingFlag( gate                :ctmpGateID;          //Gate ID
                                  invokeID            :ctmpInvokeID;        //Invoke ID
                                  deviceDN            :ctmpDeviceString;    //사용 안 함.(확장용)
                                  agentLeavingFlag    :ctmpINT;             //0:예약취소, 1:이석예약
                                  uiTimeOut           :ctmpINT;             //자동이석 예정시간(초단위)
                                  agentId             :ctmpDeviceString;    //Agent ID
                                  agentData           :ctmpDeviceString;    //사용안함.(확장용)
                                  agentGroup          :ctmpDeviceString;    //사용안함.(확장용)
                                  reasoncode          :ctmpINT              //사용안함.(확장용)
                                ) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiGetMaxCPSQ( gate                :ctmpINT;          //Gate ID
                         invokeID            :ctmpSHORT;        //Invoke ID
                         ciodID              :ctmpINT;
                         cpid                :ctmpINT;
                         maxcpsq             :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiBlackListInsert( gate                :ctmpINT;          //Gate ID
                              invokeID            :ctmpSHORT;        //Invoke ID
                              ciod                :ctmpINT;
                              var blst            :ctmpBlackList) :u_int; stdcall; external DLLNAME;
{}
{
function nxcapiPreviewMakeCall( gate                :ctmpGateID;
                              invokeID            :ctmpSHORT;
                              ciod                :ctmpINT;
                              cpid                :ctmpINT;
                              cpsq                :ctmpINT;
//                              agentId             :ctmpINT; //2011.03.03
                              agentID             :ctmpDeviceString;
                              dialkind            :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiSetUEIData( gate                :ctmpGateID;
                         invokeID            :ctmpSHORT;
                         ServerID            :ctmpCHAR;
                         var ActiveCall      :ctmpConnectionID;
                         var UEI             :ctmpUEI) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentStatusGet( gate                :ctmpGateID;
                             invokeID            :ctmpSHORT;
                             mode                :ctmpINT;
                             maxcnt              :ctmpINT;
                             group               :ctmpINT;
                             part                :ctmpINT;
                             var status          :ctmpAgentStatus;
                             var rtnCount        :ctmpINT;
                             orderby             :ctmpINT = 0) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiWaitAgentInQueueGet( gate                :ctmpGateID;
                                  invokeID            :ctmpSHORT;
                                  queueDN             :ctmpINT;
                                  var waitAgentCnt    :ctmpINT;
                                  var waitTime        :ctmpINT;
                                  var waitCount       :ctmpSHORT) :u_int; stdcall; external DLLNAME;



// Softphone (callmanager) API
// 당분간 함수 제외


//  Extended Switching Service
{}
{
function nxcapiRemoteCentersGet( gate               :ctmpGateID;
                               invokeID           :ctmpInvokeID;
                               var remoteCenter   :ctmpRemoteCenter;
                               remoteCenterCount  :ctmpSHORT;
                               var centerCount    :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentBusyGetII( gate               :ctmpGateID;
                             center             :ctmpCenterID;
                             invokeID           :ctmpInvokeID;
                             AgentGroup         :ctmpSHORT;
                             AgentPart          :ctmpSHORT;
                             maxCount           :ctmpSHORT;
                             var BusyAgent      :TReadyBusy;
                             var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentBusyGetCountII( gate               :ctmpGateID;
                                  center             :ctmpCenterID;
                                  invokeID           :ctmpInvokeID;
                                  AgentGroup         :ctmpSHORT;
                                  AgentPart          :ctmpSHORT;
                                  maxCount           :ctmpSHORT;
                                  var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentBusyGetValueII( gate               :ctmpGateID;
                                  center             :ctmpCenterID;
                                  invokeID           :ctmpInvokeID;
                                  count              :ctmpSHORT;
                                  var agentId        :ctmpDeviceString;  //ctmpINT; 2011.03.03
                                  var deviceDN       :ctmpINT;
                                  var blendMode      :ctmpMode_Def;
                                  var countinueTime  :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentReadyGetII( gate               :ctmpGateID;
                              center             :ctmpCenterID;
                              invokeID           :ctmpInvokeID;
                              AgentGroup         :ctmpSHORT;
                              AgentPart          :ctmpSHORT;
                              maxCount           :ctmpSHORT;
                              var readyAgent     :TReadyAgent;
                              var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiAgentReadyGetCountII( gate               :ctmpGateID;
                                   center             :ctmpCenterID;
                                   invokeID           :ctmpInvokeID;
                                   AgentGroup         :ctmpSHORT;
                                   AgentPart          :ctmpSHORT;
                                   maxCount           :ctmpSHORT;
                                   var readCount      :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryAgentStatusExII( gate               :ctmpGateID;
                                   center             :ctmpCenterID;
                                   invokeID           :ctmpInvokeID;
//                                   agentID            :ctmpINT;
                                   agentID            :ctmpDeviceString; //2011.03.03

                                   deviceDN           :ctmpINT;
//                                   var queryAgentID   :ctmpINT;
                                   var queryagentID        :ctmpDeviceString; //2011.03.03
                                   var queryAgentMode :ctmpAgentMode_Def;
                                   var queryAgentDN   :ctmpINT;
                                   var queryAgentblendMode:ctmpMode_Def;
                                   var queryAgentblockMode:ctmpMode_Def;
                                   var queryAgentTime :ctmpINT;
                                   var queryAgentType :ctmpAgentType_Def) : u_int; stdcall; external DLLNAME;

{}
{
function nxcapiWaitTimeGetEx( gate               :ctmpgateID;
                            invokeID           :ctmpInvokeID;
                            groupDN            :ctmpINT;
                            queueDN            :ctmpINT;
                            var waitTime       :ctmpINT;
                            var waitCount      :ctmpSHORT) :u_int; stdcall; external DLLNAME;

{}


function nxcapiPwdConfirm( gate            :ctmpGateID;
                           invokeID        :ctmpInvokeID;
                           deviceDN        :ctmpINT;
                           confirm         :ctmpINT;
                           var UEI         :ctmpUEI) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiLoginPwd( gate           :ctmpGateID;
                       invokeID       :ctmpInvokeID;
                       agentid        :ctmpINT;
                       pwd            :ctmpPwdString;
                       agnetname      :ctmpNameString) :u_int; stdcall; external DLLNAME;
{} //2011.03.03

{}
{
function nxcapiQueryRoutePointInfoEx( gate               :ctmpGateID;
                                    invokeID           :ctmpInvokeID;
                                    maxcnt             :ctmpINT;
                                    RoutePoint         :ctmpINT;
                                    var RoutePointInfo :ctmpRoutePointInfoEx) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiQueryDNISInfo( gate             :ctmpGateID;
                            invokeID         :ctmpInvokeID;
                            maxcnt           :ctmpINT;
                            DNIS             :ctmpINT;
                            var DNISInfo     :ctmpDNISInfo;
                            var count        :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiPreviewCampaignDescGet( gate                :ctmpGateID;
                                     invokeID            :ctmpInvokeID;
                                     ciodID              :ctmpINT;
                                     campaignID          :ctmpINT;
                                     var PreviewCampaign :ctmpPreviewCampaignDesc;
                                     var rtnCount        :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiPreviewDataHandle( gate                   :ctmpGateID;
                                invokeID               :ctmpInvokeID;
                                ciodID                 :ctmpINT;
                                campaignID             :ctmpINT;
                                readmode               :ctmpINT;
                                var ctmpPreviewData    :ctmpPreviewData) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiCounselMasterCode( gate                   :ctmpGateID;
                                invokeID               :ctmpInvokeID;
                                var counselresult      :ctmpCounselResultExMaster;
                                var readcount          :ctmpINT) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiPreviewResultEx( gate                   :ctmpGateID;
                              invokeID               :ctmpInvokeID;
                              var counselresult      :ctmpCounselResultEx) :u_int; stdcall; external DLLNAME;

{}
{
function nxcapiBlackListIIInsert( gate                  :ctmpINT;
                                invokeID              :ctmpSHORT;
                                ciod                  :ctmpINT;
                                var blst              :ctmpBlackListII) :u_int; stdcall; external DLLNAME;
{}
{
function nxcapiSendUserData( gate                  :ctmpGateID;
                           invokeID              :ctmpInvokeID;
                           deviceDN              :ctmpINT;
                           myDn                  :ctmpINT;
                           code                  :ctmpINT;
                           appName               :ctmpApplString;
                           var privateData       :ctmpPrivateData;
                           var UEI               :ctmpUEI) :u_int; stdcall; external DLLNAME;
{}
{
function nxcapiQueryAnalogDnStatus( gate                :ctmpGateID;
                                  invokeID            :ctmpInvokeID;
                                  var analogdn        :ctmpAnalogDn;
                                  var readcnt         :ctmpINT) :u_int; stdcall; external DLLNAME;
{}

implementation

end.
