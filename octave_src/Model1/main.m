clear;clc
X=[1,1560,3.6,3.7;2,1560,6.2,3.7;3,1560,15,3.7];

[n,m] = size(X);
disp(['There are ' num2str(n) ' Objects with ' num2str(m) ' criterions.'])

disp(X)

Position = [3];
Type = [1];

for i = 1 : size(Position,2)
    X(:,Position(i)) = positivization(X(:,Position(i)),Type(i),Position(i));

end
disp('Mat. after Positivization:')
disp(X)

weigh = [0.4, 0.15, 0.3, 0.15];
OK = 0;
while OK == 0
    if abs(sum(weigh) - 1)<0.000001 && size(weigh,1) == 1 && size(weigh,2) == m
         OK =1;
    else
        weigh = input('ERR: 1');
    end
end

Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
disp('Mat. after Standardization: ')
disp(Z)

D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
S = D_N ./ (D_P+D_N);    % 未归一化的得分
disp('Result: ')
standard_S = S / sum(S)

num_each = [0.28; 0.52; 0.2];

dot_result = num_each .* standard_S;
final = sum(dot_result)

