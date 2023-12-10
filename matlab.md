```matlab
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
figure;imshow(Imagausf), title('开运算后的二值图像');

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

```

```matlab
img=imread('5.4元.jpg');
imgGray=rgb2gray(img);
figure;
imshow(imgGray);
level=graythresh(imgGray);
imBW=imbinarize(imgGray,level);%二值化
figure;
imshow(imBW);
se=strel('disk',6);
imBW = imopen(imBW,se); %开运算

figure('NumberTitle', 'off', 'Name', '二值图像');
imshow(imBW);
outImg=uint8(imBW);
label=1;        %标记
flag=0;         %看是上下左右哪一个
num=0;          %用于计算连通域的个数
[Height,Width]=size(imBW); 
arr = [];%模拟堆栈
for m = 2:(Height-1)
    for n = 2:(Width-1)
        x=m;
        y=n;
        if(outImg(x,y)==0)   
            label=label+1;
            arr(end+1)=x;%记录坐标
            arr(end+1)=y;
            num=num+1;
            while(~isempty(arr))                   
                x=arr(end-1);
                y=arr(end);
                arr(end)=[];
                arr(end)=[];
                outImg(x,y)=label;
                if(outImg(x,y-1)==0)
                    arr(end+1)=x;%记录坐标
                    arr(end+1)=y-1;
%                     flag=1;%左
                end
                
                if(outImg(x,y+1)==0)
                    arr(end+1)=x;%记录坐标
                    arr(end+1)=y+1;
%                     flag=2;%右
                end
                
                if(outImg(x+1,y)==0)
                    arr(end+1)=x+1;%记录坐标
                    arr(end+1)=y;
%                     flag=3;%下
                end
                
                if(outImg(x-1,y)==0)
                    arr(end+1)=x-1;%记录坐标
                    arr(end+1)=y;
%                     flag=4;%上
                end
                
            end
        end
    end
end


figure('NumberTitle', 'off', 'Name', 'outImg');
imshow(outImg);


%%着色
R=img(:,:,1); %red
G=img(:,:,2); %green
B=img(:,:,3); %blue
for m=2:label   
    [O,P]=find(outImg==m);
    for q=1:size(O,1)
        R(O(q),P(q))=255;
        G(O(q),P(q))=0;
        B(O(q),P(q))=0;
    end
end

img(:,:,1)=R; %red
img(:,:,2)=G; %green
img(:,:,3)=B; %blue
figure('NumberTitle', 'off', 'Name', 'RGB');
imshow(img);

```

```matlab
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Imagaus = imnoise(Imagf,'gaussian',0.08);       % 加入高斯躁声 
% %Imasalt = imnoise(Imagf,'salt & pepper',0.02);  %加入椒盐躁声
% Imagausmed = medfilt2(Imagf);                         % 对高斯躁声中值滤波
% Imasaltmed = medfilt2(Imagf);                         % 对椒盐躁声中值滤波
% 
% Amf=[1 1 1                                  % 对高斯躁声的算术均值滤波
%    1 1 1
%    1 1 1];
% Avg=1/9*Amf;      
% 
% Imagausconv = conv2(double(Imagf),double(Avg));                        
% 
% Imasaltconv = conv2(double(Imagf),double(Avg));          % 对椒盐躁声的算术均值滤波           
% 
% sigma=8;                                  % 标准差大小  
% window=double(uint8(3*sigma)*2+1);        % 窗口大小一半为3*sigma  
% H=fspecial('gaussian', window, sigma);    % fspecial('gaussian', hsize, sigma)产生滤波模板   
% Img_gauss=imfilter(Imagf,H,'replicate');     % 为了不出现黑边，使用参数'replicate'（输入图像的外部边界通过复制内部边界的值来扩展）  
% %title('(9)对高斯噪声的高斯滤波');
% 
% Img_salt=imfilter(Imagf,H,'replicate'); 
% %title('(10)对椒盐噪声的高斯滤波');
% 
% subplot(154), imshow(Img_gauss);
% subplot(155), imshow(Img_salt);
```

