function [y_1 , y_2] = EASI_me_g2 ( x1 , x2 , iter)
% iter = iteration number
lambda = 0.001 ;
t = length(x1);
y_1 = zeros(t^2,1);
y_2 = zeros(t^2,1);

m = 2 ;
x = [ reshape(x1,[1 , t^2]) ; reshape(x2,[1 , t^2])] ;
I	= eye(m);

for j = 1: t^2
    
    B = eye (m) ;
    x_iter = x(:,j);
    y = B * x_iter ;
    y_y	= y*y';
    g = y ./ log(diag(y_y)) ;
    
    for i = 1:iter
        
        % B = B - lambda*(y*y' - eye(m) + g*y' - y*g' )*B ;
        g_y	= g * y';
        B = B - lambda*((y_y - I)/(1+lambda*trace(y_y)) + (g_y - g_y')/(1+lambda*abs(g'*y)))*B;
        y = B * x_iter ;
        g = y ./ log(diag(y_y)) ;
        
        
    end
    
    y_1(j) = y(1,:);
    y_2(j) = y(2,:);
    
end

end

