%========================================================================
%   PROJECT:   "MENTAL CONTROL" 
%   - Open-source programming. Funded by ELLAK.

%   Algorithms for EEG analysis and features extraction
%   to recognize left and right hand movements for a BCI system.
%
%   The purpose of this project is to provide insights into basic
%   concepts around EEG signal processing using free, open EEG data.

%   Copyright (C) 2015, Kostas Tsiouris

% [feature_vector] = feature_extraction_v1(signal)
% feature_extraction_v1 computes signal energy by STFT.
% INPUTS:
% - signal          : The EEG time series (vector of size c x l).
%                       c = number of channels
%                       l = length of signal
% OUTPUTS
% - feature_vector  : The extracted feature vector (vector of size 1 x 103).

%   Version: 1.0

%========================================================================

% LICENSE:
%     This program is free software; you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation; either version 3 of the License, or
%     any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program. If not, see http://www.gnu.org/licenses/>.

%=========================================================================
% Link      : https://github.com/ellak-monades-aristeias/mental-control

%========================================================================= 


function [feature_vector] = feature_extraction_v1(signal)

%----------------------------------------------------------------------------------------------------------------------------------------------
% Features
%----------------------------------------------------------------------------------------------------------------------------------------------
%    
%     -- Signal Energy, sum of all channels (STFT signal)
%     f1 = signal sum 1-3 Hz 
%     f2 = signal sum 4-7 Hz
%     f3 = signal sum 8-13 Hz
%     f4 = signal sum 14-20 Hz
%     f5 = signal sum 21-30 Hz
%     f6 = signal sum 31-45 Hz
%     f7 = signal sum 55-95 Hz
%     f8 = signal sum 105-145 Hz
% 
%     -- Signal Energy per EEG channel  
%     f_FP1_x = signal energy from channel FP1
%     f_FP2_x = signal energy from channel FP2
%     f_F3_x = signal energy from channel F3
%     f_F4_x = signal energy from channel F4
%     f_C3_x = signal energy from channel C3
%     f_C4_x = signal energy from channel C4
%     f_P3_x = signal energy from channel P3
%     f_P4_x = signal energy from channel P4
%     f_O1_x = signal energy from channel O1
%     f_O2_x = signal energy from channel O2
%     f_F7_x = signal energy from channel F7
%     f_F8_x = signal energy from channel F8
%     f_T3_x = signal energy from channel T3
%     f_T4_x = signal energy from channel T4
%     f_T5_x = signal energy from channel T5
%     f_T6_x = signal energy from channel T6
%     f_FZ_x = signal energy from channel FZ
%     f_CZ_x = signal energy from channel CZ
%     f_PZ_x = signal energy from channel PZ
%
%----------------------------------------------------------------------------------------------------------------------------------------------

    % Define experiment parameters
    Fs = 500;
    overlap = 0;
    
%----------------------------------------------------------------------------------------------------------------------------------------------
% Short-Time Fourier Transform (using spectrogram function)
%----------------------------------------------------------------------------------------------------------------------------------------------

    sum_energy = 0;
    channel_energy = [];
    for i=1:size(signal,1)
        [a,~,~] = spectrogram( signal(i,:) , size(signal,2) , overlap , Fs , Fs );
        a=abs(a);
        sum_energy = sum_energy + a;
        channel_energy = [channel_energy , a];
    end
    
%----------------------------------------------------------------------------------------------------------------------------------------------
% Signal energy in frequency bands from all channels.
%----------------------------------------------------------------------------------------------------------------------------------------------

    f1 = sum(sum_energy(2:4,:));
    f2 = sum(sum_energy(5:8,:));
    f3 = sum(sum_energy(9:14,:));
    f4 = sum(sum_energy(15:21,:));
    f5 = sum(sum_energy(22:31,:));
    f6 = sum(sum_energy(32:46,:));
    f7 = sum(sum_energy(56:96,:));
    f8 = sum(sum_energy(106:146,:));

    
