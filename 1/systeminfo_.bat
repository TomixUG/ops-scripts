@echo off
rem program vypíše aktuální systémové informace, na začátku přepíše soubor
echo Aktualni datum %DATE% %TIME% > systeminfo.txt

echo. >> systeminfo.txt
echo Nazev prihlaseneho uzivatele: %USERNAME% >> systeminfo.txt

echo. >> systeminfo.txt
echo Systeminfo: >> systeminfo.txt
systeminfo >> systeminfo.txt

echo. >> systeminfo.txt
echo Vyhledavaci cesty (path): >> systeminfo.txt
echo %PATH% >> systeminfo.txt

echo. >> systeminfo.txt
echo Systemove promenne: >> systeminfo.txt
set >> systeminfo.txt

