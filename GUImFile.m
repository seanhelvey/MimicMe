function varargout = GUImFile(varargin)

% GUIMFILE M-file for GUImFile.fig
%      GUIMFILE, by itself, creates a new GUIMFILE or raises the existing
%      singleton*.
%
%      H = GUIMFILE returns the handle to a new GUIMFILE or the handle to
%      the existing singleton*.
%
%      GUIMFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMFILE.M with the given input arguments.
%
%      GUIMFILE('Property','Value',...) creates a new GUIMFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUImFile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUImFile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUImFile

%------------------------------------------------------------------------
% ************** LINES 27-82 should not be modified *********************
%------------------------------------------------------------------------

% Last Modified by GUIDE v2.5 15-Dec-2011 21:03:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUImFile_OpeningFcn, ...
                   'gui_OutputFcn',  @GUImFile_OutputFcn, ...
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

% --- Executes just before GUImFile is made visible.
function GUImFile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUImFile (see VARARGIN)

% Choose default command line output for GUImFile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% ************************** IMPORTANT NOTE *******************************
% The handles object / structure is utilized throughtout the code
% It is the interface between the users selections and the 
% implmenetation of those choices.  You will see
%
%

% This sets up the initial plot - only do when we are invisible
% so window can get raised using GUImFile.
if strcmp(get(hObject,'Visible'),'off')
    %plot(rand(5));
end

% UIWAIT makes GUImFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUImFile_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%------------------------------------------------------------------------
%MENU CONTROLS (NOT MODIFIED)
%------------------------------------------------------------------------

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

%------------------------------------------------------------------------
% ******************* Modifications begin here **************************
%------------------------------------------------------------------------

%------------------------------------------------------------------------
%Main button "UPDATE"
%------------------------------------------------------------------------

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

%these global variables are key to the solution
%the sound chosen by the user is stored here
%and played in the "Play" button
global myFs;
global myY;
global myX;

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

popup_sel_sound = get(handles.popupmenu3, 'Value');

switch popup_sel_sound
    case 1
        [x, fs] = wavread('hammerOrig.wav');
        myX=x;
        myFs=fs;

        [y, fs] = wavread('hammerMimic.wav');
        myY=y;
        myFs=fs;
        
    case 2
        [x, fs] = wavread('frogOriginal.wav');
        myX=x;
        myFs=fs;

        [y, fs] = wavread('frogMimic.wav');
        myY=y;
        myFs=fs;        
        
    case 3
        [x, fs] = wavread('kookaburraOriginal.wav');
        myX=x;
        myFs=fs;

        [y, fs] = wavread('kookaburraMimic.wav');
        myY=y;
        myFs=fs;
        
    case 4
        [x, fs] = wavread('ambulanceOriginalA.wav');
        myX=x;
        myFs=fs;

        [y, fs] = wavread('ambulanceMimicA.wav');
        myY=y;
        myFs=fs;  
        
    case 5
        [x, fs] = wavread('ambulanceOriginalB.wav');
        myX=x;
        myFs=fs;

        [y, fs] = wavread('ambulanceMimicB.wav');
        myY=y;
        myFs=fs;          
end    

axes(handles.axes1);
cla;

popup_sel_graph = get(handles.popupmenu1, 'Value');

switch popup_sel_graph
    case 1
        plot(x);
    case 2
        spectrogram(x);
    case 3
        phasez(x);
end

axes(handles.axes4);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');

switch popup_sel_index
    case 1
        plot(y);
    case 2
        spectrogram(y);
    case 3
        phasez(y);
end

%------------------------------------------------------------------------
%Left or original "Play" button
%------------------------------------------------------------------------

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

%the sound selected by the user was stored globally above
global myFs;
global myX;

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

play_button = get(handles.pushbutton5, 'Value');
if play_button == 1
    sound(myX,myFs);
end

%------------------------------------------------------------------------
%Right or Mimicked "Play" button
%------------------------------------------------------------------------

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)

%the sound selected by the user was stored globally above
global myFs;
global myY;

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

play_button = get(handles.pushbutton6, 'Value');
if play_button == 1
    sound(myY,myFs);
end

%------------------------------------------------------------------------
%GRAPH DROPDOWN
%------------------------------------------------------------------------

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end


set(hObject, 'String', {'plot','spectrogram','phasez'});


%------------------------------------------------------------------------
%SOUND DROPDOWN
%------------------------------------------------------------------------

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Hammer','Frog','Kookaburra','AmbulanceA','AmbulanceB'});
