% Author:       -Segundo David Junior Cruz Leyva  
%               -Josue Tavara Idrogo       
%
% Date:         Junho 03, 2016  
%
% Course:   PI
%
% Function   : simCoseno
%
% Purpose    : Get the cosine similarity between two vectors
% 
% Parameters : vector q , vector p
% 
% Return     : sim
function [ sim ] = simCoseno(q,p)
    sim=dot(q,p)/(norm(q)*norm(p));
end

