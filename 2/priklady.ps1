# musime pridat relativni a absolutni path
$source_file = Join-Path -Path $PSScriptRoot -ChildPath "priklady.txt"

$buffer = "" # buffer vystupu

$i = 0 # pocitani pocet iteraci (pro psani chyb vstupu uzivatele)

# iterujeme pres kazdy radek v souboru
foreach ($line in Get-Content $source_file) {
    $i = $i + 1
    $problem = $line.Split(" ")

    # pokud je radek prazdny ignoruj
    if($line -eq ""){
        continue
    }

    # zkontroluj jestli je vstup validni cislo
    # -as [decimal] neprojde pro nulu, proto se musi pridat kontrola jestli je toto cislo 0
    if(!($problem[0] -eq "0") -and !($problem[0] -as [decimal])){
        Write-Output "ERROR radek $($i): invalidni prvni cislo"
        exit
    }
    if(!($problem[2] -eq "0") -and !($problem[2] -as [decimal])){
        Write-Output "ERROR radek $($i): invalidni druhe cislo" 
        exit
    }

    # zjistime jake je znemenko, podle toho bud pricteme, odecteme, nasobime, delime
    # vysledek zaokrouhlime na 2 des mista
    switch ($problem[1]) {
        "+" {
            $answer = [math]::Round([float]$problem[0] + [float]$problem[2], 2)
            break
        }
        "-" {
            $answer = [math]::Round([float]$problem[0] - [float]$problem[2], 2)
            break
        }
        "*" {
            $answer = [math]::Round([float]$problem[0] * [float]$problem[2], 2)
            break
        }
        "/" {
            $answer = [math]::Round([float]$problem[0] / [float]$problem[2], 2)

            # zkontroluj jestli se nedeli nulou
            if($problem[2] -eq 0){
                Write-Output "ERROR radek $($i): Nulou se neda delit!"
                exit
            }

            break
        }
        default {
           Write-Output "ERROR radek $($i): bylo nalezeno invalidni znamenko"
           exit
        }
    }

    # zapsat do bufferu
    $buffer += "$line = $answer`n"
}

# pokud kod dosel na toto misto, znamena to, ze vse probehlo bez erroru
# zapis tedy vystup do souboru
"" | Out-File -FilePath priklady.txt -Append -Encoding utf8 # novy radek
"" | Out-File -FilePath priklady.txt -Append -Encoding utf8 # novy radek
$buffer | Out-File -FilePath $source_file -Append -Encoding utf8
