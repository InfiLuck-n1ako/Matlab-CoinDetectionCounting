ImaSrc = imread('Image\110-125.jpg');
Imagray = rgb2gray(ImaSrc);
Imadb = im2double(Imagray);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

figure;imshow(ImaSrc);
% subplot(142), imshow(Imagf);
figure;imshow(Imaim2bw);

% 二值化图像（可以使用适当的阈值或其他方法）
binaryImage = imbinarize(Imagray);

% 定义开运算的结构元素
se = strel('disk',32);  % 这里使用了一个半径为5的圆形结构元素，你可以根据需要调整大小

% 应用开运算
openedImage = imopen(binaryImage, se);

sigma=8;                                  % 标准差大小  
window=double(uint8(3*sigma)*2+1);        % 窗口大小一半为3*sigma  
H=fspecial('gaussian', window, sigma);    % fspecial('gaussian', hsize, sigma)产生滤波模板   

Imagausf = openedImage;
LoopNum = 0;
while LoopNum < 5
    Imagausf = imfilter(Imagausf,H,'replicate');
    LoopNum = LoopNum + 1;
end
figure;imshow(Imagausf), title('开运算后的二值图像');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 标记连通域
[labeledImage,coiNum] = bwlabel(~Imagausf, 4);
% 显示标记结果
figure;imshow(label2rgb(labeledImage));

% 边缘检测
[Imagf, thresh] = edge(Imadb,'roberts', 16/255);
figure;imshow(Imagf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Find Circles (Use Hough Transform)
[centers, radii] = find_circles(Imagf, [110, 125]);

%Remove overlapped circles
[centersNew,radiiNew] = RemoveOverLap(centers,radii,125,1);

%MatA = [centersNew,radiiNew];
%Draw
% hough_circles_draw(ImaSrc, centersNew, radiiNew);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %Find Circles (Use Hough Transform)
% [centers, radii] = find_circles(Imagf, [120, 130]);
% 
% %Remove overlapped circles
% [centersNew,radiiNew] = RemoveOverLap(centers,radii,100,1);

%disp(MatA);
%Draw
hough_circles_draw(ImaSrc, centersNew, radiiNew);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Total coins calculation
sumOf50s=0;
sumOf10s=0;

for i = 1 : size(radiiNew)     
        if(radiiNew(i) > 118)
          sumOf50s=sumOf50s+1;
        else
          sumOf10s=sumOf10s+1;
        end          
end
fprintf('The number of 50 cent is %d\n', sumOf50s );
fprintf('The number of 10 cent is %d\n', sumOf10s );
