
##################
# AUDIO STIMULUS #
#   PRESENTER    #
##################

'''
Laszlo Robert Zsiros - RbLc
Department of Ethology,
ELTE University, Budapest
2024-06-20
'''

#####################
# UNDER DEVELOPMENT #
#####################

import pygame               # Loads and plays the sound files
import time                 # Waits for the sound to finish playing
import os                   # For file path manipulation
import random               # For pseudorandomization

'''
IMPORTANT: Run this script form the scripts directory!

Loads a list of sound files and plays them sequentially using pygame mixer.

The script doesn't check for snippet length and bitrate. It assumes all sound files are of the same length and bitrate.
If it is important, that has to be addressed. 

'''
# Set random seed to ensure reproducibility
random.seed(42)

# This isolates the tag (dog, human, etc)
def get_tag(element):
    return element.split('_')[0]

# This function shuffles the list without consecutive repeats
def pseudorandomizer(lst):
    while True:
        random.shuffle(lst)                                        # Shuffle the list
        for i in range(1, len(lst)):
            if get_tag(lst[i]) == get_tag(lst[i - 1]):             # But if two following tags are the same, reshuffle
                break
        else:
            return lst                                             # If they are not the same move on

sample_list = ['dog_1', 'pig_1', 'human_1', 'environment_1', 'silence_1', 
               'dog_2', 'pig_2', 'human_2', 'environment_2', 'silence_2', 
               'dog_3', 'pig_3', 'human_3', 'environment_3', 'silence_3']

print("Original list: ")
print(sample_list)

# Shuffle without consecutive repeats
shuffled_list = pseudorandomizer(sample_list)
print("\nAfter pseudorandomization: ")
print(shuffled_list)


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

