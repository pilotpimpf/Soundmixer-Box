############################################################################################
#      NSIS Installation Script created by NSIS Quick Setup Script Generator v1.09.18
#               Entirely Edited with NullSoft Scriptable Installation System                
#              by Vlasis K. Barkas aka Red Wine red_wine@freemail.gr Sep 2006               
############################################################################################

!define APP_NAME "Soundmixer-Box"
!define COMP_NAME "PilotPimpf"
!define VERSION "00.01.00.00"
!define COPYRIGHT "Author  © 2022"
!define DESCRIPTION "Application"
!define INSTALLER_NAME "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\setup.exe"
!define MAIN_APP_EXE "Volumeregulator.exe"
!define INSTALL_TYPE "SetShellVarContext current"
!define REG_ROOT "HKCU"
!define REG_APP_PATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${MAIN_APP_EXE}"
!define UNINSTALL_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

######################################################################

VIProductVersion  "${VERSION}"
VIAddVersionKey "ProductName"  "${APP_NAME}"
VIAddVersionKey "CompanyName"  "${COMP_NAME}"
VIAddVersionKey "LegalCopyright"  "${COPYRIGHT}"
VIAddVersionKey "FileDescription"  "${DESCRIPTION}"
VIAddVersionKey "FileVersion"  "${VERSION}"

######################################################################

SetCompressor ZLIB
Name "${APP_NAME}"
Caption "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
BrandingText "${APP_NAME}"
XPStyle on
InstallDirRegKey "${REG_ROOT}" "${REG_APP_PATH}" ""
InstallDir "$PROGRAMFILES\Soundmixer-Box"

######################################################################

!include "MUI.nsh"

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING

!insertmacro MUI_PAGE_WELCOME

!ifdef LICENSE_TXT
!insertmacro MUI_PAGE_LICENSE "${LICENSE_TXT}"
!endif

!insertmacro MUI_PAGE_DIRECTORY

!ifdef REG_START_MENU
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "Soundmixer-Box"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${REG_ROOT}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${UNINSTALL_PATH}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${REG_START_MENU}"
!insertmacro MUI_PAGE_STARTMENU Application $SM_Folder
!endif

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN "$INSTDIR\${MAIN_APP_EXE}"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM

!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

######################################################################

Section -MainProgram
${INSTALL_TYPE}
SetOverwrite ifnewer
SetOutPath "$INSTDIR"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.gitignore"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\config.ini"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\configurator.exe"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\configurator.py"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\README.md"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\requirements.txt"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\run.bat"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\run_in_background.bat"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\setup.bat"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\stop.bat"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\t.log"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\Volumeregulator.exe"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\volumeregulator.py"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\volumeregulator.spec"
SetOutPath "$INSTDIR\images"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\images\Configurator-icon.ico"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\images\Configurator-icon.png"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\images\mixer-icon.png"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\images\one.jpg"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\images\Soundmixer-Box-icon.ico"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\images\Soundmixer-Box-icon.png"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\images\two.jpg"
SetOutPath "$INSTDIR\arduino_potientometer\arduino_potentiometer"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\arduino_potientometer\arduino_potentiometer\arduino_potentiometer.ino"
SetOutPath "$INSTDIR\.git"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\COMMIT_EDITMSG"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\config"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\description"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\FETCH_HEAD"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\HEAD"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\index"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\ORIG_HEAD"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\packed-refs"
SetOutPath "$INSTDIR\.git\refs\remotes\origin"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\refs\remotes\origin\3-Sliders"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\refs\remotes\origin\HEAD"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\refs\remotes\origin\PimpfPC"
SetOutPath "$INSTDIR\.git\refs\heads"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\refs\heads\3-Sliders"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\refs\heads\main"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\refs\heads\PimpfPC"
SetOutPath "$INSTDIR\.git\objects\pack"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\pack\pack-30c8d4481c6b76ea9597596e01e9ca3d204cae04.idx"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\pack\pack-30c8d4481c6b76ea9597596e01e9ca3d204cae04.pack"
SetOutPath "$INSTDIR\.git\objects\e3"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\e3\6c2e1f8e32e17ac05994794b4839734a17acb9"
SetOutPath "$INSTDIR\.git\objects\d8"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\d8\997b26f5032a5a5a050e139a52f2d0c719992a"
SetOutPath "$INSTDIR\.git\objects\9e"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\9e\465bfa2d05f803b1835d0a5032cf47a4528fdf"
SetOutPath "$INSTDIR\.git\objects\95"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\95\9c411cfd67f9fb071126b6c0366d6c60e37466"
SetOutPath "$INSTDIR\.git\objects\75"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\75\d3adf6ee9e77abb979037c1e097ebbbfa6c7ea"
SetOutPath "$INSTDIR\.git\objects\5c"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\5c\17dc156a2c525816f6b73f11d11264a037c255"
SetOutPath "$INSTDIR\.git\objects\43"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\43\37028b7e2b97d19f880ffc7a3e3d63bb38240b"
SetOutPath "$INSTDIR\.git\objects\25"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\objects\25\252ab7112b4c3c00f63e2f8730673cc1bda1b4"
SetOutPath "$INSTDIR\.git\logs"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\logs\HEAD"
SetOutPath "$INSTDIR\.git\logs\refs\remotes\origin"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\logs\refs\remotes\origin\3-Sliders"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\logs\refs\remotes\origin\HEAD"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\logs\refs\remotes\origin\PimpfPC"
SetOutPath "$INSTDIR\.git\logs\refs\heads"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\logs\refs\heads\3-Sliders"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\logs\refs\heads\main"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\logs\refs\heads\PimpfPC"
SetOutPath "$INSTDIR\.git\info"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\info\exclude"
SetOutPath "$INSTDIR\.git\hooks"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\applypatch-msg.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\commit-msg.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\fsmonitor-watchman.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\post-update.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-applypatch.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-commit.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-merge-commit.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-push.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-rebase.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-receive.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\prepare-commit-msg.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\push-to-checkout.sample"
File "C:\Users\Andreas\Documents\GitHub\Soundmixer-Box\.git\hooks\update.sample"
SectionEnd

