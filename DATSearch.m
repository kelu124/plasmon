function Results = DATSearch(REF,CentralValue,Etape)
%CentralValue = [0.18800    3.9880   50    0.0015  450  633.0000    1.33];
Uncertainty = 0.1/Etape;
Points = 5;
SS = zeros(3,length(CentralValue));
for CV = 1:length(CentralValue)
    SS(1,CV) = CentralValue(CV)*(1-Uncertainty);
    SS(2,CV) = CentralValue(CV)*(1+Uncertainty);
    SS(3,CV) = (SS(2,CV)-SS(1,CV))/Points;
    if Etape > 3
        if CV == 5
            SS(1,5) = (CentralValue(5)-400)*(1-Uncertainty)+400;
            SS(2,5)= (CentralValue(5)-400)*(1+Uncertainty)+400;
            SS(3,5) = (SS(2,5)-SS(1,5))/Points;
        end
    end
end
Results = zeros(Points,12);
tic;
ID = 0;
% NAG, D1, KAG, D2, NB

%f=statusbar('DATSearch');

N = 100;
    Start =CentralValue(7)*(1-Uncertainty/5);
    End = CentralValue(7)*(1+Uncertainty/5);
    Step = (End-Start)/N;
    Err = zeros(1,N+1);
for L=0:N
NB = Start + L*Step;
a = DATSimul(CentralValue(1),CentralValue(2),CentralValue(3),CentralValue(4),CentralValue(5),CentralValue(6),NB,1.5,0.055,0);
MaxPeakAngle = abs(a.MaxPeakAngle-REF.MaxPeakAngle);
Err(L+1) = MaxPeakAngle;
end
[a,b] = min(Err);
NB = Start + b*Step;



for L5=0:0
    % NB variant?
    for L4=0:Points
        D1 = SS(1,3)+L4*SS(3,3);
        for L3=0:Points
            KV2 = SS(1,4)+L3*SS(3,4);
            for L2=0:Points
                D2 = SS(1,5)+L2*SS(3,5);
                for L=0:0
                    ID = ID+1;
                    NAG = CentralValue(1);
                    a = DATSimul(NAG,3.988,D1,KV2,D2,633,NB,1.5,0.055,0);
                    MaxPeakAngle = abs(a.MaxPeakAngle-REF.MaxPeakAngle)/REF.MaxPeakAngle;
                    MaxPeakValue = abs(a.MaxPeakValue-REF.MaxPeakValue)/REF.MaxPeakValue;
                    Width = abs(a.Width-REF.Width)/REF.Width;
                    MinPeakAngle = abs(a.MinPeakAngle-REF.MinPeakAngle)/REF.MinPeakAngle;
                    MinPeakValue = abs(a.MinPeakValue-REF.MinPeakValue)/REF.MinPeakValue;
                    Mean = abs(a.Mean-REF.Mean)/REF.Mean;
                   % f=statusbar(((L+1)*(L2+1)*(L3+1)*(L4+1)*(L5+1))/((Points+1)^3),f);
                    Error = 14*MinPeakValue+6*REF.MinPeakAngle*MinPeakAngle+Width;
                    Results(ID,:) = [Error,NAG,D1,KV2,D2,NB,MaxPeakAngle,MaxPeakValue,Width,MinPeakAngle,MinPeakValue,Mean];
                end
            end
        end
    end
end
s = sortrows(Results,1);

pp = zeros(3,7);
for Ser=1:3
pp(Ser,:) = [s(Ser,2) CentralValue(2) s(Ser,3) s(Ser,4) s(Ser,5) CentralValue(6) NB];
end
Results = mean(pp,1);

%delete(statusbar)
toc
%87,43 pour 3 points, laptop @home