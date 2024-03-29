filename='dut_meas.s2p';
s_obj=sparameters(filename);
Rg=0.2;
Rd=1;
Rs=0.1;
Lg=10e-12;
Ld=12e-12;
Ls=5e-12;
Cpg=5e-15;
Cpd=8e-15;
parasitics=[Rg;Rd;Rs;Lg;Ld;Ls;Cpg;Cpd];
s_intrinsic_obj=depara(s_obj,parasitics);
figure;
smith(s_obj,1,1);
hold on;
smith(s_intrinsic_obj,1,1);