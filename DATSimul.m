
function R=DATSimul(nAg,kAg,d1,kV2,d2,LAMBDA,nb,nBL,kBL,tBL)

TStart=60;
TStop=70;
N = 2000;

pi=acos(-1);
lambda = LAMBDA*1e-9;
R.Type = 'simulated data';
Step = (TStop-TStart)/N;


%        n          k        t
    V1 =    [1.5174     0.0000,       0      ];  %Verre
if LAMBDA == 633
Ag =    [nAg,      kAg,    d1*1e-9  ];  %Ag, officialy n = 0.135, k = 3.988. @633, n = 0.127, k = 3.298. @545
V2 =    [1.4571,    kV2,  d2*1e-9 ];  %Verre
Eau =   [nb,      0.,  0      ]; %Eau
end

if LAMBDA == 545
Ag =    [nA,      kAg,    d1*1e-9  ];  %Ag, officialy  n = 0.127, k = 3.298. @545
V2 =    [1.459,    kV2,  d2*1e-9 ];  %Verre
Eau =   [nb,      0,  0      ]; %Eau
end


Blm =   [nBL,     kBL,   tBL*1e-9   ];  %BLM
Eau =   [nb,      0,  0      ]; %Eau

K =     [V1;Ag;V2;Blm;Eau];
Nl = length(K);
E = zeros(1,Nl);


for Ki=1:Nl
    Er = K(Ki,1)^2 - K(Ki,2)^2;
    Ei = 2*K(Ki,1)*K(Ki,2);
    E(Ki) = complex(Er,Ei);
end

% Début de la procédure
 Text = zeros(1,N);
 Thetas = zeros(1,N);
 Beta = zeros(1,N-2);
  Q = zeros(1,N-2);
for Kt=1:N
    Text(1,Kt) =(TStart + Kt*Step);
    Trad = Text(Kt)*pi/180;
    Thetas(1,Kt) = Trad;
    %PrismAngle = pi/3;
    %T = PrismAngle + asin( sin(Trad - PrismAngle ) / K(1,1));
    T = Trad;
    q1 = sqrt ( E(1) - (K(1,1)*sin(T))^2) / E( 1);
    qn = sqrt (E(Nl) - (K(1,1)*sin(T))^2) / E(Nl);
    
    M = [1,0;0,1];
    
    for Kj=2:(Nl-1)
        KKj = Kj - 1;
        Beta(KKj) =  sqrt( E(Kj) -  (K(1,1)*sin(T))^2 ) * pi*2*K(Kj,3)/lambda;
        Q(KKj) =     sqrt( E(Kj) -  (K(1,1)*sin(T))^2 ) / E(Kj);
    
        MTransfer(1,1) = cos (Beta(KKj));
        MTransfer(1,2) =- i * sin (Beta(KKj)) / Q(KKj);
        MTransfer(2,1) =- i * sin (Beta(KKj)) * Q(KKj);
        MTransfer(2,2) = cos (Beta(KKj));

        M = M * MTransfer;
        
    end
    
    
    Rnom =      (M(1,1)+ M(1,2)*qn)*q1  -  (M(2,1)+M(2,2)*qn);
    Rdenom =    (M(1,1)+ M(1,2)*qn)*q1  +  (M(2,1)+M(2,2)*qn);
    

    R.reflec(Kt) = abs(Rnom / Rdenom)^2; 
    R.angle(Kt) = Text(1,Kt);

end
R.lambda = lambda;
R.Step = Step;
R.Start=TStart;
R.Stop= TStop;
[a,b] = min(R.reflec);
    R.MinPeakAngle = b*R.Step + R.Start;
    R.MinPeakValue = a;
    [a,b] = max(R.reflec(1:N/4));
    R.MaxPeakAngle = b*R.Step + R.Start;
    R.MaxPeakValue = a;
    R.N = N;
R.Width = (R.MinPeakValue+R.MaxPeakValue)/2;
            R.Left=0;
            R.Right=0;
    for k=1:N-1
        if (R.reflec(k)>R.Width && R.reflec(k+1)<R.Width)
            R.Left=R.angle(k);
        end;
        if (R.reflec(k)<R.Width && R.reflec(k+1)>R.Width)
            R.Right=R.angle(k);
        end;
    end
    R.Width = R.Right - R.Left;

    R.Mean= mean(R.reflec(6700/5:6900/5));

