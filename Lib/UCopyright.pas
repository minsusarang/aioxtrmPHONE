unit UCopyright;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls;
//,GIFImage

type
  TFCopyright = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure LabelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCopyright: TFCopyright;

implementation

{$R *.DFM}

procedure TFCopyright.FormClick(Sender: TObject);
begin
  Close;
end;

procedure TFCopyright.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFCopyright.LabelClick(Sender: TObject);
begin
  Close;
end;

end.
