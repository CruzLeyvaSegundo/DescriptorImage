function [ sim ] = simCoseno(q,p)
sim=dot(q,p)/(norm(q)*norm(p));
end

