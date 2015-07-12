function varargout = CFDifferences(varargin)
% CFDIFFERENCES MATLAB code for CFDifferences.fig
%      CFDIFFERENCES, by itself, creates a new CFDIFFERENCES or raises the existing
%      singleton*.
%
%      H = CFDIFFERENCES returns the handle to a new CFDIFFERENCES or the handle to
%      the existing singleton*.
%
%      CFDIFFERENCES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CFDIFFERENCES.M with the given input arguments.
%
%      CFDIFFERENCES('Property','Value',...) creates a new CFDIFFERENCES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CFDifferences_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CFDifferences_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CFDifferences

% Last Modified by GUIDE v2.5 02-Dec-2012 21:16:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CFDifferences_OpeningFcn, ...
    'gui_OutputFcn',  @CFDifferences_OutputFcn, ...
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


% --- Executes just before CFDifferences is made visible.
function CFDifferences_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CFDifferences (see VARARGIN)


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

handles.current_T1=[0];
handles.current_Y1=[0,0,0,0,0,0];
handles.current_T2=[0];
handles.current_Y2=[0,0,0,0,0,0];
set(handles.outputText,'String',{'*************OUTPUT*************'});



% Choose default command line output for CFDifferences
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CFDifferences wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CFDifferences_OutputFcn(hObject, eventdata, handles)
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
%%%%%%%START CONDITION 1%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%CONDITIONS%%%%%%%%%%%%%%%%%%%%%%%%%
%General Antibiotics
if get(handles.generalantibiotics1,'Value')==true %checkbox
    ABM=str2double(get(handles.antibioticsPower1,'String')); %Multiplier
    %%%%type of action%%%%
    if  get(handles.antibioticsinoutPopup1,'Value')==1 %first option
        if ABM >1
            printout(sprintf('\nAn antibiotic cannot inhibit more than 100%% of bacteria growth, please change the antibiotic value in Situation 1 to a number between 0 and 1'),handles);
            go=false;
        end
        if ABM <0
            printout(sprintf('\nAn antibiotic cannot inhibit less than 0%% of bacteria growth, please change the antibiotic value in Situation 1 to a number between 0 and 1'),handles);
            go=false;
        end
        %%check conditions
        ABin=1-ABM;
    elseif  get(handles.antibioticsinoutPopup1,'Value')==2 %second option
        if ABM <1
            printout(sprintf('\nAn antibiotic cannot cause less bacteria to die, please change the antibiotic value in Situation 1 to a number equal to or greater than 1'),handles);
            go=false;
        end
        ABout=ABM;
    end
    
end

%Mucus Clearers
if get(handles.mucusclearers1,'Value')==true %checkbox
    ABM=str2double(get(handles.mucusclearersPower1,'String')); %Multiplier
    if ABM <1
        printout(sprintf('\nA Mucus Clearer cannot cause less mucus to be cleared, please change the Mucus Clearers value in Situation 1 to a number equal to or greater than 1'),handles);
        go=false;
    end
    MC=ABM;
    
end

%Percusion Vest
if get(handles.percusionvest1,'Value')==true %checkbox
    ABM=str2double(get(handles.percusionvestpower1,'String')); %Multiplier
    if ABM <1
        printout(sprintf('\nA method of chest physical therapy cannot cause less mucus to be cleared, please change the Chest Physical Therapy value in Situation 1 to a number equal to or greater than 1'),handles);
        go=false;
    end
    PV=ABM;
    
end