%----------------------------------------------------------------------------------------------------------------------------------------------
% Signal energy in frequency bands per channel.
% Only electrodes corresponding to motor-related regions of the brain are selected.
%----------------------------------------------------------------------------------------------------------------------------------------------
    
    % FP1 channel
    f_FP1_1 = sum(channel_energy(2:4,1));
    f_FP1_2 = sum(channel_energy(5:8,1));
    f_FP1_3 = sum(channel_energy(9:14,1));
    f_FP1_4 = sum(channel_energy(15:21,1));
    f_FP1_5 = sum(channel_energy(22:31,1));
    
    % FP1 channel
    f_FP2_1 = sum(channel_energy(2:4,2));
    f_FP2_2 = sum(channel_energy(5:8,2));
    f_FP2_3 = sum(channel_energy(9:14,2));
    f_FP2_4 = sum(channel_energy(15:21,2));
    f_FP2_5 = sum(channel_energy(22:31,2));
    
    % F3 channel
    f_F3_1 = sum(channel_energy(2:4,3));
    f_F3_2 = sum(channel_energy(5:8,3));
    f_F3_3 = sum(channel_energy(9:14,3));
    f_F3_4 = sum(channel_energy(15:21,3));
    f_F3_5 = sum(channel_energy(22:31,3));
    
    % F4 channel
    f_F4_1 = sum(channel_energy(2:4,4));
    f_F4_2 = sum(channel_energy(5:8,4));
    f_F4_3 = sum(channel_energy(9:14,4));
    f_F4_4 = sum(channel_energy(15:21,4));
    f_F4_5 = sum(channel_energy(22:31,4));
    
    % C3 channel
    f_C3_1 = sum(channel_energy(2:4,5));
    f_C3_2 = sum(channel_energy(5:8,5));
    f_C3_3 = sum(channel_energy(9:14,5));
    f_C3_4 = sum(channel_energy(15:21,5));
    f_C3_5 = sum(channel_energy(22:31,5));
    
    % C4 channel
    f_C4_1 = sum(channel_energy(2:4,6));
    f_C4_2 = sum(channel_energy(5:8,6));
    f_C4_3 = sum(channel_energy(9:14,6));
    f_C4_4 = sum(channel_energy(15:21,6));
    f_C4_5 = sum(channel_energy(22:31,6));
    
    % P3 channel
    f_P3_1 = sum(channel_energy(2:4,7));
    f_P3_2 = sum(channel_energy(5:8,7));
    f_P3_3 = sum(channel_energy(9:14,7));
    f_P3_4 = sum(channel_energy(15:21,7));
    f_P3_5 = sum(channel_energy(22:31,7));
    
    % P4 channel
    f_P4_1 = sum(channel_energy(2:4,8));
    f_P4_2 = sum(channel_energy(5:8,8));
    f_P4_3 = sum(channel_energy(9:14,8));
    f_P4_4 = sum(channel_energy(15:21,8));
    f_P4_5 = sum(channel_energy(22:31,8));
    
    % O1 channel
    f_O1_1 = sum(channel_energy(2:4,9));
    f_O1_2 = sum(channel_energy(5:8,9));
    f_O1_3 = sum(channel_energy(9:14,9));
    f_O1_4 = sum(channel_energy(15:21,9));
    f_O1_5 = sum(channel_energy(22:31,9));
    
    % O2 channel
    f_O2_1 = sum(channel_energy(2:4,10));
    f_O2_2 = sum(channel_energy(5:8,10));
    f_O2_3 = sum(channel_energy(9:14,10));
    f_O2_4 = sum(channel_energy(15:21,10));
    f_O2_5 = sum(channel_energy(22:31,10));
    
    % F7 channel
    f_F7_1 = sum(channel_energy(2:4,11));
    f_F7_2 = sum(channel_energy(5:8,11));
    f_F7_3 = sum(channel_energy(9:14,11));
    f_F7_4 = sum(channel_energy(15:21,11));
    f_F7_5 = sum(channel_energy(22:31,11));
    
    % F8 channel
    f_F8_1 = sum(channel_energy(2:4,12));
    f_F8_2 = sum(channel_energy(5:8,12));
    f_F8_3 = sum(channel_energy(9:14,12));
    f_F8_4 = sum(channel_energy(15:21,12));
    f_F8_5 = sum(channel_energy(22:31,12));
    
    % T3 channel
    f_T3_1 = sum(channel_energy(2:4,13));
    f_T3_2 = sum(channel_energy(5:8,13));
    f_T3_3 = sum(channel_energy(9:14,13));
    f_T3_4 = sum(channel_energy(15:21,13));
    f_T3_5 = sum(channel_energy(22:31,13));
    
    % T4 channel
    f_T4_1 = sum(channel_energy(2:4,14));
    f_T4_2 = sum(channel_energy(5:8,14));
    f_T4_3 = sum(channel_energy(9:14,14));
    f_T4_4 = sum(channel_energy(15:21,14));
    f_T4_5 = sum(channel_energy(22:31,14));
    
    % T5 channel
    f_T5_1 = sum(channel_energy(2:4,15));
    f_T5_2 = sum(channel_energy(5:8,15));
    f_T5_3 = sum(channel_energy(9:14,15));
    f_T5_4 = sum(channel_energy(15:21,15));
    f_T5_5 = sum(channel_energy(22:31,15));
    
    % T6 channel
    f_T6_1 = sum(channel_energy(2:4,16));
    f_T6_2 = sum(channel_energy(5:8,16));
    f_T6_3 = sum(channel_energy(9:14,16));
    f_T6_4 = sum(channel_energy(15:21,16));
    f_T6_5 = sum(channel_energy(22:31,16));
    
    % Fz channel
    f_FZ_1 = sum(channel_energy(2:4,17));
    f_FZ_2 = sum(channel_energy(5:8,17));
    f_FZ_3 = sum(channel_energy(9:14,17));
    f_FZ_4 = sum(channel_energy(15:21,17));
    f_FZ_5 = sum(channel_energy(22:31,17));
        
    % Cz channel
    f_CZ_1 = sum(channel_energy(2:4,18));
    f_CZ_2 = sum(channel_energy(5:8,18));
    f_CZ_3 = sum(channel_energy(9:14,18));
    f_CZ_4 = sum(channel_energy(15:21,18));
    f_CZ_5 = sum(channel_energy(22:31,18));
        
    % Pz channel
    f_PZ_1 = sum(channel_energy(2:4,19));
    f_PZ_2 = sum(channel_energy(5:8,19));
    f_PZ_3 = sum(channel_energy(9:14,19));
    f_PZ_4 = sum(channel_energy(15:21,19));
    f_PZ_5 = sum(channel_energy(22:31,19));

