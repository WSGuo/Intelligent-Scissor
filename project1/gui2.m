
function varargout = gui2(varargin)
% GUI2 MATLAB code for gui2.fig
%      GUI2, by itself, creates a new GUI2 or raises the existing
%      singleton*.
%
%      H = GUI2 returns the handle to a new GUI2 or the handle to
%      the existing singleton*.
%
%      GUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI2.M with the given input arguments.
%
%      GUI2('Property','Value',...) creates a new GUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui2

% Last Modified by GUIDE v2.5 27-Feb-2018 00:28:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui2_OpeningFcn, ...
                   'gui_OutputFcn',  @gui2_OutputFcn, ...
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

% --- Executes just before gui2 is made visible.

function gui2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui2 (see VARARGIN)

% Choose default command line output for gui2
handles.output = hObject;

%initialization

handles.contourVisible = 0;
handles.Click = 0;
handles.currentLineExist = 0;
handles.FirstClickPre = 0;
handles.FollowingClickPre = 0;
handles.finishCurCon = 0;
handles.finishCurConClosed = 0;
handles.numOfCon = 0;
handles.numOfSeeds = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui2 wait for user response (see UIRESUME)
% uiwait(handles.MainGUI);


% --- Outputs from this function are returned to the command line.
function varargout = gui2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [FileName,PathName] = uigetfile('*.tga','Select the input image file');
    FullFileName = fullfile(PathName,FileName);
  
    handles.img = (tga_read_image(FullFileName));
    [height,width,chn] = size(handles.img);
    if(chn~=3)
        [FileName,PathName] = uigetfile('*.png','Select the input image file');
        FullFileName = fullfile(PathName,FileName);
        handles.img = imread(FullFileName);
    end
    
    blur = input('Please input whether the avg filter is applied: 0 for default, 1 for blurring\n');
    if(blur)
        %blur the image
        filter_size = input('Please input the avg filter size : \n');
        H = fspecial('average',filter_size);
        handles.img = imfilter(handles.img,H);
        disp('img after blurring');
        image(handles.img);
    end
    
     mode = input('Please input the cost function used: 0 for default ,1 for modified\n');
     if(mode == 0)
        handles.costgraph = calC(handles.img,2);
     else
         handles.costgraph = calC2(handles.img,2);
     end

    image(handles.img);
    disp('cost graph calculated');
    %handles.img = imread(FullFileName);
    
    guidata(hObject,handles);


% --------------------------------------------------------------------
function menu_file_save_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    imgWithCon = (handles.img);
    for i = 1:handles.numOfCon
        allpts = handles.lines(i).return_allpts;
        [n,m] = size(allpts);
        disp(n);
        for j = 1:n
            this_y = allpts(j,1);
            this_x = allpts(j,2);
            imgWithCon(this_x,this_y,1:3) = double([0,1,0])*255;
            
        end
        
    end
    disp('image before storing');
    image(uint8(imgWithCon));
    imwrite(imgWithCon,'myImagewithCon.jpeg','JPEG');


% --- Executes on mouse motion over figure - except title and menu.
function MainGUI_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to MainGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    C = get (gca, 'CurrentPoint');
    title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
    if ((handles.contourVisible)&& (~handles.finishCurCon)&&(~handles.finishCurConClosed))
        if handles.Click == 0 
            % no seedpt yet,do nothing
        else
            % already has a seed pt
            if (handles.FirstClickPre || handles.FollowingClickPre)
                if handles.currentLineExist
                    delete(handles.currentLine);
                    handles.currentLine = line([handles.seedX,C(1,1)],[handles.seedY,C(1,2)],'Color','red');
                
                else
                    handles.currentLine = line([handles.seedX,C(1,1)],[handles.seedY,C(1,2)],'Color','red');
                    handles.currentLineExist = 1;
                end
            end
        end
    elseif (handles.contourVisible && ((handles.finishCurCon)||(handles.finishCurConClosed)))
        % enable selection
        for i = 1:handles.numOfCon
            result = handles.lines(i).return_region;
            maxX = result(1);
            maxY = result(2);
            minX = result(3);
            minY = result(4);
            handles.curSelected = 0;
           
            %disp(handles.lines(i));
            if (C(1,1)>minX)&&(C(1,1)<maxX)&&(C(1,2)>minY)&&(C(1,2)<maxY)
                handles.lines(i) = handles.lines(i).redraw_contour('red');
                handles.lines(i).its_color = 1;
                handles.curSelectedCon = handles.lines(i);
                handles.curSelectedConIndex = i;
                
                handles.curSelected = 1;
            elseif handles.lines(i).its_color == 1
                handles.lines(i)=handles.lines(i).redraw_contour('green');
                handles.lines(i).its_color = 0;
            end

        end
    end
        
    
guidata(hObject,handles); 
        
    


% --------------------------------------------------------------------
function tools_Callback(~, eventdata, handles)
% hObject    handle to tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function brush_menu_Callback(hObject, eventdata, handles)
% hObject    handle to brush_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function scissor_menu_Callback(hObject, eventdata, handles)
% hObject    handle to scissor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
scissor;
guidata(hObject,handles);


 
 




