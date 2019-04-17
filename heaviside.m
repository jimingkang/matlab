% modified heaviside function, =1 when x>0, =0 when x<=0
function f=heaviside(x)

f = (sign(x)+abs(sign(x)))/2;

end