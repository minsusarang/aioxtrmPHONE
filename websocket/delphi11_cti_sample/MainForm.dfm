object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'HYOSUNG ITX(AIO)'
  ClientHeight = 779
  ClientWidth = 1060
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1060
    779)
  TextHeight = 15
  object pan_lbLog: TPanel
    Left = 153
    Top = 0
    Width = 907
    Height = 779
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 903
    ExplicitHeight = 778
    object lblStatus: TLabel
      Left = 0
      Top = 0
      Width = 907
      Height = 15
      Align = alTop
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2827861
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 33
    end
    object lbLog: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 18
      Width = 901
      Height = 427
      Align = alClient
      Color = 16316155
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
      WordWrap = False
      ExplicitWidth = 897
      ExplicitHeight = 426
    end
    object CurvyPanel1: TCurvyPanel
      AlignWithMargins = True
      Left = 3
      Top = 451
      Width = 901
      Height = 325
      Align = alBottom
      Caption = ''
      TabOrder = 1
      ExplicitTop = 450
      ExplicitWidth = 897
      object lblWebSocket: TLabel
        Left = 24
        Top = 3
        Width = 96
        Height = 15
        Caption = '1. WebSocket URL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2827861
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object lblUserId: TLabel
        Left = 297
        Top = 3
        Width = 52
        Height = 15
        Caption = '2. User ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2827861
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object lblPhoneId: TLabel
        Left = 410
        Top = 3
        Width = 63
        Height = 15
        Caption = '3. Phone ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2827861
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object lblInitMode: TLabel
        Left = 512
        Top = 3
        Width = 52
        Height = 15
        Caption = 'Init Mode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2827861
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object lblTransferNumber: TLabel
        Left = 24
        Top = 149
        Width = 89
        Height = 15
        Caption = 'Transfer Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2827861
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object edtWebSocketUrl: TEdit
        Left = 24
        Top = 24
        Width = 267
        Height = 23
        TabOrder = 0
      end
      object edtUserId: TEdit
        Left = 297
        Top = 24
        Width = 107
        Height = 23
        TabOrder = 1
      end
      object edtPhoneId: TEdit
        Left = 410
        Top = 24
        Width = 93
        Height = 23
        TabOrder = 2
      end
      object btnCampaign: TButton
        Left = 144
        Top = 53
        Width = 97
        Height = 25
        Caption = #52896#54168#51064
        TabOrder = 3
        OnClick = btnCampaignClick
      end
      object btnRecord: TButton
        Left = 256
        Top = 53
        Width = 71
        Height = 25
        Caption = #48512#48516#45433#52712#49884#51089
        TabOrder = 4
        OnClick = btnRecordClick
      end
      object btnHijack: TButton
        Left = 340
        Top = 53
        Width = 61
        Height = 25
        Caption = #45817#44200#48155#44592
        TabOrder = 5
        OnClick = btnHijackClick
      end
      object cbInitMode: TComboBox
        Left = 509
        Top = 24
        Width = 121
        Height = 23
        Style = csDropDownList
        TabOrder = 6
      end
      object chkOverrideLogin: TCheckBox
        Left = 636
        Top = 27
        Width = 81
        Height = 17
        Caption = 'Override'
        TabOrder = 7
      end
      object chkAutoReconnect: TCheckBox
        Left = 736
        Top = 27
        Width = 113
        Height = 17
        Caption = 'AutoReconnect'
        TabOrder = 8
      end
      object btnGetState: TButton
        Left = 24
        Top = 93
        Width = 105
        Height = 25
        Caption = #49345#53468#52404#53356
        TabOrder = 9
        OnClick = btnGetStateClick
      end
      object btnClearLog: TButton
        Left = 136
        Top = 93
        Width = 105
        Height = 25
        Caption = #47196#44536#51648#50864#44592
        TabOrder = 10
        OnClick = btnClearLogClick
      end
      object btnOutbound: TButton
        Left = 247
        Top = 93
        Width = 105
        Height = 25
        Caption = 'ob'#47784#46300
        TabOrder = 11
        OnClick = btnOutboundClick
      end
      object edtTransferNumber: TEdit
        Left = 24
        Top = 170
        Width = 225
        Height = 23
        TabOrder = 12
      end
      object btnTransferCold: TButton
        Left = 376
        Top = 169
        Width = 105
        Height = 25
        Caption = 'Cold'#54840#51204#54872
        TabOrder = 13
        OnClick = btnTransferColdClick
      end
      object btnTransferWarm: TButton
        Left = 496
        Top = 169
        Width = 105
        Height = 25
        Caption = 'Warm'#54840#51204#54872
        TabOrder = 14
        OnClick = btnTransferWarmClick
      end
      object btnTxComplete: TButton
        Left = 24
        Top = 199
        Width = 95
        Height = 25
        Caption = #51204#54868#50756#47308
        TabOrder = 15
        OnClick = btnTxCompleteClick
      end
      object btnTxCancel: TButton
        Left = 130
        Top = 199
        Width = 95
        Height = 25
        Caption = #51204#54868#52712#49548
        TabOrder = 16
        OnClick = btnTxCancelClick
      end
      object btnTxToggle: TButton
        Left = 342
        Top = 199
        Width = 95
        Height = 25
        Caption = #54924#51088#51204#54872
        TabOrder = 17
        OnClick = btnTxToggleClick
      end
      object btnIvrSsn: TButton
        Left = 456
        Top = 199
        Width = 95
        Height = 25
        Caption = #51452#48124#48264#54840#48155#44592
        TabOrder = 18
        OnClick = btnIvrSsnClick
      end
      object btnIvrAcc: TButton
        Left = 564
        Top = 199
        Width = 95
        Height = 25
        Caption = #44228#51340#48264#54840#48155#44592
        TabOrder = 19
        OnClick = btnIvrAccClick
      end
      object btnIvrRet: TButton
        Left = 672
        Top = 199
        Width = 95
        Height = 25
        Caption = 'IVR'#51204#54872#52712#49548
        TabOrder = 20
        OnClick = btnIvrRetClick
      end
      object edtQueueName: TEdit
        Left = 16
        Top = 232
        Width = 145
        Height = 23
        TabOrder = 21
        Text = 'all'
      end
      object btnQueueAdd: TButton
        Left = 176
        Top = 230
        Width = 89
        Height = 25
        Caption = #53328#47196#44536#51064
        TabOrder = 22
        OnClick = btnQueueAddClick
      end
      object btnQueueSub: TButton
        Left = 272
        Top = 230
        Width = 89
        Height = 25
        Caption = #53328#47196#44536#50500#50883
        TabOrder = 23
        OnClick = btnQueueSubClick
      end
      object btnQueueRun: TButton
        Left = 376
        Top = 278
        Width = 89
        Height = 25
        Caption = #53328#54876#49457#54868
        TabOrder = 24
        OnClick = btnQueueRunClick
      end
      object btnQueuePause: TButton
        Left = 464
        Top = 230
        Width = 89
        Height = 25
        Caption = #53328#48708#54876#49457#54868
        TabOrder = 25
        OnClick = btnQueuePauseClick
      end
      object btnQueueState: TButton
        Left = 568
        Top = 278
        Width = 95
        Height = 25
        Caption = #53328#49345#53468#52404#53356
        TabOrder = 26
        OnClick = btnQueueStateClick
      end
      object btnTeamAgents: TButton
        Left = 24
        Top = 278
        Width = 105
        Height = 25
        Caption = #54016#47716#48260
        TabOrder = 27
        OnClick = btnTeamAgentsClick
      end
      object btnGroupAgents: TButton
        Left = 144
        Top = 278
        Width = 105
        Height = 25
        Caption = #44536#47353#47716#48260
        TabOrder = 28
        OnClick = btnGroupAgentsClick
      end
      object btnCenterAgents: TButton
        Left = 264
        Top = 278
        Width = 105
        Height = 25
        Caption = #51204#52404#47716#48260
        TabOrder = 29
        OnClick = btnCenterAgentsClick
      end
      object btn_CallList: TButton
        Left = 247
        Top = 54
        Width = 49
        Height = 24
        Caption = #44592#47197
        TabOrder = 30
        OnClick = btn_CallListClick
      end
    end
  end
  object pan_MainForm: TShader
    Left = 0
    Top = 0
    Width = 153
    Height = 779
    Align = alLeft
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    FromColor = 15594231
    ToColor = 13162726
    FromColorMirror = 13162726
    ToColorMirror = 13162726
    Direction = False
    Version = '1.4.2.1'
    ExplicitHeight = 778
    object CurvyPanel2: TCurvyPanel
      AlignWithMargins = True
      Left = 4
      Top = 6
      Width = 145
      Height = 72
      Margins.Top = 5
      Align = alTop
      BorderColor = clSilver
      Caption = ''
      TabOrder = 0
      object btn_Board: TAdvGlowButton
        AlignWithMargins = True
        Left = 6
        Top = 8
        Width = 68
        Height = 25
        Cursor = crHandPoint
        Caption = #54637#49345#50948
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #47569#51008' '#44256#46357
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Rounded = False
        TabOrder = 0
        Appearance.BorderColor = 11382963
        Appearance.BorderColorHot = 11565130
        Appearance.BorderColorCheckedHot = 11565130
        Appearance.BorderColorDown = 11565130
        Appearance.BorderColorChecked = 13744549
        Appearance.BorderColorDisabled = 13948116
        Appearance.Color = 8555887
        Appearance.ColorTo = 8555887
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirror = 8555887
        Appearance.ColorMirrorTo = 8555887
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3750459
        Appearance.TextColorDown = 2303013
        Appearance.TextColorHot = 2303013
        Appearance.TextColorDisabled = 13948116
      end
      object AdvGlowButton1: TAdvGlowButton
        AlignWithMargins = True
        Left = 75
        Top = 8
        Width = 64
        Height = 25
        Cursor = crHandPoint
        Caption = #51088#46041#48155#44592
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = #47569#51008' '#44256#46357
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Rounded = False
        TabOrder = 1
        Appearance.BorderColor = 11382963
        Appearance.BorderColorHot = 11565130
        Appearance.BorderColorCheckedHot = 11565130
        Appearance.BorderColorDown = 11565130
        Appearance.BorderColorChecked = 13744549
        Appearance.BorderColorDisabled = 13948116
        Appearance.Color = 8555887
        Appearance.ColorTo = 8555887
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirror = 8555887
        Appearance.ColorMirrorTo = 8555887
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.TextColorChecked = 3750459
        Appearance.TextColorDown = 2303013
        Appearance.TextColorHot = 2303013
        Appearance.TextColorDisabled = 13948116
      end
      object lab_Status_NM: TCurvyEdit
        Left = 7
        Top = 37
        Width = 67
        Height = 24
        BorderColor = clWhite
        Caption = ''
        Color = 15265000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 2
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        Text = #47196#44536#50500#50883
      end
      object lab_Status_Time: TCurvyEdit
        Left = 75
        Top = 37
        Width = 63
        Height = 24
        BorderColor = clWhite
        Caption = ''
        Color = 14937075
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        TabOrder = 3
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        Text = '00:00:00'
      end
    end
    object CurvyPanel3: TCurvyPanel
      AlignWithMargins = True
      Left = 4
      Top = 86
      Width = 145
      Height = 256
      Margins.Top = 5
      Align = alTop
      Caption = ''
      TabOrder = 1
      object edtDialNumber: TCurvyEdit
        Left = 8
        Top = 38
        Width = 129
        Height = 26
        BorderColor = 5539249
        Caption = ''
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 0
        TabStop = False
        Version = '1.2.4.2'
        Controls = <>
        EmptyText = #51204#54868#48264#54840
        ImeName = ''
        ParentFont = False
        Text = ''
      end
      object BtnBreak: TAdvSmoothButton
        Left = 7
        Top = 7
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Nirmala UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #51060'       '#49437
        Color = 4686550
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 1
        Version = '2.2.4.0'
        OnClick = BtnBreakClick
        TMSStyle = 8
      end
      object btnDial: TAdvSmoothButton
        Left = 7
        Top = 67
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #51204#54868#44152#44592
        Color = 8689228
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 2
        Version = '2.2.4.0'
        OnClick = btnDialClick
        TMSStyle = 8
      end
      object btnAnswer: TAdvSmoothButton
        Left = 7
        Top = 98
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #51204#54868#48155#44592
        Color = 8689228
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 3
        Version = '2.2.4.0'
        OnClick = btnAnswerClick
        TMSStyle = 8
      end
      object btnTransfer: TAdvSmoothButton
        Left = 7
        Top = 129
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = 'Attend'#54840#51204#54872
        Color = 4686550
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 4
        Version = '2.2.4.0'
        OnClick = btnTransferClick
        TMSStyle = 8
      end
      object btnTx3Connect: TAdvSmoothButton
        Left = 7
        Top = 160
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #49340#51088#53685#54868
        Color = 4686550
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 5
        Version = '2.2.4.0'
        OnClick = btnTx3ConnectClick
        TMSStyle = 8
      end
      object btnHold: TAdvSmoothButton
        Left = 7
        Top = 191
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #53685#54868#48372#47448
        Color = 8689228
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 6
        Version = '2.2.4.0'
        OnClick = btnHoldClick
        TMSStyle = 8
      end
      object btnHangup: TAdvSmoothButton
        Left = 7
        Top = 222
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #51204#54868#45130#44592
        Color = 8689228
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 7
        Version = '2.2.4.0'
        OnClick = btnHangupClick
        TMSStyle = 8
      end
    end
    object CurvyPanel4: TCurvyPanel
      AlignWithMargins = True
      Left = 4
      Top = 617
      Width = 145
      Height = 104
      Margins.Top = 5
      Align = alTop
      Caption = ''
      TabOrder = 2
      object btnConnect: TAdvSmoothButton
        Left = 7
        Top = 6
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #47196'  '#44536'  '#51064
        Color = 8689228
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 0
        Version = '2.2.4.0'
        OnClick = btnConnectClick
        TMSStyle = 8
      end
      object btnDisconnect: TAdvSmoothButton
        Left = 7
        Top = 37
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #47196#44536#50500#50883
        Color = 4686550
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 1
        Version = '2.2.4.0'
        OnClick = btnDisconnectClick
        TMSStyle = 8
      end
      object btnClose: TAdvSmoothButton
        Left = 7
        Top = 68
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #51333'       '#47308
        Color = 4686550
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 2
        Version = '2.2.4.0'
        OnClick = btnCloseClick
        TMSStyle = 8
      end
    end
    object CurvyPanel6: TCurvyPanel
      AlignWithMargins = True
      Left = 4
      Top = 729
      Width = 145
      Height = 46
      Margins.Top = 5
      Align = alTop
      Caption = ''
      TabOrder = 3
    end
    object CurvyPanel7: TCurvyPanel
      AlignWithMargins = True
      Left = 4
      Top = 428
      Width = 145
      Height = 181
      Margins.Top = 5
      Align = alTop
      Caption = ''
      TabOrder = 4
      object edtDuration: TCurvyEdit
        Left = 69
        Top = 35
        Width = 68
        Height = 26
        BorderColor = 5539249
        Caption = ''
        Color = 14674161
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 0
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        ReadOnly = True
        Text = ''
      end
      object edtSrtTime: TCurvyEdit
        Left = 70
        Top = 7
        Width = 68
        Height = 26
        BorderColor = 5539249
        Caption = ''
        Color = 14674161
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 1
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        ReadOnly = True
        Text = '09:00:00'
      end
      object edtEndTime: TCurvyEdit
        Left = 69
        Top = 64
        Width = 68
        Height = 26
        BorderColor = 5539249
        Caption = ''
        Color = 14674161
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 2
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        ReadOnly = True
        Text = ''
      end
      object edtRec: TCurvyEdit
        Left = 49
        Top = 121
        Width = 88
        Height = 26
        BorderColor = 5539249
        Caption = ''
        Color = 14674161
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 3
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        ReadOnly = True
        Text = ''
      end
      object edtInOut: TCurvyEdit
        Left = 69
        Top = 93
        Width = 68
        Height = 26
        BorderColor = 5539249
        Caption = ''
        Color = 14674161
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 4
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        ReadOnly = True
        Text = ''
      end
      object edtAni: TCurvyEdit
        Left = 49
        Top = 149
        Width = 88
        Height = 26
        BorderColor = 5539249
        Caption = ''
        Color = 14674161
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 64
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 5
        TabStop = False
        Version = '1.2.4.2'
        Alignment = taCenter
        Controls = <>
        ImeName = ''
        ParentFont = False
        ReadOnly = True
        Text = ''
      end
      object panStrTime: TCurvyPanel
        Left = 30
        Top = 7
        Width = 37
        Height = 26
        Caption = #49884#51089
        Color = 5793394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 6
      end
      object panEndTime: TCurvyPanel
        Left = 30
        Top = 64
        Width = 37
        Height = 26
        Caption = #51333#47308
        Color = 5793394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 7
      end
      object panDuration: TCurvyPanel
        Left = 30
        Top = 35
        Width = 37
        Height = 26
        Caption = '('#52488')'
        Color = 5793394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 8
      end
      object panInOut: TCurvyPanel
        Left = 8
        Top = 92
        Width = 59
        Height = 26
        Caption = 'In/Out'
        Color = 5793394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 9
      end
      object panRec: TCurvyPanel
        Left = 7
        Top = 121
        Width = 40
        Height = 26
        Caption = 'REC#'
        Color = 5793394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 10
      end
      object panAni: TCurvyPanel
        Left = 7
        Top = 148
        Width = 40
        Height = 26
        Caption = 'ANI#'
        Color = 5793394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 11
      end
      object CurvyPanel14: TCurvyPanel
        Left = 7
        Top = 7
        Width = 21
        Height = 83
        Caption = #53685#54868
        Color = 5793394
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        TabOrder = 12
        WordWrap = True
      end
    end
    object CurvyPanel5: TCurvyPanel
      AlignWithMargins = True
      Left = 4
      Top = 350
      Width = 145
      Height = 70
      Margins.Top = 5
      Align = alTop
      Caption = ''
      TabOrder = 5
      object btnInbound: TAdvSmoothButton
        Left = 7
        Top = 5
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #45824'       '#44592
        Color = 4686550
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 0
        Version = '2.2.4.0'
        OnClick = btnInboundClick
        TMSStyle = 8
      end
      object btnNotReady: TAdvSmoothButton
        Left = 7
        Top = 36
        Width = 130
        Height = 28
        Cursor = crHandPoint
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWhite
        Appearance.Font.Height = -12
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = [fsBold]
        Appearance.SimpleLayout = True
        Appearance.Rounding = 5
        Caption = #54980'  '#52376'  '#47532
        Color = 4686550
        ParentFont = False
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Segoe UI'
        Status.Appearance.Font.Style = []
        TabOrder = 1
        Version = '2.2.4.0'
        OnClick = btnNotReadyClick
        TMSStyle = 8
      end
    end
  end
  object panAlert: TPanel
    Left = 744
    Top = 664
    Width = 296
    Height = 88
    Anchors = [akRight, akBottom]
    BevelOuter = bvNone
    Color = 3947580
    ParentBackground = False
    TabOrder = 1
    Visible = False
    ExplicitLeft = 740
    ExplicitTop = 663
    object lblAlert: TLabel
      Left = 16
      Top = 14
      Width = 264
      Height = 60
      Alignment = taCenter
      AutoSize = False
      Caption = 'Alert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
  end
  object LoginFlowTimer: TTimer
    Enabled = False
    OnTimer = LoginFlowTimerTimer
    Left = 888
    Top = 16
  end
  object AlertTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = AlertTimerTimer
    Left = 928
    Top = 16
  end
  object PingTimer: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = PingTimerTimer
    Left = 792
    Top = 16
  end
  object StateTimer: TTimer
    Enabled = False
    OnTimer = StateTimerTimer
    Left = 720
    Top = 16
  end
  object ReconnectTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = ReconnectTimerTimer
    Left = 648
    Top = 16
  end
  object pmBreak: TPopupMenu
    OnPopup = pmBreakPopup
    Left = 832
    Top = 16
    object miBreakAway: TMenuItem
      Caption = #51088#47532#48708#50880
      Hint = 'away'
      RadioItem = True
      OnClick = BreakMenuItemClick
    end
    object miBreakRest: TMenuItem
      Caption = #55092#49885
      Hint = 'rest'
      RadioItem = True
      OnClick = BreakMenuItemClick
    end
    object miBreakLunch: TMenuItem
      Caption = #49885#49324
      Hint = 'lunch'
      RadioItem = True
      OnClick = BreakMenuItemClick
    end
    object miBreakMeeting: TMenuItem
      Caption = #54924#51032
      Hint = 'meeting'
      RadioItem = True
      OnClick = BreakMenuItemClick
    end
    object miBreakSeminar: TMenuItem
      Caption = #44368#50977
      Hint = 'seminar'
      RadioItem = True
      OnClick = BreakMenuItemClick
    end
    object miBreakEtc: TMenuItem
      Caption = #44592#53440
      Hint = 'etc'
      RadioItem = True
      OnClick = BreakMenuItemClick
    end
  end
end
