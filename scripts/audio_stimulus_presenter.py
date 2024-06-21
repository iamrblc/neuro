
##################
# AUDIO STIMULUS #
#   PRESENTER    #
##################

#####################
# UNDER DEVELOPMENT #
#####################

import pygame
import time
import os

'''
IMPORTANT: Run this script form the scripts directory!

Loads a list of sound files and plays them sequentially using pygame mixer.
'''

# Initialize pygame mixer
pygame.mixer.init()

print ("Pygame mixer initialized")

# List of sound files to be played sequentially
sound_files = ['dog_001.wav',
               'dog_002.wav',
               'dog_003.wav',
               'dog_004.wav',
               'dog_005.wav',
               'dog_006.wav']

print ("Sound files added")


# Preload sound files
sounds = [pygame.mixer.Sound(file) for file in sound_files]

print ("Sounds preloaded")

# Function to play a sound file and wait for it to finish
def play_sound(sound, sound_number):
    sound.play()
    time.sleep(sound.get_length())
    print(f'Sound {sound_number} finished')

print("function declared")

# Play each preloaded sound in sequence with a counter
for idx, sound in enumerate(sounds, start=1):
    play_sound(sound, idx)

print("All sounds finished playing.")

