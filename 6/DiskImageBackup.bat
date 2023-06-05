@echo off

:: prvni zkontrolujeme jestli ma uzivatel administratorske prava, pokud ne ukoncime program
:: udelame to zavolanim prikazu, ke kteremu maji pristup pouze admins
dism >nul 2>&1
if errorlevel 1 (
    echo ERROR: Script musi byt spusten jako admin
    exit /b 1
) 

echo ==== Zalohovani disku =====
echo varovani: nelze zalohovat aktualne pouzivany disk
echo.

:: snazime se od uzivatele dostat vstup, ptame se do te doby nez ho da
:loop
set partition=
set /p partition="Zadejte partition, kterou chcete zalohovat (napr. D:\): "
if "%partition%"=="" (
    goto loop
)
:: zkontrolujeme jestli je cesta validni
IF NOT EXIST "%partition%\" (
    echo partition "%partition%" neni validni!
    goto loop
) 

:: snazime se od uzivatele dostat vstup, ptame se do te doby nez ho da
:loop2
set imagename=
set /p imagename="Zadejte cestu kam chcete ulozit bitovou kopii (napr. C:\backup.wim): "
if "%imagename%"=="" (
    goto loop2
)
:: vezmeme parent path (cesta k tomu souboru, bez toho souboru) a zkontrolujeme jeslti je validni
set "parentPath=%imagename%\.."
IF NOT EXIST "%parentPath%\" (
    echo cesta neni validni!
    goto loop2
) 

echo.
echo Jdeme zalohovat partition %partition%
echo Bitova kopie se ulozi do %imagename%
echo.
echo == Log programu DISM: ==

:: udelame bitovou kopii a compresujeme ji
dism /Capture-Image /ImageFile:%imagename% /CaptureDir:%partition% /Name:MyImage /Compress:Max /CheckIntegrity

echo.

if errorlevel 1 (
    echo == ERROR: Nastal problem v prubehu vytvareni bitove kopie! ==
) else (
    echo == Disk byl uspesne zalohovan ==
)

