function varargout = Responsi_scpk_WP(varargin)
% RESPONSI_SCPK_WP MATLAB code for Responsi_scpk_WP.fig
%      RESPONSI_SCPK_WP, by itself, creates a new RESPONSI_SCPK_WP or raises the existing
%      singleton*.
%
%      H = RESPONSI_SCPK_WP returns the handle to a new RESPONSI_SCPK_WP or the handle to
%      the existing singleton*.
%
%      RESPONSI_SCPK_WP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SCPK_WP.M with the given input arguments.
%
%      RESPONSI_SCPK_WP('Property','Value',...) creates a new RESPONSI_SCPK_WP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi_scpk_WP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi_scpk_WP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi_scpk_WP

% Last Modified by GUIDE v2.5 26-Jun-2021 12:27:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi_scpk_WP_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi_scpk_WP_OutputFcn, ...
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


% --- Executes just before Responsi_scpk_WP is made visible.
function Responsi_scpk_WP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi_scpk_WP (see VARARGIN)

% Choose default command line output for Responsi_scpk_WP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi_scpk_WP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi_scpk_WP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Showdata.
function Showdata_Callback(hObject, eventdata, handles)
% hObject    handle to Showdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Real_Estate_50.xlsx');
opts.SelectedVariableNames = (1:5);
data = readmatrix('Real_Estate_50.xlsx', opts);
set(handles.tabel1,'data',data,'visible','on'); 
%membaca dan menampilakan file Real Estate 50.xlsx



% --- Executes on button press in Ranking.
function Ranking_Callback(hObject, eventdata, handles)
% hObject    handle to Ranking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Real_Estate_50.xlsx');
opts.SelectedVariableNames = (2:5);
data = readmatrix('Real_Estate_50.xlsx', opts); 
%membaca dan menampilakn file Real Estate 50.xlsx
k=[0,0,1,0]; %nilai benefit / cost
w=[3,5,4,1]; %nilai bobot kriteria

%1.Perbaikan bobot
[m n]=size (data); %untuk inisialisasi ukuran x inisiasi nilai ukuran x
w=w./sum(w); %untuk membagi bobot dengan kriteria dengan jumlah total bobot

%2. Menghitung Vector(S) pada setiap baris(Alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(data(i,:).^w);
end;

opts = detectImportOptions('Real_Estate_50.xlsx');
opts.SelectedVariableNames = (1);
baru = readmatrix('Real_Estate_50.xlsx', opts);
xlswrite('Result_WP.xlsx', baru, 'Sheet1', 'A1'); %meletakkan data pada file colom A1
S=S'; %mengubah data hasil perhitungan dari horizontal ke vertikal matriks
xlswrite('Result_WP.xlsx', S, 'Sheet1', 'B1'); %meletakkan data pada file colom B1

opts = detectImportOptions('Result_WP.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('Result_WP.xlsx', opts); %membaca file Result WP.xlsx

X=sortrows(data,2,'descend'); %mengurutkan data dari file berdasarkan kolom ke-2 dari yang terbesar
set(handles.tabel2,'data',X,'visible','on'); %menampilkan data yang telah diurutkan ke dalam tabel
