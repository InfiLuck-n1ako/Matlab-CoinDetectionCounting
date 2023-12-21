function varargout = dImproce(varargin)
% DIMPROCE MATLAB code for dImproce.fig
%      DIMPROCE, by itself, creates a new DIMPROCE or raises the existing
%      singleton*.
%
%      H = DIMPROCE returns the handle to a new DIMPROCE or the handle to
%      the existing singleton*.
%
%      DIMPROCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIMPROCE.M with the given input arguments.
%
%      DIMPROCE('Property','Value',...) creates a new DIMPROCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dImproce_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dImproce_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dImproce

% Last Modified by GUIDE v2.5 19-Dec-2023 19:24:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dImproce_OpeningFcn, ...
                   'gui_OutputFcn',  @dImproce_OutputFcn, ...
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


% --- Executes just before dImproce is made visible.
function dImproce_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dImproce (see VARARGIN)

% Choose default command line output for dImproce
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dImproce wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dImproce_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Files_Callback(~, ~, ~)
% hObject    handle to Files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Edit_Callback(~, ~, ~)
% hObject    handle to Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Options_Callback(~, ~, ~)
% hObject    handle to Options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(~, ~, ~)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str_help = ['Click "选择文件", select the image where you want to obtain the number and amount of coins, ' ...
    'select coin detection and counting in "选择", and finally click "开始执行".' ...
    'You can choose the save format in "文件","另存为".'];
msgbox(str_help,'提示信息');

% --------------------------------------------------------------------
function CountCoin_Callback(hObject, ~, handles)
% hObject    handle to CountCoin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.TempString = 'HoughCir';
guidata(hObject, handles);


% --------------------------------------------------------------------
function RGB2gray_Callback(hObject, ~, handles)
% hObject    handle to RGB2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.TempString= 'rgb2gray';
guidata(hObject, handles);

% --------------------------------------------------------------------
function Imim2bw_Callback(hObject, ~, handles)
% hObject    handle to Imim2bw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.TempString= 'imbinarize';
guidata(hObject, handles);

% --------------------------------------------------------------------
function Imopen_Callback(hObject, ~, handles)
% hObject    handle to Imopen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.TempString= 'imopen';
guidata(hObject, handles);

% --------------------------------------------------------------------
function Imgausf_Callback(hObject, ~, handles)
% hObject    handle to Imgausf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.TempString = 'bwlable';
guidata(hObject, handles);

% --------------------------------------------------------------------
function Imagf_Callback(hObject, ~, handles)
% hObject    handle to Imagf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.TempString = 'edge';
guidata(hObject, handles);

% --------------------------------------------------------------------
function HoughCir_Callback(hObject, ~, handles)
% hObject    handle to HoughCir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.TempString = 'HoughCir';
guidata(hObject, handles);

% --------------------------------------------------------------------
function Open_Callback(hObject, ~, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Open a dialog to select an image file
    [fileName, filePath] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, 'Select an Image File');
    
    % Check if the user selected a file
    if fileName ~= 0
        % Read the selected image
        image = imread(fullfile(filePath, fileName));
        
        % Display the image in the "imageAxes"
        axes(handles.axes1);              
        imshow(image);
        % Store the image data in the handles structure for later use
        handles.SrcImage = image;
        guidata(hObject, handles);
    end


% --------------------------------------------------------------------
function Close_Callback(~, ~, ~)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 关闭当前打开的 GUI（如果有的话）
close(gcf);
% 打开 GUIDE 创建的 GUI 文件（替换 'YourGUIDEFileName' 为你的 GUIDE 文件名）
guide('dImproce.fig');

% --------------------------------------------------------------------
function Save_Callback(~, ~, ~)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in saveImageButton.
% 获取用户选择的保存路径和文件名
[filename, pathname] = uiputfile({'*.png';'*.jpg';'*.bmp'}, 'Save Image As');

% 如果用户取消了保存操作，filename 和 pathname 将为 0
if isequal(filename,0) || isequal(pathname,0)
    % 用户取消保存操作
    return;
