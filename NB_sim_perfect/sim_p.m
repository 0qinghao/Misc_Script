critical_p = 0.7;
test_time = 500;

stack = zeros(1,test_time);

for i=2:test_time+1
   if critical_p > rand()
       stack_t = stack(i-1) + 1;
       stack_t = min(stack_t,10);
   else
       stack_t = stack(i-1) - 1;
       stack_t = max(stack_t,0);
   end
   
   stack(i) = stack_t;
end

plot(stack)