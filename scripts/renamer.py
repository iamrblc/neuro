#################
#  FILE RENAMER #
#################

'''
This file renames all files in a given directory in the format
of tag_001.wav.

Make sure you have a backup of the files before running this
script as the original filenames might carry important
information that will be lost.

If you run it on a different file structure, you may need to
tweak it a bit.
'''

# Load packages

import os      # For file name operations
import sys     # For system operations

# Get current working directory
cwd = os.getcwd()
print(cwd)

# Path to /data_audio
audio_dir = os.path.join(cwd, 'data_audio')

# Subdirectories with audio files
dog_dir = os.path.join(audio_dir, 'dog')
environment_dir = os.path.join(audio_dir, 'environment')
human_dir = os.path.join(audio_dir, 'human')
swine_dir = os.path.join(audio_dir, 'swine')

# FUNCTIONS
# Rename files
def rename_files(directory, tag):
    # Change working directory to proper one
    os.chdir(directory)
    # List all files in the directory
    files = os.listdir(directory)
    # Sort the files in the directory
    files.sort()
    # Counter for the file number
    file_number = 1
    # Iterate through the files
    for file in files:
        # Split the file name into the name and extension
        name, ext = os.path.splitext(file)
        # Create a new file name with the tag and the file number
        new_name = f'{tag}_{file_number:03}{ext}'
        # Rename the file
        os.rename(file, new_name)
        # Increment the file number
        file_number += 1

# Call the function for each subdirectory
rename_files(dog_dir, 'dog')
rename_files(environment_dir, 'env')
rename_files(human_dir, 'human')
rename_files(swine_dir, 'pig')

print("All files renamed.")
