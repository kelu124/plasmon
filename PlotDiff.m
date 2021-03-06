function Results = PlotDiff(REF)
d = 10;
NS = 455;NF = 459;
Step = (NF - NS)/d;
tic;
for L=1:d
    VAR = NS+L*Step;
    a = DATSimul(0.2,3.988,52,0.0015,VAR,633,1.3345,1.5,0.055,0);
    Results.Value(L) = VAR;
    Results.MaxPeakAngle(L) = abs(a.MaxPeakAngle-REF.MaxPeakAngle)/REF.MaxPeakAngle;
    Results.MaxPeakValue(L) = abs(a.MaxPeakValue-REF.MaxPeakValue)/REF.MaxPeakValue;
    Results.Width(L) = abs(a.Width-REF.Width);
    Results.MinPeakAngle(L) = abs((a.MinPeakAngle-REF.MinPeakAngle)/REF.MinPeakAngle);
    Results.MinPeakValue(L) = abs(a.MinPeakValue-REF.MinPeakValue)/REF.MinPeakValue;
    Results.Mean(L) = abs(a.Mean-REF.Mean)/REF.Mean;
    Results.Error(L) = Results.Mean(L)+Results.MinPeakValue(L) +Results.MinPeakAngle(L)+Results.Width(L)+Results.MaxPeakValue(L)+Results.MaxPeakAngle(L) ;
end
toc
figure;
subplot(3,2,1);
title ('maxpeakangle');
plot(Results.Value,Results.MaxPeakAngle);
subplot(3,2,2);
title ('maxpeakvalue');
plot(Results.Value,Results.MaxPeakValue);
subplot(3,2,3);
title ('minpeakangle');
plot(Results.Value,Results.MinPeakAngle);
subplot(3,2,4);
title ('minpeakvalue');
plot(Results.Value,Results.MinPeakValue);
subplot(3,2,5);
title ('width');
plot(Results.Value,Results.Width);
subplot(3,2,6);
title ('mean');
plot(Results.Value,Results.Mean);
figure;
plot(Results.Value,Results.Error);
