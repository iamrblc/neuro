
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

'''
IMPORTANT: Run this script form the scripts directory!

Loads a list of sound files and plays them sequentially using pygame mixer.

The script doesn't check for snippet length and bitrate. It assumes all sound files are of the same length and bitrate.
If it is important, that has to be addressed. 

'''

#### 0. SETUP 
#### 0.1 Load packages
import pygame               # Loads and plays the sound files
import time                 # Waits for the sound to finish playing
import os                   # For file path manipulation
import random               # For pseudorandomization
from collections import Counter # For counting elements

#### 0.2 Set random seed to ensure reproducibility
#random.seed(42)

#### 0.3 Constants
NUM_REPS = 15                
BLOCK_LENGTH = 6            

TAGS = ['dog',
        'environment',
        'human',
        'swine',
        'silence']

#### 0.4 Initialize pygame mixer
pygame.mixer.init()
print ("The audio modul is up and running.")

#### 0.5 Define functions
#### 0.5.1 Sound loader
def sound_loader(tag):
    """
    Load all .wav sounds from the specified folder based on the tag.
    
    Parameters:
    tag (str): The tag for the sounds, which is also the folder name (e.g., dog, pig, human).

    Returns:
    list: A list of preloaded pygame Sound objects.
    """
    folder = f'../data_audio/{tag}'
    sounds_list = []
    
    # Load all .wav files from the specified folder
    for file in os.listdir(folder):
        if file.endswith('.wav'):
            sounds_list.append(os.path.join(folder, file))
    
    # Preload sound files
    preloaded_sounds = [pygame.mixer.Sound(file) for file in sounds_list]
    
    print(f"All {tag} sounds preloaded")
    
    return preloaded_sounds

#### 0.5.2 Pseudorandomizer
def pseudorandomizer(tags = TAGS, num_reps = NUM_REPS):
    '''
    In this context "pseudorandom" simply means random shuffle with no
    two subsequent elements being the same.  
    '''
    total_count = num_reps * len(tags)
    tag_counter = Counter(tags * num_reps)
    
    result = []
    
    def add_tag():
        if len(result) == total_count:
            return True
        
        available_tags = [tag for tag in tags if tag_counter[tag] > 0]
        random.shuffle(available_tags)
        
        for tag in available_tags:
            if len(result) == 0 or result[-1] != tag:
                result.append(tag)
                tag_counter[tag] -= 1
                
                if add_tag():
                    return True
                
                # Backtrack
                result.pop()
                tag_counter[tag] += 1
        
        return False
    
    add_tag()
    return result

#### 0.5.3 Sound player
def play_sound(sound):
    '''
    This function is responsible for playing the sound snippets one
    after the other. 
    '''
    sound.play()
    time.sleep(sound.get_length()) 

#### 1. Preload the sounds
for tag in TAGS:
    preloaded_sounds = sound_loader(tag)
    globals()[f"{tag}_preloaded_sounds"] = preloaded_sounds
    print(f"{tag}_preloaded_sounds: {preloaded_sounds}")

#### 2. Create the pseudorandom sequence of blocks
block_sequence = pseudorandomizer()
print(len(block_sequence), block_sequence)

#### 3. Run the experiment
print("Experiment starts now.")
for block in block_sequence:
    preloaded_sounds = eval(f"{block}_preloaded_sounds")
    play_this = random.sample(preloaded_sounds, BLOCK_LENGTH*2)
    for snippet in play_this:
        play_sound(snippet)
    print(f"{block} sounds played")
    time.sleep(2)
    print("2 sec pause over")
print("Experiment is over.")