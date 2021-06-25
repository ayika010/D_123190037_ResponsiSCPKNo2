function varargout = D_123190037_ResponsiSCPK(varargin)
%      D_123190037_ResponsiSCPK, by itself, creates a new D_123190037_ResponsiSCPK or raises the existing
%      singleton*.
%
%      H = D_123190037_ResponsiSCPK returns the handle to a new D_123190037_ResponsiSCPK or the handle to
%      the existing singleton*.
%
%      D_123190037_ResponsiSCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in D_123190037_ResponsiSCPK.M with the given input arguments.
%
%      D_123190037_ResponsiSCPK('Property','Value',...) creates a new D_123190037_ResponsiSCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before D_123190037_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to D_123190037_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help D_123190037_ResponsiSCPK

% Last Modified by GUIDE v2.5 26-Jun-2021 00:18:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @D_123190037_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @D_123190037_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before D_123190037_ResponsiSCPK is made visible.
function D_123190037_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to D_123190037_ResponsiSCPK (see VARARGIN)

% Choose default command line output for D_123190037_ResponsiSCPK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes D_123190037_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = D_123190037_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = [1 3 4 5 6 7 8]; %memilih kolom(kriteria) untuk tabel 1
opts.DataRange = "A2:H21"; %melimit range baris
data = readmatrix('DATA RUMAH.xlsx',opts);
set(handles.uitable1,'data',data);

opts.SelectedVariableNames = [3 4 5 6 7 8];%memilih kolom untuk tabel 2
data2 =xlsread('DATA RUMAH.xlsx','C2:H1011');

w=[0.3,0.2,0.23,0.1,0.07,0.1];
k=[0,1,1,1,1,1];
[m,n]=size (data2); %matriks m  n ukuran data2
R=zeros (m,n); %kosong
Y=zeros (m,n); %titik kosong
for j=1:n
    if (k(j)==1)
        R(:,j)=data2(:,j)./max(data2(:,j));
    else
        R(:,j)=min(data2(:,j))./data2(:,j);
    end
end
%proses perankingan
for i=1:m
    V(i)= sum(w.*R(i,:));
end
%mengurutkan dari terbesar ke terkecil
ranking = sort(V, 'descend');
hasil = ranking.';

[nilaitertinggi, letak] = max(V);%mencari nilai tertingi dan index untuk no rumah

disp("No Rumah ke = "+letak +", Dengan nilai : "+ nilaitertinggi);

%menampilkan ke tabel gui
set(handles.uitable2, 'data', hasil(1:20,:));
