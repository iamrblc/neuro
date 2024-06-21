import pygame
import time
import os

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

# Make ./scripts the current working directory
os.chdir(os.path.dirname(__file__))
print ("Current working directory set to ./scripts")

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

