function [errmin,modelparameters,s_model_obj]=randsearch_repmat(s_obj)
freq=s_obj.Frequencies;
LB=zeros(8,1);
UB=[10;10;10;100e-12;100e-12;100e-12;100e-15;100e-15];
N=100;%�������
LB=zeros(8,N);
UB1=[10;10;10;100e12;100e-12;100e-12;100e-15;100e-15];
UB=repmat(UB1,1,N);
randpara=rand(8,N);
parasitics_matrix=LB+(UB-LB).*randpara;
for pr =1:N
    parasitics=LB+(UB-LB).*randpara(:,pr);
    s_intrin_obj=depara(s_obj,parasitics);
    intrinsics=extractintrin(s_intrin_obj);
    s_intrin_model_obj=calintrin(intrinsics,freq);
    s_model_obj=addpara(s_intrin_model_obj,parasitics);
    parasitics_matrix(pr)=err(s_obj,s_model_obj);
end
[errmin,index]=min(parasitics_matrix);
parasitics=LB+(UB-LB).*randpara(:,index);
s_intrin_obj=depara(s_obj,parasitics);
intrinsics=extractintrin(s_intrin_obj);
s_intrin_model_obj=calintrin(intrinsics,freq);
s_model_obj=addpara(s_intrin_model_obj,parasitics);
modelparameters=[parasitics;intrinsics];