######################################################################

Section -Icons_Reg
SetOutPath "$INSTDIR"
WriteUninstaller "$INSTDIR\uninstall.exe"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
CreateDirectory "$SMPROGRAMS\$SM_Folder"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk" "$INSTDIR\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!insertmacro MUI_STARTMENU_WRITE_END
!endif

!ifndef REG_START_MENU
CreateDirectory "$SMPROGRAMS\Soundmixer-Box"
CreateShortCut "$SMPROGRAMS\Soundmixer-Box\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\Soundmixer-Box\Uninstall ${APP_NAME}.lnk" "$INSTDIR\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\Soundmixer-Box\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!endif

WriteRegStr ${REG_ROOT} "${REG_APP_PATH}" "" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayName" "${APP_NAME}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "UninstallString" "$INSTDIR\uninstall.exe"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayIcon" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayVersion" "${VERSION}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "Publisher" "${COMP_NAME}"

!ifdef WEB_SITE
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "URLInfoAbout" "${WEB_SITE}"
!endif
SectionEnd

######################################################################

Section Uninstall
${INSTALL_TYPE}
Delete "$INSTDIR\.gitignore"
Delete "$INSTDIR\config.ini"
Delete "$INSTDIR\configurator.exe"
Delete "$INSTDIR\configurator.py"
Delete "$INSTDIR\README.md"
Delete "$INSTDIR\requirements.txt"
Delete "$INSTDIR\run.bat"
Delete "$INSTDIR\run_in_background.bat"
Delete "$INSTDIR\setup.bat"
Delete "$INSTDIR\stop.bat"
Delete "$INSTDIR\t.log"
Delete "$INSTDIR\Volumeregulator.exe"
Delete "$INSTDIR\volumeregulator.py"
Delete "$INSTDIR\volumeregulator.spec"
Delete "$INSTDIR\images\Configurator-icon.ico"
Delete "$INSTDIR\images\Configurator-icon.png"
Delete "$INSTDIR\images\mixer-icon.png"
Delete "$INSTDIR\images\one.jpg"
Delete "$INSTDIR\images\Soundmixer-Box-icon.ico"
Delete "$INSTDIR\images\Soundmixer-Box-icon.png"
Delete "$INSTDIR\images\two.jpg"
Delete "$INSTDIR\arduino_potientometer\arduino_potentiometer\arduino_potentiometer.ino"
Delete "$INSTDIR\.git\COMMIT_EDITMSG"
Delete "$INSTDIR\.git\config"
Delete "$INSTDIR\.git\description"
Delete "$INSTDIR\.git\FETCH_HEAD"
Delete "$INSTDIR\.git\HEAD"
Delete "$INSTDIR\.git\index"
Delete "$INSTDIR\.git\ORIG_HEAD"
Delete "$INSTDIR\.git\packed-refs"
Delete "$INSTDIR\.git\refs\remotes\origin\3-Sliders"
Delete "$INSTDIR\.git\refs\remotes\origin\HEAD"
Delete "$INSTDIR\.git\refs\remotes\origin\PimpfPC"
Delete "$INSTDIR\.git\refs\heads\3-Sliders"
Delete "$INSTDIR\.git\refs\heads\main"
Delete "$INSTDIR\.git\refs\heads\PimpfPC"
Delete "$INSTDIR\.git\objects\pack\pack-30c8d4481c6b76ea9597596e01e9ca3d204cae04.idx"
Delete "$INSTDIR\.git\objects\pack\pack-30c8d4481c6b76ea9597596e01e9ca3d204cae04.pack"
Delete "$INSTDIR\.git\objects\e3\6c2e1f8e32e17ac05994794b4839734a17acb9"
Delete "$INSTDIR\.git\objects\d8\997b26f5032a5a5a050e139a52f2d0c719992a"
Delete "$INSTDIR\.git\objects\9e\465bfa2d05f803b1835d0a5032cf47a4528fdf"
Delete "$INSTDIR\.git\objects\95\9c411cfd67f9fb071126b6c0366d6c60e37466"
Delete "$INSTDIR\.git\objects\75\d3adf6ee9e77abb979037c1e097ebbbfa6c7ea"
Delete "$INSTDIR\.git\objects\5c\17dc156a2c525816f6b73f11d11264a037c255"
Delete "$INSTDIR\.git\objects\43\37028b7e2b97d19f880ffc7a3e3d63bb38240b"
Delete "$INSTDIR\.git\objects\25\252ab7112b4c3c00f63e2f8730673cc1bda1b4"
Delete "$INSTDIR\.git\logs\HEAD"
Delete "$INSTDIR\.git\logs\refs\remotes\origin\3-Sliders"
Delete "$INSTDIR\.git\logs\refs\remotes\origin\HEAD"
Delete "$INSTDIR\.git\logs\refs\remotes\origin\PimpfPC"
Delete "$INSTDIR\.git\logs\refs\heads\3-Sliders"
Delete "$INSTDIR\.git\logs\refs\heads\main"
Delete "$INSTDIR\.git\logs\refs\heads\PimpfPC"
Delete "$INSTDIR\.git\info\exclude"
Delete "$INSTDIR\.git\hooks\applypatch-msg.sample"
Delete "$INSTDIR\.git\hooks\commit-msg.sample"
Delete "$INSTDIR\.git\hooks\fsmonitor-watchman.sample"
Delete "$INSTDIR\.git\hooks\post-update.sample"
Delete "$INSTDIR\.git\hooks\pre-applypatch.sample"
Delete "$INSTDIR\.git\hooks\pre-commit.sample"
Delete "$INSTDIR\.git\hooks\pre-merge-commit.sample"
Delete "$INSTDIR\.git\hooks\pre-push.sample"
Delete "$INSTDIR\.git\hooks\pre-rebase.sample"
Delete "$INSTDIR\.git\hooks\pre-receive.sample"
Delete "$INSTDIR\.git\hooks\prepare-commit-msg.sample"
Delete "$INSTDIR\.git\hooks\push-to-checkout.sample"
Delete "$INSTDIR\.git\hooks\update.sample"
 
