%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUDIO STIMULUS PRESENTER FOR HD-DOT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make sure you are in the scripts directory when launching the file.

% 0. ENVIRONMENT SETTINGS

% Clear everything
clear all
clc

% Set up current dictionary as working directory ('./')
cd(fileparts(mfilename('fullpath')))

% Set up path to the audio snippets (../data_audio)
audio_path = fullfile(fileparts(mfilename('fullpath')), '..', 'data_audio');

disp("It ran until here for sure")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OKAY, LET'S SWITCH TO A REAL LANGUAGE FOR NOW... %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
