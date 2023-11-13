#!/usr/bin/python3
# Programme permettant de piloter les lumières Philips Hue
# à travers une interface simple.
# Version 2.0
# 
# Ecrit par d0cs1s

from tkinter import *
from phue import Bridge

b = Bridge('172.19.0.168')

# Décommenter la ligne suivante et appuyer sur le bridge avant le 1er lancement du programme
#b.connect()

# Fenêtre principale
root = Tk()

# Personnalisation de la fenêtre
root.title("PyLight 2.0")
root.geometry("480x360")
root.minsize(480, 360)
root.config(background='#270087')

# Création frames
frame_text = Frame(root, bg='#270087')
frame_lights = Frame(root, bg='#270087')
frame_hue = Frame(root, bg='#270087')

# Titre
label_title = Label(frame_text, text="PyLight 2", font=("Helvetica", 35), bg='#270087', fg='white')
label_title.pack()

# Sous-titre
label_subtitle = Label(frame_text, text="Soyez inspirés", font=("Helvetica", 15), bg='#270087', fg='white')
label_subtitle.pack()

# Réglettes de luminosité et boutons on/off
lights = b.get_light_objects('id')
for light_id in lights:
    channel_frame = Frame(frame_lights, bg='#1d0066')
    channel_frame.pack(side='left')

    scale_command = lambda x, light_id=light_id: b.set_light(light_id,{'bri': int(x), 'transitiontime': 1})
    scale = Scale(channel_frame, from_ = 254, to = 0, command = scale_command, length = 200, showvalue = 0, bg='#1d0066')
    scale.set(b.get_light(light_id,'bri'))
    scale.pack()

    button_var = BooleanVar()
    button_var.set(b.get_light(light_id, 'on'))
    button_command = lambda button_var=button_var, light_id=light_id: b.set_light(light_id, 'on', button_var.get())
    button = Checkbutton(channel_frame, variable = button_var, command = button_command, bg='#1d0066')
    button.pack()

    label = Label(channel_frame, bg='#1d0066', fg='white')
    label.config(text = b.get_light(light_id,'name'))
    label.pack()


# Changement de couleurs
for light_id in lights:
    channel_frame2 = Frame(frame_hue, bg='#1d0066')
    channel_frame2.pack(side='left')

    scale_command2 = lambda x, light_id=light_id: b.set_light(light_id,{'hue': int(x), 'transitiontime': 1})
    scale2 = Scale(channel_frame2, from_ = 65535, to = 0, command = scale_command2, length = 225, showvalue = 0, bg='#1d0066')
    scale2.set(b.get_light(light_id,'hue'))
    scale2.pack()

    label2 = Label(channel_frame2, bg='#1d0066', fg='white')
    label2.config(text = b.get_light(light_id,'name'))
    label2.pack()


# Let's rock'n'roll
# /TODO maybe with pyaudio


# Pack des frames avant affichage
frame_text.pack(expand=True)
frame_lights.pack(pady=1, side='left', expand=True)
frame_hue.pack(pady=1, side='right', expand=True)

# Affichage de la fenêtre
root.mainloop()
