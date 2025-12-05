
function x = Gauss_Seidel(A,b)

    % Algorithm source from Wikipedia: 

    x = 100*ones([size(b),1]).';
    x_next = zeros([size(x),1]).';


    iteration = 0;


    epsilon = 1e-9;
    delta = 1;

    while delta > epsilon

        iteration = iteration + 1;

        for i = 1:size(x)
    
            preelements = 0;
            postelements = 0;

            for j = 1:(i-1)
            
                if i ~= 1
                    preelements = preelements + A(i,j)*x_next(j);
                end

            end

            for j = (i+1):size(x)

                postelements = postelements + A(i,j)*x(j);

            end

            x_next(i) = 1/A(i,i) *(b(i) - preelements - postelements);

        end

        delta = max(abs(x_next - x));

        x = x_next;

    end

    fprintf('Exited Gauss-Seidel after %d iterations. Residual: %d.\n', iteration, delta)

end