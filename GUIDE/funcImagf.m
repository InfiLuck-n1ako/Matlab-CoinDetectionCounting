function results = funcImagf(Imagray)
    Imadb = im2double(Imagray);
    [Imagf, ~] = edge(Imadb,'roberts', 16/255);
    results = Imagf;
end