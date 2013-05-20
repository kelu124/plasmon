
function R=DATOpen(filename)

%% Calculer combien il y a de lignes

if findstr(filename, 'GREEN') > 0
    Data.lambda = 545e-9;
end
if findstr(filename, 'RED') > 0
    Data.lambda = 633e-9;
end

fid = fopen(filename, 'rt'); 
while feof(fid) == 0 
    tline = fgetl(fid); 
    matches = findstr(tline, '$NDATAPOINTS'); 
    num = length(matches); 
    if num > 0 
        [a,NLines] = strread(tline,'%s%d','delimiter',':');
    end 
end 
fclose(fid); 


%% 
fid = fopen(filename, 'rt'); 
while feof(fid) == 0 
    tline = fgetl(fid); 
    matches = findstr(tline, 'Raw_Reference'); 
    num = length(matches); 
    if num > 0 
        tline = fgetl(fid); 
        for i=1:NLines,
            a = strread(tline,'%f');
            Data.angle(i) = a(1);Data.reflec(i) = a(2);
            %Data(4,i) = a(4);Data(3,i) = a(3);
            tline = fgetl(fid); 
        end
    end 
end 
fclose(fid); 
R = Data;
[a,b] = min(R.reflec);
    R.MinPeakAngle = R.angle(b);
    R.MinPeakValue = a;
    [a,b] = max(R.reflec(1:3000));
    R.MaxPeakAngle = R.angle(b);
    R.MaxPeakValue = a;
    R.N = NLines;
    R.Width = (R.MinPeakValue+R.MaxPeakValue)/2;
                R.Left=0;
            R.Right=0;
    for k=1:NLines-1
        if (R.reflec(k)>R.Width && R.reflec(k+1)<R.Width)
            R.Left=R.angle(k);
        end;
        if (R.reflec(k)<R.Width && R.reflec(k+1)>R.Width)
            R.Right=R.angle(k);
        end;
    end
    R.Width = R.Right - R.Left;
    R.Type = 'imported data';
R.Mean = mean(R.reflec(6700:6900));
    
res = plot(Data.angle(:)',Data.reflec(:)');


