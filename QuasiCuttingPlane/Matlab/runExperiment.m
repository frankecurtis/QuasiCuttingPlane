function runExperiment(n,m,seed,K)

[f_sub,k_sub] = runAlgorithm(n,m,seed,K,false);
[f_qcp,k_qcp] = runAlgorithm(n,m,seed,K,true);

figure(1);
plot(1:max(k_sub,k_qcp),log(f_sub(1:max(k_sub,k_qcp))));
hold on;
plot(1:max(k_sub,k_qcp),log(f_qcp(1:max(k_sub,k_qcp))));
legend('fsub','fqcp');