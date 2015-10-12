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

function varargout = app_gui(varargin)
% APP_GUI MATLAB code for app_gui.fig
% Κώδικας MATLAB για το APP_GUI

% Begin initialization code - DO NOT EDIT
% Έναρξη κώδικα αρχικοποίησης - ΜΗΝ ΕΠΕΞΕΡΓΑΣΤΕΙΤΕ ΤΟ ΑΚΟΛΟΥΘΟ ΚΟΜΜΑΤΙ
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @app_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @app_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% Τέλος κώδικα αρχικοποίησης - ΜΗΝ ΕΠΕΞΕΡΓΑΣΤΕΙΤΕ ΤΟ ΠΑΡΑΠΑΝΩ ΚΟΜΜΑΤΙ


% --- Executes just before app_gui is made visible.
% --- Εκτελείτε ακριβώς πριν την εμφάνιση του παραθύρου του app_gui.
function app_gui_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for app_gui.
% Εξαγωγή προκαθορισμένης εξόδου του app_gui στη γραμμή εντολών.
handles.output = hObject;

% Insert new variable 'p' that defines current targer position. Plot basic figure.
% Εισαγωγή της μεταβλητής 'p' που ορίζει την τρέχουσα θέση του κέρσορα. Σχεδίαση του σχήματος κίνησης.
handles.p=0;
plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')

% Update handles structure.
% Ενημέρωση της μεταβλητής handles.
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = app_gui_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
% Εξαγωγή προκαθορισμένης εξόδου της μεταβλητής 'handles' στη γραμμή εντολών.
varargout{1} = handles.output;


% --- Executes on button press in 'pushbutton1' (left).
% --- Εκτελέσιμος κώδικας κάθε φορά που πατιέται το κουμπί 'pushbutton1'(left).
function pushbutton1_Callback(hObject, eventdata, handles)
    
	%  Choose only the reduced feature vector.
	%  Διατήρηση μόνο των επιλεγμένων χαρακτηριστικών.
	featureNames = {'SE_55_95','SE_105_145','f_F4_4','f_C4_1','f_C4_4','f_P4_1'...
              'f_O2_1','f_F8_1','f_F8_5','f_T3_2','f_CZ_1','f_PZ_1'};
    
	%  Insert the 2 classes values.
	%  Εισαγωγή των τιμών των 2 κλάσσεων.
	featureNames(end+1) = {'class'};

    %  Load test EEG dataset from directory.
    %  Φόρτωση των EEG δεδομένων επαλήθευσης του παραδείγματος.
    testd=load('frequency_results_test.mat');
	
	%  Select the reduced feature set and the classification classes as discribed above.
	%  Επιλογή του μειωμένου σετ χαρακτηριστικών και των κλασεων ταξινόμησης όπως περιγράφεται παραπάνω.
    a=num2cell(testd.frequency_results_test(:,[7,8,27,34,37,44,54,64,68,70,94,99]));
    b=num2cell(testd.frequency_results_test(:,end));
    
	%  Merge and convert to matrix format.
	%  Ένωση και μετατροπή σε μορφή πίνακα.
	data = [a,b];
    a=cell2mat(data);
    
	%  Select a random EEG segment of left hand movement from the test dataset.
	%  Επιλογή ενός τυχαίου EEG τμήματος κίνησης αριστερού χεριού από το σετ δεδομένων επαλήθευσης.
	b=find(a(:,end)==1);
    n = randi(size(b,1));
    n = b(n);
    data = data(n,:);
	
    
    %  Convert to WEKA format.
	%  Μετατροπή σε μορφή αναγνωρίσιμη από το WEKA.
	classindex = size(data,2);
    test =  matlab2weka('test-model',featureNames,data,classindex);
          
    %  SELECT CLASSIFIER, default KStar model (max 1 per run, the remaining must be set as comments).
	%  Επιλογή του επιθυμητού ταξινομητή, προεπιλεγμένο το μοντέλο KStar (μέγιστο ένας κάθε φορά, οι υπόλοιποι μετατρέπονται σε σχόλια).
    classifier=weka.core.SerializationHelper.read('kstar_model.model');
    %classifier=weka.core.SerializationHelper.read('kNN_model.model');
    %classifier=weka.core.SerializationHelper.read('multilayer_perceptron_model.model');
    %classifier=weka.core.SerializationHelper.read('naive_Bayes_model.model');
    %classifier=weka.core.SerializationHelper.read('decision_table_model.model');
    
    % Run classifier to new EEG test data.
	% Εκτέλεση της ταξινόμησης στα νέα EEG δεδομένα επαλήθευσης.
    predicted = wekaClassify(test,classifier);
    predicted = predicted+1;
    
	%  If result equals 1, then segment is classified as left hand movement and target moves left by one (previous-1).
	%  The updated figure is reploted.
	%  Αν το αποτέλεσμα της ταξινόμησης είναι 1, το τμήμα αναγνωρίστηκε ώς κίνηση αριστερού χεριού και ο κέρσορας
	%  μετακινείται προς τα αριστερά κατά μια θέση (προηγούμενη-1). Το ανανεωμένο σχήμα επανασχεδιάζεται.
    if predicted==1
        handles.p=handles.p-1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    
	%  If result equals 2, then segment is classified as right hand movement and target moves right by one (previous+1).
	%  The updated figure is reploted.
	%  Αν το αποτέλεσμα της ταξινόμησης είναι 2, το τμήμα αναγνωρίστηκε ώς κίνηση δεξιού χεριού και ο κέρσορας
	%  μετακινείται προς τα δεξιά κατά μια θέση (προηγούμενη+1). Το ανανεωμένο σχήμα επανασχεδιάζεται.
    elseif predicted==2
        handles.p=handles.p+1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    end

