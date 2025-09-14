function [ symbol_K_best ] = K_best(Da_Str,y,H,Q,R) 
%% intialization
K = 6;
z = Q'*y;
symbols = qammod([0 1 2 3],4)/sqrt(2);

%% layer 4: 4 nodes -> 4 nodes
survival_node_4 = qammod([0 1 2 3],4)/sqrt(2);

%% layer 3: 4*4 nodes -> 6 nodes
node3 = zeros(1, 16);
idx3 = zeros(1, 6);
for i = 1:4
    temp = [repmat(survival_node_4(i),1,4);symbols];
    temp = flipud(temp);
    node3(4*i-3:4*i) = abs(z(4)-R(4,4)*survival_node_4(i)).^2 + abs(z(3)-R(3,3:4)*temp).^2;
end
[path_metric_3, temp_idx3] = sort(node3);
for i = 1:K
    if mod(temp_idx3(i), 4) ~= 0
        idx3(i) = mod(temp_idx3(i), 4);
    else
        idx3(i) = 4;
    end
end
idx4 = ceil(temp_idx3(1:6)/4);
path_metric = path_metric_3(1:6);
symbol3 = qammod(idx3-1,4)/sqrt(2);
symbol4 = qammod(idx4-1,4)/sqrt(2);
survival_node_3 = [symbol4; symbol3];

%% layer 2: 6*4 nodes -> 6 nodes
node2 = zeros(1, 24);
idx2 = zeros(1, 6);
for i = 1:6
    temp = [repmat(survival_node_3(:,i),1,4);symbols];
    temp = flipud(temp);
    node2(4*i-3:4*i) = repmat(path_metric(i),1,4) + abs(z(2)-R(2,2:4)*temp).^2;
end
[path_metric_2, temp_idx2] = sort(node2);
for i = 1:6
    if mod(temp_idx2(i), 4) ~= 0
        idx2(i) = mod(temp_idx2(i), 4);
    else
        idx2(i) = 4;
    end
end
idx34 = ceil(temp_idx2(1:6)/4);
path_metric =  path_metric_2(1:6);
symbol2 = qammod(idx2-1,4)/sqrt(2);
survival_node_2 = [survival_node_3(:,idx34) ; symbol2];

%% layer 1: 6*4 nodes -> 6 nodes
node1 = zeros(1, 24);
idx1 = zeros(1, 1);
for i = 1:6
    temp = [repmat(survival_node_2(:,i),1,4);symbols];
    temp = flipud(temp);
    node1(4*i-3:4*i) = repmat(path_metric(i),1,4) + abs(z(1)-R(1,1:4)*temp).^2;
end
[path_metric_1, temp_idx1] = sort(node1);
if mod(temp_idx1(1), 4) ~= 0
    idx1 = mod(temp_idx1(1), 4);
else
    idx1 = 4;
end
idx234 = ceil(temp_idx1(1)/4);
path_metric =  path_metric_1(1:6);
symbol1 = qammod(idx1-1,4)/sqrt(2);
survival_node_1 = [survival_node_2(:,idx234) ; symbol1];

symbol_K_best = flipud(survival_node_1);
symbol_K_best = qamdemod(symbol_K_best, 4);
end
