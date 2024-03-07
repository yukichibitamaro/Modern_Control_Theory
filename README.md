# ★Modern_Control_Theory★

現代制御理論(解析やシミュレーション)に関するソースコード，関数，Simulinkをまとめたリポジトリ

# ◎開発環境

### 〇 開発言語
 
・MATLAB & Simulink

### 〇 バージョン

・2023b
 
### 〇 アドオン(ライブラリ)

 
・Simulink バージョン23.2

　：　シミュレーションのモデル作成

・Control System Toolbox バージョン23.2 

　：　線形制御システムの時間領域や周波数領域における動作の解析，設計，調整
    
・Simulink Control Design バージョン23.2

　：　Simulink でモデル化された制御システムの設計と解析
    
・Symbolic Math Toolbox バージョン23.2

　：　シンボリックな微分、積分、単純化、変換、方程式の求解などを解析的に実行


# ◎ソースコード

 
 ・Primary_system_response_time.m
 
　：　線形1次システムの時間応答解析解の導出
 
 ・n_Secondary_system_response_time.m
 
　：　線形n次システムの時間応答解析解の導出

 ・SET_Sim_of_regulator_control.m
 
　：　レギュレータ制御シミュレーション設定&実行ファイル

 ・SET_Sim_of_integral_servo_I_PD.m
 
　：　積分型サーボ制御(I-PD制御)の性能評価シミュレーション設定&実行ファイル

 ・Model_Sim_of_State_deviation_FB_PD.m
 
　：　状態偏差FB制御(PD制御)の性能評価シミュレーション設定&実行ファイル

 ・Model_Sim_of_State_deviation_FB_PD_.m
 
　：　(微分先行型)状態偏差FB制御(P-D制御)の性能評価シミュレーション設定&実行ファイル

 ・SET_Sim_of_state_deviation_FB_and_output_integral_PID.m
 
　：　状態偏差FB&出力偏差積分制御(PID制御)の性能評価シミュレーション設定&実行ファイル

 ・SET_Sim_of_state_deviation_FB_and_output_integral_PI-D.m
 
　：　(微分先行型)状態偏差FB&出力偏差積分制御(PID制御)の性能評価シミュレーション設定&実行ファイル

# ◎関数

 
 ・Function_animate1MSD
 
　：　1慣性機械(マス・ばね・ダンパ)システムのアニメーション描画関数

# ◎Simulink

 ・Model_Sim_of_regulator.slx
 
　：　レギュレータ制御の性能評価シミュレーションSimulinkモデル
 
 ・Model_Sim_of_integral_servo_I_PD
 
　：　積分型サーボ制御の性能評価シミュレーションSimulinkモデル
 　 
# ◎シミュレーション

 ・レギュレータ制御

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/dc54ba4f-0cf2-4e02-90e8-4b5c8969a7f5


 ・積分型サーボ制御

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/54a572d5-e691-42c8-9e06-c53327ee1525


https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/88c9f3e1-8ff7-4c0f-84d3-718a9bf64e69





