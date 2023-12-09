ImaSrc = imread('Image\coin4.jpg');
Imagray = rgb2gray(ImaSrc);
Imadb = im2double(Imagray);
T0 = 0.01;
T1 = (min(Imadb(:)) + max(Imadb(:)))/2;
r1 = find(Imadb > T1);
r2 = find(Imadb <= T1);
T2 = (mean(Imadb(r1)) + mean(Imadb(r2)))/2;
while abs(T2 -T1) < T0
    T1 = T2;
    r1 = find(Imadb > T1);
    r2 = find(Imadb <= T1);
    T2 = (mean(Imadb(r1)) + mean(Imadb(r2)))/2;
end

Imaim2bw = imbinarize(Imadb, T2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Imafil1 = [-1, -1, -1; 2, 2, 2; -1 -1 -1];
% Imafil2 = [-1, -1, 2; -1, 2, -1; 2, -1, -1];
% Imafil3 = [-1, 2, -1; -1, 2, -1;-1, 2, -1];
% Imafil4 = [2, -1, -1; -1, 2, -1; -1, -1, 2];
% 
% Imagf1 = imfilter(Imagray, Imafil1);
% Imagf2 = imfilter(Imagray, Imafil2);
% Imagf3 = imfilter(Imagray, Imafil3);
% Imagf4 = imfilter(Imagray, Imafil4);
% Imagf = Imagf1+Imagf2+Imagf3+Imagf4; 

figure;imshow(ImaSrc);
% subplot(142), imshow(Imagf);
figure;imshow(Imaim2bw);

% 二值化图像（可以使用适当的阈值或其他方法）
binaryImage = imbinarize(Imagray);

% 定义开运算的结构元素
se = strel('disk',32);  % 这里使用了一个半径为5的圆形结构元素，你可以根据需要调整大小

% 应用开运算
openedImage = imopen(binaryImage, se);

% 显示结果
%figure;
%subplot(1,4,1), imshow(binaryImage), title('二值图像');

sigma=8;                                  % 标准差大小  
window=double(uint8(3*sigma)*2+1);        % 窗口大小一半为3*sigma  
H=fspecial('gaussian', window, sigma);    % fspecial('gaussian', hsize, sigma)产生滤波模板   

Imagausf = openedImage;
LoopNum = 0;
while LoopNum < 9
    Imagausf = imfilter(Imagausf,H,'replicate');
    LoopNum = LoopNum + 1;
end
figure;imshow(Imagausmed), title('开运算后的二值图像');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 标记连通域
[labeledImage,coiNum] = bwlabel(~Imagausf, 4);

Imafil1 = [-1, -1, -1; 2, 2, 2; -1 -1 -1];
Imafil2 = [-1, -1, 2; -1, 2, -1; 2, -1, -1];
Imafil3 = [-1, 2, -1; -1, 2, -1;-1, 2, -1];
Imafil4 = [2, -1, -1; -1, 2, -1; -1, -1, 2];

Imagf1 = imfilter(labeledImage, Imafil1);
Imagf2 = imfilter(labeledImage, Imafil2);
Imagf3 = imfilter(labeledImage, Imafil3);
Imagf4 = imfilter(labeledImage, Imafil4);
Imagf = Imagf1+Imagf2+Imagf3+Imagf4; 
figure;imshow(Imagf);

% 显示标记结果
figure;imshow(label2rgb(labeledImage));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 霍夫圆检测
[centers, radii] = imfindcircles(Imagf, [10 1000]);

% 绘制检测到的圆
figure;imshow(ImaSrc);
viscircles(centers, radii, 'EdgeColor', 'r');

