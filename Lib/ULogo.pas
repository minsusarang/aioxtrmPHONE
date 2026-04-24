unit ULogo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls;

type
  TFLogo = class(TForm)
    Image1: TImage;
    Label1: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogo: TFLogo;

implementation

{$R *.DFM}

procedure TFLogo.FormCreate(Sender: TObject);
begin
  with Self do
  begin
    Caption := 'Logo ' + Application.Title;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);
  end;
end;

procedure TFLogo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFLogo.FormActivate(Sender: TObject);
begin
//
end;

end.
