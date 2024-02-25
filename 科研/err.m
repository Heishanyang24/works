function errabs=err(s_obj1,s_obj2)
spar1=s_obj1.Parameters;
spar2=s_obj2.Parameters;
diffspar=spar2-spar1;
errmatrix=abs(diffspar)./abs(spar1);
errabs=mean(mean(mean(errmatrix)));