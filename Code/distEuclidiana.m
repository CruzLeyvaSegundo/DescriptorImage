function [ dist ] = distEuclidiana(q,p)
M(1,:)=q;
M(2,:)=p;
dist=pdist(M,'euclidean');
end

