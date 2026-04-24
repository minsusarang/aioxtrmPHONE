{/==============================================================================
  Name : varRec
  Name-kr : 녹취서버 공통 var
  Ver : 1.0.0.0
  Description : 녹취서버에서 공통으로 사용할 var 선언
  Changes :
    2005. 02. 28 : 1.0.0.0 녹취서버 공통 var 생성
//=============================================================================}
unit varRec;

interface

Uses
  Classes;

type
  //녹취서버 정보
  TRecServRec = record
    RecGB     : Integer; //[0:No|1:동방|2:Nice|3:VTM]
    RecRepeat : Integer;
    RecIP     : String;
    RecPort   : String;
  end;

  //녹취 정보
  TRecordRec = record
    IsRec     : Boolean;
    IsDualRec : Boolean;
    MainServ  : TRecServRec;
    SubServ   : TRecServRec;
  end;

  //녹취데이타
  TRecDataRec = record
    Station     : String;
    AgentID     : String;
    AgentNM     : String;
    PhoneNumber : String;
    CID         : String;
    CallID      : String;
    Contract    : String;
    JuminNo     : String;
    CallType    : String;
  end;

const
  TRecSvrListArr: array[0..3] of String=('None',
                                         'DongBang',
                                         'Nice',
                                         'VTM');
  gSvrDB   = 1;
  gSvrNice = 2;
  gSvrVTM  = 3;
var
  RecordRec: TRecordRec;//녹취관련 서버정보
  RecDataRec: TRecDataRec;//녹취서버에 저장될 DATA

  FLogName: String;//로그파일명

  //서버연결관련 변수2개
  TRecSvrConnArr: array[0..1] of Boolean;//0:main|1:sub
  //녹취성공여부관련 변수2개
  TRecResultArr: array[0..1] of Boolean;//0:main|1:sub

implementation

end.
