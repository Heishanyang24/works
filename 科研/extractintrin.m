function intrinsics=extractintrin(s_intrinsic_obj)
spar=s_intrinsic_obj.Parameters;
freq=s_intrinsic_obj.Frequencies;
omega=2*pi*freq;
ypar=s2y(spar);
m=length(freq);

% 初始化支路y参数
YGS=zeros(m,1);
YGD=zeros(m,1);
YDS=zeros(m,1);
YGM=zeros(m,1);

% 计算支路y参数
YGS(:,1)=ypar(1,1,:)+ypar(1,2,:);
YGD(:,1)=-ypar(1,2,:);
YGM(:,1)=ypar(2,1,:)-ypar(1,2,:);
YDS(:,1)=ypar(2,2,:)+ypar(1,2,:);

% 拟合计算Cgs, 电容大小在fF级
fitrange=200;
ydata_fullrange=imag(YGS)*1e15;
xdata_fullrange=omega;
ydata=ydata_fullrange(1:fitrange);
xdata=xdata_fullrange(1:fitrange);
ft = fittype( 'a*x', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display= 'Off';
opts.Lower= 0;
opts.Upper= 100;
opts.StartPoint= 20;
opts.Robust= 'LAR';
fitresult=fit(xdata,ydata,ft,opts);
Cgs=fitresult.a/1e15;

% 拟合计算Cgd, 电容大小在fF级
fitrange=200;
ydata_fullrange=imag(YGD)*1e15;
xdata_fullrange=omega;
ydata=ydata_fullrange(1:fitrange);
xdata=xdata_fullrange(1:fitrange);
ft = fittype( 'a*x', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display= 'Off';
opts.Lower= 0;
opts.Upper= 100;
opts.StartPoint= 20;
opts.Robust= 'LAR';
fitresult=fit(xdata,ydata,ft,opts);
Cgd=fitresult.a/1e15;

% 拟合计算Cds, 电容大小在fF级
ydata=imag(YDS)*1e15;
xdata=omega;
ft = fittype( 'a*x', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display= 'Off';
opts.Lower= 0;
opts.Upper= 100;
opts.StartPoint= 20;
opts.Robust= 'LAR';
fitresult=fit(xdata,ydata,ft,opts);
Cds=fitresult.a/1e15;

% 拟合计算Ri
ydata=real(YGS)./(Cgs.^2);
ft = fittype( 'a*x^2', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display= 'Off';
opts.Lower= 0;
opts.Upper= 10;
opts.StartPoint= 1;
opts.Robust= 'LAR';
fitresult=fit(xdata,ydata,ft,opts);
Ri=fitresult.a;

% 拟合计算Rj
ydata=real(YGD)./(Cgd.^2);
ft = fittype( 'a*x^2', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display= 'Off';
opts.Lower= 0;
opts.Upper= 10;
opts.StartPoint= 1;
opts.Robust= 'LAR';
fitresult=fit(xdata,ydata,ft,opts);
Rj=fitresult.a;

% 均值计算Rds
ydata=1./real(YDS);
Rds=mean(ydata);

% 均值计算gm
ydata=abs(YGM.*(1+1j*omega*Cgs*Ri));
gm=mean(ydata);

% 拟合计算tau
ydata=-angle(YGM.*(1+1j*omega*Cgs*Ri))*1e12;
xdata=omega;
ft = fittype( 'a*x', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = 0;
opts.Upper = 100;
opts.StartPoint = 1;
opts.Robust = 'LAR';
fitresult=fit(xdata,ydata,ft,opts);
tau=fitresult.a/1e12;

intrinsics=[Cgs;Cgd;Cds;Ri;Rj;Rds;gm;tau];
