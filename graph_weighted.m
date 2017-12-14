function graph=graph_weighted(graph_features,alpha)
% weighted graph
%     graph_features, the graphs for each features, n*n*t
%     alpha, the weights, t*1
%     graph, the weighted graph, n*n
% 2017-5-18 11:30:34

[n,~,t]=size(graph_features);
graph=zeros(n);
for i=1:t
    graph=graph + alpha(i)*graph_features(:,:,i);
end