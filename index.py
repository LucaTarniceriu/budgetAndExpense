import os
from datetime import date

n = "start"
cmd = False
while(True):
    os.system('cls')
    n = 0
    total = 0


    n = input("Suma:")
    for digit in range(1, len(n)):
        if n[digit].isdigit() == False: cmd = True

    if cmd==False:
        n = int(n)
    else:
        if n == "file" or n == "open" or n == "output" or n == "total" or n == "stop" or n == "end" or n == "close":
            os.startfile('Z:\\wallet\\output.txt')      # open file
            break
    name = input("Sursa:")
    imprumut = input("Imprumut:")
    if imprumut == "da": imprumut = "imprumut"
    else: imprumut = " "
    curency = input("Curency:")




    with open("output.txt") as file:                #  read last line / str(s = x) --> int(s)
        for line in (file.readlines() [-1]):
            if line.isdigit():
                total = int(total) * 10 + int(line)

    if(curency == "EUR" or curency == "eur"):
        total = int(total) + (5 * n)
    else:
        total = int(total) + int(n)
    total_text = "s = " + str(total) + " RON"


    with open("output.txt", 'r+') as fp:            # delete last line
        lines = fp.readlines()
        fp.seek(0)
        fp.truncate()
        fp.writelines(lines[:-1])

    Date = date.today().strftime("%d %b %Y")

    with open("output.txt", "a") as f:              # write sum, date, and new total 
        if n > 0:
            f.write(" ")


        if len(str(n)) == 4 and n > 0:
            f.write(str(n) + "  " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)

        if len(str(n)) == 3 and n > 0:
            f.write(str(n) + "   " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)

        if len(str(n)) == 2 and n > 0:
            f.write(str(n) + "    " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)
        
        if len(str(n)) == 1 and n > 0:
            f.write(str(n) + "     " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)

        if len(str(n)) > 4 and n > 0:
            f.write(str(n) + "  " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)




        if len(str(n)) == 4 and n < 0:
            f.write(str(n) + "   " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)

        if len(str(n)) == 3 and n < 0:
            f.write(str(n) + "    " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)

        if len(str(n)) == 2 and n < 0:
            f.write(str(n) + "     " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)
        
        if len(str(n)) == 1 and n < 0:
            f.write(str(n) + "      " + curency.upper() + " " + Date + "   " + name + " "  + imprumut)

        if len(str(n)) > 4 and n < 0:
            f.write(str(n) + " " + curency.upper() + "   " + Date + "   " + name + " "  + imprumut)


        f.write("\n" + total_text)


