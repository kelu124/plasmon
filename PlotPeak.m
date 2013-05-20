function Results = PlotPeak(BPR,BPG)
d = 7;
D1 = 51.7;D1s=51.7;
D2 = 450;D2s=455;
Step1 = (D1s-D1)/d;
Step2 = (D1s-D1)/d;

for K=1:d
    for L=1:d
        a = DATSimul(D1+K*Step1,D2+L*Step2,545,1.3345,0,0,0);
        Results.PositionPeakGreen(K,L) = abs(a.MinPeakAngle-BPG.MinPeakAngle);
        Results.WidthGreen(K,L) = abs(a.Width-BPG.Width);
        a = DATSimul(D1+K*Step1,D2+L*Step2,633,1.3345,0,0,0);
        Results.PositionPeakRed(K,L) = abs(a.MinPeakAngle-BPR.MinPeakAngle);
        Results.WidthRed(K,L) = abs(a.Width-BPR.Width);
    end
end

surf(Results.PositionPeakRed);figure;surf(Results.WidthRed);