%Anti-Inflamatories
if get(handles.antiinflamatory1,'Value')==true %checkbox
    ABM=str2double(get(handles.antiinflamatoryPower1,'String')); %Multiplier
    %%%%type of action%%%%
    if  get(handles.antiinflamotoriesinoutPopup1,'Value')==1 %first option
        if ABM >1
            printout(sprintf('\nAn anti-inflamatory cannot inhibit more than 100%% of pro-inflamatory cytokine production, please change the anti-inflamatory value in Situation 1 to a number between 0 and 1'),handles);
            go=false;
        end
        if ABM <0
            printout(sprintf('\nAn anti-inflamatory cannot inhibit less than 0%% of pro-inflamatory cytokine production, please change the anti-inflamatory value in Situation 1 to a number between 0 and 1'),handles);
            go=false;
        end
        AIpin=1-ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup1,'Value')==2 %second option
        if ABM <1
            printout(sprintf('\nAn anti-inflamatory cannot cause less pro-inflamatory cytokines to break down, please change the anti-inflamatory value in Situation 1 to a number equal to or greater than 1'),handles);
            go=false;
        end
        AIpout=ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup1,'Value')==3 %second option
        if ABM <1
            printout(sprintf('\nAn anti-inflamatory cannot cause less anti-inflamatory cytokines to be produced, please change the anti-inflamatory value in Situation 1 to a number equal to or greater than 1'),handles);
            go=false;
        end
        AIain=ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup1,'Value')==4 %second option
        if ABM >1
            printout(sprintf('\nAn anti-inflamatory cannot inhibit more than 100%% of anti-inflamatory cytokine breakdown, please change the anti-inflamatory value in Situation 1 to a number between 0 and 1'),handles);
            go=false;
        end
        if ABM <0
            printout(sprintf('\nAn anti-inflamatory cannot inhibit less than 0%% of anti-inflamatory cytokine breakdown, please change the anti-inflamatory value in Situation 1 to a number between 0 and 1'),handles);
            go=false;
        end
        
        AIaout=1-ABM;
    end
    
end

%CF
if get(handles.CFyes1,'Value')==true
    CF=1;
elseif get(handles.CFyes1,'Value')==false
    CF=0;
end




%General Antibiotics
if get(handles.generalantibiotics2,'Value')==true %checkbox
    ABM=str2double(get(handles.antibioticsPower2,'String')); %Multiplier
    %%%%type of action%%%%
    if  get(handles.antibioticsinoutPopup2,'Value')==1 %first option
         if ABM >1
            printout(sprintf('\nAn antibiotic cannot inhibit more than 100%% of bacteria growth, please change the antibiotic value in Situation 2 to a number between 0 and 1'),handles);
            go=false;
        end
        if ABM <0
            printout(sprintf('\nAn antibiotic cannot inhibit less than 0%% of bacteria growth, please change the antibiotic value in Situation 2 to a number between 0 and 1'),handles);
            go=false;
        end       
        
        ABin=1-ABM;
        
    elseif  get(handles.antibioticsinoutPopup2,'Value')==2 %second option
            if ABM <1
            printout(sprintf('\nAn antibiotic cannot cause less bacteria to die, please change the antibiotic value in Situation 2 to a number equal to or greater than 1'),handles);
            go=false;
        end
        ABout=ABM;
    end
    
end

%Mucus Clearers
if get(handles.mucusclearers2,'Value')==true %checkbox
    ABM=str2double(get(handles.mucusclearersPower2,'String')); %Multiplier
        if ABM <1
        printout(sprintf('\nA Mucus Clearer cannot cause less mucus to be cleared, please change the Mucus Clearers value in Situation 2 to a number equal to or greater than 1'),handles);
        go=false;
    end
    MC=ABM;
    
end

%Percusion Vest
if get(handles.percusionvest2,'Value')==true %checkbox
    ABM=str2double(get(handles.percusionvestpower1,'String')); %Multiplier
        if ABM <1
        printout(sprintf('\nA method of chest physical therapy cannot cause less mucus to be cleared, please change the Chest Physical Therapy value in Situation 2 to a number equal to or greater than 1'),handles);
        go=false;
    end
    PV=ABM;
    
end

