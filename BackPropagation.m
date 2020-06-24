function BackPropagation(X,salida)
    load('Coeficientes.mat');
    alfa = 1;
    Y = [1 1];
    d4 = [1 1];
    for i=1:2
        Y(i) = RedNeuronal(i,X);
        d4(i)= delta4(Y(i),salida(i));
    end
    
    for j=1:3
        
        for i=1:12
            w1(j,i) = w1(j,i) - alfa*error(j,i,d4,X,w1,w2,w3,u2,u3,u4);
            u2(i) = u2(i) - alfa*delta2(i,d4,X,w1,w2,w3,u2,u3,u4);
        end
    end
        
    for j=1:12
        
        for i=1:8
            
            w2(j,i) = w2(j,i) - alfa*error2(j,i,d4,X,w1,w2,w3,u2,u3,u4);
            u3(i) = u3(i) - alfa*delta3(i,d4,X,w1,w2,w3,u2,u3,u4);
        end
    end
        
    for j=1:8
        
        for i=1:2
            w3(j,i) = w3(j,i) - alfa*error3(i,d4(i),X,w1,w2,w3,u2,u3,u4);
            u4(i) = u4(i) - alfa*d4(i);
        end
    end
    
    save Coeficientes.mat w1 w2 w3 u2 u3 u4;
end

function res = delta4(Y,sal)
    
    res = Y*(1-Y)*(Y-sal);
    
end

function res = delta3(k,d4,X,w1,w2,w3,u2,u3,u4)
    
    
    a3=A3(k,X,w1,w2,u2,u3);     
    sumatoria=0;
        
    for i=1:2
        
        sumatoria = (w3(k,i)*d4(i)) + sumatoria;
    end
    res = a3*(1-a3)*sumatoria;
       
    
end

function res = delta2(k,d4,X,w1,w2,w3,u2,u3,u4)
        
    a2=A2(k,X,w1,u2);        
    sumatoria=0;
    for p=1:8
        sumatoria = (w2(k,p)*delta3(p,d4,X,w1,w2,w3,u2,u3,u4)+sumatoria);
    end    
    
    res = a2*(1-a2)*sumatoria;
       
    
end

function res = error3(k,d4,X,w1,w2,w3,u2,u3,u4)
    
    res = A3(k,X,w1,w2,u2,u3)*d4;
    
end

function res = error2(j,k,d4,X,w1,w2,w3,u2,u3,u4)
    
    res = A2(j,X,w1,u2)*delta3(k,d4,X,w1,w2,w3,u2,u3,u4);
    
end

function res = error(j,k,d4,X,w1,w2,w3,u2,u3,u4)
    
    res = X(j)*delta2(k,d4,X,w1,w2,w3,u2,u3,u4);
    
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

function res = f(x)
  res = 1 ./ (1 + exp(-x));
end