function varargout = scissor(varargin)
% SCISSOR MATLAB code for scissor.fig
%      SCISSOR, by itself, creates a new SCISSOR or raises the existing
%      singleton*.
%
%      H = SCISSOR returns the handle to a new SCISSOR or the handle to
%      the existing singleton*.
%
%      SCISSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCISSOR.M with the given input arguments.
%
%      SCISSOR('Property','Value',...) creates a new SCISSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before scissor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to scissor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help scissor

% Last Modified by GUIDE v2.5 23-Feb-2018 12:50:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @scissor_OpeningFcn, ...
                   'gui_OutputFcn',  @scissor_OutputFcn, ...
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


% --- Executes just before scissor is made visible.
function scissor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to scissor (see VARARGIN)

% Choose default command line output for scissor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Initialize inter-UI data
set(handles.ModeButtonGroup,'selectedobject',[]);
set(handles.ScissorRangeButtonGroup,'selectedobject',[]);

guidata(hObject,handles); 


% UIWAIT makes scissor wait for user response (see UIRESUME)
% uiwait(hObjectPanel);


% --- Outputs from this function are returned to the command line.
function varargout = scissor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in image_only.
function image_only_Callback(hObject, eventdata, handles)
% hObject    handle to image_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of image_only

handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);


% --- Executes on button press in image_with_contour.
function image_with_contour_Callback(hObject, eventdata, handles)
% hObject    handle to image_with_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of image_with_contour
handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);

% --- Executes on button press in pixel_nodes.
function pixel_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to pixel_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pixel_nodes
handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);

% --- Executes on button press in cost_graph.
function cost_graph_Callback(hObject, eventdata, handles)
% hObject    handle to cost_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cost_graph
handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);

% --- Executes on button press in whole_image.
function whole_image_Callback(hObject, eventdata, handles)
% hObject    handle to whole_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of whole_image
handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);

% --- Executes on button press in brush_selection.
function brush_selection_Callback(hObject, eventdata, handles)
% hObject    handle to brush_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of brush_selection
handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);

% --- Executes on button press in path_tree.
function path_tree_Callback(hObject, eventdata, handles)
% hObject    handle to path_tree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of path_tree
handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);

% --- Executes on button press in minimum_path.
function minimum_path_Callback(hObject, eventdata, handles)
% hObject    handle to minimum_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of minimum_path
handles.selectedMode = get(get(handles.ModeButtonGroup,'SelectedObject'), 'Tag');
handles.selectedRange = get(get(handles.ScissorRangeButtonGroup,'SelectedObject'), 'Tag');
guidata(hObject,handles);

% --- Executes on button press in close.
function close_Callback(~, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close;
