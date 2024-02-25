function s_obj=addpara(s_intrinsic_obj,parasitics)
%初始化寄生参数
Rg=parasitics(1);
Rd=parasitics(2);
Rs=parasitics(3);
Lg=parasitics(4);
Ld=parasitics(5);
Ls=parasitics(6);
Cpg=parasitics(7);
Cpd=parasitics(8);

%初始化整体参数
spar=s_intrinsic_obj.Parameters;
freq=s_intrinsic_obj.Frequencies;
m=length(freq);
omega=2*pi*freq;

%利用z参数加入寄生电阻参数
zpar=s2z(spar);
z1=zeros(2,2,m);
z1=zeros(2,2,m);
z1(1,1,:)=Rg+Rs;
z1(1,2,:)=Rs;
z1(2,1,:)=Rs;
z1(2,2,:)=Rd+Rs;
zadd=zpar+z1;

%利用y参数加入寄生电容系数
ypar=z2y(zadd);
y1=zeros(2,2,m);
y1(1,1,:)=1j*omega*(Cpg);
y1(1,2,:)=0;
y1(2,1,:)=0;
y1(2,2,:)=1j*omega*(Cpd);
yadd=ypar+y1;

%利用z参数加入寄生电感参数
zpar_1=y2z(yadd);
z2=zeros(2,2,m);
z2(1,1,:)=1j*omega*(Lg+Ls);
z2(1,2,:)=1j*omega*(Ls);
z2(2,1,:)=1j*omega*(Ls);
z2(2,2,:)=1j*omega*(Ld+Ls);
zadd_1=zpar_1+z2;

%将z参数转换为s参数
spar_0=z2s(zadd_1);
s_obj=sparameters(spar_0,freq);















