@echo off

:: Zkontroluje jestli jsme pripojeni k internetu pomoci errorlevelu
:: Pokud neni internet dostupny ukonci program
echo Overovani konektivity k internetu...
ping -n 3 google.com > nul
if errorlevel 1 (
    echo KONEKTIVITA CHYBA
    exit /b 1
) else (
    echo KONEKTIVITA OK
    echo KONEKTIVITA OK > internet.txt
    echo. >> internet.txt
)

:: Pta se uzivatele tak dlouho, nez neco napise
set address=
set /p address="Zadejte domenu nebo IP adresu serveru: "
:loop
if "%address%"=="" (
    set /p address="Zadejte domenu nebo IP adresu serveru: "
    goto loop
)

:: Napise zadanou adresu do souboru
echo Adresa: %address% >> internet.txt
echo. >> internet.txt

:: Napise tracert
:: Pomoci 2> NUL udela, at program nepise zadny vystup
echo Ziskavani cesty paketu na zadanou adresu serveru...
echo ===== Cesta paketu: ===== >> internet.txt
tracert %address% >> internet.txt 2> NUL

:: Napise whois
echo Ziskavani informaci o domene pomoci whois...
echo. >> internet.txt
echo ===== Whois informace o domene: ===== >> internet.txt
whois %address% >> internet.txt 2> NUL

:: Napise DNS zanzamy
echo Ziskavani DNS zaznamu domeny...
echo. >> internet.txt
echo ===== DNS zaznamy: ====== >> internet.txt
nslookup %address% >> internet.txt 2> NUL

