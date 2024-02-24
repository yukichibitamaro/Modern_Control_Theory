%% 任意の時間応答(単位ステップ応答)のサンプルコード
%% 線形n次システム(1慣性系機械システム)
%% バージョン：MATLAB 2023b

%% RESET
clear variables; % 変数消去
close all;       % Figure消去
clc;             % コマンドウィンドウの履歴消去
format compact;  % 余計な改行を消去
%% SYMBOLIC VARIABLE DEFINITION
syms m c k F t tau % シンボリック変数の定義
m = 1;  % 質量係数
c = 2;  % 粘性係数
k = 10; % ばね定数
F = 1;  % 一定値入力(単位入力)
%% DEFINING STATE-SPACE MODEL
A = [   0,    1 ;  % システム係数行列 A
     -k/m, -c/m];
B = [0; 1/m];      % 入力係数行列 B
C = [1 0];         % 観測行列 C
D = 0;             % 直達項 D
x0 = zeros(2,1);   % 状態変数の初期値
u = 1;             % 単位ステップ入力
%% CALCULATING TIME RESPONSE
% 零状態応答
y1 = C * expm(A*t)* x0;
% 零入力応答
f = C * expm(A*(t-tau))*B*u;
y2 = int(f,tau,[0,t]);
% 時間応答の解析解の表示
disp("単位ステップ応答の解析解")
y = y1 + y2