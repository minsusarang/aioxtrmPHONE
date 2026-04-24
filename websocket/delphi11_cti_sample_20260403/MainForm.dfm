object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'CTI WebSocket Sample for Delphi 11.3'
  ClientHeight = 782
  ClientWidth = 927
  Color = 15659765
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object lblWebSocket: TLabel
    Left = 24
    Top = 104
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
  object lblCtiServer: TLabel
    Left = 297
    Top = 104
    Width = 67
    Height = 15
    Caption = '2. CTI Server'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2827861
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object lblUserId: TLabel
    Left = 471
    Top = 104
    Width = 52
    Height = 15
    Caption = '3. User ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2827861
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object lblPhoneId: TLabel
    Left = 641
    Top = 104
    Width = 63
    Height = 15
    Caption = '4. Phone ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2827861
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object lblInitMode: TLabel
    Left = 352
    Top = 163
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
  object lblDialNumber: TLabel
    Left = 24
    Top = 298
    Width = 68
    Height = 15
    Caption = 'Dial Number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2827861
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object lblTransferNumber: TLabel
    Left = 24
    Top = 362
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
  object Label1: TLabel
    Left = 8
    Top = 81
    Width = 33
    Height = 15
    Caption = #49345#53468' : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2827861
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
  end
  object lab_Status_NM: TLabel
    Left = 47
    Top = 81
    Width = 48
    Height = 15
    Caption = #47196#44536#50500#50883
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2827861
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lab_Status_Time: TLabel
    Left = 105
    Top = 83
    Width = 48
    Height = 15
    Caption = '00:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2827861
    Font.Height = -12
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 927
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = 3351364
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 923
    object lblTitle: TLabel
      Left = 24
      Top = 18
      Width = 219
      Height = 32
      Caption = 'CTI WebSocket '#51228#50612
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object lblSubtitle: TLabel
      Left = 24
      Top = 54
      Width = 161
      Height = 15
      Caption = 'Delphi 11.3 + SGC WebSockets'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13817833
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object edtWebSocketUrl: TEdit
    Left = 24
    Top = 125
    Width = 267
    Height = 23
    TabOrder = 1
  end
  object edtCtiServer: TEdit
    Left = 297
    Top = 125
    Width = 168
    Height = 23
    TabOrder = 2
  end
  object edtUserId: TEdit
    Left = 471
    Top = 125
    Width = 164
    Height = 23
    TabOrder = 3
  end
  object edtPhoneId: TEdit
    Left = 641
    Top = 125
    Width = 172
    Height = 23
    TabOrder = 4
  end
  object btnConnect: TButton
    Left = 24
    Top = 154
    Width = 145
    Height = 32
    Caption = #51217#49549
    TabOrder = 5
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 176
    Top = 154
    Width = 145
    Height = 32
    Caption = #51217#49549' '#51333#47308
    TabOrder = 6
    OnClick = btnDisconnectClick
  end
  object btnLogin: TButton
    Left = 24
    Top = 202
    Width = 97
    Height = 25
    Caption = #47196#44536#51064
    TabOrder = 10
    OnClick = btnLoginClick
  end
  object btnLogout: TButton
    Left = 136
    Top = 202
    Width = 97
    Height = 25
    Caption = #47196#44536#50500#50883
    TabOrder = 11
    OnClick = btnLogoutClick
  end
  object btnCampaign: TButton
    Left = 552
    Top = 270
    Width = 97
    Height = 25
    Caption = #52896#54168#51064
    TabOrder = 48
    OnClick = btnCampaignClick
  end
  object btnRecord: TButton
    Left = 664
    Top = 270
    Width = 71
    Height = 25
    Caption = #48512#48516#45433#52712#49884#51089
    TabOrder = 49
    OnClick = btnRecordClick
  end
  object btnHijack: TButton
    Left = 748
    Top = 270
    Width = 61
    Height = 25
    Caption = #45817#44200#48155#44592
    TabOrder = 50
    OnClick = btnHijackClick
  end
  object cbInitMode: TComboBox
    Left = 416
    Top = 159
    Width = 121
    Height = 23
    Style = csDropDownList
    TabOrder = 7
  end
  object chkOverrideLogin: TCheckBox
    Left = 560
    Top = 162
    Width = 81
    Height = 17
    Caption = 'Override'
    TabOrder = 8
  end
  object chkAutoReconnect: TCheckBox
    Left = 656
    Top = 162
    Width = 113
    Height = 17
    Caption = 'AutoReconnect'
    TabOrder = 9
  end
  object btnGetState: TButton
    Left = 24
    Top = 242
    Width = 105
    Height = 25
    Caption = #49345#53468#52404#53356
    TabOrder = 12
    OnClick = btnGetStateClick
  end
  object btnClearLog: TButton
    Left = 136
    Top = 242
    Width = 105
    Height = 25
    Caption = #47196#44536#51648#50864#44592
    TabOrder = 13
    OnClick = btnClearLogClick
  end
  object edtDialNumber: TEdit
    Left = 24
    Top = 319
    Width = 225
    Height = 23
    TabOrder = 14
  end
  object btnDial: TButton
    Left = 256
    Top = 318
    Width = 105
    Height = 25
    Caption = #45796#51060#50620
    TabOrder = 15
    OnClick = btnDialClick
  end
  object btnInbound: TButton
    Left = 384
    Top = 318
    Width = 105
    Height = 25
    Caption = 'ib'#47784#46300
    TabOrder = 16
    OnClick = btnInboundClick
  end
  object btnOutbound: TButton
    Left = 504
    Top = 318
    Width = 105
    Height = 25
    Caption = 'ob'#47784#46300
    TabOrder = 17
    OnClick = btnOutboundClick
  end
  object btnAnswer: TButton
    Left = 624
    Top = 318
    Width = 85
    Height = 25
    Caption = #51204#54868#48155#44592
    TabOrder = 18
    OnClick = btnAnswerClick
  end
  object btnHangup: TButton
    Left = 724
    Top = 318
    Width = 85
    Height = 25
    Caption = #45130#44592'/'#44144#51208
    TabOrder = 19
    OnClick = btnHangupClick
  end
  object edtTransferNumber: TEdit
    Left = 24
    Top = 383
    Width = 225
    Height = 23
    TabOrder = 20
  end
  object btnTransfer: TButton
    Left = 256
    Top = 382
    Width = 105
    Height = 25
    Caption = 'Attend'#54840#51204#54872
    TabOrder = 21
    OnClick = btnTransferClick
  end
  object btnTransferCold: TButton
    Left = 376
    Top = 382
    Width = 105
    Height = 25
    Caption = 'Cold'#54840#51204#54872
    TabOrder = 22
    OnClick = btnTransferColdClick
  end
  object btnTransferWarm: TButton
    Left = 496
    Top = 382
    Width = 105
    Height = 25
    Caption = 'Warm'#54840#51204#54872
    TabOrder = 23
    OnClick = btnTransferWarmClick
  end
  object btnHold: TButton
    Left = 24
    Top = 426
    Width = 85
    Height = 25
    Caption = #54848#46300
    TabOrder = 24
    OnClick = btnHoldClick
  end
  object btnNotReady: TButton
    Left = 120
    Top = 426
    Width = 85
    Height = 25
    Caption = 'NotReady'
    TabOrder = 25
    OnClick = btnNotReadyClick
  end
  object btnAway: TButton
    Left = 216
    Top = 426
    Width = 75
    Height = 25
    Caption = #51088#47532#48708#50880
    TabOrder = 26
    OnClick = btnAwayClick
  end
  object btnRest: TButton
    Left = 302
    Top = 426
    Width = 75
    Height = 25
    Caption = #55092#49885
    TabOrder = 27
    OnClick = btnRestClick
  end
  object btnLunch: TButton
    Left = 388
    Top = 426
    Width = 75
    Height = 25
    Caption = #49885#49324
    TabOrder = 28
    OnClick = btnLunchClick
  end
  object btnMeeting: TButton
    Left = 474
    Top = 426
    Width = 75
    Height = 25
    Caption = #54924#51032
    TabOrder = 29
    OnClick = btnMeetingClick
  end
  object btnSeminar: TButton
    Left = 560
    Top = 426
    Width = 75
    Height = 25
    Caption = #44368#50977
    TabOrder = 30
    OnClick = btnSeminarClick
  end
  object btnEtc: TButton
    Left = 646
    Top = 426
    Width = 75
    Height = 25
    Caption = #44592#53440
    TabOrder = 31
    OnClick = btnEtcClick
  end
  object btnTxComplete: TButton
    Left = 24
    Top = 466
    Width = 95
    Height = 25
    Caption = #51204#54868#50756#47308
    TabOrder = 32
    OnClick = btnTxCompleteClick
  end
  object btnTxCancel: TButton
    Left = 130
    Top = 466
    Width = 95
    Height = 25
    Caption = #51204#54868#52712#49548
    TabOrder = 33
    OnClick = btnTxCancelClick
  end
  object btnTx3Connect: TButton
    Left = 236
    Top = 466
    Width = 95
    Height = 25
    Caption = '3'#51088#53685#54868
    TabOrder = 34
    OnClick = btnTx3ConnectClick
  end
  object btnTxToggle: TButton
    Left = 342
    Top = 466
    Width = 95
    Height = 25
    Caption = #54924#51088#51204#54872
    TabOrder = 35
    OnClick = btnTxToggleClick
  end
  object btnIvrSsn: TButton
    Left = 456
    Top = 466
    Width = 95
    Height = 25
    Caption = #51452#48124#48264#54840#48155#44592
    TabOrder = 36
    OnClick = btnIvrSsnClick
  end
  object btnIvrAcc: TButton
    Left = 564
    Top = 466
    Width = 95
    Height = 25
    Caption = #44228#51340#48264#54840#48155#44592
    TabOrder = 37
    OnClick = btnIvrAccClick
  end
  object btnIvrRet: TButton
    Left = 672
    Top = 466
    Width = 95
    Height = 25
    Caption = 'IVR'#51204#54872#52712#49548
    TabOrder = 38
    OnClick = btnIvrRetClick
  end
  object edtQueueName: TEdit
    Left = 24
    Top = 514
    Width = 145
    Height = 23
    TabOrder = 39
    Text = 'all'
  end
  object btnQueueAdd: TButton
    Left = 184
    Top = 514
    Width = 89
    Height = 25
    Caption = #53328#47196#44536#51064
    TabOrder = 40
    OnClick = btnQueueAddClick
  end
  object btnQueueSub: TButton
    Left = 280
    Top = 514
    Width = 89
    Height = 25
    Caption = #53328#47196#44536#50500#50883
    TabOrder = 41
    OnClick = btnQueueSubClick
  end
  object btnQueueRun: TButton
    Left = 376
    Top = 514
    Width = 89
    Height = 25
    Caption = #53328#54876#49457#54868
    TabOrder = 42
    OnClick = btnQueueRunClick
  end
  object btnQueuePause: TButton
    Left = 472
    Top = 514
    Width = 89
    Height = 25
    Caption = #53328#48708#54876#49457#54868
    TabOrder = 43
    OnClick = btnQueuePauseClick
  end
  object btnQueueState: TButton
    Left = 568
    Top = 514
    Width = 95
    Height = 25
    Caption = #53328#49345#53468#52404#53356
    TabOrder = 44
    OnClick = btnQueueStateClick
  end
  object btnTeamAgents: TButton
    Left = 24
    Top = 554
    Width = 105
    Height = 25
    Caption = #54016#47716#48260
    TabOrder = 45
    OnClick = btnTeamAgentsClick
  end
  object btnGroupAgents: TButton
    Left = 144
    Top = 554
    Width = 105
    Height = 25
    Caption = #44536#47353#47716#48260
    TabOrder = 46
    OnClick = btnGroupAgentsClick
  end
  object btnCenterAgents: TButton
    Left = 264
    Top = 554
    Width = 105
    Height = 25
    Caption = #51204#52404#47716#48260
    TabOrder = 47
    OnClick = btnCenterAgentsClick
  end
  object pan_lbLog: TPanel
    Left = 0
    Top = 585
    Width = 927
    Height = 197
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 51
    ExplicitWidth = 923
    ExplicitHeight = 196
    DesignSize = (
      927
      197)
    object lblStatus: TLabel
      Left = 3
      Top = 3
      Width = 33
      Height = 15
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2827861
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object lbLog: TListBox
      AlignWithMargins = True
      Left = 3
      Top = 48
      Width = 921
      Height = 146
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = 16316155
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 917
      ExplicitHeight = 145
    end
  end
  object btn_CallList: TButton
    Left = 247
    Top = 203
    Width = 49
    Height = 24
    Caption = #44592#47197
    TabOrder = 52
    OnClick = btn_CallListClick
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
end
