function H = hough_circles_acc(img, radius)
    % Compute Hough accumulator array for finding circles.
    %
    % img: image containing edge pixels
    % radius: Radius of circles to look for, in pixels   
    H = zeros(size(img));
    for x = 1 : size(img, 2)
        for y = 1 : size(img, 1)
            if (img(y,x))
                for theta = linspace(0, 2 * pi, 360)
                    a = round(x + radius * cos(theta));                
                    b = round(y + radius * sin(theta));
                    if (a > 0 && a <= size(H, 2) && b > 0 && b <= size(H,1))
                        H(b,a) = H(b,a) + 1;
                    end
                end
            end
        end
    end
end