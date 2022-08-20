############################################################################################
#      NSIS Installation Script created by NSIS Quick Setup Script Generator v1.09.18
#               Entirely Edited with NullSoft Scriptable Installation System                
#              by Vlasis K. Barkas aka Red Wine red_wine@freemail.gr Sep 2006               
############################################################################################

!define APP_NAME "Soundmixer-Box"
!define COMP_NAME "PilotPimpf"
!define VERSION "00.01.00.02"
!define COPYRIGHT "Author  © 2022"
!define DESCRIPTION "Application"
!define INSTALLER_NAME "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\setup.exe"
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
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.gitignore"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\config.ini"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\configurator.exe"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\configurator.py"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\README.md"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\requirements.txt"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\setup.exe"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\Volumeregulator.exe"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\volumeregulator.py"
SetOutPath "$INSTDIR\setup"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\setup\NSIS Quick Setup Script Generator.exe"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\setup\Settings.ini"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\setup\Soundmixer-Box.ini"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\setup\Soundmixer-Box.nsi"
SetOutPath "$INSTDIR\images"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\images\Configurator-icon.ico"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\images\Configurator-icon.png"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\images\mixer-icon.png"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\images\one.jpg"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\images\Soundmixer-Box-icon.ico"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\images\Soundmixer-Box-icon.png"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\images\two.jpg"
SetOutPath "$INSTDIR\arduino_potientometer\arduino_potentiometer"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\arduino_potientometer\arduino_potentiometer\arduino_potentiometer.ino"
SetOutPath "$INSTDIR\.git"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\COMMIT_EDITMSG"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\config"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\description"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\FETCH_HEAD"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\HEAD"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\index"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\packed-refs"
SetOutPath "$INSTDIR\.git\refs\remotes\origin"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\refs\remotes\origin\HEAD"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\refs\remotes\origin\PimpfPC"
SetOutPath "$INSTDIR\.git\refs\heads"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\refs\heads\main"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\refs\heads\PimpfPC"
SetOutPath "$INSTDIR\.git\objects\pack"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\objects\pack\pack-59c6d56adb9ce227012ba0f28cdb4ff2cb6c4e90.idx"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\objects\pack\pack-59c6d56adb9ce227012ba0f28cdb4ff2cb6c4e90.pack"
SetOutPath "$INSTDIR\.git\objects\52"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\objects\52\f289f61486afa9adad0720623043fc05639ccb"
SetOutPath "$INSTDIR\.git\objects\32"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\objects\32\20eed9eec4bea58630a486d738bd0bbe04d9bd"
SetOutPath "$INSTDIR\.git\objects\16"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\objects\16\b46ba65c72e773e5f5af6a34c2cc8b21b304a1"
SetOutPath "$INSTDIR\.git\logs"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\logs\HEAD"
SetOutPath "$INSTDIR\.git\logs\refs\remotes\origin"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\logs\refs\remotes\origin\HEAD"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\logs\refs\remotes\origin\PimpfPC"
SetOutPath "$INSTDIR\.git\logs\refs\heads"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\logs\refs\heads\main"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\logs\refs\heads\PimpfPC"
SetOutPath "$INSTDIR\.git\info"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\info\exclude"
SetOutPath "$INSTDIR\.git\hooks"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\applypatch-msg.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\commit-msg.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\fsmonitor-watchman.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\post-update.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-applypatch.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-commit.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-merge-commit.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-push.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-rebase.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\pre-receive.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\prepare-commit-msg.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\push-to-checkout.sample"
File "C:\Users\telsc\Documents\GitHub\Soundmixer-Box\.git\hooks\update.sample"
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
Delete "$INSTDIR\setup.exe"
Delete "$INSTDIR\Volumeregulator.exe"
Delete "$INSTDIR\volumeregulator.py"
Delete "$INSTDIR\setup\NSIS Quick Setup Script Generator.exe"
Delete "$INSTDIR\setup\Settings.ini"
Delete "$INSTDIR\setup\Soundmixer-Box.ini"
Delete "$INSTDIR\setup\Soundmixer-Box.nsi"
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
Delete "$INSTDIR\.git\packed-refs"
Delete "$INSTDIR\.git\refs\remotes\origin\HEAD"
Delete "$INSTDIR\.git\refs\remotes\origin\PimpfPC"
Delete "$INSTDIR\.git\refs\heads\main"
Delete "$INSTDIR\.git\refs\heads\PimpfPC"
Delete "$INSTDIR\.git\objects\pack\pack-59c6d56adb9ce227012ba0f28cdb4ff2cb6c4e90.idx"
Delete "$INSTDIR\.git\objects\pack\pack-59c6d56adb9ce227012ba0f28cdb4ff2cb6c4e90.pack"
Delete "$INSTDIR\.git\objects\52\f289f61486afa9adad0720623043fc05639ccb"
Delete "$INSTDIR\.git\objects\32\20eed9eec4bea58630a486d738bd0bbe04d9bd"
Delete "$INSTDIR\.git\objects\16\b46ba65c72e773e5f5af6a34c2cc8b21b304a1"
Delete "$INSTDIR\.git\logs\HEAD"
Delete "$INSTDIR\.git\logs\refs\remotes\origin\HEAD"
Delete "$INSTDIR\.git\logs\refs\remotes\origin\PimpfPC"
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
RmDir "$INSTDIR\.git\objects\16"
RmDir "$INSTDIR\.git\objects\32"
RmDir "$INSTDIR\.git\objects\52"
RmDir "$INSTDIR\.git\objects\pack"
RmDir "$INSTDIR\.git\refs\heads"
RmDir "$INSTDIR\.git\refs\remotes\origin"
RmDir "$INSTDIR\.git"
RmDir "$INSTDIR\arduino_potientometer\arduino_potentiometer"
RmDir "$INSTDIR\images"
RmDir "$INSTDIR\setup"
 
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