end

% 构建完整的保存路径
fullFilePath = fullfile(pathname, filename);

% 从 axes 控件中获取图像数据
imageData = imread('..\Image\temPicture20231212.png');

% 保存图像到指定文件
imwrite(imageData, fullFilePath);

% 显示保存成功的消息
msgbox('Image saved successfully!', 'Success', 'modal');

% --------------------------------------------------------------------
function Exit_Callback(~, ~, ~)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Close the application
delete('..\Image\temPicture20231212.png'); % 删除指定的图片文件
close(gcf);


% --- Executes on button press in Choose.
function Choose_Callback(hObject, ~, handles)
% hObject    handle to Choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Open a dialog to select an image file
    [fileName, filePath] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, 'Select an Image File');
    
    % Check if the user selected a file
    if fileName ~= 0
        % Read the selected image
        image = imread(fullfile(filePath, fileName));
        
        % Display the image in the "imageAxes"
        axes(handles.axes1);              %在第一个轴中显示
        imshow(image);
        % Store the image data in the handles structure for later use
        handles.SrcImage = image;
        guidata(hObject, handles);
    end


% --- Executes on button press in Start.
function Start_Callback(~, ~, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(handles.TempString, 'rgb2gray')
    image = funcRGB2gray(handles.SrcImage);
    axes(handles.axes2);
    imshow(image);

elseif strcmp(handles.TempString, 'imbinarize')
    imagegray = funcRGB2gray(handles.SrcImage);
    image = funcImim2bw(imagegray);
    axes(handles.axes2);
    imshow(image);

elseif strcmp(handles.TempString, 'imopen')
    imagegray = funcRGB2gray(handles.SrcImage);
    % Imaim2bw = funcImim2bw(imagegray);
    image = funcImopen(imagegray);
    axes(handles.axes2);
    imshow(image);

elseif strcmp(handles.TempString, 'bwlable')
    imagegray = funcRGB2gray(handles.SrcImage);
    % Imaim2bw = funcImim2bw(imagegray);
    openedImage = funcImopen(imagegray);
    Imagausf = funcImagausf(openedImage);
    image = funcLabeledImage(Imagausf);
    axes(handles.axes2);
    imshow(image);

elseif strcmp(handles.TempString, 'edge')
    imagegray = funcRGB2gray(handles.SrcImage);
    % Imaim2bw = funcImim2bw(imagegray);
    % openedImage = funcImopen(imagegray);
    % Imagausf = funcImagausf(openedImage);
    % labeledImage = funcLabeledImage(Imagausf);
    image = funcImagf(imagegray);
    axes(handles.axes2);
    imshow(image);

elseif strcmp(handles.TempString, 'HoughCir')
    imagegray = funcRGB2gray(handles.SrcImage);
    % Imaim2bw = funcImim2bw(imagegray);
    % openedImage = funcImopen(imagegray);
    % Imagausf = funcImagausf(openedImage);
    % labeledImage = funcLabeledImage(Imagausf);
    Imagegf = funcImagf(imagegray);
    funcHoughCir(handles.SrcImage,Imagegf);
    image = imread('..\Image\temPicture20231212.png');
    axes(handles.axes2);
    imshow(image);
end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Total coins calculation
sumOf50s=0;
sumOf10s=0;

%Find Circles (Use Hough Transform)
[centers, radii] = find_circles(Imagegf, [112, 119]);

%Remove overlapped circles
[~,radiiNew] = RemoveOverLap(centers,radii,125,1);

for i = 1 : size(radiiNew)     
        if(radiiNew(i) > 115)
          sumOf50s=sumOf50s+1;
        else
          sumOf10s=sumOf10s+1;
        end          
end

Total = sumOf10s+sumOf50s ;

set(handles.edit1,'string',"硬币共有："+Total+"个");
set(handles.edit2,'string',"一元硬币有"+num2str(sumOf50s)+"个，五角硬币有"+num2str(sumOf10s)+"个。");



function edit1_Callback(~, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, ~, ~)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, ~, ~)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
