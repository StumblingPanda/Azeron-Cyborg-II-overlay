; Custom installer page — asks for anonymous data sharing consent.
; Checked by default (opt-out). Preference written to %APPDATA%\AzeronOverlay\prefs.json.

Var ShareDataCheckbox
Var ShareDataState

!macro customHeader
  Page custom ShareDataPage ShareDataLeave
!macroend

!macro customInit
  StrCpy $ShareDataState 1
!macroend

Function ShareDataPage
  !insertmacro MUI_HEADER_TEXT "Help Improve Device Support" "Share anonymous calibration data (optional)"

  nsDialogs::Create 1018
  Pop $0

  ${NSD_CreateLabel} 0 0 100% 70u "When you calibrate your Azeron using the built-in wizard, you can help other users by sharing your anonymous device layout data.$\n$\nThis builds a library of supported hardware configurations so future users are mapped automatically.$\n$\nNo personal information or key names are ever collected. You can change this at any time in the app settings."
  Pop $0

  ${NSD_CreateCheckBox} 0 80u 100% 12u "Share anonymous calibration data to help support more devices (recommended)"
  Pop $ShareDataCheckbox
  ${NSD_SetState} $ShareDataCheckbox $ShareDataState

  nsDialogs::Show
FunctionEnd

Function ShareDataLeave
  ${NSD_GetState} $ShareDataCheckbox $ShareDataState
FunctionEnd

!macro customInstall
  CreateDirectory "$APPDATA\AzeronOverlay"
  FileOpen $0 "$APPDATA\AzeronOverlay\prefs.json" w
  ${If} $ShareDataState == 1
    FileWrite $0 '{"shareAnonymousData":true}'
  ${Else}
    FileWrite $0 '{"shareAnonymousData":false}'
  ${EndIf}
  FileClose $0
!macroend
