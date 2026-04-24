{/==============================================================================
  Name : LibDBRec
  Name-kr : 동방녹취서버Lib
  Ver : 1.0.0.1
  Description : 동방녹취서버용 DLL Lib
  Changes :
    2005. 02. 28 : 1.0.0.1 각 녹취서버별로 Lib 분리
    2004. 04. 20 : 1.0.0.0 Nice+동방 통합 Lib 구성
//=============================================================================}
unit LibDBRec;

interface

uses
  Sysutils, varRec, libRec;

const
  {rec}
  RECDLLFNC1 = 'Dbic_rec.dll';
  {wav Changer}
  SAVEDLLFNC1 = 'g723_wav_dll.dll';


  {Rec}
//1. 녹음 시작함수 - 인자값(녹취IP, 녹취Port, 녹음내선번호(4), CID(15), PCS번호(15), 상담원ID(8), 상담원이름(10))
function Rec_Start(IP, Port, Device ,CID, PCS, S_ID, S_NAME:PChar):Boolean; stdcall; External RECDLLFNC1;
//2. 녹음 종료함수 - 인자값(녹취IP, 녹취Port, 녹음내선번호(4))
function Rec_Stop(IP, Port, Device: PChar): Boolean; stdcall; External RECDLLFNC1;
//3. 녹음 마킹지정 - 인자값(녹취IP, 녹취Port, 녹음내선번호(4))
function Rec_Marking(IP, Port, Device: PChar): Boolean; stdcall; External RECDLLFNC1;


  {wav Changer}
function g723_wav_convert(G723File, WavFile: PChar): Boolean; stdcall; External SAVEDLLFNC1;


    //========================================================
    function DBRecStart(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;
    function DBRecStop(AServRec: TRecServRec; ADataRec: TRecDataRec): Boolean;


implementation

function DBRecStart(AServRec: TRecServRec; ADataRec: TRecDataRec; nLoopCount: Integer=1): Boolean;
  function RecStart(nCnt: Integer): Integer;
  var
    bRtn: Boolean;
  begin
    with ADataRec do
      FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrDB], 'RacDataRec', 'value', '', Station+','+AgentID+','+AgentNM+','+PhoneNumber+','+CID+','+CallID+','+Contract+','+JuminNo+','+CallType+','+AServRec.RecIP+','+AServRec.RecPort));
    try
      bRtn := Rec_Start(PChar(AServRec.RecIP), PChar(AServRec.RecPort),
                        PChar(ADataRec.Station), PChar(ADataRec.CID),
                        PChar(ADataRec.PhoneNumber),
                        PChar(ADataRec.AgentID), PChar(ADataRec.AgentNM));
    except
      bRtn := False;
    end;
    if bRtn then Result := 0
    else Result := 1;
    FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrDB], 'Rec_Start', 'process'+IntToStr(nCnt), IntToStr(Result), '동방 녹취 '+IntToStr(nCnt)+'차 시도'));
  end;
var
  nLoop, nResult: Integer;
begin
  Result := False;
  nResult := 1;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrDB], 'DBRecStart', 'start', ''));
  for nLoop := 1 to nLoopCount do
  begin
    nResult := RecStart(nLoop);
    case nResult of
      0 : break;
    end;
  end;
  Result := nResult=0;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrDB], 'DBRecStart', 'end', ''));
end;

function DBRecStop(AServRec: TRecServRec; ADataRec: TRecDataRec): Boolean;
var
  nResult: Integer;
begin
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrDB], 'DBRecStop', 'start', ''));
  try
    Result := Rec_Stop(PChar(AServRec.RecIP), PChar(AServRec.RecPort), PChar(ADataRec.Station));
  except
    Result := False;
  end;
  if Result then nResult := 0
  else nResult := 1;
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrDB], 'Rec_Stop', 'process', IntToStr(nResult), '동방 녹취 종료'));
  FRecLog.Log(FRecLog.LogValue(TRecSvrListArr[gSvrDB], 'DBRecStop', 'end', ''));
end;

end.




