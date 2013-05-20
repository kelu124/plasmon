function Graph=DATPlot(DATASET)
plot(DATASET.angle,DATASET.reflec)
XLABEL('Angle');
YLABEL('Reflectivity coefficient');
text(67,0.7,DATASET.Type)