%% 1慣性機械(マス・ばね・ダンパ)システムのアニメーション実行ファイル
% 関数の引数(時間,変位,速度,変位目標値(軌道),速度目標値(軌道),制御入力(操作量),アニメーションサンプリング時間,台車幅,figureナンバー,動画保存名と拡張子)
function Function_animate1MSD(Time,Displacement,Velocity,Target_Displacement,Target_Velocity,Control_Input,animation_sampling,cart_wide,figure_NUM,Movie_name)
    %% 初期設定
    % 質点の設定
    w = cart_wide;  % 慣性体の幅の設定
    h = 2.2; % 慣性体の高さの設定
    y = 0; % 慣性体の位置の設定
    % 変数設定
    t = linspace(Time(1), Time(end), animation_sampling); % シミュレーション時間をアニメーションステップ数に分割して時間ベクトルを生成
    x = zeros(animation_sampling, 1); % 質点の位置の空行列を定義
    u = zeros(animation_sampling, 1); % 制御入力の空行列を定義
    % ルックアップテーブルを使用して各質点の位置,速度,入力をアニメーション時間軸に変更
    x(:, 1) = interp1(Time, Displacement(:, 1), t);  % 質点の位置
    v(:, 1) = interp1(Time, Velocity(:, 1), t);  % 質点の位置 
    u(:, 1)  = interp1(Time, Control_Input(:, 1), t); % 制御入力
    spacing = fix(2 * max(abs(x), [], "all")); % 初期位置設定
    remainder = mod(spacing,5);
    difference = 5 - remainder;
    if (remainder ~= 0)
    spacing = spacing + difference;
    end
    xmax = spacing * 2; % x軸の範囲を設定
    %% アニメーションの描画と動画の保存準備
    if figure_NUM == 1
       fig = figure(1); % Figure1をアクティブ(ステップ目標値)
       filename = Movie_name; % 保存する動画ファイル名
       vidObj = VideoWriter(filename, 'MPEG-4'); % VideoWriterオブジェクトの作成
       open(vidObj); % 動画ファイル起動 
    elseif figure_NUM == 2
       fig = figure(2); % Figure2をアクティブ(正弦波目標軌道)
       filename = Movie_name; % 保存する動画ファイル名
       vidObj = VideoWriter(filename, 'MPEG-4'); % VideoWriterオブジェクトの作成
       open(vidObj); % 動画ファイル起動 
    else
       error('Invalid figure number. Please specify 1 or 2.');
    end
    set(fig, 'Position', get(0,'Screensize')); % ディスプレイに対してフルスクリーンでグラフ描画
    for j = 1:numel(t)
        % 質点の挙動(アニメーション)を表示するサブプロットを作成
        subplot(4,1,1)
        cla % サンプリングごとの慣性体,ばね,ダンパの履歴消去
        hold on
        x0k = 0; % ばね，ダンパの左端点の位置
        % ばねの描画
        xc = spacing + x(j,1);     % 慣性体の位置(重心)設定       
        xs = linspace(x0k,xc,spacing); % ばねのギザギザ具合の設定1
        ys = 0.3*(-1).^(1:numel(xs));  % ばねのギザギザ具合の設定2
        plot(xs,ys + 1.65,"k");        % ばねの描画(ばねの高さもオフセットして設定)
        % ダンパの描画
        yd = 0.5;
        xd = x0k + (xc-x0k)*0.47+0.1;
        xd2 = x0k + (xc-x0k)*0.4;
        xd3 = x0k + (xc-x0k)*0.5 + 0.5;
        plot([x0k,xd,NaN,xd,xd],[yd,yd,NaN,yd-0.3,yd+0.3],"k")
        plot([xd2,xd3,NaN,xd2,xd3,NaN,xd3,xd3,NaN,xd3,xc],[yd-0.5,yd-0.5,NaN,yd+0.5,yd+0.5,NaN,yd-0.5,yd+0.5,NaN,yd,yd],"k")
        % 慣性体の描画
        x1 = spacing + x(j,1) - w/2;
        rectangle("Position",[x1 y w h],"FaceColor","k")
        % Plot x1, x2 distances
        if (x(j,1) > 0)
            quiver(spacing, y+h*1.1, x(j,1),0,"k-","MaxHeadSize",1/(x(j,1))^1,'AutoScale','off','LineWidth',3)
        elseif (x(j,1) < 0)
            quiver(spacing, y+h*1.1, x(j,1),0,"k-","MaxHeadSize",1/(-x(j,1))^1,'AutoScale','off','LineWidth',3)
        else
            quiver(spacing, y+h*1.1, 0,0,"k-","MaxHeadSize",1,'AutoScale','off','LineWidth',3)
        end
        % シミュレーション結果の描画(慣性体の位置)
        plot([1;1]*[spacing, spacing + x(j,1)],[0.95;1.1]*(y*[1,1]+h*1.1),"k-","markersize",12)
        text((spacing + spacing + x(j,1))/2,(y+h*1.3),"p(t)",'FontAngle', 'italic',"HorizontalAlignment","Center",'FontSize',25)
        plot(spacing + x(j,1)-w/4,-0.25,'ko','MarkerSize',25,'MarkerFaceColor','k')
        plot(spacing + x(j,1)+w/4,-0.25,'ko','MarkerSize',25,'MarkerFaceColor','k')
        axis([0, xmax, -0.5, 3]) % 軸の範囲を変更
        set(gca, "ytick", [])    % y軸消去
        h_axes = gca;
        h_axes.XAxis.FontSize = 15; % x軸フォントサイズの設定
        h_axes.YAxis.FontSize = 15; % y軸フォントサイズの設定
        tick_values1 = linspace(0, xmax, fix(xmax/5)+1);
        tick_values2 = linspace(-spacing, spacing, fix(xmax/5)+1);
        xticks(tick_values1);
        xticklabels(arrayfun(@num2str, tick_values2, 'UniformOutput', false));
        xlabel("Displacement [m]")
        hold off
        % シミュレーション結果の描画(慣性体の位置)
        subplot(4,1,2) 
        cla
        hold on
        if (max(Target_Displacement) == 0) && (max(-Target_Displacement) == 0)
            % 目標軌道の描画をしない
        else
            plot(Time, Target_Displacement,':k','LineWidth',4.0)
        end
        plot(t, x,'-b','LineWidth',4.0)
        plot(t(j), x(j, 1), "bo", "MarkerFaceColor", 'b', 'MarkerSize', 10)
        grid on;
        h_axes = gca;
        h_axes.XAxis.FontSize = 15; % x軸フォントサイズの設定
        h_axes.YAxis.FontSize = 15; % y軸フォントサイズの設定
        xlim([0,max(Time)])
        if (max(-Target_Displacement) == 0)
            if (max(Target_Displacement) == 0)
                ylim([-max(-x)-3,max(x)+3])
            else
                ylim([0,max(x)+3])
            end
        else
            ylim([-max(-x)-2,max(x)+2])
        end
        xlabel("Time [s]")
        ylabel("Displacement [m]")
        hold off
        % シミュレーション結果の描画(慣性体の速度)
        subplot(4,1,3) 
        cla
        hold on
        if (Target_Velocity ~= 0)
            plot(Time, Target_Velocity,':k','LineWidth',4.0)
        end
        plot(t, v,'-b','LineWidth',4.0)
        plot(t(j), v(j, 1), "bo", "MarkerFaceColor", 'b', 'MarkerSize', 10)
        grid on;
        h_axes = gca;
        h_axes.XAxis.FontSize = 15; % x軸フォントサイズの設定
        h_axes.YAxis.FontSize = 15; % y軸フォントサイズの設定
        xlim([0,max(Time)])
        ylim([-max(-v)-5,max(v)+5])
        xlabel("Time [s]")
        ylabel("Velocity [m/s]")
        hold off
        % シミュレーション結果の描画(制御入力)
        subplot(4,1,4)
        cla % サンプリングごとのマーカー履歴消去
        hold on % グラフの保持
        plot(t, u,'-b','LineWidth',4.0)
        plot(t(j), u(j, 1), "bo", "MarkerFaceColor", 'b', 'MarkerSize', 10)
        grid on;
        h_axes = gca;
        h_axes.XAxis.FontSize = 15; % x軸フォントサイズの設定
        h_axes.YAxis.FontSize = 15; % y軸フォントサイズの設定
        xlim([0,max(Time)])
        xlabel("Time [s]")
        ylabel("Control input [N]")
        hold off
        % アニメーション& 動画処理
        drawnow % アニメーションの確実な実行
        writeVideo(vidObj, getframe(fig)); % フレームを動画に書き込む
    end
    close(vidObj); % 動画ファイルを閉じる
end