% --------------------------------------------------------------------
function exit_menu_Callback(hObject, eventdata, handles)
% hObject    handle to exit_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close;
    


% --------------------------------------------------------------------
function update_menu_Callback(hObject, eventdata, handles)
% hObject    handle to update_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% this function is used to check the status of scissor panel
% get the handle of Gui1

h = findobj('Tag','ScissorPanel');
 % if exists (not empty)
if ~isempty(h)
    data = guidata(h);
    
    % get handles and other user-defined data associated to Gui1
    % maybe you want to set the text in Gui2 with that from Gui1

    selectedMode = data.selectedMode;
    selectedRange = data.selectedRange;
    

    % start updating the image 
    if strcmp(selectedMode,'image_only')
        handles.contourVisible = 0;
        image(handles.img);
        dragzoom('off');
        handles.Click = 0;
        handles.contourVisible = 0;
        handles.currentLineExist = 0;
        handles.FirstClickPre = 0;
        handles.FollowingClickPre = 0;
        handles.finishCurCon = 0;
        handles.finishCurConClosed = 0;
        handles.numOfCon = 0;
        handles.numOfSeeds = 0;
        

    elseif strcmp(selectedMode,'image_with_contour')
         handles.contourVisible = 1;
         dragzoom('off');
         
    elseif strcmp(selectedMode,'pixel_nodes')
        handles.contourVisible = 0;
        % display the pixel_nodes
        [height,width,chn] = size(handles.img);
        pixel_node_graph = zeros((height-2)*3,(width-2)*3,3);
        
        for i = 2:(height-1)
            for j = 2:(width-1)
                new_x = 3*i-4;
                new_y = 3*j-4;
                pixel_node_graph (new_x,new_y,1:3)= handles.img(i,j,1:3);

            end
        end
       image(uint8(pixel_node_graph));
       %zoom on;
        
    elseif strcmp(selectedMode,'cost_graph')
        handles.contourVisible = 0;
        image(uint8(handles.costgraph));
        %zoom on;
        
    elseif strcmp(selectedMode, 'path_tree')
        %get cost graph first
        input_nodes_num = data.input_nodes_num;
        disp(input_nodes_num);
        handles.contourVisible = 0;
        disp('input for path tree');
        disp(handles.seedX);
        disp(handles.seedY);
        pathTreeGraph = PathTree(input_nodes_num,handles.seedY-1,handles.seedX-1, handles.costgraph);
        image(uint8(pathTreeGraph));
        disp('path tree done');
        %zoom on;
    else 
        %data.selecetedMode == 'minimum_path'
        handles.contourVisible = 0;
        minPathGraph = minPath(handles.bfenterY-1,handles.bfenterX-1,handles.seedY-1,handles.seedX-1,handles.costgraph);
        image(uint8(minPathGraph));
        disp('min path done');
        
        
        
    end
end

 guidata(hObject,handles);


 
% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function MainGUI_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MainGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ((handles.contourVisible) && (~handles.finishCurCon)&&(~handles.finishCurConClosed))
    %display the contour
    
    %fetch the mouse position first
    C = get (gca, 'CurrentPoint');
    if handles.Click == 0
        disp('enter click')
        if handles.FirstClickPre == 1
        % startingPt for contour
            handles.curContour = contourCompleteObj;
            handles.seedX = int64(C(1,1));
            handles.seedY = int64(C(1,2));
            handles.numOfSeeds = handles.numOfSeeds +1;
            handles.seeds(handles.numOfSeeds,1) = handles.seedX;
            handles.seeds(handles.numOfSeeds,2) = handles.seedY;

            handles.Click = 1;
            handles.StartSeedX = int64(C(1,1));
            handles.StartSeedY = int64(C(1,2));
            disp('set first click')
        end
    else
        if handles.FollowingClickPre == 1
        % middlept for the contour
            handles.endX = int64(C(1,1));
            handles.endY = int64(C(1,2));
            this_conObj = contourObj(handles.seedX, handles.seedY, handles.endX, handles.endY,handles.costgraph);
            handles.curContour = handles.curContour.insert(this_conObj);
            handles.seedX = handles.endX;
            handles.seedY = handles.endY;
            
            handles.numOfSeeds = handles.numOfSeeds +1;
            handles.seeds(handles.numOfSeeds,1) = handles.seedX;
            handles.seeds(handles.numOfSeeds,2) = handles.seedY;
            
        end

    end

    
end

guidata(hObject,handles);


