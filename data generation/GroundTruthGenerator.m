function GTmicro = GroundTruthGenerator(L1,L2,GTmacro)

if(L1>L2)
    L1 = L2;
end
% 
% if(avgLength<L1/2)
%     avgLength = floor(L1/2);
% end

if(GTmacro == 1)
    GTmicro(1) = randi([1 L1-44100*20]);
    GTmicro(2) = randi([GTmicro(1)+ 44100*20 L1]);
    GTmicro(3) = randi([GTmicro(1) GTmicro(2)-44100*20]);
    GTmicro(4) = randi([GTmicro(3)+ 44100*20 L2]);
else
    GTmicro(1) = randi([1 L1-44100*40]);
    GTmicro(2) = randi([GTmicro(1)+44100*20 L1-44100*20]);
    GTmicro(3) = randi([GTmicro(2) L2-44100*20]);

    GTmicro(4) = randi([GTmicro(3)+ 44100*20 L2]);
end
