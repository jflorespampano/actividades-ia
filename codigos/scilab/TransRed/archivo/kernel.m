function [Kdeuv]=kernel(u,v)
Kdeuv=(u(1)*v(1))^2+2*u(1)*u(2)*v(1)*v(2)+(u(2)*v(2))^2;
