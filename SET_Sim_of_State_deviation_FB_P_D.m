%% 状態偏差フィードバック制御(P-D制御)のシミュレーション設定&実行ファイル
%% 1慣性系機械(マス・ばね・ダンパ)システム
%% バージョン：2023b

%% ---------- RESET ---------- 
clear variables; % 変数消去
close all;       % Figure消去
clc;             % コマンドウィンドウの履歴消去
format compact;  % 余計な改行を消去
%% ---------- SETTINGS SIMULATION ---------- 
% シミュレーション時間
Sim_time = 10;         % シミュレーション時間
Sampling_time = 0.001; % サンプリング時間
% 一定変位目標値の設定(余弦波での立ち上げ)
Target_value = 10;  % 最終値
Tfin = 1;          % 立ち上げ最終時間
Target_angular_frequency = pi/(2*Tfin); % 角周波数
% 正弦波変位目標軌道の設定
Amplitude = 10;               % 振幅
Vibration_period = 4;         % 振動周期
Angular_frequency = (2*pi)/Vibration_period; % 角周波数
Initial_phase = 0;            % 初期位相
% ステップ外生入力の設定
Step_noise = -10;       % ステップ値
Noise_rise_time = 5;   % 立ち上がり時間
%% ---------- SETTINGS ANIMATION ---------- 
% アニメーション結果を見て3つを手動調整
animation_sampling = 1/0.004; % アニメーションサンプリング時間
Cart_width_Const = 4.5;       % 描画する台車の幅(一定変位目標値)
Cart_width_SineWave = 4.5;    % 描画する台車の幅(正弦波変位目標軌道)
%% ---------- VARIABLE DEFINITION ---------- 
m = 1;  % 質量係数
c = 2;  % 粘性係数
k = 1;  % ばね定数
%% ---------- DEFINING STATE-SPACE MODEL ---------- 
A = [   0,    1 ;  % システム係数行列 A
     -k/m, -c/m]; 
B = [0; 1/m];      % 入力係数行列 B
C = [1 0];         % 観測行列 C
D = 0;             % 直達項 D
x0 = zeros(2,1);   % 状態変数の初期値
State_space = ss(A,B,C,D); % 状態空間モデルの定義
%% ---------- CONTROLLER DESIGN ---------- 
q11 =  1000; % 変位の重み
q22 =     1; % 速度の重み
Q = diag([q11 q22]); % 状態変数重み行列の定義
R   =     1;             % 入力重み行列の定義
Ke  = -lqr(A,B,Q,R)      % LQRによるフィードバックゲインの計算
%% ---------- SIMULATION ---------- 
open_system('Model_Sim_of_State_deviation_FB_P_D'); % Simulinkを起動
sim('Model_Sim_of_State_deviation_FB_P_D');         % シミュレーション実行
%% ---------- ANIMATION ---------- 
% 関数の引数(時間,変位,速度,変位目標値(軌道),速度目標値(軌道),制御入力(操作量),アニメーションサンプリング時間,台車幅,figureナンバー,動画保存名と拡張子)
Function_animate1MSD(Time,Displacement_Const,Velocity_Const,Target_Displacement_Const,Target_Velocity_Const,Control_Input_Const,animation_sampling,Cart_width_Const,1,'Movie_Constant_Target_Value.mp4')
Function_animate1MSD(Time,Displacement_SineWave,Velocity_SineWave,Target_Displacement_SineWave,Target_Velocity_SineWave,Control_Input_SineWave,animation_sampling,Cart_width_SineWave,2,'Movie_SineWave_Target.mp4')
disp('Finished!!!!!!!!')