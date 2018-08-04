@shift /0
:: IpswTools
:: Copyright (C) 2016
:: See attached license
::DevJam
@ECHO off


TITLE IpswTools

COLOR 0B
::------------------------------------------------------------------------------------
CLS
setlocal enableextensions enabledelayedexpansion
echo   ***************************************************************************
echo   *                             IpswTools                                   *
echo   ***************************************************************************
Echo.
Echo       888       888        888                                     
Echo       888   o   888        888                                     
Echo       888  d8b  888        888                                     
Echo       888 d888b 888 .d88b. 888 .d8888b .d88b. 88888b.d88b.  .d88b. 
Echo       888d88888b888d8P  Y8b888d88P"   d88""88b888 "888 "88bd8P  Y8b
Echo       88888P Y8888888888888888888     888  888888  888  88888888888
Echo       8888P   Y8888Y8b.    888Y88b.   Y88..88P888  888  888Y8b.    
Echo       888P     Y888 "Y8888 888 "Y8888P "Y88P" 888  888  888 "Y8888
Echo.
echo.
echo   ***************************************************************************
echo   *  Thanks Callum Jones(Ikeyhelper)  ISnaig  Dev_Jam                       *
echo   ***************************************************************************
set FINISH=0
set i=0
echo.

:Starting
REM We display a point without carriage return.
echo|set /p=.

REM Operation to execute
ping 123.45.67.89 -n 1 -w 500 > nul

set /a i = i + 1
if /i %i% leq 10 goto Starting
echo.


:beginning
SET toolbox=%appdata%\IpswTools\bin
SET logdir=%appdata%\IpswTools\logs
SET tempdir=%temp%\IpswTools

RD "%appdata%\IpswTools" /S /s /Q 1> NUL 2> NUL
RD "%temp%\IpswTools" /S /s /Q  1> NUL 2> NUL
RD "%UserPROFILE%\IpswTools" /S /s /Q  1> NUL 2> NUL
DEL %temp%\IpswTools\*.* /Q /F  1> NUL 2> NUL


IF not EXIST %appdata%\IpswTools  MKDIR %appdata%\IpswTools > NUL
IF not EXIST %toolbox%  MKDIR %toolbox% > NUL
IF not EXIST %tempdir%  MKDIR %tempdir% > NUL
IF not EXIST %logdir%  MKDIR %logdir% > NUL

IF "%uuid%"==""  ( 
    SET uuid=IpswTools~git
    SET version=%uuid%
)

CALL :log #############################################################################
CALL :log Starting IpswTools v%version% on %date%
CALL :log #############################################################################

title Copy Files...
::copy files
XCOPY %UserPROFILE%\Desktop\IpswTools\*.exe "%appdata%\IpswTools\bin" >> %logme%

echo.
echo   ***************************************************************************
echo   *                 Download Tools please wait....                          *
echo   ***************************************************************************
title Download Tools...
echo off
%toolbox%\wget -P %appdata%\IpswTools "http://iweb.dl.sourceforge.net/project/ipswtools/tools.zip" 


title Create Directory...
IF not EXIST %UserProfile%\IpswTools  MKDIR %UserProfile%\IpswTools > NUL
IF not EXIST "%UserProfile%\IpswTools\IpswTools.settings.bat"  ( 
    ECHO Cannot find settings file.
    ECHO Downloading new settings file.
    PUSHD %UserProfile%\IpswTools
XCOPY %UserPROFILE%\Desktop\IpswTools\ressources\IpswTools.settings.bat %UserPROFILE%\IpswTools >> %logme%
    POPD
)
:: parse the settings
CALL %UserProfile%\IpswTools\IpswTools.settings.bat this-is-meant-to-be-run

IF not EXIST %tempdir%  MKDIR %tempdir% > NUL

:: Run on startup
COLOR 0B
CD %tempdir%

:: delete me some stuffs

IF EXIST *  DEL * /S /Q >> %logme%
IF EXIST dlipsw  RMDIR dlipsw /S /Q >> %logme%
IF EXIST IPSW  RMDIR IPSW /S /Q >> %logme%
IF EXIST toolbox  RMDIR toolbox /S /Q >> %logme%
IF EXIST decrypted  RMDIR decrypted /S /Q >> %logme%
IF EXIST *.txt  DEL *.txt /S /Q >> %logme%
CLS
CD %toolbox%
IF not EXIST %appdata%\IpswTools\bin\genpass.exe  ( 
    ECHO Extracting Files...
    :: Extract the tools
    IF not EXIST %tempdir%  MKDIR %tempdir% >> %logme%
    IF not EXIST %toolbox%  MKDIR %toolbox% >> %logme%
    COPY %MYFILES%\7za.exe %toolbox%\7za.exe >> %logme%
    CALL 7za.exe x -y -mmt %appdata%\IpswTools\tools.zip >> %logme%
    DEL %appdata%\IpswTools\tools.zip
    )
IF "%viewlog%"=="yes"  ( 
    IF EXIST %toolbox%\baretail.exe  ( 
        TASKKILL /IM "baretail.exe" /F > NUL > NUL
        START "" %toolbox%\baretail "%logme%"
    )
)
:: check for old files and remove them
CALL :log Clearing existing files
IF EXIST %tempdir%\kbags  RMDIR %tempdir%\kbags /S /Q >> %logme%
IF EXIST %tempdir%\IPSW  RMDIR %tempdir%\IPSW /S /Q >> %logme%
IF EXIST %tempdir%\dlipsw  RMDIR %tempdir%\dlipsw /S /Q >> %logme%
IF EXIST %tempdir%\keys.txt  DEL if exist /S /Q %tempdir%\keys.txt >> %logme%
IF EXIST %tempdir%\kbags.txt  DEL /S /Q %tempdir%\kbags.txt >> %logme%
CLS



:Debut
title iTunes installed??
CD %tempdir%
CLS


set IPSW=
Echo.
Echo 88888888888888b.  .d8888b. 888       888   88888888888             888        
Echo   888  888   Y88bd88P  Y88b888   o   888       888                 888        
Echo   888  888    888Y88b.     888  d8b  888       888                 888        
Echo   888  888   d88P "Y888b.  888 d888b 888       888  .d88b.  .d88b. 888.d8888b 
Echo   888  8888888P"     "Y88b.888d88888b888       888 d88""88bd88""88b88888K     
Echo   888  888             "88888888P Y88888       888 888  888888  888888"Y8888b.
Echo   888  888       Y88b  d88P8888P   Y8888       888 Y88..88PY88..88P888     X88
Echo 8888888888        "Y8888P" 888P     Y888       888  "Y88P"  "Y88P" 888 88888P'
Echo.



