#!/usr/bin/python

from time import sleep
from phue import Bridge
import logging

# Entrer l'ip du bridge
logging.basicConfig()
b = Bridge('IP')

# Décommenter la ligne suivante pour enregistrer l'app
#b.connect()

# Rainbow hue
lights = b.lights
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
