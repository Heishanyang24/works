function intrinsics=extractintrin(s_intrinsic_obj)
spar=s_intrinsic_obj.Parameters;
freq=s_intrinsic_obj.Frequencies;
omega=2*pi*freq;
ypar=s2y(spar);
m=length(freq);

% ��ʼ��֧·y����
YGS=zeros(m,1);
YGD=zeros(m,1);
YDS=zeros(m,1);
YGM=zeros(m,1);

% ����֧·y����
YGS(:,1)=ypar(1,1,:)+ypar(1,2,:);
YGD(:,1)=-ypar(1,2,:);
YGM(:,1)=ypar(2,1,:)-ypar(1,2,:);
YDS(:,1)=ypar(2,2,:)+ypar(1,2,:);

% ��ϼ���Cgs, ���ݴ�С��fF��
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

% ��ϼ���Cgd, ���ݴ�С��fF��
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

% ��ϼ���Cds, ���ݴ�С��fF��
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

% ��ϼ���Ri
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

% ��ϼ���Rj
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

% ��ֵ����Rds
ydata=1./real(YDS);
Rds=mean(ydata);

% ��ֵ����gm
ydata=abs(YGM.*(1+1j*omega*Cgs*Ri));
gm=mean(ydata);

% ��ϼ���tau
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
