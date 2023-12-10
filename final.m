%p3150127 Anna Noukou
%p3150062 Vasileios Karampelas

I=imread('Image\coin.jpg');
%I=imresize(I, 0.5);

%Make it gray
I=rgb2gray(I);

%Apply gauss to reduce noise 
gaussianFilter = fspecial('gaussian', [10 10], 2);
img = imfilter(I, gaussianFilter,'replicate');

%Edge enhancement
img = edge(img, 'Sobel');

imshow(img);

%disp('Please wait while we are processing the image');
%disp('...');

%Find Circles (Use Hough Transform)
[centers, radii] = find_circles(img, [260, 350]);

%Remove overlapped circles
[centersNew,radiiNew] = RemoveOverLap(centers,radii,100,1);

%Draw
hough_circles_draw(I, centersNew, radiiNew);


%Total coins calculation
sumOf2s=0;
sumOf1s=0;
sumOf50s=0;
sumOf10s=0;

for i = 1 : size(radiiNew)     
        if(radiiNew(i) > 50.6)
          sumOf2s=sumOf2s+1 ;
        elseif(radiiNew(i) > 46.30)
          sumOf50s=sumOf50s+1;
        elseif(radiiNew(i) > 42.35)
          sumOf1s=sumOf1s+1;
        else
          sumOf10s=sumOf10s+1;
        end          
end

fprintf('The number of 2 euro is %d\n', sumOf2s );
fprintf('The number of 1 euro is %d\n', sumOf1s );
fprintf('The number of 50 cent is %d\n', sumOf50s );
fprintf('The number of 10 cent is %d\n', sumOf10s );
