function Results = DATFit(REF,CentralValue,Bilayer,Etape)
%CentralValue = [0.2000    3.9880   52.4700    0.001423  452.58  633.0000    1.334613];
%Bilayer = [1.4   0.01   6]
Uncertainty = 0.1/Etape;
N = Etape;
Points = 5;
SS = zeros(3,length(Bilayer));
for CV = 1:length(Bilayer)
    SS(1,CV) = Bilayer(CV)*(1-Uncertainty);
    SS(2,CV) = Bilayer(CV)*(1+Uncertainty);
    SS(3,CV) = (SS(2,CV)-SS(1,CV))/Points;
end
Results = zeros(Points,10);
tic;
ID = 0;
% NAG, D1, KAG, D2, NB

%f=statusbar('DATSearch');



        for L1=0:Points
            nBil = SS(1,1)+L1*SS(3,1);
            for L2=0:Points
                kBil = SS(1,2)+L2*SS(3,2);
                for L3=0:Points
                    ID = ID+1;
                    tBil = SS(1,3)+L3*SS(3,3);
                    a = DATSimul(CentralValue(1),CentralValue(2),CentralValue(3),CentralValue(4),CentralValue(5),CentralValue(6),CentralValue(7),nBil,kBil,tBil);
                    MaxPeakAngle = abs(a.MaxPeakAngle-REF.MaxPeakAngle)/REF.MaxPeakAngle;
                    MaxPeakValue = abs(a.MaxPeakValue-REF.MaxPeakValue)/REF.MaxPeakValue;
                    Width = abs(a.Width-REF.Width)/REF.Width;
                    MinPeakAngle = abs(a.MinPeakAngle-REF.MinPeakAngle)/REF.MinPeakAngle;
                    MinPeakValue = abs(a.MinPeakValue-REF.MinPeakValue)/REF.MinPeakValue;
                    Mean = abs(a.Mean-REF.Mean)/REF.Mean;
                    %f=statusbar(((L1+1)*(L2+1)*(L3+1))/((Points+1)^3),f);
                    Error = 80*MinPeakValue+20*REF.MinPeakAngle*MinPeakAngle+5*Width;
                    Results(ID,:) = [Error,nBil,kBil,tBil,MaxPeakAngle,MaxPeakValue,Width,MinPeakAngle,MinPeakValue,Mean];
                end
            end
        end

s = sortrows(Results,1);

NMean = 3;

pp = zeros(NMean,3);
for Ser=1:NMean
pp(Ser,:) = [s(Ser,2) s(Ser,3) s(Ser,4)];
end
Results = mean(pp,1);



%delete(statusbar)
toc
%87,43 pour 3 points, laptop @home