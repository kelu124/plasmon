function Results = DATCoeff(REF)
N = 7;
BEGINNING = [0.19800    3.9880   50    0.0015  450  633.0000    1.33];
ERPIdx = zeros(N,length(BEGINNING));

ERPIdx(1,:) = DATSearch(REF,BEGINNING,1);

for i=2:N
ERPIdx(i,:) = DATSearch(REF,ERPIdx(i-1,:),i);
end

Results = ERPIdx;