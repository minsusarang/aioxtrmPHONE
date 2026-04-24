object FrmCallList: TFrmCallList
  Left = 0
  Top = 0
  Caption = #53084' '#51060#47141
  ClientHeight = 640
  ClientWidth = 980
  Color = 15850207
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 980
    Height = 88
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 976
    object lblTitle: TLabel
      Left = 24
      Top = 16
      Width = 126
      Height = 32
      Caption = 'Call History'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object lblSubtitle: TLabel
      Left = 26
      Top = 54
      Width = 284
      Height = 15
      Caption = #48156#49888' / '#49688#49888' '#47532#49828#53944#47484' INI '#54028#51068#47196' '#48520#47084#50724#44256' '#51200#51109#54633#45768#45796'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14864832
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 580
    Width = 980
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 579
    ExplicitWidth = 976
    DesignSize = (
      980
      60)
    object btnReload: TButton
      Left = 24
      Top = 14
      Width = 100
      Height = 30
      Caption = #45796#49884' '#48520#47084#50724#44592
      TabOrder = 0
      OnClick = btnReloadClick
    end
    object btnSave: TButton
      Left = 132
      Top = 14
      Width = 100
      Height = 30
      Caption = #51200#51109
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnClose: TButton
      Left = 852
      Top = 14
      Width = 100
      Height = 30
      Anchors = [akTop, akRight]
      Caption = #45803#44592
      TabOrder = 2
      OnClick = btnCloseClick
      ExplicitLeft = 848
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 88
    Width = 980
    Height = 492
    ActivePage = tabInbound
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 976
    ExplicitHeight = 491
    object tabOutbound: TTabSheet
      Caption = #48156#49888' '#47532#49828#53944
      object grdOutbound: TStringGrid
        Left = 0
        Top = 0
        Width = 972
        Height = 462
        Align = alClient
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goRowSelect]
        TabOrder = 0
        ExplicitWidth = 968
        ExplicitHeight = 461
      end
    end
    object tabInbound: TTabSheet
      Caption = #49688#49888' '#47532#49828#53944
      ImageIndex = 1
      object grdInbound: TStringGrid
        Left = 0
        Top = 0
        Width = 972
        Height = 462
        Align = alClient
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goRowSelect]
        TabOrder = 0
      end
    end
  end
end