%Anti-Inflamatories
if get(handles.antiinflamatory2,'Value')==true %checkbox
    ABM=str2double(get(handles.antiinflamatoryPower2,'String')); %Multiplier
    %%%%type of action%%%%
    if  get(handles.antiinflamotoriesinoutPopup2,'Value')==1 %first option
               if ABM >1
            printout(sprintf('\nAn anti-inflamatory cannot inhibit more than 100%% of pro-inflamatory cytokine production, please change the anti-inflamatory value in Situation 2 to a number between 0 and 1'),handles);
            go=false;
        end
        if ABM <0
            printout(sprintf('\nAn anti-inflamatory cannot inhibit less than 0%% of pro-inflamatory cytokine production, please change the anti-inflamatory value in Situation 2 to a number between 0 and 1'),handles);
            go=false;
        end
        AIpin=1-ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup2,'Value')==2 %second option
               if ABM <1
            printout(sprintf('\nAn anti-inflamatory cannot cause less pro-inflamatory cytokines to break down, please change the anti-inflamatory value in Situation 2 to a number equal to or greater than 1'),handles);
            go=false;
        end
        AIpout=ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup2,'Value')==3 %second option
               if ABM <1
            printout(sprintf('\nAn anti-inflamatory cannot cause less anti-inflamatory cytokines to be produced, please change the anti-inflamatory value in Situation 2 to a number equal to or greater than 1'),handles);
            go=false;
        end
        AIain=ABM;
    elseif  get(handles.antiinflamotoriesinoutPopup2,'Value')==4 %second option
                if ABM >1
            printout(sprintf('\nAn anti-inflamatory cannot inhibit more than 100%% of anti-inflamatory cytokine breakdown, please change the anti-inflamatory value in Situation 2 to a number between 0 and 1'),handles);
            go=false;
        end
        if ABM <0
            printout(sprintf('\nAn anti-inflamatory cannot inhibit less than 0%% of anti-inflamatory cytokine breakdown, please change the anti-inflamatory value in Situation 2 to a number between 0 and 1'),handles);
            go=false;
        end
        AIaout=1-ABM;
    end
    
end

%CF
if get(handles.CFyes2,'Value')==true
    CF=1;
elseif get(handles.CFyes2,'Value')==false
    CF=0;
end

