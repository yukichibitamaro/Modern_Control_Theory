%% 積分型サーボ制御のシミュレーション設定ファイル
%% 1慣性系機械システム
%% バージョン：MATLAB 2023b

%% RESET
clear variables; % 変数消去
close all;       % Figure消去
clc;             % コマンドウィンドウの履歴消去
format compact;  % 余計な改行を消去
%% SETTINGS SIMULATION
% シミュレーション時間
Sim_time = 10;         % シミュレーション時間
Sampling_time = 0.001; % サンプリング時間
% ステップ目標値
Step_tarege = 10;      % ステップ値
Target_rise_time = 1;  % 立ち上がり時間
% 正弦波目標軌道
Amplitude = 10;        % 振幅
Angular_frequency = 3; % 角周波数
Initial_phase = 0;     % 初期位相
% ステップ外生入力
Step_noise = 50;        % ステップ値
Noise_rise_time = 5;   % 立ち上がり時間
%% VARIABLE DEFINITION
m = 1;  % 質量係数
c = 2;  % 粘性係数
k = 10; % ばね定数
%% DEFINING STATE-SPACE MODEL
A = [   0,    1 ;  % システム係数行列 A
     -k/m, -c/m]; 
B = [0; 1/m];      % 入力係数行列 B
C = [1 0];         % 観測行列 C
D = 0;             % 直達項 D
x0 = zeros(2,1);   % 状態変数の初期値
State_space = ss(A,B,C,D); % 状態空間モデルの定義
n = length(A);     % 状態変数の数
p = size(B,2);     % 制御入力(操作量)の数
q = size(C,1);     % 制御出力(制御量)の数
%% DEFINING EXTENDED STATE DEVIATION MODEL
tildeAe = [ A, zeros(n,q);
            -C, zeros(q,q)];
tildeBe = [B;zeros(q,p)];
%% CONTROLLER DESIGN
q11 =    500; % 変位の重み
q22 =    100; % 速度の重み
q33 =  100000000; % 積分器の重み
Q = diag([q11 q22 q33]); % 状態変数重み行列の定義
R   =   1;  % 入力重み行列の定義
tildeKe = -lqr(tildeAe,tildeBe,Q,R);
Ke = tildeKe(:,1:n);
G  = tildeKe(:,n+1:n+q);
%% SIMULATION
open_system('Model_Simulation_of_integral_servo_control'); % Simulinkを起動
sim('Model_Simulation_of_integral_servo_control'); % シミュレーション実行
%% Animation
animation_sampling = 1/0.004;
%Function_animate1MSD(Time,Displacement_Step,Target_Step,Control_Input_Step,animation_sampling,8)
Function_animate1MSD(Time,Displacement_SW,Target_SW,Control_Input_SW,animation_sampling,6)
disp('fin')



