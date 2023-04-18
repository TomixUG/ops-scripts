@echo off

echo Ukladani vsech potrebnych informaci do systeminfo.txt...

rem program vypíše aktuální systémové informace, na začátku přepíše soubor
echo Aktualni datum %DATE% %TIME% > systeminfo.txt

rem vypise nazev prihlaseneho uzivatele
echo. >> systeminfo.txt
echo Nazev prihlaseneho uzivatele: %USERNAME% >> systeminfo.txt

rem vypise systemove info
echo. >> systeminfo.txt
echo Systeminfo: >> systeminfo.txt
systeminfo >> systeminfo.txt >nul 2>&1

rem vypise paths
echo. >> systeminfo.txt
echo Vyhledavaci cesty (path): >> systeminfo.txt
echo %PATH% >> systeminfo.txt

rem vypise systemove promenne
echo. >> systeminfo.txt
echo Systemove promenne: >> systeminfo.txt
set >> systeminfo.txt

echo Hotovo!
