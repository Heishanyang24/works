filename='dut_meas.s2p';
s_obj=sparameters(filename);
tic
[errmin,modelparameters,s_model_obj]=randsearch(s_obj);
toc
subplot(2,4,1)
rfplot(s_obj,1,1,'real');
hold on
rfplot(s_model_obj,1,1,'real');
hold off
subplot(2,4,2)
rfplot(s_obj,1,2,'real');
hold on
rfplot(s_model_obj,1,2,'real');
hold off
subplot(2,4,3)
rfplot(s_obj,2,1,'real');
hold on
rfplot(s_model_obj,2,1,'real');
hold off
subplot(2,4,4)
rfplot(s_obj,2,2,'real');
hold on
rfplot(s_model_obj,2,2,'real');
hold off
subplot(2,4,5)
rfplot(s_obj,1,1,'imag');
hold on
rfplot(s_model_obj,1,1,'imag');
hold off
subplot(2,4,6)
rfplot(s_obj,1,2,'imag');
hold on
rfplot(s_model_obj,1,2,'imag');
hold off
subplot(2,4,7)
rfplot(s_obj,2,1,'imag');
hold on
rfplot(s_model_obj,2,1,'imag');
hold off
subplot(2,4,8)
rfplot(s_obj,2,2,'imag');
hold on
rfplot(s_model_obj,2,2,'imag');
hold off

