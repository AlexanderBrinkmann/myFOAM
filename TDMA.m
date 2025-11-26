
function x = TDMA(A,b)

    % Algorithm source from Wikipedia: 

    N = size(b);


    P(1) = A(1,2)/A(1,1);
    for i = 2:N-1
        P(i) = A(i,i+1)/(A(i,i) - A(i,i-1)*P(i-1));
    end

    R(1) = b(1)/A(1,1);
    for i = 2:N
        R(i) = (b(i) - A(i,i-1)*R(i-1))/(A(i,i) - A(i,i-1)*P(i-1));
    end


    x(N) = R(N);
    for i = N-1:-1:1
        x(i) = R(i) - P(i)*x(i+1);
    end

end