```matlab

% 定义霍夫变换参数范围
rMin = 20;
rMax = 100;
stepSize = 1;
radii = rMin:stepSize:rMax;
centers = [size(gray, 1)/2, size(gray, 2)/2]; % 假设圆心在图像中心

% 霍夫变换
houghSpace = zeros(size(gray, 1), size(gray, 2), length(radii));
for r = 1:length(radii)
    radius = radii(r);
    for x = 1:size(gray, 2)
        for y = 1:size(gray, 1)
            if edgeImg(y, x) == 1
                for t = 0:pi/50:2*pi
                    a = round(x - radius*cos(t));
                    b = round(y - radius*sin(t));
                    if a >= 1 &amp;&amp; a <= size(gray, 2) &amp;&amp; b >= 1 &amp;&amp; b <= size(gray, 1)
                        houghSpace(b, a, r) = houghSpace(b, a, r) + 1;
                    end
                end
            end
        end
    end
end

% 寻找霍夫空间中的峰值
numCircles = coiNum; % 假设需要找到3个圆
centers = zeros(numCircles, 2);
radii = zeros(numCircles, 1);
for i = 1:numCircles
    [maxValue, maxIndex] = max(houghSpace(:));
    [y, x, r] = ind2sub(size(houghSpace), maxIndex);
    centers(i, :) = [x, y];
    radii(i) = radii(r);
    houghSpace(y, x, r) = 0; % 将已经找到的峰值清零
end

% 在原始图像中绘制圆
figure, imshow(img);
hold on;
for i = 1:numCircles
    viscircles(centers(i, :), radii(i), 'EdgeColor', 'r');
end
hold off;
```

```matlab
function[circlefind]=findcircle(img,minr,maxr,stepr,stepa,percent)
r=round((maxr-minr)/stepr)+1;%可增长的步长个数
angle=round(2*pi/stepa);
[m,n]=size(img);
houghspace=zeros(m,n,r);%霍夫空间
[m1,n1]=find(img);%返回二值化边缘检测图像Img中非零点的坐标，m1存放横坐标，n1存放纵坐标
num=size(m1,1);%非零点个数
%霍夫空间，统计相同圆 点的个数
%a = x-r*cos(angle), b = y-r*sin(angle)
for i=1:num
    for j=1:r
        for k=1:angle
            a=round(m1(i)-(minr+(j-1)*stepr)*cos(k*stepa));
            b=round(n1(i)-(minr+(j-1)*stepr)*sin(k*stepa));
            if(a>0&&a<=m&&b>0&&b<=n)
                houghspace(a,b,j)=houghspace(a,b,j)+1;
            end
        end
    end
end
%以阈值来检测圆
par=max(max(max(houghspace)));%找出个数最多的圆的数量作为阈值
par2=par*percent;%百分比percent阈值调整
[m2,n2,r2]=size(houghspace);
circlefind=[];%存储大于阈值的圆的圆心坐标及半径
for i=1:m2
    for j=1:n2
        for k=1:r2
            if (houghspace(i,j,k)>=par2)
                a=[i,j,minr+k*stepr];
                circlefind=[circlefind;a];
            end
        end
    end
end
end
```

```matlab
% 读取图像并转换为灰度图像
img = imread('circle.jpg');
gray = rgb2gray(img);

% 边缘检测
edgeImg = edge(gray, 'canny');

% 定义霍夫变换参数范围
rMin = 20;
rMax = 100;
stepSize = 1;
radii = rMin:stepSize:rMax;
centers = [size(gray, 1)/2, size(gray, 2)/2]; % 假设圆心在图像中心

% 霍夫变换
houghSpace = zeros(size(gray, 1), size(gray, 2), length(radii));
for r = 1:length(radii)
    radius = radii(r);
    for x = 1:size(gray, 2)
        for y = 1:size(gray, 1)
            if edgeImg(y, x) == 1
                for t = 0:pi/50:2*pi
                    a = round(x - radius*cos(t));
                    b = round(y - radius*sin(t));
                    if a >= 1 &amp;&amp; a <= size(gray, 2) &amp;&amp; b >= 1 &amp;&amp; b <= size(gray, 1)
                        houghSpace(b, a, r) = houghSpace(b, a, r) + 1;
                    end
                end
            end
        end
    end
end

% 寻找霍夫空间中的峰值
numCircles = 3; % 假设需要找到3个圆
centers = zeros(numCircles, 2);
radii = zeros(numCircles, 1);
for i = 1:numCircles
    [maxValue, maxIndex] = max(houghSpace(:));
    [y, x, r] = ind2sub(size(houghSpace), maxIndex);
    centers(i, :) = [x, y];
    radii(i) = radii(r);
    houghSpace(y, x, r) = 0; % 将已经找到的峰值清零
end

% 在原始图像中绘制圆
figure, imshow(img);
hold on;
for i = 1:numCircles
    viscircles(centers(i, :), radii(i), 'EdgeColor', 'r');
end
hold off;
```