%----------------------------------------------------------------------------------------------------------------------------------------------
%   Return feature vector
%----------------------------------------------------------------------------------------------------------------------------------------------
    
    feature_vector = [f1,f2,f3,f4,f5,f6,f7,f8, f_FP1_1,f_FP1_2,f_FP1_3,f_FP1_4,f_FP1_5, ...
          f_FP2_1,f_FP2_2,f_FP2_3,f_FP2_4,f_FP2_5, f_F3_1,f_F3_2,f_F3_3,f_F3_4,f_F3_5, ...
          f_F4_1,f_F4_2,f_F4_3,f_F4_4,f_F4_5, f_C3_1,f_C3_2,f_C3_3,f_C3_4,f_C3_5, ...
          f_C4_1,f_C4_2,f_C4_3,f_C4_4,f_C4_5, f_P3_1,f_P3_2,f_P3_3,f_P3_4,f_P3_5, ...
          f_P4_1,f_P4_2,f_P4_3,f_P4_4,f_P4_5, f_O1_1,f_O1_2,f_O1_3,f_O1_4,f_O1_5, ...
          f_O2_1,f_O2_2,f_O2_3,f_O2_4,f_O2_5, f_F7_1,f_F7_2,f_F7_3,f_F7_4,f_F7_5, ...
          f_F8_1,f_F8_2,f_F8_3,f_F8_4,f_F8_5, f_T3_1,f_T3_2,f_T3_3,f_T3_4,f_T3_5, ...
          f_T4_1,f_T4_2,f_T4_3,f_T4_4,f_T4_5, f_T5_1,f_T5_2,f_T5_3,f_T5_4,f_T5_5, ...
          f_T6_1,f_T6_2,f_T6_3,f_T6_4,f_T6_5, f_FZ_1,f_FZ_2,f_FZ_3,f_FZ_4,f_FZ_5, ...
          f_CZ_1,f_CZ_2,f_CZ_3,f_CZ_4,f_CZ_5, f_PZ_1,f_PZ_2,f_PZ_3,f_PZ_4,f_PZ_5 ];
          
%----------------------------------------------------------------------------------------------------------------------------------------------
      
end