function varargout = JointMenu(varargin)
% JOINTMENU MATLAB code for JointMenu.fig
%      JOINTMENU, by itself, creates a new JOINTMENU or raises the existing
%      singleton*.
%
%      H = JOINTMENU returns the handle to a new JOINTMENU or the handle to
%      the existing singleton*.
%
%      JOINTMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JOINTMENU.M with the given input arguments.
%
%      JOINTMENU('Property','Value',...) creates a new JOINTMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before JointMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to JointMenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help JointMenu

% Last Modified by GUIDE v2.5 12-Feb-2015 16:04:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JointMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @JointMenu_OutputFcn, ...
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


% --- Executes just before JointMenu is made visible.
function JointMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to JointMenu (see VARARGIN)

% Create the values that will populate all pre-set fields
handles.Translational=1;
handles.Rotational=0;

handles.rom='na';

handles.k='na';

handles.s1='0.5';
handles.s2='10';

handles.f='na';

handles.AlE=73000;
handles.PLAE=2800;
handles.ABSE=2587.5;
handles.AlG=28000;
handles.PLAG=875;
handles.ABSG=875;


%Set initial data value for drop down box values
handles.type = handles.Translational;
handles.matE = handles.AlE;
handles.matG = handles.AlG;

% Choose default command line output for JointMenu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JointMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = JointMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in type_popup.
function type_popup_Callback(hObject, eventdata, handles)
% hObject    handle to type_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
case 'Translational' % User selects Translational.
 handles.type = handles.Translational;
case 'Rotational' % User selects Rotational.
 handles.type = handles.Rotational;
end
% Save the handles structure.
guidata(hObject,handles)

% Hints: contents = cellstr(get(hObject,'String')) returns type_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from type_popup


% --- Executes during object creation, after setting all properties.
function type_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rom_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rom_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rom = get(hObject,'string');
handles.rom = rom;
guidata(gcbo,handles); 


% --- Executes during object creation, after setting all properties.
function rom_edit_CreateFcn(hObject, ~, handles)
% hObject    handle to rom_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_edit_Callback(hObject, eventdata, handles)
% hObject    handle to k_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
k = get(hObject,'string');
handles.k = k;
guidata(gcbo,handles); 
% Hints: get(hObject,'String') returns contents of k_edit as text
%        str2double(get(hObject,'String')) returns contents of k_edit as a double


% --- Executes during object creation, after setting all properties.
function k_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to s1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s1 = get(hObject,'string');
handles.s1 = s1;
guidata(gcbo,handles); 
% Hints: get(hObject,'String') returns contents of s1_edit as text
%        str2double(get(hObject,'String')) returns contents of s1_edit as a double


% --- Executes during object creation, after setting all properties.
function s1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to s2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s2 = get(hObject,'string');
handles.s2 = s2;
guidata(gcbo,handles); 
% Hints: get(hObject,'String') returns contents of s2_edit as text
%        str2double(get(hObject,'String')) returns contents of s2_edit as a double


% --- Executes during object creation, after setting all properties.
function s2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mat_popupmenu.
function mat_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to mat_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
case 'Aluminum' % User selects Aluminum.
 handles.matE = handles.AlE;
 handles.matG = handles.AlG;
case 'PLA' % User selects PLA.
 handles.matE = handles.PLAE;
 handles.matG = handles.PLAG;
case 'ABS' % User selects PLA.
 handles.matE = handles.ABSE;
 handles.matG = handles.ABSG;
end
% Save the handles structure.
guidata(hObject,handles)

% Hints: contents = cellstr(get(hObject,'String')) returns mat_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mat_popupmenu


% --- Executes during object creation, after setting all properties.
function mat_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mat_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function f_edit_Callback(hObject, eventdata, handles)
% hObject    handle to f_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = get(hObject,'string');
handles.f = f;
guidata(gcbo,handles); 
% Hints: get(hObject,'String') returns contents of f_edit as text
%        str2double(get(hObject,'String')) returns contents of f_edit as a double


% --- Executes during object creation, after setting all properties.
function f_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in done_pushbutton1.
function done_pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to done_pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get user input from GUI
% disp(handles.type);
% disp(handles.rom);
% disp(handles.k);
% disp(handles.s1);
% disp(handles.s2);
% disp(handles.f);
% disp(handles.matE);
% disp(handles.matG);


[ z ] = DecisiontreeFunction(handles.type,handles.rom,handles.k,handles.s1,handles.s2,handles.f,handles.matE,handles.matG);