::Search iTunes installed "Green" not installed "red"
COLOR 0e
SET Location=%ProgramFiles%\iTunes
SET FileName=iTunes.exe
echo(  & ECHO Please Wait for moment .... Searching for "%FileName%" on "%Location%"
TimeOut /T 3 /NoBreak  > Nul
IF EXIST "%Location%\%FileName%"  (color 0A  && ECHO The "%FileName%" is installed && PAUSE
) ELSE (
    COLOR 0C & ECHO The "%FileName%" is not installed please install to continue& Start http://www.apple.com/befr/itunes/download/ & PAUSE & please install iTunes 
    
   goto Debut)
::--------------------------------------------------------------------------------------------------------------    
title Menu IpswTools
cls
:Menu
COLOR 0B 
cls
echo.
echo.
echo   ***************************************************************************
echo                    		Menu IpswTools                				 
echo   ***************************************************************************
echo   * Choose the tools in this list:                                          *
echo   *                                                                         *
echo   * 1. Download Ipsw Apple Server.                                          *
echo   * 2. Decrypt All (img3, iBEC, iBSS, DMG).                                 *
echo   * 3. Idevicerestore (Restore,Update).                                     *
echo   * 4. KBAGs Grab digital signing (No KEys ) ...                            *
echo   * 5. Patch (asr,iBEC,iBSS , Create Custom ipsw).                          *
echo   * 6. Quit                                                                 *
echo   *                                                                         *
echo   *                                                                         *
echo   * Very useful tools to have on hand ... ;)                                *
echo   ***************************************************************************
echo. 



SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO Download
IF /I '%INPUT%'=='2' GOTO Decrypt
IF /I '%INPUT%'=='3' GOTO Idevicerestore
IF /I '%INPUT%'=='4' GOTO kbags
IF /I '%INPUT%'=='5' GOTO Patch
IF /I '%INPUT%'=='6' GOTO Quit


CLS

ECHO        ========================INVALID INPUT========================
ECHO --------------------------------------------------------------------------
ECHO                Please select a number from the Main
echo                 Menu [1-7] or select 'Q' to quit.
ECHO --------------------------------------------------------------------------
ECHO    ========================PRESS ANY KEY TO CONTINUE========================

PAUSE > NUL
GOTO Menu

:Quit
CLS

ECHO           ========================THANKYOU========================
ECHO --------------------------------------------------------------------------
ECHO    ========================PRESS ANY KEY TO CONTINUE========================

PAUSE>NUL
EXIT



::---------------------------------------------------------------------------------------

:Download
title Choice Firmware...
CALL :log Opening IPSW downloader...

cls
Color 05
Echo.
Echo d8b   8888888b.                              888                     888
Echo Y8P   888  "Y88b                             888                     888
Echo       888    888                             888                     888
Echo 888   888    888 .d88b. 888  888  88888888b. 888 .d88b.  8888b.  .d88888
Echo 888   888    888d88""88b888  888  888888 "88b888d88""88b    "88bd88" 888
Echo 888   888    888888  888888  888  888888  888888888  888.d888888888  888
Echo 888   888  .d88PY88..88PY88b 888 d88P888  888888Y88..88P888  888Y88b 888
Echo 888   8888888P"  "Y88P"  "Y8888888P" 888  888888 "Y88P" "Y888888 "Y88888
Echo.
ECHO --------------------------------------------------------------------------------
echo - You have chosen to download an IPSW file. 
echo - Which device are you downloading for? (e.g. iPhone5,4)
set /P dldevice=- Device: %=%

echo - Which firmware do you wish to download? (e.g. 9.0.0)
set /P dlfw=- Firmware: %=%


IF EXIST %tempdir%\dlipsw  RMDIR %tempdir%\dlipsw > NUL
IF not EXIST %tempdir%\dlipsw  MKDIR %tempdir%\dlipsw > NUL

CD %tempdir%\dlipsw

IF EXIST url.txt  DEL url.txt /S /Q > NUL
ECHO - Fetching Link...

%toolbox%\curl -A "IpswTools - %uuid% - %version%" --silent http://api.ios.icj.me/v2.1/%dldevice%/%dlfw%/url -I  > response.txt

:: check for multiple buildids
FINDSTR "300 Multiple Choices" response.txt > nul

IF ERRORLEVEL 1  ( 
    SET downloadlink=http://api.ios.icj.me/v2/%dldevice%/%dlfw%
    GOTO downloadipsw
)

<nul set /p "= - Multiple BuildIDs Found: "
%toolbox%\curl -A "IpswTools - %uuid% - %version%" --silent http://api.ios.icj.me/v2/%dldevice%/%dlfw%/buildid  > choices.txt