%%%%%%%%%%%%%%%%%%%%%CONDITIONS END%%%%%%%%%%%%%%%%%%%%%
if go==true
    
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

    %General Antibiotics
    if get(handles.generalantibiotics1,'Value')==true %checkbox
        ABM=str2double(get(handles.antibioticsPower1,'String')); %Multiplier
        %%%%type of action%%%%
        if  get(handles.antibioticsinoutPopup1,'Value')==1 %first option
            %%check conditions
            ABin=1-ABM;
        elseif  get(handles.antibioticsinoutPopup1,'Value')==2 %second option
            ABout=ABM;
        end
        
    end
    
    %Mucus Clearers
    if get(handles.mucusclearers1,'Value')==true %checkbox
        ABM=str2double(get(handles.mucusclearersPower1,'String')); %Multiplier
        MC=ABM;
        
    end
    
    %Percusion Vest
    if get(handles.percusionvest1,'Value')==true %checkbox
        ABM=str2double(get(handles.percusionvestpower1,'String')); %Multiplier
        PV=ABM;
        
    end
    
    %Anti-Inflamatories
    if get(handles.antiinflamatory1,'Value')==true %checkbox
        ABM=str2double(get(handles.antiinflamatoryPower1,'String')); %Multiplier
        %%%%type of action%%%%
        if  get(handles.antiinflamotoriesinoutPopup1,'Value')==1 %first option
            AIpin=1-ABM;
        elseif  get(handles.antiinflamotoriesinoutPopup1,'Value')==2 %second option
            AIpout=ABM;
        elseif  get(handles.antiinflamotoriesinoutPopup1,'Value')==3 %second option
            AIain=ABM;
        elseif  get(handles.antiinflamotoriesinoutPopup1,'Value')==4 %second option
            AIaout=1-ABM;
        end
        
    end
    
    %CF
    if get(handles.CFyes1,'Value')==true
        CF=1;
    elseif get(handles.CFyes1,'Value')==false
        CF=0;
    end
    
    
    
    
    %%%%%%%End Conditions%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    
    %prints simulation start
    line=sprintf('\n\n--BEGINING SIMULATION 1--');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>18
        set(handles.outputText,'ListboxTop',lstr-17);
    end
    pause(.0000000000000000001);
    
    [T,Y]=ode45(@modelBASIC,[ti tf],[y1,y2,y3,y4,y5,y6]);
    
    %prints simulation end
    line=sprintf('--SIMULATION 1 COMPLETE--');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>18
        set(handles.outputText,'ListboxTop',lstr-17);
    end
    pause(.0000000000000000001);
    
    
    handles.current_T1=T;
    handles.current_Y1=Y;
    
    %prints final time
    line=sprintf('At final time %f',T(end));
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>18
        set(handles.outputText,'ListboxTop',lstr-17);
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
        if lstr>18
            set(handles.outputText,'ListboxTop',lstr-17);
        end
        pause(.0000000000000000001);
    end
    
    
    
    
    guidata(hObject,handles);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%START CONDITION 2%%%%%%%%%%%
    
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
    %General Antibiotics
    if get(handles.generalantibiotics2,'Value')==true %checkbox
        ABM=str2double(get(handles.antibioticsPower2,'String')); %Multiplier
        %%%%type of action%%%%
        if  get(handles.antibioticsinoutPopup2,'Value')==1 %first option
            ABin=1-ABM;
        elseif  get(handles.antibioticsinoutPopup2,'Value')==2 %second option
            ABout=ABM;
        end
        
    end
    
    %Mucus Clearers
    if get(handles.mucusclearers2,'Value')==true %checkbox
        ABM=str2double(get(handles.mucusclearersPower2,'String')); %Multiplier
        MC=ABM;
        
    end
    
    %Percusion Vest
    if get(handles.percusionvest2,'Value')==true %checkbox
        ABM=str2double(get(handles.percusionvestpower1,'String')); %Multiplier
        PV=ABM;
        
    end
    
    %Anti-Inflamatories
    if get(handles.antiinflamatory2,'Value')==true %checkbox
        ABM=str2double(get(handles.antiinflamatoryPower2,'String')); %Multiplier
        %%%%type of action%%%%
        if  get(handles.antiinflamotoriesinoutPopup2,'Value')==1 %first option
            AIpin=1-ABM;
        elseif  get(handles.antiinflamotoriesinoutPopup2,'Value')==2 %second option
            AIpout=ABM;
        elseif  get(handles.antiinflamotoriesinoutPopup2,'Value')==3 %second option
            AIain=ABM;
        elseif  get(handles.antiinflamotoriesinoutPopup2,'Value')==4 %second option
            AIaout=1-ABM;
        end
        
    end
    
    %CF
    if get(handles.CFyes2,'Value')==true
        CF=1;
    elseif get(handles.CFyes2,'Value')==false
        CF=0;
    end
    
    
    
    %%%%%%%End Conditions%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %prints simulation start
    line=sprintf('\n\n--BEGINING SIMULATION 2--');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>18
        set(handles.outputText,'ListboxTop',lstr-17);
    end
    pause(.0000000000000000001);
    
    [T,Y]=ode45(@modelBASIC,[ti tf],[y1,y2,y3,y4,y5,y6]);
    
    %prints simulation end
    line=sprintf('--SIMULATION 2 COMPLETE--');
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>18
        set(handles.outputText,'ListboxTop',lstr-17);
    end
    pause(.0000000000000000001);
    
    
    handles.current_T2=T;
    handles.current_Y2=Y;
    
    %prints final time
    line=sprintf('At final time %f',T(end));
    oldlines=get(handles.outputText,'String');
    newlines=[oldlines;{line}];
    set(handles.outputText,'String',newlines);
    guidata(hObject,handles);
    lstr=length(get(handles.outputText,'String'));
    if lstr>18
        set(handles.outputText,'ListboxTop',lstr-17);
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
        if lstr>18
            set(handles.outputText,'ListboxTop',lstr-17);
        end
        pause(.0000000000000000001);
    end
    
    
    
    
    guidata(hObject,handles);
    
    handles.current_xprint=[ti:tf]';
    handles.current_y1print=interp1(handles.current_T1,handles.current_Y1,handles.current_xprint);
    handles.current_y2print=interp1(handles.current_T2,handles.current_Y2,handles.current_xprint);
    
%     handles.current_y1print=handles.current_y1print;
%     handles.current_y2print=handles.current_y2print;
    handles.current_diffprint=handles.current_y2print-handles.current_y1print;
end
guidata(hObject,handles);







% --- Executes on selection change in outputText.
function outputText_Callback(hObject, eventdata, handles)
% hObject    handle to outputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns outputText contents as cell array
%        contents{get(hObject,'Value')} returns selected item from outputText


% --- Executes during object creation, after setting all properties.
function outputText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generalantibiotics2.
function generalantibiotics2_Callback(hObject, eventdata, handles)
% hObject    handle to generalantibiotics2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of generalantibiotics2


% --- Executes on button press in mucusclearers2.
function mucusclearers2_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearers2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mucusclearers2


% --- Executes on button press in percusionvest2.
function percusionvest2_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvest2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of percusionvest2


% --- Executes on button press in antiinflamatory2.
function antiinflamatory2_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatory2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of antiinflamatory2


