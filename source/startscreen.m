function varargout = startscreen(varargin)
% STARTSCREEN MATLAB code for startscreen.fig
%      STARTSCREEN, by itself, creates a new STARTSCREEN or raises the existing
%      singleton*.
%
%      H = STARTSCREEN returns the handle to a new STARTSCREEN or the handle to
%      the existing singleton*.
%
%      STARTSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTSCREEN.M with the given input arguments.
%
%      STARTSCREEN('Property','Value',...) creates a new STARTSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before startscreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to startscreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help startscreen

% Last Modified by GUIDE v2.5 03-Dec-2012 01:20:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @startscreen_OpeningFcn, ...
                   'gui_OutputFcn',  @startscreen_OutputFcn, ...
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


% --- Executes just before startscreen is made visible.
function startscreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to startscreen (see VARARGIN)

% Choose default command line output for startscreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes startscreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = startscreen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in gui.
function gui_Callback(hObject, eventdata, handles)
% hObject    handle to gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CFModelingGUI

% --- Executes on button press in diff.
function diff_Callback(hObject, eventdata, handles)
% hObject    handle to diff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CFDifferences


% --- Executes on button press in FAQ.
function FAQ_Callback(hObject, eventdata, handles)
% hObject    handle to FAQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('CF Modeling Suite FAQ.pdf');

% --- Executes on button press in usageregulations.
function usageregulations_Callback(hObject, eventdata, handles)
% hObject    handle to usageregulations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('CF Modeling Suite Usage Regulations.pdf');