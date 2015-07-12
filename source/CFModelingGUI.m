function varargout = CFModelingGUI(varargin)
% CFMODELINGGUI MATLAB code for CFModelingGUI.fig
%      CFMODELINGGUI, by itself, creates a new CFMODELINGGUI or raises the existing
%      singleton*.
%
%      H = CFMODELINGGUI returns the handle to a new CFMODELINGGUI or the handle to
%      the existing singleton*.
%
%      CFMODELINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CFMODELINGGUI.M with the given input arguments.
%
%      CFMODELINGGUI('Property','Value',...) creates a new CFMODELINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CFModelingGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CFModelingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CFModelingGUI

% Last Modified by GUIDE v2.5 06-Dec-2012 16:25:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CFModelingGUI_OpeningFcn, ...
    'gui_OutputFcn',  @CFModelingGUI_OutputFcn, ...
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


% --- Executes just before CFModelingGUI is made visible.
function CFModelingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CFModelingGUI (see VARARGIN)

global CF
global ABin
global ABout
global MC
global EABin
global EABout
global PV
global AIpin
global AIpout
global AIain
global AIaout

CF=0;
ABin=1;
ABout=1;
MC=1;
EABin=1;
EABout=1;
PV=1;
AIpin=1;
AIpout=1;
AIain=1;
AIaout=1;

handles.current_T=[0];
handles.current_Y=[0,0,0,0,0,0];
set(handles.outputText,'String',{'*************OUTPUT*************'});


