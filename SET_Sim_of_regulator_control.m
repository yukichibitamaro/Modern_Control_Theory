%% レギュレータ制御のシミュレーション設定&実行ファイル
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
% 目標値の設定
Target_Displacement = zeros((1/Sampling_time)*Sim_time+1,1); % 変位目標値
Target_Velocity = zeros((1/Sampling_time)*Sim_time+1,1);     % 速度目標値
%% ---------- SETTINGS ANIMATION ---------- 
% アニメーション結果を見て2つを手動調整
animation_sampling = 1/0.004; % アニメーションサンプリング時間
Cart_width = 4.5;          % 描画する台車の幅(ステップ目標値)
%% ---------- VARIABLE DEFINITION ---------- 
m = 1;  % 質量係数
c = 2;  % 粘性係数
k = 10; % ばね定数
%% ---------- DEFINING STATE-SPACE MODEL ---------- 
A = [   0,    1 ;  % システム係数行列 A
     -k/m, -c/m]; 
B = [0; 1/m];      % 入力係数行列 B
C = [1 0];         % 観測行列 C
D = 0;             % 直達項 D
x0 = [10;0];   % 状態変数の初期値
State_space = ss(A,B,C,D); % 状態空間モデルの定義
%% ---------- CONTROLLER DESIGN ---------- 
p1 = -6; % 変位の極
p2 = -3; % 速度の極
p = [p1,p2]; % 状態変数の極
K = -place(A,B,p) % 状態フィードバックゲインの抽出
%% ---------- SIMULATION ---------- 
open_system('Model_Sim_of_regulator'); % Simulinkを起動
sim('Model_Sim_of_regulator');         % シミュレーション実行
%% ---------- ANIMATION ---------- 
% 関数の引数(時間,変位,速度,変位目標値(軌道),速度目標値(軌道),制御入力(操作量),アニメーションサンプリング時間,台車幅,figureナンバー,動画保存名と拡張子)
Function_animate1MSD(Time,Displacement,Velocity,Target_Displacement,Target_Velocity,Control_Input,animation_sampling,Cart_width,1,'Movie_Regulator.mp4')
disp('Finished!!!!!!!!')