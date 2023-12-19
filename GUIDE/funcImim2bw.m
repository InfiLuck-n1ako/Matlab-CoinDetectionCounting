function results = funcImim2bw(Imagray)
    Imadb = im2double(Imagray);
            
    T0 = 0.01;
    T1 = (min(Imadb(:)) + max(Imadb(:)))/2;
    r1 = Imadb > T1;
    r2 = Imadb <= T1;
    T2 = (mean(Imadb(r1)) + mean(Imadb(r2)))/2;
    while abs(T2 -T1) < T0
        T1 = T2;
        r1 = Imadb > T1;
        r2 = Imadb <= T1;
        T2 = (mean(Imadb(r1)) + mean(Imadb(r2)))/2;
    end
    
    Imaim2bw = imbinarize(Imadb, T2);

    results = Imaim2bw;
end