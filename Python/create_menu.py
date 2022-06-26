#!/usr/bin/python

menu_options = {
    1: 'Option 1',
    2: 'Option 2',
    3: 'Option 3',
    4: 'Exit',
}


def print_menu():
    for key in menu_options.keys():
        print (key, '--', menu_options[key] )

        
def option1():
     print('Selection \'Option 1\'')

        
def option2():
     print('Selection \'Option 2\'')

        
def option3():
     print('Selection \'Option 3\'')

        
if __name__=='__main__':
    while(True):
        print_menu()
        option = ''
        try:
            option = int(input('Entrez votre choix: '))
        except:
            print('Entrez un nombre ...')
        #Check what choice was entered and act accordingly
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
