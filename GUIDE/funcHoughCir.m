function results = funcHoughCir(ImaSrc,Imagf)
    %Find Circles (Use Hough Transform)                     %%%%%%%%%%%%%%%%%%%%↓↓↓↓↓↓↓↓↓↓↓%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [centers, radii] = find_circles(Imagf, [110, 125]);     %%%%%%%%%%%%%%%%%%%%此处修改参数%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                            %%%%%%%%%%%%%%%%%%%%↑↑↑↑↑↑↑↑↑↑↑%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Remove overlapped circles
    [centersNew,radiiNew] = RemoveOverLap(centers,radii,125,1);
    
    % MatA = [centersNew,radiiNew];
    %Draw
    % hough_circles_draw(UIAxes, centersNew, radiiNew);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % %Find Circles (Use Hough Transform)
    % [centers, radii] = find_circles(Imagf, [120, 130]);
    % 
    % %Remove overlapped circles
    % [centersNew,radiiNew] = RemoveOverLap(centers,radii,100,1);
    % Draw

    hough_circles_draw(ImaSrc, centersNew, radiiNew);
    results = 0;
    end