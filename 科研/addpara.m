function s_obj=addpara(s_intrinsic_obj,parasitics)
%��ʼ����������
Rg=parasitics(1);
Rd=parasitics(2);
Rs=parasitics(3);
Lg=parasitics(4);
Ld=parasitics(5);
Ls=parasitics(6);
Cpg=parasitics(7);
Cpd=parasitics(8);

%��ʼ���������
spar=s_intrinsic_obj.Parameters;
freq=s_intrinsic_obj.Frequencies;
m=length(freq);
omega=2*pi*freq;

%����z������������������
zpar=s2z(spar);
z1=zeros(2,2,m);
z1=zeros(2,2,m);
z1(1,1,:)=Rg+Rs;
z1(1,2,:)=Rs;
z1(2,1,:)=Rs;
z1(2,2,:)=Rd+Rs;
zadd=zpar+z1;

%����y���������������ϵ��
ypar=z2y(zadd);
y1=zeros(2,2,m);
y1(1,1,:)=1j*omega*(Cpg);
y1(1,2,:)=0;
y1(2,1,:)=0;
y1(2,2,:)=1j*omega*(Cpd);
yadd=ypar+y1;

%����z�������������в���
zpar_1=y2z(yadd);
z2=zeros(2,2,m);
z2(1,1,:)=1j*omega*(Lg+Ls);
z2(1,2,:)=1j*omega*(Ls);
z2(2,1,:)=1j*omega*(Ls);
z2(2,2,:)=1j*omega*(Ld+Ls);
zadd_1=zpar_1+z2;

%��z����ת��Ϊs����
spar_0=z2s(zadd_1);
s_obj=sparameters(spar_0,freq);















