function [] = kernelized_kmeans(X)

k = [2];
m = size(X,1);
r = zeros(m,1);

for i = 1:length(k)
    meanX_prev = rand(k(i),1);
    meanY_prev = rand(k(i),1);
    meanX = X(1:k(i),1);
    meanY = X(1:k(i),2);
    result = zeros(m,k(i));
    
    for index = 1:100
        for meanIndex = 1:k(i)
            result(:,meanIndex) = (X(:,1) - meanX(meanIndex)).^2 + (X(:,2) - meanY(meanIndex)).^2;                 
        end

        [M,I] = min(result,[],2);
        r(:,1) = I;

        for meanIndex = 1:k(i)
            ind = find(r == meanIndex);
            meanX(meanIndex) = sum(X(ind,1))/length(ind);
            meanY(meanIndex) = sum(X(ind,2))/length(ind);
        end

        if (isequal(meanX,meanX_prev) && isequal(meanY,meanY_prev))
            disp('Equal')
            break;
        else
            meanX_prev = meanX;
            meanY_prev = meanY;
        end
    end
    
    subplot(1,1,i)
    for meanIndex = 1:k(i)
        ind = find(r == meanIndex);
        X1 = X(ind,1);
        X2 = X(ind,2);
        scatter(X1,X2);
        hold on;
    end
    
    hold off
    
end