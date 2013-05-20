function Results = ReCreate(DATA,BRP)


d1 = DATA(3);
d2 = DATA(5);
nAg = DATA(1);
kAg = DATA(2);
kV2 =DATA(4);

nb= DATA(7); 
%nb= 1.3334; pour le vert ?
% BPRS = DATSimul(d1,d2,633,nb,1.43,0.055,0);
 BRPS = DATSimul(nAg,kAg,d1,kV2,d2,633,nb,1.5425,0.1638,0);
% BPGS = DATSimul(d1,d2,545,nb,1.49,0.01,8.2);
% 
% 
% subplot(2,1,1)
% plot(BPRS.angle,BPRS.reflec,'g',BPR.angle,BPR.reflec,'r');
% XLABEL('Angle');
% YLABEL('Reflectivity coefficient');
% 
%subplot(2,1,2)
plot(BRPS.angle,BRPS.reflec,'g',BRP.angle,BRP.reflec,'r');
 XLABEL('Angle');
 YLABEL('Reflectivity coefficient');
% figure
% 
% BPGS = DATSimul(d1,d2,545,nb,1.43,0.055,0);
% plot(BPGS.angle,BPGS.reflec,'g',BPG.angle,BPG.reflec,'r');
% XLABEL('Angle');
% YLABEL('Reflectivity coefficient');