% --- Executes on selection change in antibioticsPopup2.
function antibioticsPopup2_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antibioticsPopup2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antibioticsPopup2
if  get(hObject,'Value')==2 %TOBI
    set(handles.antibioticsPower2,'String',.49);
    set(handles.antibioticsinoutPopup2,'Value',1);
end

% --- Executes during object creation, after setting all properties.
function antibioticsPopup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mucusclearersPopup2.
function mucusclearersPopup2_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearersPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mucusclearersPopup2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mucusclearersPopup2
if  get(hObject,'Value')==2
    set(handles.mucusclearersPower2,'String',1.71);
end

% --- Executes during object creation, after setting all properties.
function mucusclearersPopup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mucusclearersPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in percusionvestPopup2.
function percusionvestPopup2_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvestPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns percusionvestPopup2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from percusionvestPopup2

if  get(hObject,'Value')==2 %TOBI
    set(handles.percusionvestpower2,'String',1.5);
end

% --- Executes during object creation, after setting all properties.
function percusionvestPopup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percusionvestPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antiinflamatoriesPopup2.
function antiinflamatoriesPopup2_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatoriesPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antiinflamatoriesPopup2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antiinflamatoriesPopup2

if  get(hObject,'Value')==2
    set(handles.antiinflamatoryPower2,'String',.62);
    set(handles.antiinflamotoriesinoutPopup2,'Value',1);
end

% --- Executes during object creation, after setting all properties.
function antiinflamatoriesPopup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamatoriesPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function antibioticsPower2_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsPower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antibioticsPower2 as text
%        str2double(get(hObject,'String')) returns contents of antibioticsPower2 as a double
set(handles.antibioticsPopup2,'Value',1);


% --- Executes during object creation, after setting all properties.
function antibioticsPower2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsPower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mucusclearersPower2_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearersPower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mucusclearersPower2 as text
%        str2double(get(hObject,'String')) returns contents of mucusclearersPower2 as a double
set(handles.mucusclearersPopup2,'Value',1);


% --- Executes during object creation, after setting all properties.
function mucusclearersPower2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mucusclearersPower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function percusionvestpower2_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvestpower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percusionvestpower2 as text
%        str2double(get(hObject,'String')) returns contents of percusionvestpower2 as a double
set(handles.percusionvestPopup2,'Value',1);


% --- Executes during object creation, after setting all properties.
function percusionvestpower2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percusionvestpower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function antiinflamatoryPower2_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatoryPower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antiinflamatoryPower2 as text
%        str2double(get(hObject,'String')) returns contents of antiinflamatoryPower2 as a double
set(handles.antiinflamatoriesPopup2,'Value',1);


% --- Executes during object creation, after setting all properties.
function antiinflamatoryPower2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamatoryPower2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antibioticsinoutPopup2.
function antibioticsinoutPopup2_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsinoutPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antibioticsinoutPopup2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antibioticsinoutPopup2
set(handles.antibioticsPopup2,'Value',1);


% --- Executes during object creation, after setting all properties.
function antibioticsinoutPopup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsinoutPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antiinflamotoriesinoutPopup2.
function antiinflamotoriesinoutPopup2_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamotoriesinoutPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antiinflamotoriesinoutPopup2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antiinflamotoriesinoutPopup2
set(handles.antiinflamatoriesPopup2,'Value',1);


% --- Executes during object creation, after setting all properties.
function antiinflamotoriesinoutPopup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamotoriesinoutPopup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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

%%%%%%%%%%%%%%%%
figure
T=handles.current_xprint;
Y=handles.current_y1print;

leg=[];

if get(handles.mgraph,'Value')==true
    plot(T,Y(:,1),'m','LineWidth',2);
    leg=[leg,{'M'}];
    hold on
end
if get(handles.bgraph,'Value')==true
    plot(T,Y(:,2),'b','LineWidth',2);
    leg=[leg,{'B'}];
    hold on
end
if get(handles.pgraph,'Value')==true
    plot(T,Y(:,3),'k','LineWidth',2);
    leg=[leg,{'P'}];
    hold on
end
if get(handles.agraph,'Value')==true
    plot(T,Y(:,4),'Color',[.5977,.7969,0],'LineWidth',2);
    leg=[leg,{'A'}];
    hold on
end
if get(handles.hgraph,'Value')==true
    plot(T,Y(:,5),'g','LineWidth',2);
    leg=[leg,{'H'}];
    hold on
