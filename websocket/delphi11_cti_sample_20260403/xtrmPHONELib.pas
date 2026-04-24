unit xtrmPHONELib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, JSON;

type
  TxtrmPHONELib = class(TObject)
  public
    procedure GetOption: Boolean;
  end;

  TOptionRec = record//옵션 정보
    IsAutoAnswer: Boolean;        //자동 전화받기
    IsCatchCall: Boolean;         //전화받기 팝업
    IsTelNumberNoCheck: Boolean;  //전화번호 포멧체크
    IsPhoneBookHisDay: Integer;   //전화번호 수발신 보관기간(day)
    IsAccessCode: Boolean;        // 발신 탭코드
  end;
var
  OptionRec: TOptionRec;
  xtrmPHONELib:  TxtrmPHONELib;
implementation

procedure TxtrmPHONELib.GetOption: boolean;
var
  I: Integer;
begin
  try
    //
  except
    Result := False;
  end;
end;
end.
