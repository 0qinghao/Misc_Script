pn=[1.55
1.85
2.4
1.3
2.6
3.15
3.85
4.72
]-1;
ps=[1.1118268
1.258224814
1.36229075
1.102127322
1.401649111
1.489559337
1.565632398
1.655999873
]-1;

plot(pn,ps,'o')
xlabel('Pn')
ylabel('Ps')

modelFun1=@(p,x) log(x+p(2))./log(p(1)) + p(3);
startingVals1=[2 1 1];
modelFun2=@(p,x) p(1) ./ x + p(2) 
startingVals2=[-1 1];

nlModel1 = fitnlm(pn, ps, modelFun1, startingVals1)
nlModel2 = fitnlm(pn, ps, modelFun2, startingVals2)

xgrid = linspace(0,10,100)';
line(xgrid, predict(nlModel1,xgrid), 'Color', 'r');
line(xgrid, predict(nlModel2,xgrid), 'Color', 'g');
xlim([0 10])
ylim([0 10])