% Choose default command line output for CFModelingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CFModelingGUI wait for user response (see UIRESUME )
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CFModelingGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in runsimulation.
function runsimulation_Callback(hObject, eventdata, handles)
% hObject    handle to runsimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ti=str2double(get(handles.initialtime,'String'));
tf=str2double(get(handles.finaltime,'String'));
y1=str2double(get(handles.icM,'String'));
y2=str2double(get(handles.icB,'String'));
y3=str2double(get(handles.icP,'String'));
y4=str2double(get(handles.icA,'String'));
y5=str2double(get(handles.icH,'String'));
y6=str2double(get(handles.icD,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%START CONDITION%%%%%%%%%%%
global CF
global ABin
global ABout
global MC
global EABin
global EABout
global PV
global AIpin
global AIpout
global AIain
global AIaout

ABin=1;
ABout=1;
MC=1;
EABin=1;
EABout=1;
PV=1;
AIpin=1;
AIpout=1;
AIain=1;
AIaout=1;

go=true;

%General Antibiotics
if get(handles.generalantibiotics,'Value')==true %checkbox
    ABM=str2double(get(handles.antibioticsPower,'String')); %Multiplier
    %%%%type of action%%%%
    if  get(handles.antibioticsinoutPopup,'Value')==1 %first option
        %%check conditions
        if ABM >1
            line=sprintf('\nAn antibiotic cannot inhibit more than 100%% of bacteria growth, please change the antibiotic value to a number between 0 and 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%check conditions
        if ABM <0
            line=sprintf('\nAn antibiotic cannot inhibit less than 0%% of bacteria growth, please change the antibiotic value to a number between 0 and 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
        %%set multiplier
        ABin=1-ABM;
    elseif  get(handles.antibioticsinoutPopup,'Value')==2 %second option
        %%check conditions
        if ABM <1
            line=sprintf('\nAn antibiotic cannot cause less bacteria to die, please change the antibiotic value to a number equal to or greater than 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
        ABout=ABM;
    end
    
end

%Mucus Clearers
if get(handles.mucusclearers,'Value')==true %checkbox
    ABM=str2double(get(handles.mucusclearersPower,'String')); %Multiplier
     %%check conditions
        if ABM <1
            line=sprintf('\nA Mucus Clearer cannot cause less mucus to be cleared, please change the Mucus Clearers value to a number equal to or greater than 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
    MC=ABM;
end

%Percusion Vest
if get(handles.percusionvest,'Value')==true %checkbox
    ABM=str2double(get(handles.percusionvestpower,'String')); %Multiplier
    %%check conditions
        if ABM <1
            line=sprintf('\nA method of chest physical therapy cannot cause less mucus to be cleared, please change the Chest Physical Therapy value to a number equal to or greater than 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
    PV=ABM;
    
end

%Anti-Inflamatories
if get(handles.antiinflamatory,'Value')==true %checkbox
    ABM=str2double(get(handles.antiinflamatoryPower,'String')); %Multiplier
    %%%%type of action%%%%
    if  get(handles.antiinflamotoriesinoutPopup,'Value')==1 %first option
                %%check conditions
        if ABM >1
            line=sprintf('\nAn anti-inflamatory cannot inhibit more than 100%% of pro-inflamatory cytokine production, please change the anti-inflamatory value to a number between 0 and 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%check conditions
        if ABM <0
            line=sprintf('\nAn anti-inflamatory cannot inhibit less than 0%% of pro-inflamatory cytokine production, please change the anti-inflamatory value to a number between 0 and 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
        %%set multiplier
        AIpin=1-ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup,'Value')==2 %second option
            %%check conditions
        if ABM <1
            line=sprintf('\nAn anti-inflamatory cannot cause less pro-inflamatory cytokines to break down, please change the anti-inflamatory value to a number equal to or greater than 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
        AIpout=ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup,'Value')==3 %second option
                    %%check conditions
        if ABM <1
            line=sprintf('\nAn anti-inflamatory cannot cause less anti-inflamatory cytokines to be produced, please change the anti-inflamatory value to a number equal to or greater than 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
        AIain=ABM;
        
    elseif  get(handles.antiinflamotoriesinoutPopup,'Value')==4 %second option
                        %%check conditions
        if ABM >1
            line=sprintf('\nAn anti-inflamatory cannot inhibit more than 100%% of anti-inflamatory cytokine breakdown, please change the anti-inflamatory value to a number between 0 and 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%check conditions
        if ABM <0
            line=sprintf('\nAn anti-inflamatory cannot inhibit less than 0%% of anti-inflamatory cytokine breakdown, please change the anti-inflamatory value to a number between 0 and 1');
            oldlines=get(handles.outputText,'String');
            newlines=[oldlines;{line}];
            set(handles.outputText,'String',newlines);
            guidata(hObject,handles);
            lstr=length(get(handles.outputText,'String'));
            if lstr>21
                set(handles.outputText,'ListboxTop',lstr-20);
            end
            go=false;
        end
        %%set multiplier
        %%set multiplier
        AIaout=1-ABM;
    end
    
end




%%%%%%%End Conditions%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if ABout<1
    line=sprintf('\n\n--BEGINING SIMULATION--');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>21
        set(handles.outputText,'ListboxTop',lstr-20);
    end
    go=false;
end

if go==true;
    %prints simulation start
    line=sprintf('\n\n--BEGINING SIMULATION--');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>21
        set(handles.outputText,'ListboxTop',lstr-20);
    end
    pause(.0000000000000000001);
    
    [T,Y]=ode45(@modelBASIC,[ti tf],[y1,y2,y3,y4,y5,y6]);
    
    %prints simulation end
    line=sprintf('--SIMULATION COMPLETE--');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>21
        set(handles.outputText,'ListboxTop',lstr-20);
    end
    pause(.0000000000000000001);
    
    
    handles.current_T=T;
    handles.current_Y=Y;
    
    %prints final time
    line=sprintf('At final time %f',T(end));
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>21
        set(handles.outputText,'ListboxTop',lstr-20);
    end
    pause(.0000000000000000001);
    
    %prints final data values
    Yname={'M','B','P','A','H','D'};
    for x=1:length(Y(end,:))
        line=sprintf('%s is: %f',Yname{x},Y(end,x));
        oldlines=get(handles.outputText,'String');
        newlines=[oldlines;{line}];
        set(handles.outputText,'String',newlines);
        guidata(hObject,handles);
        lstr=length(get(handles.outputText,'String'));
        if lstr>21
            set(handles.outputText,'ListboxTop',lstr-20);
        end
        pause(.0000000000000000001);
    end
end




guidata(hObject,handles);



function graphsavename_Callback(hObject, eventdata, handles)
% hObject    handle to graphsavename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of graphsavename as text
%        str2double(get(hObject,'String')) returns contents of graphsavename as a double


% --- Executes during object creation, after setting all properties.
function graphsavename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graphsavename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in savegraphButton.
function savegraphButton_Callback(hObject, eventdata, handles)
% hObject    handle to savegraphButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=get(handles.graphsavename,'String');
m=get(handles.mgraph,'Value');
b=get(handles.bgraph,'Value');
p=get(handles.pgraph,'Value');
a=get(handles.agraph,'Value');
h=get(handles.hgraph,'Value');
d=get(handles.dgraph,'Value');
T=handles.current_T;
Y=handles.current_Y;
printGraph(T,Y,m,b,p,a,h,d,name);

% --- Executes on button press in mgraph.
function mgraph_Callback(hObject, eventdata, handles)
% hObject    handle to mgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mgraph


% --- Executes on button press in bgraph.
function bgraph_Callback(hObject, eventdata, handles)
% hObject    handle to bgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bgraph


% --- Executes on button press in pgraph.
function pgraph_Callback(hObject, eventdata, handles)
% hObject    handle to pgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pgraph


% --- Executes on button press in agraph.
function agraph_Callback(hObject, eventdata, handles)
% hObject    handle to agraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of agraph


% --- Executes on button press in hgraph.
function hgraph_Callback(hObject, eventdata, handles)
% hObject    handle to hgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hgraph


% --- Executes on button press in dgraph.
function dgraph_Callback(hObject, eventdata, handles)
% hObject    handle to dgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dgraph


% --- Executes on button press in graphButton.
function graphButton_Callback(hObject, eventdata, handles)
% hObject    handle to graphButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=handles.current_T;
Y=handles.current_Y;

leg=[];

if get(handles.mgraph,'Value')==true
    plot(T,Y(:,1),'m');
    leg=[leg,{'M'}];
    hold on
end
if get(handles.bgraph,'Value')==true
    plot(T,Y(:,2),'b');
    leg=[leg,{'B'}];
    hold on
end
if get(handles.pgraph,'Value')==true
    plot(T,Y(:,3),'k');
    leg=[leg,{'P'}];
    hold on
end
if get(handles.agraph,'Value')==true
    plot(T,Y(:,4),'Color',[.5977,.7969,0]);
    leg=[leg,{'A'}];
    hold on
end
if get(handles.hgraph,'Value')==true
    plot(T,Y(:,5),'g');
    leg=[leg,{'H'}];
    hold on
end
if get(handles.dgraph,'Value')==true
    plot(T,Y(:,6),'r');
    leg=[leg,{'D'}];
    hold on
end

legend(leg);

hold off


function datafilename_Callback(hObject, eventdata, handles)
% hObject    handle to datafilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datafilename as text
%        str2double(get(hObject,'String')) returns contents of datafilename as a double


% --- Executes during object creation, after setting all properties.
function datafilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datafilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in savedatabutton.
function savedatabutton_Callback(hObject, eventdata, handles)
% hObject    handle to savedatabutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=handles.current_T;
Y=handles.current_Y;
name=get(handles.datafilename,'String');
dlmwrite(name,[T,Y],'precision',20);



% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in randombacterialinfection.
function randombacterialinfection_Callback(hObject, eventdata, handles)
% hObject    handle to randombacterialinfection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of randombacterialinfection


% --- Executes on button press in generalantibiotics.
function generalantibiotics_Callback(hObject, eventdata, handles)
% hObject    handle to generalantibiotics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of generalantibiotics


% --- Executes on button press in mucusclearers.
function mucusclearers_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mucusclearers


% --- Executes on button press in emergencyantibiotics.
function emergencyantibiotics_Callback(hObject, eventdata, handles)
% hObject    handle to emergencyantibiotics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of emergencyantibiotics


% --- Executes on button press in percusionvest.
function percusionvest_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of percusionvest


% --- Executes on button press in potentiatorcorrector.
function potentiatorcorrector_Callback(hObject, eventdata, handles)
% hObject    handle to potentiatorcorrector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of potentiatorcorrector


% --- Executes on button press in antiinflamatory.
function antiinflamatory_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of antiinflamatory


% --- Executes on button press in oxygentherapy.
function oxygentherapy_Callback(hObject, eventdata, handles)
% hObject    handle to oxygentherapy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of oxygentherapy



function initialtime_Callback(hObject, eventdata, handles)
% hObject    handle to initialtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of initialtime as text
%        str2double(get(hObject,'String')) returns contents of initialtime as a double


% --- Executes during object creation, after setting all properties.
function initialtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function finaltime_Callback(hObject, eventdata, handles)
% hObject    handle to finaltime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of finaltime as text
%        str2double(get(hObject,'String')) returns contents of finaltime as a double


% --- Executes during object creation, after setting all properties.
function finaltime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to finaltime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function icM_Callback(hObject, eventdata, handles)
% hObject    handle to icM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icM as text
%        str2double(get(hObject,'String')) returns contents of icM as a double


% --- Executes during object creation, after setting all properties.
function icM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function icB_Callback(hObject, eventdata, handles)
% hObject    handle to icB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icB as text
%        str2double(get(hObject,'String')) returns contents of icB as a double


% --- Executes during object creation, after setting all properties.
function icB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function icP_Callback(hObject, eventdata, handles)
% hObject    handle to icP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icP as text
%        str2double(get(hObject,'String')) returns contents of icP as a double


% --- Executes during object creation, after setting all properties.
function icP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function icA_Callback(hObject, eventdata, handles)
% hObject    handle to icA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icA as text
%        str2double(get(hObject,'String')) returns contents of icA as a double


% --- Executes during object creation, after setting all properties.
function icA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function icH_Callback(hObject, eventdata, handles)
% hObject    handle to icH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icH as text
%        str2double(get(hObject,'String')) returns contents of icH as a double


% --- Executes during object creation, after setting all properties.
function icH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function icD_Callback(hObject, eventdata, handles)
% hObject    handle to icD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of icD as text
%        str2double(get(hObject,'String')) returns contents of icD as a double


% --- Executes during object creation, after setting all properties.
function icD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to icD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CFyes.
function CFyes_Callback(hObject, eventdata, handles)
% hObject    handle to CFyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CF
CF=1;
% Hint: get(hObject,'Value') returns toggle state of CFyes


% --- Executes on button press in CFno.
function CFno_Callback(hObject, eventdata, handles)
% hObject    handle to CFno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CF
CF=0;
% Hint: get(hObject,'Value') returns toggle state of CFno


% --- Executes on slider movement.
function outputSlider_Callback(hObject, eventdata, handles)
% hObject    handle to outputSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function outputSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function outputText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in antibioticsPopup.
function antibioticsPopup_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antibioticsPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antibioticsPopup
if  get(hObject,'Value')==2 %TOBI
    set(handles.antibioticsPower,'String',.49);
    set(handles.antibioticsinoutPopup,'Value',1);
end

% --- Executes during object creation, after setting all properties.
function antibioticsPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mucusclearersPopup.
function mucusclearersPopup_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearersPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mucusclearersPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mucusclearersPopup

if  get(hObject,'Value')==2 %TOBI
    set(handles.mucusclearersPower,'String',1.71);
end

% --- Executes during object creation, after setting all properties.
function mucusclearersPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mucusclearersPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in eantibioticsPopup.
function eantibioticsPopup_Callback(hObject, eventdata, handles)
% hObject    handle to eantibioticsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns eantibioticsPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from eantibioticsPopup


% --- Executes during object creation, after setting all properties.
function eantibioticsPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eantibioticsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in percusionvestPopup.
function percusionvestPopup_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvestPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns percusionvestPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from percusionvestPopup
if  get(hObject,'Value')==2 %TOBI
    set(handles.percusionvestpower,'String',1.5);
end

% --- Executes during object creation, after setting all properties.
function percusionvestPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percusionvestPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antiinflamatoriesPopup.
function antiinflamatoriesPopup_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatoriesPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antiinflamatoriesPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antiinflamatoriesPopup
if  get(hObject,'Value')==2
    set(handles.antiinflamatoryPower,'String',.62);
    set(handles.antiinflamotoriesinoutPopup,'Value',1);
end

% --- Executes during object creation, after setting all properties.
function antiinflamatoriesPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamatoriesPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function antibioticsPower_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antibioticsPower as text
%        str2double(get(hObject,'String')) returns contents of antibioticsPower as a double

set(handles.antibioticsPopup,'Value',1);


% --- Executes during object creation, after setting all properties.
function antibioticsPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mucusclearersPower_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearersPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mucusclearersPower as text
%        str2double(get(hObject,'String')) returns contents of mucusclearersPower as a double
set(handles.mucusclearersPopup,'Value',1);

% --- Executes during object creation, after setting all properties.
function mucusclearersPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mucusclearersPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eantibioticsPower_Callback(hObject, eventdata, handles)
% hObject    handle to eantibioticsPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eantibioticsPower as text
%        str2double(get(hObject,'String')) returns contents of eantibioticsPower as a double


% --- Executes during object creation, after setting all properties.
function eantibioticsPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eantibioticsPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function percusionvestpower_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvestpower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percusionvestpower as text
%        str2double(get(hObject,'String')) returns contents of percusionvestpower as a double
set(handles.percusionvestPopup,'Value',1);


% --- Executes during object creation, after setting all properties.
function percusionvestpower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percusionvestpower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function antiinflamatoryPower_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatoryPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antiinflamatoryPower as text
%        str2double(get(hObject,'String')) returns contents of antiinflamatoryPower as a double
set(handles.antiinflamatoriesPopup,'Value',1);


% --- Executes during object creation, after setting all properties.
function antiinflamatoryPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamatoryPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in outputText.
function outputText_Callback(hObject, eventdata, handles)
% hObject    handle to outputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns outputText contents as cell array
%        contents{get(hObject,'Value')} returns selected item from outputText


% --- Executes on selection change in antibioticsinoutPopup.
function antibioticsinoutPopup_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsinoutPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antibioticsinoutPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antibioticsinoutPopup

set(handles.antibioticsPopup,'Value',1);

% --- Executes during object creation, after setting all properties.
function antibioticsinoutPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsinoutPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antiinflamotoriesinoutPopup.
function antiinflamotoriesinoutPopup_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamotoriesinoutPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antiinflamotoriesinoutPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antiinflamotoriesinoutPopup
set(handles.antiinflamatoriesPopup,'Value',1);


% --- Executes during object creation, after setting all properties.
function antiinflamotoriesinoutPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamotoriesinoutPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resetinitialconditions.
function resetinitialconditions_Callback(hObject, eventdata, handles)
% hObject    handle to resetinitialconditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.icM,'String','1.4');
set(handles.icB,'String','4.5');
set(handles.icP,'String','2');
set(handles.icA,'String','2');
set(handles.icH,'String','1500');
set(handles.icD,'String','6');
guidata(hObject,handles);
pause(.000000000000000000000000000000001);



function datatime_Callback(hObject, eventdata, handles)
% hObject    handle to datatime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datatime as text
%        str2double(get(hObject,'String')) returns contents of datatime as a double


% --- Executes during object creation, after setting all properties.
function datatime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datatime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in viewdata.
function viewdata_Callback(hObject, eventdata, handles)
% hObject    handle to viewdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
if str2double(get(handles.datatime,'String'))<handles.current_T(1)
     line=sprintf('the time value entered is out of the time range of the simulation');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>21
        set(handles.outputText,'ListboxTop',lstr-20);
    end   
elseif str2double(get(handles.datatime,'String'))>handles.current_T(end)
         line=sprintf('the time value entered is out of the time range of the simulation');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>21
        set(handles.outputText,'ListboxTop',lstr-20);
    end  
else

dat=interp1(handles.current_T,handles.current_Y,str2double(get(handles.datatime,'String')));

     line=sprintf('At time %f',str2double(get(handles.datatime,'String')));
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>21
        set(handles.outputText,'ListboxTop',lstr-20);
    end   
    
        Yname={'M','B','P','A','H','D'};
    for x=1:length(dat(end,:))
        line=sprintf('%s is: %f',Yname{x},dat(end,x));
        oldlines=get(handles.outputText,'String');
        newlines=[oldlines;{line}];
        set(handles.outputText,'String',newlines);
        guidata(hObject,handles);
        lstr=length(get(handles.outputText,'String'));
        if lstr>21
            set(handles.outputText,'ListboxTop',lstr-20);
        end
    end
end
    
    
    guidata(hObject,handles);
