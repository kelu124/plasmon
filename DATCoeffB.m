function Results = DATCoeffB(REF,Indices)
N = 4;
BEGINNING = [1.4   0.16   6];
BRPIdx = zeros(N,length(BEGINNING));

BRPIdx(1,:) = DATFit(REF,Indices,BEGINNING,1);

for i=2:N
BRPIdx(i,:) = DATFit(REF,Indices,BRPIdx(i-1,:),i);
end

Results = BRPIdx;