function results = funcLabeledImage(Imagausf)
    [labeledImage,~] = bwlabel(~Imagausf, 8);

    results = labeledImage;
end