%   Update handles structure.
%   Ενημέρωση της μεταβλητής handles.
    guidata(hObject, handles);



% --- Executes on button press in 'pushbutton2' (right).
% --- Εκτελέσιμος κώδικας κάθε φορά που πατιέται το κουμπί 'pushbutton2'(right).
function pushbutton2_Callback(hObject, eventdata, handles)
    
	%  Choose only the reduced feature vector.
	%  Διατήρηση μόνο των επιλεγμένων χαρακτηριστικών.
	featureNames = {'SE_55_95','SE_105_145','f_F4_4','f_C4_1','f_C4_4','f_P4_1'...
              'f_O2_1','f_F8_1','f_F8_5','f_T3_2','f_CZ_1','f_PZ_1'};
    
	%  Insert the 2 classes values.
	%  Εισαγωγή των τιμών των 2 κλάσσεων.
	featureNames(end+1) = {'class'};

    %  Load test EEG dataset from directory.
    %  Φόρτωση των EEG δεδομένων επαλήθευσης του παραδείγματος.
    testd=load('frequency_results_test.mat');
    
	%  Select the reduced feature set and the classification classes as discribed above.
	%  Επιλογή του μειωμένου σετ χαρακτηριστικών και των κλασεων ταξινόμησης όπως περιγράφεται παραπάνω.
    a=num2cell(testd.frequency_results_test(:,[7,8,27,34,37,44,54,64,68,70,94,99]));
    b=num2cell(testd.frequency_results_test(:,end));
    
	%  Merge and convert to matrix format.
	%  Ένωση και μετατροπή σε μορφή πίνακα.
	data = [a,b];
    a=cell2mat(data);
    
	%  Select a random EEG segment of right hand movement from the test dataset.
	%  Επιλογή ενός τυχαίου EEG τμήματος κίνησης δεξιού χεριού από το σετ δεδομένων επαλήθευσης.
	b=find(a(:,end)==2);
    n = randi(size(b,1));
    n = b(n);
    data = data(n,:);
    
	%  Convert to WEKA format.
	%  Μετατροπή σε μορφή αναγνωρίσιμη από το WEKA.
	classindex = size(data,2);
    test =  matlab2weka('test-model',featureNames,data,classindex);
          
    %  SELECT CLASSIFIER, default KStar model (max 1 per run, the remaining must be set as comments).
	%  Επιλογή του επιθυμητού ταξινομητή, προεπιλεγμένο το μοντέλο KStar (μέγιστο ένας κάθε φορά, οι υπόλοιποι μετατρέπονται σε σχόλια).
    classifier=weka.core.SerializationHelper.read('kstar_model.model');
    %classifier=weka.core.SerializationHelper.read('kNN_model.model');
    %classifier=weka.core.SerializationHelper.read('multilayer_perceptron_model.model');
    %classifier=weka.core.SerializationHelper.read('naive_Bayes_model.model');
    %classifier=weka.core.SerializationHelper.read('decision_table_model.model');
    
    % Run classifier to new EEG test data.
	% Εκτέλεση της ταξινόμησης στα νέα EEG δεδομένα επαλήθευσης.
    predicted = wekaClassify(test,classifier);
    predicted = predicted+1;
    
    %  If result equals 1, then segment is classified as left hand movement and target moves left by one (previous-1).
	%  The updated figure is reploted.
	%  Αν το αποτέλεσμα της ταξινόμησης είναι 1, το τμήμα αναγνωρίστηκε ώς κίνηση αριστερού χεριού και ο κέρσορας
	%  μετακινείται προς τα αριστερά κατά μια θέση (προηγούμενη-1). Το ανανεωμένο σχήμα επανασχεδιάζεται.
    if predicted==1
        handles.p=handles.p-1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    
	%  If result equals 2, then segment is classified as right hand movement and target moves right by one (previous+1).
	%  The updated figure is reploted.
	%  Αν το αποτέλεσμα της ταξινόμησης είναι 2, το τμήμα αναγνωρίστηκε ώς κίνηση δεξιού χεριού και ο κέρσορας
	%  μετακινείται προς τα δεξιά κατά μια θέση (προηγούμενη+1). Το ανανεωμένο σχήμα επανασχεδιάζεται.
    elseif predicted==2
        handles.p=handles.p+1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    end
    
%   Update handles structure.
%   Ενημέρωση της μεταβλητής handles.
   guidata(hObject, handles);