% --- Executes on key press with focus on MainGUI and none of its controls.
function MainGUI_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to MainGUI (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
modifiers = get(gcf,'currentModifier');
key1 = get(gcf,'CurrentKey');
disp(eventdata.Key);

if(strcmp(key1,'equal')&&ismember('control',modifiers))
    %zoom in
    zoom(1.5);
    dragzoom() ;
end
if(strcmp(key1,'hyphen')&&ismember('control',modifiers))
    %zoom in
    zoom(0.8);
    dragzoom() ;
end
if(strcmp(key1,'leftarrow')&&ismember('control',modifiers))
    %signal for first click preparation
    handles.FirstClickPre = 1;
    handles.finishCurCon = 0;
    handles.finishCurConClosed = 0;
    disp('FirstClickPre');
end

if(strcmp(key1,'leftarrow')&&handles.Click)
    %signal for first click
    handles.FollowingClickPre = 1;
    handles.finishCurCon=0;
    handles.finishCurConClosed = 0;
    disp('Follwoing');
end
if(strcmp(key1,'return'))
    disp('finished, enter session')
    handles.finishCurCon = 1;
    handles.FirstClickPre = 0;
    handles.FollowingClickPre = 0;
    handles.finishCurConClosed = 0;
    handles.Click = 0;
    % delete current mouse line
    if handles.currentLineExist
       delete(handles.currentLine);
    end
    %draw the last contour
    C = get (gca, 'CurrentPoint');
    handles.endX = int64(C(1,1));
    handles.endY = int64(C(1,2));
    
    handles.numOfCon = handles.numOfCon +1;
    handles.curContour = handles.curContour.insert(contourObj(handles.seedX, handles.seedY, handles.endX, handles.endY,handles.costgraph));
    
    disp('enter mode call redraw')
    %disp('before redraw')
    %disp(handles.curContour.contourObjList(1).lines(1));
    handles.curContour = handles.curContour.redraw_contour('green');
    
    %disp('before')
    %disp(handles.curContour.contourObjList(1).lines(1));
    handles.lines(handles.numOfCon) = handles.curContour;
    %disp('after')
    %disp(handles.lines(1).contourObjList(1).lines(1));
    
    
    handles.bfenterX = handles.seedX;
    handles.bfenterY = handles.seedY;
    
    handles.seedX = handles.endX;
    handles.seedY = handles.endY;
    
    handles.numOfSeeds = handles.numOfSeeds +1;
    handles.seeds(handles.numOfSeeds,1) = handles.seedX;
    handles.seeds(handles.numOfSeeds,2) = handles.seedY;
    

    disp('finished execute enter session')
end
if(strcmp(key1,'f')&&ismember('control',modifiers))
% finish curcon as closed
    disp('finish as closed')
    handles.finishCurConClosed = 1;
    
    handles.FirstClickPre = 0;
    handles.FollowingClickPre = 0;
    handles.finishCurCon = 0;
    handles.Click = 0;
    % delete current mouse line
    if handles.currentLineExist
       delete(handles.currentLine);
    end
    % connect the StartSeed and endpt
    handles.numOfCon = handles.numOfCon +1;
    handles.curContour = handles.curContour.insert(contourObj(handles.seedX, handles.seedY,handles.StartSeedX,handles.StartSeedY,handles.costgraph));
    
    handles.curContour = handles.curContour.redraw_contour('green');
    handles.lines(handles.numOfCon) = handles.curContour;

    
    handles.numOfSeeds = handles.numOfSeeds +1;
    handles.seeds(handles.numOfSeeds,1) = handles.StartSeedX;
    handles.seeds(handles.numOfSeeds,2) = handles.StartSeedY;

    
end

if(strcmp(key1,'backspace'))
% finish curcon as closed
    disp('delete mode')
    
    % delete current mouse line
    if handles.currentLineExist
       delete(handles.currentLine);
       handles.currentLineExist = 0;
    end
    
    if((~handles.finishCurConClosed)&&(~handles.finishCurCon))
        % scissoring,delete the last seed
        handles.numOfSeeds = handles.numOfSeeds-1;
        handles.seedX = handles.seeds(handles.numOfSeeds,1);
        handles.seedY = handles.seeds(handles.numOfSeeds,2);
        % delete the corresponding contour
        handles.curContour = handles.curContour.delete_last;
    elseif(handles.curSelected)
        disp('delete contour')
        % delete the selected contour
        handles.lines(handles.curSelectedConIndex) = handles.lines(handles.curSelectedConIndex).delete_contour;
        %handles.curSelectedCon.delete_contour;
        if(handles.curSelectedConIndex~=handles.numOfCon)
            % exchange the deleted one with the last one
            handles.lines(handles.curSelectedConIndex) = handles.lines(numOfCon);
        end
        
        handles.numOfCon = handles.numOfCon - 1;
    end
    
    
end
guidata(hObject,handles);


% --------------------------------------------------------------------
function save_mask_Callback(hObject, eventdata, handles)
% hObject    handle to save_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
allpts = [];
for i = 1:handles.numOfCon
    return_pts = handles.lines(i).return_allpts
    allpts = [allpts;return_pts];
end
%allpts = handles.curContour.return_allpts;
[height,width,chn] = size(handles.img);
%disp(allpts);
mask = maskGenerator(allpts,height,width);
imshow(mask,'InitialMagnification','fit');
imwrite(mask,'myImageMask.jpeg','JPEG')
guidata(hObject,handles);