RmDir "$INSTDIR\.git\hooks"
RmDir "$INSTDIR\.git\info"
RmDir "$INSTDIR\.git\logs\refs\heads"
RmDir "$INSTDIR\.git\logs\refs\remotes\origin"
RmDir "$INSTDIR\.git\logs"
RmDir "$INSTDIR\.git\objects\25"
RmDir "$INSTDIR\.git\objects\43"
RmDir "$INSTDIR\.git\objects\5c"
RmDir "$INSTDIR\.git\objects\75"
RmDir "$INSTDIR\.git\objects\95"
RmDir "$INSTDIR\.git\objects\9e"
RmDir "$INSTDIR\.git\objects\d8"
RmDir "$INSTDIR\.git\objects\e3"
RmDir "$INSTDIR\.git\objects\pack"
RmDir "$INSTDIR\.git\refs\heads"
RmDir "$INSTDIR\.git\refs\remotes\origin"
RmDir "$INSTDIR\.git"
RmDir "$INSTDIR\arduino_potientometer\arduino_potentiometer"
RmDir "$INSTDIR\images"
 
Delete "$INSTDIR\uninstall.exe"
!ifdef WEB_SITE
Delete "$INSTDIR\${APP_NAME} website.url"
!endif

RmDir "$INSTDIR"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_GETFOLDER "Application" $SM_Folder
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk"
!endif
Delete "$DESKTOP\${APP_NAME}.lnk"

RmDir "$SMPROGRAMS\$SM_Folder"
!endif

!ifndef REG_START_MENU
Delete "$SMPROGRAMS\Soundmixer-Box\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\Soundmixer-Box\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\Soundmixer-Box\${APP_NAME} Website.lnk"
!endif
Delete "$DESKTOP\${APP_NAME}.lnk"

RmDir "$SMPROGRAMS\Soundmixer-Box"
!endif

DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}"
DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}"
SectionEnd

######################################################################

