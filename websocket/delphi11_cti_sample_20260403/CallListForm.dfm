object FrmCallList: TFrmCallList
  Left = 0
  Top = 0
  Caption = #53685#54868#51060#47141
  ClientHeight = 575
  ClientWidth = 346
  Color = 15002607
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    346
    575)
  TextHeight = 15
  object btn_Search: TAdvGlowButton
    Left = 210
    Top = 8
    Width = 61
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #51312#54924
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
    OnClick = btn_SearchClick
    Appearance.BorderColor = 11382963
    Appearance.BorderColorHot = 11565130
    Appearance.BorderColorCheckedHot = 11565130
    Appearance.BorderColorDown = 11565130
    Appearance.BorderColorChecked = 13744549
    Appearance.BorderColorDisabled = 13948116
    Appearance.Color = 5793394
    Appearance.ColorTo = 5793394
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirror = 5793394
    Appearance.ColorMirrorTo = 5793394
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
    ExplicitLeft = 854
  end
  object btn_Close: TAdvGlowButton
    Left = 277
    Top = 8
    Width = 61
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #45803#44592
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
    OnClick = btn_CloseClick
    Appearance.BorderColor = 11382963
    Appearance.BorderColorHot = 11565130
    Appearance.BorderColorCheckedHot = 11565130
    Appearance.BorderColorDown = 11565130
    Appearance.BorderColorChecked = 13744549
    Appearance.BorderColorDisabled = 13948116
    Appearance.Color = 5793394
    Appearance.ColorTo = 5793394
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirror = 5793394
    Appearance.ColorMirrorTo = 5793394
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
    ExplicitLeft = 921
  end
  object SGrid1: TAdvStringGrid
    AlignWithMargins = True
    Left = 8
    Top = 40
    Width = 330
    Height = 527
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelEdges = [beTop, beBottom]
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    Color = clWhite
    ColCount = 8
    Ctl3D = True
    DrawingStyle = gdsClassic
    FixedColor = 7108234
    FixedCols = 0
    RowCount = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = 1385532
    Font.Height = -11
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    GridLineColor = 7964059
    GridFixedLineColor = 1385532
    OnGetAlignment = SGrid1GetAlignment
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 7108234
    BackGround.Color = clWhite
    BackGround.ColorTo = 7108234
    BorderColor = 1385532
    CellNode.Color = 7108234
    ControlLook.FixedGradientFrom = 7108234
    ControlLook.FixedGradientTo = 7108234
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientHoverBorder = clGray
    ControlLook.FixedGradientDownFrom = 8454016
    ControlLook.FixedGradientDownTo = 8454016
    ControlLook.FixedGradientDownMirrorFrom = 8454016
    ControlLook.FixedGradientDownMirrorTo = 8454016
    ControlLook.FixedGradientDownBorder = 8454016
    ControlLook.FixedDropDownButton = True
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    ControlLook.ToggleSwitch.BackgroundBorderWidth = 1.000000000000000000
    ControlLook.ToggleSwitch.ButtonBorderWidth = 1.000000000000000000
    ControlLook.ToggleSwitch.CaptionFont.Charset = DEFAULT_CHARSET
    ControlLook.ToggleSwitch.CaptionFont.Color = clWindowText
    ControlLook.ToggleSwitch.CaptionFont.Height = -12
    ControlLook.ToggleSwitch.CaptionFont.Name = 'Segoe UI'
    ControlLook.ToggleSwitch.CaptionFont.Style = []
    ControlLook.ToggleSwitch.Shadow = False
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedRowHeight = 30
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWhite
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    ScrollColor = 7108234
    ScrollSynch = True
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SearchFooter.ResultFormat = '(%d of %d)'
    SelectionColor = 15002607
    SelectionTextColor = 7108234
    ShowDesignHelper = False
    SortSettings.Show = True
    Version = '9.2.1.0'
    ColWidths = (
      64
      84
      83
      92
      83
      83
      79
      64)
    RowHeights = (
      30
      22)
  end
end
