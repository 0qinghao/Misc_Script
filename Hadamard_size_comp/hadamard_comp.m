test_num = 1000;
satd_4 = zeros(1,test_num);
satd_8 = zeros(1,test_num);
satd_16 = zeros(1,test_num);
h4 = hadamard(4);h8=hadamard(8);h16=hadamard(16);

for i=1:100
   dif = round(rand(16)*255); 
   
   satd_16(i) = sum(abs(h16*dif*h16),[1,2]);
   satd_8(i) = sum(abs(h8*dif(1:8,1:8)*h8),[1,2]) + ...
       sum(abs(h8*dif(1:8,9:16)*h8),[1,2]) + ...
       sum(abs(h8*dif(9:16,1:8)*h8),[1,2]) + ...
       sum(abs(h8*dif(9:16,9:16)*h8),[1,2]);
   satd_4(i) = sum(abs(h4*dif(1:4,1:4)*h4),[1,2]) + ...
       sum(abs(h4*dif(1:4,5:8)*h4),[1,2]) + ...
       sum(abs(h4*dif(1:4,9:12)*h4),[1,2]) + ...
       sum(abs(h4*dif(1:4,13:16)*h4),[1,2]) + ...
       sum(abs(h4*dif(5:8,1:4)*h4),[1,2]) + ...
       sum(abs(h4*dif(5:8,5:8)*h4),[1,2]) + ...
       sum(abs(h4*dif(5:8,9:12)*h4),[1,2]) + ...
       sum(abs(h4*dif(5:8,13:16)*h4),[1,2]) + ...
       sum(abs(h4*dif(9:12,1:4)*h4),[1,2]) + ...
       sum(abs(h4*dif(9:12,5:8)*h4),[1,2]) + ...
       sum(abs(h4*dif(9:12,9:12)*h4),[1,2]) + ...
       sum(abs(h4*dif(9:12,13:16)*h4),[1,2]) + ...
       sum(abs(h4*dif(13:16,1:4)*h4),[1,2]) + ...
       sum(abs(h4*dif(13:16,5:8)*h4),[1,2]) + ...
       sum(abs(h4*dif(13:16,9:12)*h4),[1,2]) + ...
       sum(abs(h4*dif(13:16,13:16)*h4),[1,2]);
end

subplot(1,2,1)
plot(satd_16,satd_8,'.');
subplot(1,2,2)
plot(satd_16,satd_4,'.');