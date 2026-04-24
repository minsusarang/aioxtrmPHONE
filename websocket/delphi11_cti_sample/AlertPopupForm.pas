unit AlertPopupForm;

interface

uses
  Windows, Classes, Controls, ExtCtrls, Forms, Graphics, StdCtrls, Types;

type
  TAlertPopupForm = class(TForm)
  private
    FHideTimer: TTimer;
    FMessageLabel: TLabel;
    procedure HideTimerTimer(Sender: TObject);
    procedure PositionPopup;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ShowAlert(const AMessage: string);
    procedure HideAlert;
  end;

implementation

constructor TAlertPopupForm.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  BorderStyle := bsNone;
  BorderIcons := [];
  Position := poDesigned;
  FormStyle := fsStayOnTop;
  Color := RGB(60, 63, 92);
  Font.Name := 'Segoe UI';
  Font.Size := 10;
  ClientWidth := 320;
  ClientHeight := 92;

  FMessageLabel := TLabel.Create(Self);
  FMessageLabel.Parent := Self;
  FMessageLabel.SetBounds(16, 14, 288, 64);
  FMessageLabel.Alignment := taCenter;
  FMessageLabel.Layout := tlCenter;
  FMessageLabel.AutoSize := False;
  FMessageLabel.WordWrap := True;
  FMessageLabel.Font.Name := 'Segoe UI Semibold';
  FMessageLabel.Font.Size := 10;
  FMessageLabel.Font.Color := clWhite;
  FMessageLabel.Transparent := True;

  FHideTimer := TTimer.Create(Self);
  FHideTimer.Enabled := False;
  FHideTimer.Interval := 5000;
  FHideTimer.OnTimer := HideTimerTimer;
end;

procedure TAlertPopupForm.PositionPopup;
var
  LWorkArea: TRect;
begin
  if Assigned(Application.MainForm) then
    LWorkArea := Screen.MonitorFromWindow(Application.MainForm.Handle).WorkareaRect
  else
    LWorkArea := Screen.PrimaryMonitor.WorkareaRect;

  SetBounds(LWorkArea.Right - Width - 16, LWorkArea.Bottom - Height - 16, Width, Height);
end;

procedure TAlertPopupForm.ShowAlert(const AMessage: string);
begin
  FMessageLabel.Caption := AMessage;
  PositionPopup;
  Show;
  BringToFront;
  FHideTimer.Enabled := False;
  FHideTimer.Enabled := True;
end;

procedure TAlertPopupForm.HideAlert;
begin
  FHideTimer.Enabled := False;
  Hide;
end;

procedure TAlertPopupForm.HideTimerTimer(Sender: TObject);
begin
  HideAlert;
end;

end.
