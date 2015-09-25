%========================================================================
%   PROJECT:   "MENTAL CONTROL" 
%   - Open-source programming. Funded by ELLAK.

%   Algorithms for EEG analysis and features extraction
%   to recognize left and right hand movements for a BCI system.

%   The purpose of this project is to provide insights into basic
%   concepts around EEG signal processing using free, open EEG data.

%   Copyright (C) 2015, Kostas Tsiouris

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


%----------------------------------------------------------------------------------------------------------------------------------------------
% clear workspace
clc
clear

% Load EEG data from directory
    load('Subject1_1D.mat');
    load('Subject1_2D.mat');
    
%   Classes: "left" , "right"
    LeftForward1=LeftForward1';
    LeftForward2=LeftForward2';
    LeftForward3=LeftForward3';
    LeftBackward1=LeftBackward1';
    LeftBackward2=LeftBackward2';
    LeftBackward3=LeftBackward3';
    left=[left,LeftForward1,LeftForward2,LeftForward3,LeftBackward1,LeftBackward2,LeftBackward3];
    
    RightForward1=RightForward1';
    RightForward2=RightForward2';
    RightForward3=RightForward3';
    RightBackward1=RightBackward1';
    RightBackward2=RightBackward2';
    RightBackward3=RightBackward3';
    right=[right,RightForward1,RightForward2,RightForward3,RightBackward1,RightBackward2,RightBackward3];
    
%   Clear unnecessary matrices
clear LeftForward1 LeftForward2 LeftForward3 LeftBackward1 LeftBackward2 LeftBackward3
clear RightForward1 RightForward2 RightForward3 RightBackward1 RightBackward2 RightBackward3
clear LeftBackwardImagined LeftForwardImagined RightBackwardImagined RightForwardImagined
clear LeftLeg RightLeg baseline 

% Define experiment parameters
    window_length = 500;
    left_hand_class_ID = 1;
    right_hand_class_ID = 2;
    
%----------------------------------------------------------------------------------------------------------------------------------------------
% EEG analysis based on various feature extraction techniques.
% See feature_extraction_v(x).m files for more information.
%----------------------------------------------------------------------------------------------------------------------------------------------

    %----------------------------------------------------------------------------------------------------------------------------------------------
    % Frequency domain analysis
    %----------------------------------------------------------------------------------------------------------------------------------------------

    left_hand_features=[];
    for i=0:window_length:size(left,2)-window_length
        left_hand_features = [ left_hand_features ; feature_extraction_v1(left(:,i+1:i+window_length)) , left_hand_class_ID ];
    end

    
    right_hand_features=[];
    for i=0:window_length:size(right,2)-window_length
        right_hand_features = [ right_hand_features ; feature_extraction_v1(right(:,i+1:i+window_length)) , right_hand_class_ID ];
    end
    
    frequency_results_test=[];
    frequency_results_train=[];
    count=0;
    for i=1:size(left_hand_features,1)
        count=count+1;
        if count==3
            frequency_results_test = [ frequency_results_test ; left_hand_features(i,:) ; right_hand_features(i,:) ];
            count=0;
        else
            frequency_results_train = [ frequency_results_train ; left_hand_features(i,:) ; right_hand_features(i,:) ];
        end
    end
    
  
    %----------------------------------------------------------------------------------------------------------------------------------------------
    % Time domain statistical moments
    %----------------------------------------------------------------------------------------------------------------------------------------------

    left_hand_features=[];
    for i=0:window_length:size(left,2)-window_length
        left_hand_features = [ left_hand_features ; feature_extraction_v2(left(:,i+1:i+window_length)) , left_hand_class_ID ];
    end

    
    right_hand_features=[];
    for i=0:window_length:size(right,2)-window_length
        right_hand_features = [ right_hand_features ; feature_extraction_v2(right(:,i+1:i+window_length)) , right_hand_class_ID ];
    end
    
    
    time_statistics_results_test=[];
    time_statistics_results_train=[];
    count=0;
    for i=1:size(left_hand_features,1)
        count=count+1;
        if count==3
            time_statistics_results_test = [ time_statistics_results_test ; left_hand_features(i,:) ; right_hand_features(i,:) ];
            count=0;
        else
            time_statistics_results_train = [ time_statistics_results_train ; left_hand_features(i,:) ; right_hand_features(i,:) ];
        end
    end
    
    %----------------------------------------------------------------------------------------------------------------------------------------------
    % Time domain analysis
    %----------------------------------------------------------------------------------------------------------------------------------------------

    left_hand_features=[];
    for i=0:window_length:size(left,2)-window_length
        left_hand_features = [ left_hand_features ; feature_extraction_v3(left(:,i+1:i+window_length)) , left_hand_class_ID ];
    end

    
    right_hand_features=[];
    for i=0:window_length:size(right,2)-window_length
        right_hand_features = [ right_hand_features ; feature_extraction_v3(right(:,i+1:i+window_length)) , right_hand_class_ID ];
    end
    
    
    time_results_test=[];
    time_results_train=[];
    count=0;
    for i=1:size(left_hand_features,1)
        count=count+1;
        if count==3
            time_results_test = [ time_results_test ; left_hand_features(i,:) ; right_hand_features(i,:) ];
            count=0;
        else
            time_results_train = [ time_results_train ; left_hand_features(i,:) ; right_hand_features(i,:) ];
        end
    end
    
    %   Clear unnecessary matrices
    clear count i window_length left_hand_class_ID right_hand_class_ID left right left_hand_features right_hand_features
    
%----------------------------------------------------------------------------------------------------------------------------------------------


