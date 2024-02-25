function errabs=opterr(s_obj,norm_para)
freq=s_obj.Frequencies;
LB=zeros(8,1);
UB=[10;10;10;100e-12;100e-12;100e-12;100e-15;100e-15];
parasitics=LB+norm_para.*(UB-LB);
s_intrin_obj=depara(s_obj,parasitics);
intrinsics=extractintrin(s_intrin_obj);
s_intrin_model_obj=calintrin(intrinsics,freq);
s_model_obj=addpara(s_intrin_model_obj,parasitics);
errabs=err(s_obj,s_model_obj);