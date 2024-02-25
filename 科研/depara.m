function s_intrinsic_obj=depara(s_obj,parasitics)
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
spar=s_obj.Parameters;
freq=s_obj.Frequencies;
m=length(freq);
omega=2*pi*freq;

%����z����ȥ��������в���
zpar=s2z(spar);
zl=zeros(2,2,m);
zl(1,1,:)=1j*omega*(Lg+Ls);
zl(1,2,:)=1j*omega*(Ls);
zl(2,1,:)=1j*omega*(Ls);
zl(2,2,:)=1j*omega*(Ld+Ls);
zdel=zpar-zl;

%����y����ȥ����������ϵ��
ypar=z2y(zdel);
y1=zeros(2,2,m);
y1(1,1,:)=1j*omega*(Cpg);
y1(1,2,:)=0;
y1(2,1,:)=0;
y1(2,2,:)=1j*omega*(Cpd);
ydel=ypar-y1;

%����z����ȥ�������������
zpar_1=y2z(ydel);
z2=zeros(2,2,m);
z2(1,1,:)=Rg+Rs;
z2(1,2,:)=Rs;
z2(2,1,:)=Rs;
z2(2,2,:)=Rd+Rs;
zdel_1=zpar_1-z2;

%��z����ת��Ϊs����
spar_intrinsic=z2s(zdel_1);
s_intrinsic_obj=sparameters(spar_intrinsic,freq);


