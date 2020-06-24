function res = RedNeuronal(i,X)
    load('Coeficientes.mat');
    res = Y(i,X,w1,w2,w3,u2,u3,u4);

end

function res = A2(i,X,w1,u2)
    
    sumatoria=0;
    for q=1:3
    
        sumatoria = (X(q)*w1(q,i))+sumatoria; 

    end
    
    aux1 = sumatoria+u2(i);
    
    res = f(aux1);
        
end

function res = A3(i,X,w1,w2,u2,u3)
    
    sumatoria=0;
    for q=1:12
    
        sumatoria = (A2(q,X,w1,u2)*w2(q,i))+sumatoria; 

    end
    
    aux1 = sumatoria+u3(i);
    
    res = f(aux1);
    
end

function res = Y(i,X,w1,w2,w3,u2,u3,u4)
    
    sumatoria=0;
    for q=1:8
    
        sumatoria = (A3(q,X,w1,w2,u2,u3)*w3(q,i))+sumatoria; 

    end
    
    aux1 = sumatoria+u4(i);
    
    res = f(aux1);

end


function res = f(x)
  res = 1 ./ (1 + exp(-x));
end