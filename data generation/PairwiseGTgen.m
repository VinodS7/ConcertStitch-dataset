function groundTruth = PairwiseGTgen(pathPoints1,pathPoints2)
%% GT generator
L = size(pathPoints1,1);
groundTruth = [];
k = 1;
if(sum(sum(pathPoints1-pathPoints2)) == 0)
    startPoint =@(i) i;
    flag = true;
else
    startPoint =@(i) 1;
    flag = false;
end
for i = 1:L
    for j = startPoint(i):L
        if(i == j && flag)
            continue;
        end
        if(pathPoints2(j,1)>=pathPoints1(i,1) && pathPoints2(j,1)<pathPoints1(i,2))
            groundTruth(k,1) = 1;
            groundTruth(k,2) = pathPoints2(j,1)-pathPoints1(i,1)+1;
            groundTruth(k,4) = 1;
            
            if(pathPoints1(i,2)<pathPoints2(j,2))
            groundTruth(k,3) = pathPoints1(i,2) - pathPoints1(i,1)+1;
            groundTruth(k,5) = pathPoints1(i,2)-pathPoints2(j,1)+1;
            else
                groundTruth(k,3) = pathPoints2(j,2) - pathPoints1(i,1)+1;
                groundTruth(k,5) = pathPoints2(j,2) - pathPoints2(j,1)+1;
            end
        elseif(pathPoints1(i,1)>=pathPoints2(j,1) && pathPoints1(i,1)<pathPoints2(j,2))
            
            groundTruth(k,1) = 1;
            groundTruth(k,2) = pathPoints1(i,1)-pathPoints2(j,1)+1;
            groundTruth(k,4) = 1;
            
            if(pathPoints2(j,2)<pathPoints1(i,2))
            groundTruth(k,3) = pathPoints2(j,2) - pathPoints2(j,1)+1;
            groundTruth(k,5) = pathPoints2(j,2)-pathPoints1(i,1)+1;
            else
                groundTruth(k,3) = pathPoints1(i,2) - pathPoints2(j,1)+1;
                groundTruth(k,5) = pathPoints1(i,2) - pathPoints1(i,1)+1;
            end
        else
            groundTruth(k,1) = 0;
        end
        k = k+1;
    end
end
end