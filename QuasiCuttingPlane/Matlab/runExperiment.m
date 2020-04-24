function runExperiment(n,m,seed,K,factor)

[f_sub,k_sub] = runAlgorithm(n,m,seed,K,false,0);
[f_qcp,k_qcp] = runAlgorithm(n,m,seed,K,true,factor);

figure(1);
plot(1:max(k_sub,k_qcp),log(f_sub(1:max(k_sub,k_qcp))));
hold on;
plot(1:max(k_sub,k_qcp),log(f_qcp(1:max(k_sub,k_qcp))));
legend('fsub','fqcp');