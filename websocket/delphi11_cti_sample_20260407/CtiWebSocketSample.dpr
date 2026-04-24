program CtiWebSocketSample;
uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FrmMain},
  CallListForm in 'CallListForm.pas' {FrmCallList},
  xtrmPHONELib in 'xtrmPHONELib.pas';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
