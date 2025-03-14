#!/bin/bash

location="/home/themartianx/Projects/wallet"
suma="start"
while true
do
    clear
    echo -n Suma:
    read suma
    if [ $suma == "open" ]; then
        xed $location/output.txt &
        continue
    fi

    echo -n Source:
    read source

    echo -n Imprumut:
    read borrow

    echo -n Currency:
    read currency
    currency=${currency^^} #transforma stringul $currency in upper case

    if [ $currency == "EUR" ]; then 
        multiplier=5
    else
        multiplier=1
    fi 


    if [ $borrow == "da" ]; then
        borrow="imprumut"
    else
        borrow=""
    fi


    dateString=$(date +"%d %b %Y")
    
    if (( suma < 0 )); then # afiseaza linia inainte de a modifica fisierul, si asteapta confirmarea
        printf "%-7d%s %s   %s %s\n" "$suma" "$currency" "$dateString" "$source" "$borrow"
    else
        printf " %-6d%s %s   %s %s\n" "$suma" "$currency" "$dateString" "$source" "$borrow"
    fi
    read pause
    # Daca se intrerupe programul aici, fisierul de output nu este afectat
    
    # Ia ultima linie din output si extrage valoarea sumei
    oldSum=$( tail -n 1 $location/output.txt )
    oldSum=${oldSum:3:-4}

    touch tempFile 2>/dev/null # redirectioneaza in null un mesaj de eroare care nu influenteaza rezultatul
    head -n -1 $location/output.txt>tempFile # scrie toate liniile mai putin ultima intr-un fisier temporar
    cat tempFile > $location/output.txt # suprascrie fisierul cu intrarile, excluzand suma
    rm tempFile

    if [ "$source" == "salar" ]; then 
        leftWith=$(( suma*multiplier ))
    else
        leftWith=$( tail -n 1 $location/output.txt ) # extrage suma ramasa 
        leftWith=${leftWith:17:-6}
        leftWith=$(( leftWith + suma*multiplier )) # calculeaza noua suma ramasa
        
        touch tempFile 2>/dev/null # redirectioneaza in null un mesaj de eroare care nu influenteaza rezultatul
        head -n -1 $location/output.txt>tempFile # scrie toate liniile mai putin ultima intr-un fisier temporar
        cat tempFile > $location/output.txt # suprascrie fisierul cu intrarile, excluzand suma
        rm tempFile
    fi



    if (( suma < 0 )); then # scrie intrarile cu toate valorile si le aranjeaza in functie de dimensiunea stringului suma, si daca este pozitiva sau negativa
        printf "%-7d%s %s   %s %s\n" "$suma" "$currency" "$dateString" "$source" "$borrow" >> $location/output.txt
    else
        printf " %-6d%s %s   %s %s\n" "$suma" "$currency" "$dateString" "$source" "$borrow" >> $location/output.txt
    fi

    echo "----- left with: $leftWith -----" >> $location/output.txt # readauga linia cu leftWith 

    newSum=$(( suma*multiplier + oldSum )) # calculeaza noua suma


    echo "s = $newSum RON" >> $location/output.txt # scrie noua suma
done
