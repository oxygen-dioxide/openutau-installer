; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "OpenUTAU"
!define PRODUCT_VERSION "{version}"
!define PRODUCT_PUBLISHER "stakira"
!define PRODUCT_WEB_SITE "http://www.openutau.com/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\createdump.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\OpenUtau.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "OpenUTAU-Setup-{arch}-{version}.exe"
InstallDir "$PROGRAMFILES\OpenUTAU"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
{filelist}
  CreateDirectory "$SMPROGRAMS\OpenUTAU"
  CreateShortCut "$SMPROGRAMS\OpenUTAU\OpenUTAU.lnk" "$INSTDIR\OpenUtau.exe"
  CreateShortCut "$DESKTOP\OpenUTAU.lnk" "$INSTDIR\OpenUtau.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\createdump.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\OpenUtau.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

!define ASSOC_EXT ".ustx"
!define ASSOC_PROGID "Nullsoft.Test"
!define ASSOC_VERB "OpenUTAU"
!define ASSOC_APPEXE "OpenUtau.exe"
Section -ShellAssoc
  # Register file type
  WriteRegStr ShCtx "Software\Classes\${ASSOC_PROGID}\DefaultIcon" "" "$InstDir\${ASSOC_APPEXE},0"
  ;WriteRegStr ShCtx "Software\Classes\${ASSOC_PROGID}\shell\${ASSOC_VERB}" "" "Nullsoft Test App" [Optional]
  ;WriteRegStr ShCtx "Software\Classes\${ASSOC_PROGID}\shell\${ASSOC_VERB}" "MUIVerb" "@$InstDir\${ASSOC_APPEXE},-42" ; WinXP+ [Optional] Localizable verb display name
  WriteRegStr ShCtx "Software\Classes\${ASSOC_PROGID}\shell\${ASSOC_VERB}\command" "" '"$InstDir\${ASSOC_APPEXE}" "%1"'
  WriteRegStr ShCtx "Software\Classes\${ASSOC_EXT}" "" "${ASSOC_PROGID}"
SectionEnd

Section -un.ShellAssoc
  # Unregister file type
  ClearErrors
  DeleteRegKey ShCtx "Software\Classes\${ASSOC_PROGID}\shell\${ASSOC_VERB}"
  DeleteRegKey /IfEmpty ShCtx "Software\Classes\${ASSOC_PROGID}\shell"
  ${IfNot} ${Errors}
    DeleteRegKey ShCtx "Software\Classes\${ASSOC_PROGID}\DefaultIcon"
  ${EndIf}
  ReadRegStr $0 ShCtx "Software\Classes\${ASSOC_EXT}" ""
  DeleteRegKey /IfEmpty ShCtx "Software\Classes\${ASSOC_PROGID}"
  ${IfNot} ${Errors}
  ${AndIf} $0 == "${ASSOC_PROGID}"
    DeleteRegValue ShCtx "Software\Classes\${ASSOC_EXT}" ""
    DeleteRegKey /IfEmpty ShCtx "Software\Classes\${ASSOC_EXT}"
  ${EndIf}

  # Unregister "Open With"
  DeleteRegKey ShCtx "Software\Classes\Applications\${ASSOC_APPEXE}"
  DeleteRegValue ShCtx "Software\Classes\${ASSOC_EXT}\OpenWithList" "${ASSOC_APPEXE}"
  DeleteRegKey /IfEmpty ShCtx "Software\Classes\${ASSOC_EXT}\OpenWithList"
  DeleteRegValue ShCtx "Software\Classes\${ASSOC_EXT}\OpenWithProgids" "${ASSOC_PROGID}"
  DeleteRegKey /IfEmpty ShCtx "Software\Classes\${ASSOC_EXT}\OpenWithProgids"
  DeleteRegKey /IfEmpty  ShCtx "Software\Classes\${ASSOC_EXT}"

  # Unregister "Default Programs"
  !ifdef REGISTER_DEFAULTPROGRAMS
  DeleteRegValue ShCtx "Software\RegisteredApplications" "Nullsoft Test App"
  DeleteRegKey ShCtx "Software\Classes\Applications\${ASSOC_APPEXE}\Capabilities"
  DeleteRegKey /IfEmpty ShCtx "Software\Classes\Applications\${ASSOC_APPEXE}"
  !endif

  # Attempt to clean up junk left behind by the Windows shell
  DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Search\JumplistData" "$InstDir\${ASSOC_APPEXE}"
  DeleteRegValue HKCU "Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" "$InstDir\${ASSOC_APPEXE}.FriendlyAppName"
  DeleteRegValue HKCU "Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" "$InstDir\${ASSOC_APPEXE}.ApplicationCompany"
  DeleteRegValue HKCU "Software\Microsoft\Windows\ShellNoRoam\MUICache" "$InstDir\${ASSOC_APPEXE}" ; WinXP
  DeleteRegValue HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" "$InstDir\${ASSOC_APPEXE}"
  DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "${ASSOC_PROGID}_${ASSOC_EXT}"
  DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" "Applications\${ASSOC_APPEXE}_${ASSOC_EXT}"
  DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\${ASSOC_EXT}\OpenWithProgids" "${ASSOC_PROGID}"
  DeleteRegKey /IfEmpty HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\${ASSOC_EXT}\OpenWithProgids"
  DeleteRegKey /IfEmpty HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\${ASSOC_EXT}\OpenWithList"
  DeleteRegKey /IfEmpty HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\${ASSOC_EXT}"
  ;DeleteRegKey HKCU "Software\Microsoft\Windows\Roaming\OpenWith\FileExts\${ASSOC_EXT}"
  ;DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\${ASSOC_EXT}"
SectionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش���ļ�����Ƴ���"
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���估���е������" IDYES +2
  Abort
FunctionEnd

Section Uninstall
{deletelist}
  Delete "$DESKTOP\OpenUTAU.lnk"
  Delete "$SMPROGRAMS\OpenUTAU\OpenUTAU.lnk"

  RMDir "$SMPROGRAMS\OpenUTAU"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
