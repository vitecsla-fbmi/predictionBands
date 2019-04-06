function [MEAN, CI_LOWER, CI_UPPER ] = bootstrapCI( sigNorm, epoch, alpha)

meanG = mean(sigNorm, 1);

nTrials = size(sigNorm, 1);
nSamples = size(sigNorm, 2);


meanB = zeros(epoch,nSamples);
stdB = zeros(epoch,nSamples);
for k=1:epoch
    i=randsample(nTrials, nTrials, 1);
    sigNormReplicate = sigNorm(i, :);

     meanB(k, :) = mean(sigNormReplicate, 1);
     stdB(k, :) = std(sigNormReplicate, 1);
end
     
meanG2 = mean(meanB, 1);
sdG2 = mean(stdB, 1);

stdMeanB = std(meanB);

t = NaN(1, epoch);
for b = 1:epoch
    t(b) = max(abs(meanB(b,:) - meanG) ./ stdMeanB);
end


coeff = prctile(t,100*(1-alpha/2));


MEAN = meanG2;
CI_LOWER = meanG2 - coeff*sdG2;
CI_UPPER = meanG2 + coeff*sdG2;

end

