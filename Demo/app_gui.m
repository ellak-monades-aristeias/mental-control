function varargout = app_gui(varargin)
% APP_GUI MATLAB code for app_gui.fig
%      APP_GUI, by itself, creates a new APP_GUI or raises the existing
%      singleton*.
%
%      H = APP_GUI returns the handle to a new APP_GUI or the handle to
%      the existing singleton*.
%
%      APP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APP_GUI.M with the given input arguments.
%
%      APP_GUI('Property','Value',...) creates a new APP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before app_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to app_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help app_gui

% Last Modified by GUIDE v2.5 05-Oct-2015 15:47:34

% Begin initialization code - DO NOT EDIT
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


% --- Executes just before app_gui is made visible.
function app_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to app_gui (see VARARGIN)

% Choose default command line output for app_gui
handles.output = hObject;

handles.p=0;
plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes app_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = app_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    featureNames = {'SE_55_95','SE_105_145','f_F4_4','f_C4_1','f_C4_4','f_P4_1'...
              'f_O2_1','f_F8_1','f_F8_5','f_T3_2','f_CZ_1','f_PZ_1'};
    featureNames(end+1) = {'class'};

  % From test set 1 (File:Subject1_1D.mat)
    testd=load('frequency_results_test.mat');
    a=num2cell(testd.frequency_results_test(:,[7,8,27,34,37,44,54,64,68,70,94,99]));
    b=num2cell(testd.frequency_results_test(:,end));
    data = [a,b];
    a=cell2mat(data);
    b=find(a(:,end)==1);
    n = randi(size(b,1));
    n = b(n);
    data = data(n,:);
    classindex = size(data,2);
    %Convert to weka format
    test =  matlab2weka('test-model',featureNames,data,classindex);
          
    % SELECT CLASSIFIERS
    classifier=weka.core.SerializationHelper.read('kstar_model.model');
    %classifier=weka.core.SerializationHelper.read('kNN_model.model');
    %classifier=weka.core.SerializationHelper.read('multilayer_perceptron_model.model');
    %classifier=weka.core.SerializationHelper.read('naive_Bayes_model.model');
    %classifier=weka.core.SerializationHelper.read('decision_table_model.model');
    
    % Run classifier to data
    predicted = wekaClassify(test,classifier);
    predicted = predicted+1;
    
    if predicted==1
        handles.p=handles.p-1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    elseif predicted==2
        handles.p=handles.p+1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    end
    
    guidata(hObject, handles);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    featureNames = {'SE_55_95','SE_105_145','f_F4_4','f_C4_1','f_C4_4','f_P4_1'...
              'f_O2_1','f_F8_1','f_F8_5','f_T3_2','f_CZ_1','f_PZ_1'};
    featureNames(end+1) = {'class'};

  % From test set 1 (File:Subject1_1D.mat)
    testd=load('frequency_results_test.mat');
    a=num2cell(testd.frequency_results_test(:,[7,8,27,34,37,44,54,64,68,70,94,99]));
    b=num2cell(testd.frequency_results_test(:,end));
    data = [a,b];
    a=cell2mat(data);
    b=find(a(:,end)==2);
    n = randi(size(b,1));
    n = b(n);
    data = data(n,:);
    classindex = size(data,2);
    %Convert to weka format
    test =  matlab2weka('test-model',featureNames,data,classindex);
          
    % SELECT CLASSIFIERS
    classifier=weka.core.SerializationHelper.read('kstar_model.model');
    %classifier=weka.core.SerializationHelper.read('kNN_model.model');
    %classifier=weka.core.SerializationHelper.read('multilayer_perceptron_model.model');
    %classifier=weka.core.SerializationHelper.read('naive_Bayes_model.model');
    %classifier=weka.core.SerializationHelper.read('decision_table_model.model');
    
    % Run classifier to data
    predicted = wekaClassify(test,classifier);
    predicted = predicted+1;
    
    if predicted==1
        handles.p=handles.p-1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    elseif predicted==2
        handles.p=handles.p+1;
        plot(handles.p,0,'+',0,0,'o',30,0,'o',-30,0,'o',0,30,'o',0,-30,'o')
    end
    
    guidata(hObject, handles);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