end
if get(handles.dgraph,'Value')==true
    plot(T,Y(:,6),'r','LineWidth',2);
    leg=[leg,{'D'}];
    hold on
end

legend(leg);

hold off

title('Situation 1');


%%%%%%%%%%%%%%%%%%%%
figure
T=handles.current_xprint;
Y=handles.current_y2print;

leg=[];

if get(handles.mgraph,'Value')==true
    plot(T,Y(:,1),'m','LineWidth',2);
    leg=[leg,{'M'}];
    hold on
end
if get(handles.bgraph,'Value')==true
    plot(T,Y(:,2),'b','LineWidth',2);
    leg=[leg,{'B'}];
    hold on
end
if get(handles.pgraph,'Value')==true
    plot(T,Y(:,3),'k','LineWidth',2);
    leg=[leg,{'P'}];
    hold on
end
if get(handles.agraph,'Value')==true
    plot(T,Y(:,4),'Color',[.5977,.7969,0],'LineWidth',2);
    leg=[leg,{'A'}];
    hold on
end
if get(handles.hgraph,'Value')==true
    plot(T,Y(:,5),'g','LineWidth',2);
    leg=[leg,{'H'}];
    hold on
end
if get(handles.dgraph,'Value')==true
    plot(T,Y(:,6),'r','LineWidth',2);
    leg=[leg,{'D'}];
    hold on
end

legend(leg);

hold off

title('Situation 2');

%%%%%%%%%%%%%
figure
T=handles.current_xprint;
Y=handles.current_diffprint;

leg=[];

if get(handles.mgraph,'Value')==true
    plot(T,Y(:,1),'m','LineWidth',2);
    leg=[leg,{'M'}];
    hold on
end
if get(handles.bgraph,'Value')==true
    plot(T,Y(:,2),'b','LineWidth',2);
    leg=[leg,{'B'}];
    hold on
end
if get(handles.pgraph,'Value')==true
    plot(T,Y(:,3),'k','LineWidth',2);
    leg=[leg,{'P'}];
    hold on
end
if get(handles.agraph,'Value')==true
    plot(T,Y(:,4),'Color',[.5977,.7969,0],'LineWidth',2);
    leg=[leg,{'A'}];
    hold on
end
if get(handles.hgraph,'Value')==true
    plot(T,Y(:,5),'g','LineWidth',2);
    leg=[leg,{'H'}];
    hold on
end
if get(handles.dgraph,'Value')==true
    plot(T,Y(:,6),'r','LineWidth',2);
    leg=[leg,{'D'}];
    hold on
end

legend(leg);

hold off

title('Differences (Situation2-Situation1)')


% --- Executes on button press in generalantibiotics1.
function generalantibiotics1_Callback(hObject, eventdata, handles)
% hObject    handle to generalantibiotics1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of generalantibiotics1


% --- Executes on button press in mucusclearers1.
function mucusclearers1_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearers1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mucusclearers1


% --- Executes on button press in percusionvest1.
function percusionvest1_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvest1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of percusionvest1


% --- Executes on button press in antiinflamatory1.
function antiinflamatory1_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatory1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of antiinflamatory1


% --- Executes on selection change in antibioticsPopup1.
function antibioticsPopup1_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antibioticsPopup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antibioticsPopup1
if  get(hObject,'Value')==2 %TOBI
    set(handles.antibioticsPower1,'String',.49);
    set(handles.antibioticsinoutPopup1,'Value',1);
end



% --- Executes during object creation, after setting all properties.
function antibioticsPopup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mucusclearersPopup1.
function mucusclearersPopup1_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearersPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mucusclearersPopup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mucusclearersPopup1
if  get(hObject,'Value')==2 %TOBI
    set(handles.mucusclearersPower1,'String',1.71);
end

% --- Executes during object creation, after setting all properties.
function mucusclearersPopup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mucusclearersPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in percusionvestPopup1.
function percusionvestPopup1_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvestPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns percusionvestPopup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from percusionvestPopup1

if  get(hObject,'Value')==2 %TOBI
    set(handles.percusionvestpower1,'String',1.5);
end

% --- Executes during object creation, after setting all properties.
function percusionvestPopup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percusionvestPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antiinflamatoriesPopup1.
function antiinflamatoriesPopup1_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatoriesPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antiinflamatoriesPopup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antiinflamatoriesPopup1

