unit CallListForm;

interface

uses
  Winapi.Windows,
  System.Classes,
  System.IniFiles,
  System.Math,
  System.SysUtils,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.StdCtrls;

type
  TFrmCallList = class(TForm)
    pnlHeader: TPanel;
    lblTitle: TLabel;
    lblSubtitle: TLabel;
    pnlFooter: TPanel;
    btnReload: TButton;
    btnSave: TButton;
    btnClose: TButton;
    PageControl: TPageControl;
    tabOutbound: TTabSheet;
    tabInbound: TTabSheet;
    grdOutbound: TStringGrid;
    grdInbound: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnReloadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FIniFileName: string;
    procedure ApplyTheme;
    procedure InitGrid(AGrid: TStringGrid);
    procedure LoadFromIni;
    procedure SaveToIni;
    procedure LoadGridFromIni(const ASection: string; AGrid: TStringGrid);
    procedure SaveGridToIni(const ASection: string; AGrid: TStringGrid);
  end;

var
  FrmCallList: TFrmCallList;

implementation

{$R *.dfm}
{$WARN IMPLICIT_STRING_CAST OFF}

procedure TFrmCallList.ApplyTheme;
begin
  Color := RGB(241, 233, 223);
  Font.Name := 'Segoe UI';
  Font.Size := 9;

  pnlHeader.Color := RGB(84, 58, 40);
  pnlHeader.ParentBackground := False;
  lblTitle.Font.Color := clWhite;
  lblSubtitle.Font.Color := RGB(226, 209, 192);

  pnlFooter.Color := RGB(222, 210, 196);
  pnlFooter.ParentBackground := False;

  grdOutbound.Color := RGB(252, 248, 243);
  grdOutbound.FixedColor := RGB(117, 82, 57);
  grdInbound.Color := RGB(252, 248, 243);
  grdInbound.FixedColor := RGB(117, 82, 57);
end;

procedure TFrmCallList.InitGrid(AGrid: TStringGrid);
begin
  AGrid.ColCount := 5;
  AGrid.FixedRows := 1;
  AGrid.FixedCols := 0;
  AGrid.DefaultRowHeight := 28;
  AGrid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goRowSelect];
  AGrid.Cells[0, 0] := '일자';
  AGrid.Cells[1, 0] := '시간';
  AGrid.Cells[2, 0] := '발신';
  AGrid.Cells[3, 0] := '수신';
  AGrid.Cells[4, 0] := '전화번호';
  AGrid.ColWidths[0] := 120;
  AGrid.ColWidths[1] := 90;
  AGrid.ColWidths[2] := 150;
  AGrid.ColWidths[3] := 150;
  AGrid.ColWidths[4] := 150;
  AGrid.RowCount := Max(AGrid.RowCount, 2);
end;

procedure TFrmCallList.FormCreate(Sender: TObject);
begin
  FIniFileName := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'calllist.ini';
  ApplyTheme;
  InitGrid(grdOutbound);
  InitGrid(grdInbound);
  LoadFromIni;
end;

procedure TFrmCallList.LoadFromIni;
begin
  LoadGridFromIni('Outbound', grdOutbound);
  LoadGridFromIni('Inbound', grdInbound);
end;

procedure TFrmCallList.SaveToIni;
begin
  SaveGridToIni('Outbound', grdOutbound);
  SaveGridToIni('Inbound', grdInbound);
end;

procedure TFrmCallList.LoadGridFromIni(const ASection: string; AGrid: TStringGrid);
var
  LIni: TIniFile;
  LCount: Integer;
  LRow: Integer;
begin
  LIni := TIniFile.Create(FIniFileName);
  try
    LCount := LIni.ReadInteger(ASection, 'Count', 0);
    AGrid.RowCount := Max(LCount + 1, 2);
    InitGrid(AGrid);

    for LRow := 1 to AGrid.RowCount - 1 do
    begin
      AGrid.Cells[0, LRow] := LIni.ReadString(ASection, Format('Item%dDate', [LRow - 1]), '');
      AGrid.Cells[1, LRow] := LIni.ReadString(ASection, Format('Item%dTime', [LRow - 1]), '');
      AGrid.Cells[2, LRow] := LIni.ReadString(ASection, Format('Item%dSender', [LRow - 1]), '');
      AGrid.Cells[3, LRow] := LIni.ReadString(ASection, Format('Item%dReceiver', [LRow - 1]), '');
      AGrid.Cells[4, LRow] := LIni.ReadString(ASection, Format('Item%dPhone', [LRow - 1]), '');
    end;
  finally
    LIni.Free;
  end;
end;

procedure TFrmCallList.SaveGridToIni(const ASection: string; AGrid: TStringGrid);
var
  LIni: TIniFile;
  LRow: Integer;
  LSaveIndex: Integer;
  LHasValue: Boolean;
begin
  LIni := TIniFile.Create(FIniFileName);
  try
    LIni.EraseSection(ASection);
    LSaveIndex := 0;

    for LRow := 1 to AGrid.RowCount - 1 do
    begin
      LHasValue :=
        (Trim(AGrid.Cells[0, LRow]) <> '') or
        (Trim(AGrid.Cells[1, LRow]) <> '') or
        (Trim(AGrid.Cells[2, LRow]) <> '') or
        (Trim(AGrid.Cells[3, LRow]) <> '') or
        (Trim(AGrid.Cells[4, LRow]) <> '');

      if not LHasValue then
        Continue;

      LIni.WriteString(ASection, Format('Item%dDate', [LSaveIndex]), AGrid.Cells[0, LRow]);
      LIni.WriteString(ASection, Format('Item%dTime', [LSaveIndex]), AGrid.Cells[1, LRow]);
      LIni.WriteString(ASection, Format('Item%dSender', [LSaveIndex]), AGrid.Cells[2, LRow]);
      LIni.WriteString(ASection, Format('Item%dReceiver', [LSaveIndex]), AGrid.Cells[3, LRow]);
      LIni.WriteString(ASection, Format('Item%dPhone', [LSaveIndex]), AGrid.Cells[4, LRow]);
      Inc(LSaveIndex);
    end;

    LIni.WriteInteger(ASection, 'Count', LSaveIndex);
  finally
    LIni.Free;
  end;
end;

procedure TFrmCallList.btnReloadClick(Sender: TObject);
begin
  LoadFromIni;
end;

procedure TFrmCallList.btnSaveClick(Sender: TObject);
begin
  SaveToIni;
end;

procedure TFrmCallList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
