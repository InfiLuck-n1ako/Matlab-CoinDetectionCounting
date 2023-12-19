function results = funcImopen(Imagray)
    binaryImage = imbinarize(Imagray);
    
    % 定义开运算的结构元素
    se = strel('disk',32);  % 这里使用了一个半径为5的圆形结构元素，你可以根据需要调整大小
    
    % 应用开运算
    openedImage = imopen(binaryImage, se);
    
    results = openedImage;
end