if  get(hObject,'Value')==2
    set(handles.antiinflamatoryPower1,'String',.62);
    set(handles.antiinflamotoriesinoutPopup1,'Value',1);
end

% --- Executes during object creation, after setting all properties.
function antiinflamatoriesPopup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamatoriesPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function antibioticsPower1_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsPower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antibioticsPower1 as text
%        str2double(get(hObject,'String')) returns contents of antibioticsPower1 as a double

set(handles.antibioticsPopup1,'Value',1);

% --- Executes during object creation, after setting all properties.
function antibioticsPower1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsPower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mucusclearersPower1_Callback(hObject, eventdata, handles)
% hObject    handle to mucusclearersPower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mucusclearersPower1 as text
%        str2double(get(hObject,'String')) returns contents of mucusclearersPower1 as a double
set(handles.mucusclearersPopup1,'Value',1);


% --- Executes during object creation, after setting all properties.
function mucusclearersPower1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mucusclearersPower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function percusionvestpower1_Callback(hObject, eventdata, handles)
% hObject    handle to percusionvestpower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percusionvestpower1 as text
%        str2double(get(hObject,'String')) returns contents of percusionvestpower1 as a double
set(handles.percusionvestPopup1,'Value',1);


% --- Executes during object creation, after setting all properties.
function percusionvestpower1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percusionvestpower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function antiinflamatoryPower1_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamatoryPower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of antiinflamatoryPower1 as text
%        str2double(get(hObject,'String')) returns contents of antiinflamatoryPower1 as a double
set(handles.antiinflamatoriesPopup1,'Value',1);


% --- Executes during object creation, after setting all properties.
function antiinflamatoryPower1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamatoryPower1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antibioticsinoutPopup1.
function antibioticsinoutPopup1_Callback(hObject, eventdata, handles)
% hObject    handle to antibioticsinoutPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antibioticsinoutPopup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antibioticsinoutPopup1
set(handles.antibioticsPopup1,'Value',1);


% --- Executes during object creation, after setting all properties.
function antibioticsinoutPopup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antibioticsinoutPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in antiinflamotoriesinoutPopup1.
function antiinflamotoriesinoutPopup1_Callback(hObject, eventdata, handles)
% hObject    handle to antiinflamotoriesinoutPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns antiinflamotoriesinoutPopup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from antiinflamotoriesinoutPopup1
set(handles.antiinflamatoriesPopup1,'Value',1);


% --- Executes during object creation, after setting all properties.
function antiinflamotoriesinoutPopup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to antiinflamotoriesinoutPopup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in CFyes1.
function CFyes1_Callback(hObject, eventdata, handles)
% hObject    handle to CFyes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CFyes1



function xlsfilename_Callback(hObject, eventdata, handles)
% hObject    handle to xlsfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xlsfilename as text
%        str2double(get(hObject,'String')) returns contents of xlsfilename as a double


% --- Executes during object creation, after setting all properties.
function xlsfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlsfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in savexls.
function savexls_Callback(hObject, eventdata, handles)
% hObject    handle to savexls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename=get(handles.xlsfilename,'String');

out={'T','M','B','P','A','H','D'};

out1=cat(1,out,num2cell([handles.current_xprint,handles.current_y1print]));
out2=cat(1,out,num2cell([handles.current_xprint,handles.current_y2print]));
out3=cat(1,out,num2cell([handles.current_xprint,handles.current_diffprint]));


xlswrite(filename,out1,'Situation1');
xlswrite(filename,out2,'Situation2');
xlswrite(filename,out3,'Differences');


% --- Executes on button press in saveDLM.
function saveDLM_Callback(hObject, eventdata, handles)
% hObject    handle to saveDLM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename=get(handles.xlsfilename,'String');
dlmwrite([filename,'_Situation1'],[handles.current_xprint,handles.current_y1print],'precision',20);
dlmwrite([filename,'_Situation2'],[handles.current_xprint,handles.current_y2print],'precision',20);
dlmwrite([filename,'_Differences'],[handles.current_xprint,handles.current_diffprint],'precision',20);

function printout(line,handles)
oldlines=get(handles.outputText,'String');
newlines=[oldlines;{line}];
set(handles.outputText,'String',newlines);
% guidata(hObject,handles);
lstr=length(get(handles.outputText,'String'));
if lstr>17
    set(handles.outputText,'ListboxTop',lstr-16);
end