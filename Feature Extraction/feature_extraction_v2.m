%========================================================================
%   PROJECT:   "MENTAL CONTROL" 
%   - Open-source programming. Funded by ELLAK.

%   Algorithms for EEG analysis and features extraction
%   to recognize left and right hand movements for a BCI system.
%
%   The purpose of this project is to provide insights into basic
%   concepts around EEG signal processing using free, open EEG data.

%   Copyright (C) 2015, Kostas Tsiouris

% [feature_vector] = feature_extraction_v2(signal)
% feature_extraction_v1 computes Statistical Moments features.
% INPUTS:
% - signal          : The EEG time series (vector of size c x l).
%                       c = number of channels
%                       l = length of signal
% OUTPUTS
% - feature_vector  : The extracted feature vector (vector of size 1 x 95).

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


function [feature_vector] = feature_extraction_v2(signal)

%----------------------------------------------------------------------------------------------------------------------------------------------
% Features
%----------------------------------------------------------------------------------------------------------------------------------------------
%
%      -- Statistical Moments
%      f1 = mean value(signal) x 19 Channels
%      f2 = standard deviation(signal) x 19 Channels
%      f3 = variance(signal) x 19 Channels
%      f4 = skewness(signal) x 19 Channels
%      f5 = kurtosis(signal) x 19 Channels
%
%----------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------
% Features are extracted per channel.
% No electrodes are omitted.
%----------------------------------------------------------------------------------------------------------------------------------------------
 
    % Calculate Mean Value
    f1=[];
    for i=1:size(signal,1)
        f1 = [f1 , mean(signal(i,:))];
    end
    % f1 = mean[ FP1, FP2, F3, F4, C3, C4, P3, P4, O1, O2, F7, F8, T3, T4, T5, T6, FZ, CZ, PZ ]
    
    
    % Calculate Standard Deviation
    f2=[];
    for i=1:size(signal,1)
        f2 = [f2 , std(signal(i,:))];
    end
    % f2 = std[ FP1, FP2, F3, F4, C3, C4, P3, P4, O1, O2, F7, F8, T3, T4, T5, T6, FZ, CZ, PZ ]
    
    
    % Calculate Variance
    f3=[];
    for i=1:size(signal,1)
        f3 = [f3 , var(signal(i,:))];
    end
    % f3 = var[ FP1, FP2, F3, F4, C3, C4, P3, P4, O1, O2, F7, F8, T3, T4, T5, T6, FZ, CZ, PZ ]
    
    
    % Calculate Skewness
    f4=[];
    for i=1:size(signal,1)
        f4 = [f4 , skewness(signal(i,:))];
    end
    % f4 = skewness[ FP1, FP2, F3, F4, C3, C4, P3, P4, O1, O2, F7, F8, T3, T4, T5, T6, FZ, CZ, PZ ]
    
    
    % Calculate kurtosis
    f5=[];
    for i=1:size(signal,1)
        f5 = [f5 , kurtosis(signal(i,:))];
    end    
    % f5 = kurtosis[ FP1, FP2, F3, F4, C3, C4, P3, P4, O1, O2, F7, F8, T3, T4, T5, T6, FZ, CZ, PZ ]
    
    
%----------------------------------------------------------------------------------------------------------------------------------------------
%   Return feature vector
%----------------------------------------------------------------------------------------------------------------------------------------------
      
    feature_vector = [ f1 , f2 , f3 , f4 , f5 ];
    
%----------------------------------------------------------------------------------------------------------------------------------------------

end