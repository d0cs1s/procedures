#!/usr/bin/python

from time import sleep
from phue import Bridge
import logging

logging.basicConfig()
b = Bridge('') # Entrer l'ip du bridge

# Décommenter la ligne suivante pour enregistrer l'app
#b.connect()

lights = b.lights

# Rainbow hue
def rainbow_hue():
    i = 0
    print('Quelle lumière ?')
    for l in lights:
        print(str(i) + ' ' + l.name)
        i+=1
        
        
    selection = int(input("Entrer la valeur : "))

    totalTime = 60 # Temps du cycle
    transitionTime = 1

    maxHue = 65535
    hueIncrement = maxHue / totalTime
                
    lights[selection].transitiontime = transitionTime * 10
    lights[selection].brightness = 254
    lights[selection].saturation = 254
    lights[selection].on = True
        

    hue = 0
    while True:
        lights[selection].hue = hue
        hue = (hue + hueIncrement) % maxHue

        sleep(transitionTime)


def ignition_hue():
    i = 0
    for l in lights:
        lights[i].on = True
        lights[i].hue = 9000
        lights[i].brightness = 254
        lights[i].saturation = 254
        i+=1
        
    print(str(i) + ' lumières allumées.')


def extinction_hue():
    i = 0
    for l in lights:
        lights[i].on = False
        i+=1
        
    print(str(i) + ' lumières éteintes.')
    
    
# Dictionnaire d'options du menu principal
menu_options = {
    1: 'Allumage des lumières',
    2: 'Extinction des lumières',
    3: 'Rainbow Hue',
    4: 'Exit',
}


def print_menu():
    for key in menu_options.keys():
        print (key, '--', menu_options[key] )


def option1():
     print('Sélection : \'Allumage des lumières\'')
     ignition_hue()


def option2():
    print('Sélection : \'Extinction des lumières\'')
    extinction_hue()
    

def option3():
    print('Sélection : \'Rainbow Hue\'')
    rainbow_hue()


if __name__=='__main__':
    while(True):
        print_menu()
        option = ''
        
        try:
            option = int(input('Entrez votre choix: '))
        except:
            print('Entrez un nombre ...')
            
        if option == 1:
           option1()
        elif option == 2:
            option2()
        elif option == 3:
            option3()
        elif option == 4:
            print('Fermeture de l\'application')
            exit()
        else:
            print('Option invalide. Merci de rentrer un chiffre de 1 à 4')
