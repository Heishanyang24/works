function [errmin,modelparameters,s_model_obj]=randsearch(s_obj)
freq=s_obj.Frequencies;
LB=zeros(8,1);
UB=[10;10;10;100e-12;100e-12;100e-12;100e-15;100e-15];
N=100;%Ëæ»ú´ÎÊý
randpara=rand(8,N);
errmatrix=zeros(N,1);
for pr =1:N
    parasitics=LB+(UB-LB).*randpara(:,pr);
    s_intrin_obj=depara(s_obj,parasitics);
    intrinsics=extractintrin(s_intrin_obj);
    s_intrin_model_obj=calintrin(intrinsics,freq);
    s_model_obj=addpara(s_intrin_model_obj,parasitics);
    errmatrix(pr)=err(s_obj,s_model_obj);
end
[errmin,index]=min(errmatrix);
parasitics=LB+(UB-LB).*randpara(:,index);
s_intrin_obj=depara(s_obj,parasitics);
intrinsics=extractintrin(s_intrin_obj);
s_intrin_model_obj=calintrin(intrinsics,freq);
s_model_obj=addpara(s_intrin_model_obj,parasitics);
modelparameters=[parasitics;intrinsics];

