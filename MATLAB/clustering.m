load fisheriris.mat;
plot3(meas(:,1),meas(:,2),meas(:,3),'*');
grid on
xlabel('Sepal Width');
ylabel('Sepal Length');
zlabel('Petal Length');
title('IRIS data plot with 3 features');
N = size(meas,1);
C = size(meas,2);
% generating 3 random numbers from 1 to N as 3 center points
centers_index = ceil(rand(1,3).*(N-1));
centers = meas(centers_index,:);
% distance array storing distance of each point from C1,C2,C3
dist = zeros(N,3);
for k = 1:1:400
    for i = 1:1:N
        for j = 1:1:3
            dist(i,j) = sqrt(sum(meas(i,:)-centers(j,:)).^2);
        end
    end
    % find the minimum distance from each row in dist matrix and store that
    % index in indx matrix, minimum distance in dist_min matrix
    % for i = 1:1:N
    %     [dist_min(i,1),indx(i,1)] = min(dist(i,:));
    % end
    [dist_min,indx] = min(dist,[],2);
    % sort the indx column vector and store the corresponding indexes in Q and
    % sorted values in P
    [P Q] = sort(indx);
    % make 3 groups of dataset, those having indx as 1,2,3
    group1 = 0;
    group2 = 0;
    group3 = 0;
    for i = 1:1:N
        if(P(i)==1)
            group1 = [group1;Q(i)];
        elseif(P(i) == 2)
            group2 = [group2;Q(i)];
        else
            group3 = [group3;Q(i)];
        end
    end
    % approximating new centers by taking the mean of all 4 feature values in
    % each group
    centers = zeros(3,C); % 3 centers with 4 features each
    sz1 = size(group1,1);
    sz2 = size(group2,1);
    sz3 = size(group3,1);
    sz = [sz1;sz2;sz3];
    % for i = 1:1:3
    centers(1,:) = mean(meas(group1(2:sz1,1),:)); % starting from 2nd index since each group contains 1st element as 0
    centers(2,:) = mean(meas(group2(2:sz2,1),:));
    centers(3,:) = mean(meas(group3(2:sz3,1),:));
end    
