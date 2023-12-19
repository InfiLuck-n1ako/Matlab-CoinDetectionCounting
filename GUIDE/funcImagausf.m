function results = funcImagausf(openedImage)
    % 二值化图像（可以使用适当的阈值或其他方法）
    sigma=8;                                  % 标准差大小  
    window=double(uint8(3*sigma)*2+1);        % 窗口大小一半为3*sigma  
    H=fspecial('gaussian', window, sigma);    % fspecial('gaussian', hsize, sigma)产生滤波模板   
    
    Imagausf = openedImage;
    LoopNum = 0;
    while LoopNum < 5
        Imagausf = imfilter(Imagausf,H,'replicate');
        LoopNum = LoopNum + 1;
    end
    
    results = Imagausf;
end