:: clean up the text file
ssr 0 """ "" choices.txt
ssr 0 "," "" choices.txt
ssr 0 "{" "" choices.txt
ssr 0 "}" "" choices.txt
ssr 0 "[" "" choices.txt
ssr 0 "]" "" choices.txt

FOR %%a in ( "choices.txt" ) do ( 
    FOR /f "tokens=2 delims=:" %%B in ('find "buildid" ^< %%a') do ( 
        CALL :addtovar %%B
    )
)
ECHO %buildids%

SET %=% /P dlid=- Choose one BuildID:


SET downloadlink=http://api.ios.icj.me/v2/%dldevice%/%dlid%

GOTO downloadipsw


:downloadipsw
title Donwnload ipsw please wait..
%toolbox%\curl -A "IpswTools - %uuid% - %version%" --silent %downloadlink%/url -I  > response.txt

FINDSTR "200 OK" response.txt > nul

IF ERRORLEVEL 1  ( 
    ECHO - Error: Link not found.
    ECHO - Press any key to return to the IPSW downloader.
    CALL :log error Unable to find IPSW link
    PAUSE > NUL
    GOTO Download
)


%toolbox%\curl -A "IpswTools - %uuid% - %version%" --silent %downloadlink%/filename  > ipsw_name.txt
%toolbox%\curl -A "IpswTools - %uuid% - %version%" --silent %downloadlink%/url  > url.txt
%toolbox%\curl -A "IpswTools - %uuid% - %version%" --silent %downloadlink%/filesize  > filesize.txt

SET /p ipswName= < ipsw_name.txt
SET /p downloadlink= < url.txt
SET /p filesize= < filesize.txt

ECHO - Downloading %ipswName%... [%filesize%MB]



ECHO --------------------------------------------------------------------------------
CALL %toolbox%\curl -LO %downloadlink% --progress-bar

CALL :log IPSW Name: %ipswName%
:: check for my HDD for IPSWs :P
IF EXIST "C:\Apple Firmware"  ( 
    CALL :loC moving %ipswName% to "%UserProfile%\Desktop\%ipswName%"
    IF not EXIST "C:\Apple Firmware\%dldevice%"  MKDIR "C:\Apple Firmware\%dldevice%" > NUL
    IF not EXIST "C:\Apple Firmware\%dldevice%\Official"  MKDIR "C:\Apple Firmware\%dldevice%\Official" > NUL
    MOVE /y "%ipswName%" "C:\Apple Firmware\%dldevice%\Official\%ipswName%" >> %logme%

    IF not EXIST "C:\Apple Firmware\%dldevice%\Official\%ipswName%"  ( 
        CALL :log error IPSW move failed
    ) else (
        CALL :log IPSW move succeeded
    )

    SET IPSW="C:\Apple Firmware\%dldevice%\Official\%ipswName%"
    CLS
    ECHO - IPSW download finished^^! Saved to "C:\Apple Firmware\%dldevice%\Official\%ipswName%"

) else (
    CALL :log moving %ipswName% to "%UserProfile%\Desktop\%ipswName%"
    MOVE /y "%ipswName%" "%UserProfile%\Desktop\%ipswName%" >> %logme%

    IF not EXIST "%UserProfile%\Desktop\%ipswName%"  ( 
        CALL :log error IPSW move failed
    ) else (
        CALL :log IPSW move succeeded
    )

    SET IPSW="%UserProfile%\Desktop\%ipswName%"
    CLS
    ECHO - IPSW download finished^^! Saved to "%UserProfile%\Desktop\%ipswName%"
)
cd ..
RD "%temp%\IpswTools\dlipsw" /S /s /Q

ECHO - Press any key to continue...%tempdir%\dlipsw
PAUSE > NUL
goto Menu

:Decrypt
title Decrypt Auto
cls
COLOR 0A
Echo.
Echo d8b   8888888b.                                        888   
Echo Y8P   888  "Y88b                                       888   
Echo       888    888                                       888   
Echo 888   888    888 .d88b.  .d8888b888d888888  88888888b. 888888
Echo 888   888    888d8P  Y8bd88P"   888P"  888  888888 "88b888   
Echo 888   888    88888888888888     888    888  888888  888888   
Echo 888   888  .d88PY8b.    Y88b.   888    Y88b 888888 d88PY88b. 
Echo 888   8888888P"  "Y8888  "Y8888P888     "Y8888888888P"  "Y888
Echo                                             888888           
Echo                                        Y8b d88P888           
Echo                                         "Y88P" 888
Echo.
title IdecryptAuto Iphonewiki

:iDecrypt

ECHO Connect your iPhone !

timeout /t 10
ECHO.
ECHO Enter info Device please ....
SET ProductType=
FOR /F "tokens=2 delims=: " %%a in ('%toolbox%\ideviceinfo.exe ^| findstr "ProductType" ') do SET ProductType=%%a
SET ProductType=%ProductType: =%
SET HardwareModel=
FOR /F "tokens=2 delims=: " %%b in ('%toolbox%\ideviceinfo.exe ^| findstr "HardwareModel" ') do SET HardwareModel=%%b
SET HardwareModel=%HardwareModel: =%
SET DeviceClass=
FOR /F "tokens=2 delims=: " %%a in ('%toolbox%\ideviceinfo.exe ^| findstr "DeviceClass" ') do SET DeviceClass=%%a
SET DeviceClass=%DeviceClass: =%
%toolbox%\ideviceinfo.exe  | FIND /N /I "No device found" > NUL
cls
if errorlevel 1 (
    echo No device found
	cls
) else (
    echo PLease connect Devices!
    pause
	goto Decrypt
)

echo.
ECHO iPhone information  : %ProductType% %HardwareModel% 
start https://www.theiphonewiki.com/wiki/Firmware#%DeviceClass%
ECHO.
ECHO Enter your iPhone information !
ECHO.
ECHO Here is an example : Monarch
SET %=% /P CodeName="CodeName: "
ECHO Here is an example : 13A344
SET %=% /P BuildVersion="BuildVersion: "

%toolbox%\curl.exe -k -LO http://theiphonewiki.com/w/index.php?title=%CodeName%_%BuildVersion%_(%ProductType%)^&action=edit 
Ren "index.php_title=%CodeName%_%BuildVersion%_(%ProductType%)&action=edit" "iPhoneWiki.bat" 


cls
%toolbox%\sed.exe -i -e "s/ //g" iPhoneWiki.bat > NUL 
%toolbox%\sed.exe -i -e "s/|/Set /g" iPhoneWiki.bat > NUL 
%toolbox%\sed.exe -i "/</d" iPhoneWiki.bat > NUL 
%toolbox%\sed.exe -i "/document/d" iPhoneWiki.bat > NUL 
%toolbox%\sed.exe -i "/mw/d" iPhoneWiki.bat > NUL 
%toolbox%\sed.exe -i "/}/d" iPhoneWiki.bat > NUL 
%toolbox%\sed.exe -i "1d" iPhoneWiki.bat > NUL 
::Echo %toolbox%\Decrypting.bat>>iPhoneWiki.bat
call %temp%\IpswTools\iPhoneWiki.bat > NUL
cls

mkdir "%Version%_Origine"2>NUL 

set Version=%Version%


if not defined Version ( if "%1" == "" echo Sorry no key available for your choice
echo.
echo Please check out iphonewiki.com ...
timeout /t 5
cls
exit
)

@Echo Off&cls

::::// LES PREPARATIFS POUR AFFPNG \\::::

::Définition de la taille du CMD

mode con:lines=40 cols=120
set "$c=1"

::Définition du titre de notre instance du CMD

set "$Title=Wait"
title %$title%

::On centre notre fenêtre CMD à l'écran

start %toolbox%\flash.exe /LW "%$Title%" "centered"

::On debloque la fenêtre

start "" /wait %toolbox%\flash.exe /UL

::On récupère les coordonnées de la CMD

for /f "tokens=1-4 delims= " %%a in ('%toolbox%\flash.exe  /getcmdpos "%$Title%"') do (
    set "$TopXCMD=%%a"
    set "$TopYCMD=%%b"
    set "$LargeurCMD=%%c"
    set "$HauteurCMD=%%d"
   goto:next4
  )


::On calcul la position d'affichage de notre Waiting barre

:next4

set /a $XPosImage=(%$LargeurCMD%/2)-(150/2)+%$TopXCMD%
set /a $YPosImage=(%$HauteurCMD%/2)-(150/2)+%$TopYCMD%


::On affiche notre Image au centre de notre CMD avec le paramètres [/attach]
::Et en [/nokill]

::::// FIN DES PREPARATIFS \\::::

::::// ICI LES PREPARATIFS POUR TON CODE \\::::

echo Drag in an...
Set /P IPSW=Move ipsw in the command prompt and ENTER !
cls


::::// AFFICHAGE DU FLASH D'ATTENTE \\::::

echo Working !!! Please wait !!!
start %toolbox%\flash.exe "%toolbox%\5.swf" /flash /width 150 /heigth 150 /Xpos %$XPosImage% /YPos %$YPosImage% /attach "%$Title%" /nokill "wait"





::::// ICI TU METS TON CODE (La partie traitement) \\::::


Echo Extracting ipsw wait...
CALL %toolbox%\7za.exe x "%IPSW%" >> %logme%
ECHO Done^^


ECHO Copy Files...
move "%Kernelcache%" "%Version%_Origine" >> %logme%
move "*.dmg" "%Version%_Origine" >> %logme%
move "*.plist" "%Version%_Origine" >> %logme%
move "Firmware" "%Version%_Origine" >> %logme%
cls

ECHO Create Directory...
mkdir "Decrypting" >> %logme%
mkdir "%Version%_Decrypted" >> %logme%
mkdir "%Version%_Decrypted\Firmware" >> %logme%
mkdir "%Version%_Decrypted\Firmware\all_flash" >> %logme%
mkdir "%Version%_Decrypted\Firmware\all_flash\all_flash.%HardwareModel%.production" >> %logme%
mkdir "%Version%_Decrypted\Firmware\dfu" >> %logme%
mkdir "%Version%_Decrypted\Firmware\usr" >> %logme%
mkdir "%Version%_Decrypted\Firmware\usr\local" >> %logme%
mkdir "%Version%_Decrypted\Firmware\usr\local\standalone" >> %logme%
cls



ECHO Moment please wait copy files ....

copy "%Version%_Origine\Firmware\all_flash\all_flash.%HardwareModel%.production\*.img3" "Decrypting" >NUL
copy "%Version%_Origine\Firmware\all_flash\all_flash.%HardwareModel%.production\%BatteryFull%" "%BatteryFull%" >NUL
copy "%Version%_Origine\Firmware\dfu\*.dfu" "Decrypting"  >NUL
copy "%Version%_Origine\*.dmg" "Decrypting" >NUL
copy "%Version%_Origine\%Kernelcache%" "Decrypting" >NUL
copy "%Version%_Origine\Firmware\all_flash\all_flash.%HardwareModel%.production\manifest" "%Version%_Decrypted\Firmware\all_flash\all_flash.%HardwareModel%.production" >NUL
copy "%Version%_Origine\*.plist" "%Version%_Decrypted" >NUL
copy "%Version%_Origine\Firmware\*.bbfw" "%Version%_Decrypted\Firmware" >NUL
copy "%Version%_Origine\Firmware\*.plist" "%Version%_Decrypted\Firmware" >NUL
cls


Echo AutoDecrypt Img3...
CALL %toolbox%\xpwntool.exe Decrypting\%AppleLogo% %AppleLogo%.dec -k %AppleLogoKey% -iv %AppleLogoIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%BatteryCharging0% %BatteryCharging0%.dec -k %BatteryCharging0Key% -iv %BatteryCharging0IV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%BatteryCharging1% %BatteryCharging1%.dec -k %BatteryCharging1Key% -iv %BatteryCharging1IV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%BatteryLow0% %BatteryLow0%.dec -k %BatteryLow0Key% -iv %BatteryLow0IV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%BatteryLow1% %BatteryLow1%.dec -k %BatteryLow1Key% -iv %BatteryLow1IV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%DeviceTree% %DeviceTree%.dec -k %DeviceTreeKey% -iv %DeviceTreeIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%GlyphPlugin% %GlyphPlugin%.dec -k %GlyphPluginKey% -iv %GlyphPluginIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%iBoot% %iBoot%.dec -k %iBootKey% -iv %iBootIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%LLB% %LLB%.dec -k %LLBKey% -iv %LLBIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%RecoveryMode% %RecoveryMode%.dec -k %RecoveryModeKey% -iv %RecoveryModeIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%iBEC% %iBEC%.dec -k %iBECKey% -iv %iBECIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%iBSS% %iBSS%.dec -k %iBSSKey% -iv %iBSSIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%Kernelcache% %Kernelcache%.dec -k %KernelcacheKey% -iv %KernelcacheIV% > %logme%
echo Done !!!
cls
ECHO AutoDecrypt Ramdisk ....
CALL %toolbox%\xpwntool.exe Decrypting\%UpdateRamdisk%.dmg %UpdateRamdisk%.decrypted.dmg -k %UpdateRamdiskKey% -iv %UpdateRamdiskIV% > %logme%
CALL %toolbox%\xpwntool.exe Decrypting\%RestoreRamdisk%.dmg %RestoreRamdisk%.decrypted.dmg -k %RestoreRamdiskKey% -iv %RestoreRamdiskIV% > %logme%
Echo Done




cls
ECHO AutoDecrypt RootFS wait ....
%toolbox%\dmg.exe extract Decrypting\%RootFS%.dmg %RootFS%.decrypted.dmg -k %RootFSKey% > NUL
Echo Done !!!

cls
ECHO Move Directory ....
move "%Kernelcache%.dec" "%Version%_Decrypted" >> %logme%
move "%iBSS%.dec" "%Version%_Decrypted\Firmware\dfu" >> %logme%
move "%iBEC%.dec" "%Version%_Decrypted\Firmware\dfu" >> %logme%
move "*.dec" "%Version%_Decrypted\Firmware\all_flash\all_flash.%HardwareModel%.production" >> %logme%
move "*.dmg" "%Version%_Decrypted" >> %logme%
Echo Done!!
cls

Echo clean Files
RMDIR /S /Q "Decrypting"

move /y "%Version%_Decrypted" "%UserProfile%\Desktop\" >NUL
move /y "%Version%_Origine" "%UserProfile%\Desktop\" >NUL

ECHO - Decrypt  finished^^! Saved to "%UserProfile%\Desktop\%Version%_Decrypted"
ECHO.
ECHO - IPSW download finished^^! Saved to "%UserProfile%\Desktop\%Version%_Origine"
timeout /t 5


echo Files decrypted is in Desktop Press any key to exit ...
DEL %temp%\IpswTools\*.* /Q /F >NUL
::RMDIR /S /Q "%Version%_Origine"

::::// FIN DE TON CODE \\::::

::::// On kill notre FLASH \\::::

Start %toolbox%\flash.exe /kill "wait"


goto:menu

:Idevicerestore
cls
echo idevicerestore
echo.
Echo Votre iPhone..
%toolbox%\idevicename.exe
color 0E
title idevicerestore:
echo.
echo  Veuillez choisir [1/2/3]
echo.
echo 1/ Update
echo 2/ Restore
echo 3/ Menu
SET INPUT=
SET /P INPUT=Please select a number:
IF /I '%INPUT%'=='1' GOTO Update
IF /I '%INPUT%'=='2' GOTO Restore
IF /I '%INPUT%'=='3' GOTO Menu

:Update
Echo Update iPhone... 
Echo Deplacer l'ipsw dans l'invite de commande
set /p IPSW=
%toolbox%\idevicerestore.exe -d %IPSW% -C %temp%\IpswTools 
echo device Update finished^^
echo "Enter to return Menu"
pause
goto Menu

:Restore
Echo Restore iPhone...
Echo Deplacer l'ipsw dans l'invite de commande
set /p IPSW=
%toolbox%\idevicerestore.exe -e -d %IPSW% -C %temp%\IpswTools 
echo device Restore finished^^
echo Enter to return Menu
pause
goto Menu

::Reencryption
todo 


:kbags
cls
color 0C
echo.
echo	 dP     dP  888888ba   .d888888   .88888.  .d88888b 
echo	 88   .d8'  88    `8b d8'    88  d8'   `88 88.    "'
echo	 88aaa8P'  a88aaaa8P' 88aaaaa88a 88        `Y88888b.
echo	 88   `8b.  88   `8b. 88     88  88   YP88       `8b
echo	 88     88  88    .88 88     88  Y8.   .88 d8'   .8P
echo	 dP     dP  88888888P 88     88   `88888'   Y88888P 
echo                                         by Callum Jones
echo.
:: get the short file name of the IPSW.

call :sfn %IPSW% >> %logme%

<nul set /p "= - Extracting Files... "

cd %tempdir%

:: extract ipsw except RootFS and Ramdisks
Echo Deplacer l'ipsw dans l'invite de commande
set /p IPSW=
call :log Unzipping %IPSW%...
call %toolbox%\7za.exe e -oIPSW -mmt %IPSW% kernel* Firmware/* *.plist >> %logme%

echo Done^^!

<nul set /p "= - IPSW Info: " 

:: get the file names from manifest
for /f "tokens=*" %%a IN ('find "applelogo" ^<%tempdir%\IPSW\manifest') do set applelogo=%%a >NUL
for /f "tokens=*" %%a IN ('find "batterylow0" ^<%tempdir%\IPSW\manifest') do set batterylow0=%%a >NUL
for /f "tokens=*" %%a IN ('find "batterylow1" ^<%tempdir%\IPSW\manifest') do set batterylow1=%%a >NUL
::for /f "tokens=*" %%a IN ('find "glyphcharging" ^<%tempdir%\IPSW\manifest') do set glyphcharging=%%a >NUL
for /f "tokens=*" %%a IN ('find "batterycharging0" ^<%tempdir%\IPSW\manifest') do set batterycharging0=%%a >NUL
for /f "tokens=*" %%a IN ('find "batterycharging1" ^<%tempdir%\IPSW\manifest') do set batterycharging1=%%a >NUL
for /f "tokens=*" %%a IN ('find "glyphplugin" ^<%tempdir%\IPSW\manifest') do set glyphplugin=%%a >NUL
for /f "tokens=*" %%a IN ('find "batteryfull" ^<%tempdir%\IPSW\manifest') do set batteryfull=%%a >NUL
for /f "tokens=*" %%a IN ('find "LLB" ^<%tempdir%\IPSW\manifest') do set LLB=%%a >NUL
for /f "tokens=*" %%a IN ('find "iBoot" ^<%tempdir%\IPSW\manifest') do set iBoot=%%a >NUL
for /f "tokens=*" %%a IN ('find "DeviceTree" ^<%tempdir%\IPSW\manifest') do set DeviceTree=%%a >NUL
for /f "tokens=*" %%a IN ('find "recoverymode" ^<%tempdir%\IPSW\manifest') do set RecoveryMode=%%a >NUL
set iBSS=iBSS.%boardid%ap.RELEASE.dfu
set iBEC=iBEC.%boardid%ap.RELEASE.dfu
set kernel=kernelcache.RELEASE.%boardid%
pause
cd IPSW

<nul set /p "= - Getting Ramdisk Information... "

if exist %tempdir%\IPSW\oldstyle.txt del %tempdir%\IPSW\oldstyle.txt /S /Q >> %logme%

:: Ramdisk identification, Done properly :)

:: edit out un-needed strings using hex.
%toolbox%\binmay.exe -i %tempdir%\IPSW\Restore.plist -o %tempdir%\Restore.txt -s 0A 09 09 2>NUL
%toolbox%\binmay.exe -i %tempdir%\Restore.txt -o %tempdir%\Restore1.txt -s 09 09 09 2>NUL

:: then add a space before + after </string>

%toolbox%\ssr.exe 0 "</string>" " </string> " %tempdir%\Restore1.txt >NUL

:: then add a space after <key>Update</key><string>

%toolbox%\ssr.exe 0 "<key>Update</key><string>" "/SSR_NL/Update:" %tempdir%\Restore1.txt >NUL

:: and after <key>User</key><string>

%toolbox%\ssr.exe 0 "<key>User</key><string>" "/SSR_NL/User:" %tempdir%\Restore1.txt >NUL

:: remove 3C 2F 73 74 72 69 6E 67 3E (</string>) -- yes, i know, couldve just Done this above, who cares --- it works 

%toolbox%\binmay.exe -i %tempdir%\Restore1.txt -o %tempdir%\Restore2.txt -s "3C 2F 73 74 72 69 6E 67 3E" 2>NUL

:: replace User with restore, for easier identification

%toolbox%\ssr.exe 1 "User" "Restore" %tempdir%\Restore2.txt
%toolbox%\ssr.exe 1 "User" "NotherRD" %tempdir%\Restore2.txt
%toolbox%\ssr.exe 1 "User" "RootFS" %tempdir%\Restore2.txt

%toolbox%\binmay.exe -i %tempdir%\Restore2.txt -o %tempdir%\Restore4.txt -s 20 20 20 2>NUL

%toolbox%\ssr.exe 0 ".dmg" ".dmg/SSR_NL/" %tempdir%\Restore4.txt >NUL

:: set restore as the word after Restore:
FOR /F "tokens=2 delims=:" %%a IN ('find "Restore" ^<%tempdir%\Restore4.txt') DO set restore=%%a 
FOR /F "tokens=2 delims=:" %%a IN ('find "NotherRD" ^<%tempdir%\Restore4.txt') DO set notherRD=%%a 

if "%notherRD%"=="%restore%" (
	FOR /F "tokens=2 delims=:" %%a IN ('find "RootFS" ^<%tempdir%\Restore4.txt') DO set rootfilesystem=%%a 
) else (
	set rootfilesystem=%notherRD%
)

:: same as above but for update
FOR /F "tokens=2 delims=:" %%a IN ('find "Update" ^<%tempdir%\Restore4.txt') DO set update=%%a 

FOR /F "tokens=2 delims=:" %%a IN ('find "Update" ^<%tempdir%\Restore4.txt') DO set updateishere=yes

if exist %tempdir%\Restore4.txt del %tempdir%\Restore4.txt /S /Q >NUL

:: checking ramdisk numbers!!!
set update=%update: =%
set restore=%restore: =%
set rootfilesystem=%rootfilesystem: =%

if "%updateishere%"=="yes" (
	echo %update%> dmgs.txt
	set updateishere=yes
)

echo %restore%>> dmgs.txt
echo %rootfilesystem%>> dmgs.txt

%toolbox%\binmay.exe -i %tempdir%\IPSW\dmgs.txt -o %tempdir%\IPSW\dmgs-f.txt -s 20 20 20 2>NUL:ping -n 3 localhost >NUL
REM for /f "tokens=* delims= " %%a in (%tempdir%\IPSW\dmgs.txt) do (
	REM set /a n+=1
	REM set ramdisk!n!=%%a
REM )

REM if not "%updateishere%"=="yes" (
	REM CALL :log error No Update Ramdisk. Continuing...
	REM set restore=%ramdisk1%
	REM set rootfilesystem=%ramdisk2%
REM ) else (
    REM :: assume all 3 ramdisks are there. 
	REM set update=%ramdisk1%
	REM set restore=%ramdisk2%
	REM set rootfilesystem=%ramdisk3%
REM )
echo Done^^!

call :log Ramdisks-Update-%update%-Restore-%restore%-Rootfs-%rootfilesystem%

%toolbox%\7za.exe e -o%tempdir%\IPSW -mmt %IPSW% %update% %restore% >> %logdir%\%timestamp%


::echo bgcolor 0 0 0 >>%tempdir%\kbags.txt 


echo go fbecho ========================================>>%tempdir%\kbags.txt
::echo go fbecho - Loading iOS %ProductVersion%%MarketingVersiontitle% (%BuildNumber%) >>%tempdir%\kbags.txt 
::echo go fbecho ^> for %ProductType% (%url_parsing_device%) >>%tempdir%\kbags.txt 
echo go fbecho ========================================>>%tempdir%\kbags.txt



call :log Getting KBAGs...
:: delete the files

if exist %tempdir%\Restore.txt del %tempdir%\Restore.txt /S /Q >NUL
if exist %tempdir%\Restore1.txt del %tempdir%\Restore1.txt /S /Q >NUL
if exist %tempdir%\Restore2.txt del %tempdir%\Restore2.txt /S /Q >NUL



<nul set /p "= - Grabbing KBAGs... "

call :grabkbag %LLB% >>%tempdir%\kbags.txt
call :grabkbag %iBoot% >>%tempdir%\kbags.txt 
call :grabkbag %devicetree% >>%tempdir%\kbags.txt 
call :grabkbag %applelogo% >>%tempdir%\kbags.txt 
call :grabkbag %recoverymode% >>%tempdir%\kbags.txt 
call :grabkbag %batterylow0% >>%tempdir%\kbags.txt 
call :grabkbag %batterylow1% >>%tempdir%\kbags.txt 
::call :grabkbag %glyphcharging% >>%tempdir%\kbags.txt 
call :grabkbag %glyphplugin% >>%tempdir%\kbags.txt 
call :grabkbag %batterycharging0% >>%tempdir%\kbags.txt 
call :grabkbag %batterycharging1% >>%tempdir%\kbags.txt 
call :grabkbag %batteryfull% >>%tempdir%\kbags.txt 
call :grabkbag %ibss% >>%tempdir%\kbags.txt 
call :grabkbag %ibec% >>%tempdir%\kbags.txt 
call :grabkbag %kernel% >>%tempdir%\kbags.txt 

popd

echo go fbecho ===================================>>%tempdir%\kbags.txt
echo go fbecho - Done>>%tempdir%\kbags.txt 
echo go fbecho - KBAGs...>>%tempdir%\kbags.txt
echo go fbecho ===================================>>%tempdir%\kbags.txt

echo Done^^!
start "notepad" %temp%\IpswTools\kbags.txt
echo /exit >>%tempdir%\kbags.txt
timeout /t 3
echo Delete Files....
DEL %temp%\IpswTools\IPSW\*.* /Q /F >NUL
DEl %temp%\IpswTools\*.*/Q/F >NUL	
RMDIR /S /Q "%temp%\IpswTools\IPSW"
goto Menu


:Patch
cls
color 0C
echo.
echo  .oPYo.          o         8        .oPYo.                 o                 
echo  8    8          8         8        8    8                 8                 
echo o8YooP' .oPYo.  o8P .oPYo. 8oPYo.   8      o    o .oPYo.  o8P .oPYo. ooYoYo. 
echo  8      .oooo8   8  8    ' 8    8   8      8    8 Yb..     8  8    8 8' 8  8 
echo  8      8    8   8  8    . 8    8   8    8 8    8   'Yb.   8  8    8 8  8  8 
echo  8      `YooP8   8  `YooP' 8    8   `YooP' `YooP' `YooP'   8  `YooP' 8  8  8 
echo :..::::::.....:::..::.....:..:::..:::.....::.....::.....:::..::.....:..:..:..
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
DEL %temp%\IpswTools\*.* /Q /F >NUL
title Patch ,create custom ipsw...
ECHO Connect your iPhone !

timeout /t 10
ECHO.
ECHO Enter info Device please ....
SET ProductType=
FOR /F "tokens=2 delims=: " %%a in ('%toolbox%\ideviceinfo.exe ^| findstr "ProductType" ') do SET ProductType=%%a
SET ProductType=%ProductType: =%
SET HardwareModel=
FOR /F "tokens=2 delims=: " %%b in ('%toolbox%\ideviceinfo.exe ^| findstr "HardwareModel" ') do SET HardwareModel=%%b
SET HardwareModel=%HardwareModel: =%
SET DeviceClass=
FOR /F "tokens=2 delims=: " %%a in ('%toolbox%\ideviceinfo.exe ^| findstr "DeviceClass" ') do SET DeviceClass=%%a
SET DeviceClass=%DeviceClass: =%
%toolbox%\ideviceinfo.exe  | FIND /N /I "No device found" > NUL
cls
if errorlevel 1 (
    echo No device found
	cls
) else (
    echo PLease connect Devices!
    pause
	goto Patch
)

echo.
ECHO iPhone information  : "%ProductType% %HardwareModel% " 
start https://www.theiphonewiki.com/wiki/Firmware#%DeviceClass%
ECHO.
ECHO Enter your iPhone information !
ECHO.
ECHO Here is an example : Monarch
SET %=% /P CodeName="CodeName: "
ECHO Here is an example : 13A344
SET %=% /P BuildVersion="BuildVersion: "

%toolbox%\curl.exe -k -LO http://theiphonewiki.com/w/index.php?title=%CodeName%_%BuildVersion%_(%ProductType%)^&action=edit > NUL
Ren "index.php_title=%CodeName%_%BuildVersion%_(%ProductType%)&action=edit" "iPhoneWiki.bat" > NUL
%toolbox%\sed.exe -i -e "s/ //g" iPhoneWiki.bat > NUL
%toolbox%\sed.exe -i -e "s/|/Set /g" iPhoneWiki.bat > NUL
%toolbox%\sed.exe -i "/</d" iPhoneWiki.bat > NUL
%toolbox%\sed.exe -i "/document/d" iPhoneWiki.bat > NUL
%toolbox%\sed.exe -i "/mw/d" iPhoneWiki.bat > NUL
%toolbox%\sed.exe -i "/}/d" iPhoneWiki.bat > NUL
%toolbox%\sed.exe -i "1d" iPhoneWiki.bat > NUL
::Echo %toolbox%\Decrypting.bat>>iPhoneWiki.bat
call %temp%\IpswTools\iPhoneWiki.bat > NUL
cls


Echo  Create Directory....                                    
mkdir "%Version%" >> %logme%
mkdir "%Version%_New" >> %logme%
mkdir "%Version%_New\Firmware" >> %logme%
mkdir "%Version%_New\Firmware\all_flash" >> %logme%
mkdir "%Version%_New\Firmware\all_flash\all_flash.%HardwareModel%.production" >> %logme%
mkdir "%Version%_New\Firmware\dfu" >> %logme%
mkdir "%Version%_New\Firmware\usr" >> %logme%
mkdir "%Version%_New\Firmware\usr\local" >> %logme%
mkdir "%Version%_New\Firmware\usr\local\standalone" >> %logme%
cls

REM...
if exist "%toolbox%\FirmwareBundles\%ProductType%_%Version%_%BuildVersion%.bundle" (
REM Si le dossier existe
goto suite
)else (
echo  Sorry no bundle for your device...
timeout /t 5
cls
exit
)
REM...

:suite
cls

::::// LES PREPARATIFS POUR AFFPNG \\::::

::Définition de la taille du CMD

mode con:lines=40 cols=120
set "$c=1"

::Définition du titre de notre instance du CMD

set "$Title=Wait"
title %$title%

::On centre notre fenêtre CMD à l'écran

start %toolbox%\flash.exe  /LW "%$Title%" "centered"

::On debloque la fenêtre

start "" /wait %toolbox%\flash.exe /UL

::On récupère les coordonnées de la CMD

for /f "tokens=1-4 delims= " %%a in ('%toolbox%\flash.exe /getcmdpos "%$Title%"') do (
    set "$TopXCMD=%%a"
    set "$TopYCMD=%%b"
    set "$LargeurCMD=%%c"
    set "$HauteurCMD=%%d"
   goto:next4
  )


::On calcul la position d'affichage de notre Waiting barre

:next4

set /a $XPosImage=(%$LargeurCMD%/2)-(150/2)+%$TopXCMD%
set /a $YPosImage=(%$HauteurCMD%/2)-(150/2)+%$TopYCMD%


::On affiche notre Image au centre de notre CMD avec le paramètres [/attach]
::Et en [/nokill]

::::// FIN DES PREPARATIFS \\::::

::::// ICI LES PREPARATIFS POUR TON CODE \\::::
Echo  Drag in an...
Echo Move ipsw in the command prompt!
Set /P IPSW=
cls

::::// AFFICHAGE DU FLASH D'ATTENTE \\::::

echo Working !!! Please wait !!!
start %toolbox%\flash.exe "%toolbox%\6.swf" /flash /width 150 /heigth 150 /Xpos %$XPosImage% /YPos %$YPosImage% /attach "%$Title%" /nokill "wait"


ECHO Extract Ipsw please wait...                               
CALL %toolbox%\7za.exe x -o%Version% "%IPSW%" >> %logme%
cls

Echo Decrypt Dmg please wait...                                
copy "%toolbox%\FirmwareBundles\%ProductType%_%Version%_%BuildVersion%.bundle\*.patch" "%temp%\IpswTools\*.patch" >> %logme%
CALL %toolbox%\dmg.exe extract "%Version%\%RootFS%.dmg" "%Version%_New\Root.dmg" -k %RootFSKey% 1> NUL 2> NUL
CALL %toolbox%\xpwntool.exe "%Version%\%RestoreRamdisk%.dmg" "%Version%_New\Ramdisk.dmg" -k %RestoreRamdiskKEY% -iv %RestoreRamdiskIV% 1> NUL 2> NUL
cls 

   
Echo Patch Ramdisk please wait...                           
CALL %toolbox%\hfsplus.exe "%Version%_New\Ramdisk.dmg" grow "15728640" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Ramdisk.dmg" extract "/usr/sbin/asr" "asr.orig" >> %logme%
CALL %toolbox%\bspatch.exe "asr.orig" "asr.patched" "asr.patch" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Ramdisk.dmg" rm "/usr/sbin/asr" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Ramdisk.dmg" add "asr.patched" "/usr/sbin/asr" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Ramdisk.dmg" chmod "/usr/sbin/asr" 100755 >> %logme%
cls

   
Echo Copy Files please wait...                             
copy "%Version%\BuildManifest.plist" "%Version%_New\BuildManifest.plist" >> %logme%
copy "%Version%\Restore.plist" "%Version%_New\Restore.plist" >> %logme%
copy "%Version%\%UpdateRamdisk%.dmg" "%Version%_New\%UpdateRamdisk%.dmg" >> %logme%
copy "%Version%\Firmware\*.bbfw" "%Version%_New\Firmware\*.bbfw" >> %logme%
copy "%Version%\Firmware\*.plist" "%Version%_New\Firmware\*.plist" >> %logme%
copy "%Version%\Firmware\all_flash\all_flash.%HardwareModel%.production\*.img3" "%Version%_New\Firmware\all_flash\all_flash.%HardwareModel%.production\*.img3" >> %logme%
copy "%Version%\Firmware\all_flash\all_flash.%HardwareModel%.production\manifest" "%Version%_New\Firmware\all_flash\all_flash.%HardwareModel%.production" >> %logme%
copy "%Version%\%Kernelcache%" "%Version%_New\%Kernelcache%" >> %logme%
copy "%Version%\Firmware\dfu\*.dfu" "%Version%_New\Firmware\dfu\*.dfu" >> %logme%  
copy "%Version%\Firmware\all_flash\all_flash.%HardwareModel%.production\manifest" "%Version%_New\Firmware\all_flash\all_flash.%HardwareModel%.production" >NUL

cls

 
Echo Copy Files please wait...                             
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" extract "/private/etc/fstab" "fstab" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" grow 838860800 >> %logme%
CALL %toolbox%\RT.exe "fstab" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" rm "/private/etc/fstab" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" add "fstab.patched" "/private/etc/fstab" >> %logme%
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" chmod "/private/etc/fstab" 100755 >> %logme%


del fstab /S /Q > NUL
del fstab.patched /S /Q > NUL
cls

ECHO add unthered patch...
%toolbox%\hfsplus.exe "%Version%_New\Root.dmg" untar %toolbox%\jb\openssl.tar
echo.
echo Done^^


ECHO Add SSH...
%toolbox%\hfsplus.exe "%Version%_New\Root.dmg" untar %toolbox%\jb\ssh-shrink.tar
%toolbox%\hfsplus.exe "%Version%_New\Root.dmg" untar %toolbox%\jb\openssh.tar
%toolbox%\hfsplus.exe "%Version%_New\Root.dmg" untar %toolbox%\jb\openssl.tar
echo.
echo Done^^
echo modification manuel...
pause


ECHO add Cydia ...
%toolbox%\hfsplus.exe "%Version%_New\Root.dmg" untar %toolbox%\jb\Cydia.tar
%toolbox%\hfsplus.exe "%Version%_New\Root.dmg" chmod 6775 "/Applications/Cydia.app/MobileCydia"
echo.
echo Done^^



ECHO Symlink please wait...                                  
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/Applications" "/private/var/stash/Applications" 1> NUL 2> NUL
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/Library/Ringtones" "/private/var/stash/Ringtones" 1> NUL 2> NUL
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/Library/Wallpaper" "/private/var/stash/Wallpaper" 1> NUL 2> NUL
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/usr/bin" "/private/var/stash/bin" 1> NUL 2> NUL
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/usr/include" "/private/var/stash/include" 1> NUL 2> NUL
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/usr/libexec" "/private/var/stash/libexec" 1> NUL 2> NUL
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/usr/lib/pam" "/private/var/stash/pam" 1> NUL 2> NUL
CALL %toolbox%\hfsplus.exe "%Version%_New\Root.dmg" symlink "/usr/share" "/private/var/stash/share" 1> NUL 2> NUL
cls


   
echo ReBuild please wait...      
CALL %toolbox%\dmg.exe build "%Version%_New\Root.dmg" "%Version%_New\%RootFS%.dmg" 1> NUL 2> NUL
CALL %toolbox%\xpwntool.exe "%Version%_New\Ramdisk.dmg" "%Version%_New\%RestoreRamdisk%.dmg" -t "%Version%\%RestoreRamdisk%.dmg" -k %RestoreRamdiskkey% -iv %RestoreRamdiskIV% 1> NUL 2> NUL


del "%Version%_New\Root.dmg" >> %logme%
del "%Version%_New\Ramdisk.dmg" >> %logme%
cls


echo Build Custom please wait...                             
cd %Version%_New >> %logme%
%toolbox%\7za.exe u -tzip -mx0 Custom.ipsw >> %logme%

::MOVE Custom.ipsw ../
move /y "Custom.ipsw" "%UserProfile%\Desktop\" >NUL
Echo clean
cd ..
RMDIR /S /Q "%Version%_New" 
RMDIR /S /Q "%Version%"
del asr.orig
del asr.patched

echo done
timeout /t 8
Start %toolbox%\flash.exe /kill "wait"


goto:menu



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:grabkbag

set filename=%~f1
for /F "tokens=5 delims=: " %%z in ('%toolbox%\xpwntool.exe %filename% %temp%\IpswTools\IPSW\#') do set kbag=%%z 2>NUL >NUL

echo go fbecho - %~n1%~x1
echo go echo %~n1%~x1
echo go aes dec %kbag%
if exist %temp%\IpswTools\# del %temp%\IpswTools\# /S /Q >NUL

goto eof

:DeQuote
SET _DeQuoteVar=%1
CALL set _DeQuoteString=%%!_DeQuoteVar!%%
IF [!_DeQuoteString:~0^,1!]==[^"]  ( 
IF [!_DeQuoteString:~-1!]==[^"]  ( 
SET _DeQuoteString=!_DeQuoteString:~1,-1!
) else (goto :eof)
) else (goto :eof)
SET !_DeQuoteVar!=!_DeQuoteString!
SET _DeQuoteVar=
SET _DeQuoteString=
GOTO :eof

:sfn
SET bundlename=%~n1.bundle
SET shortipsw=%~n1.ipsw
GOTO :eof


:log

:: log messages

IF not EXIST %logdir%  MKDIR %logdir% > NUL
SET timestamp=IpswTools_%version%.log
SET logme=%logdir%\%timestamp%
IF not EXIST %logme%  echo.  > %logme%
IF not "%1"==""  ( 
    IF "%1"=="error"  ( 
        ECHO [%time:~0,8%] [ERROR] %2 %3 %4 %5 %6 %7 %8 %9 >> %logme%
    ) else (
        ECHO [%time:~0,8%] [INFO] %1 %2 %3 %4 %5 %6 %7 %8 %9 >> %logme%
    )
) else (
    ECHO Usage: log ^[error^]
)

GOTO eof

:: parse.bat - pretty epic really.

:parse
::mkdir %temp%\plistparse
::%toolbox%\binmay.exe -i %plist% -o %temp%\plistparse\tmp1 -s 0A 09 09 2>NUL
::%toolbox%\binmay.exe -i %temp%\plistparse\tmp1 -o %temp%\plistparse\tmp2 -s 09 09 09 2>NUL
::%toolbox%\ssr.exe 0 "</string>" "/SSR_NL/</string> " %temp%\plistparse\tmp2 >NUL
::%toolbox%\ssr.exe 0 "<key>%string%</key><string>" "/SSR_NL/%string%:" %temp%\plistparse\tmp2 >NUL
::FOR /F "tokens=2 delims=:" %%a IN ('find "%string%" ^<%temp%\plistparse\tmp2') DO set data1=%%a 

::echo %data1% >%temp%\plistparse\tmp3

::set thedata1=
::set data=

::%toolbox%\binmay.exe -i %temp%\plistparse\tmp3 -o %temp%\plistparse\tmp4 -s 20 20 20 2>NUL

::set /p data=<%temp%\plistparse\tmp4



::if exist %temp%\plistparse\ rmdir %temp%\plistparse /S /Q >> %logme%

goto eof

:eof

