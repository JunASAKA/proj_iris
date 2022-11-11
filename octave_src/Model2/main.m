clear;clc
X=[3.6,0.28,79;6.2,0.52,259;15,0.2,0];

[n,m] = size(X);
disp(['There are ' num2str(n) ' Objects with ' num2str(m) ' criterions.'])

disp(X)

Position = [1,3];
Type = [1,1];

for i = 1 : size(Position,2)\
    X(:,Position(i)) = Positivization(X(:,Position(i)),Type(i),Position(i));

end
disp('Mat. after Positivization:')
disp(X)
\
weigh = [0.4, 0.5, 0.1];
OK = 0;\
while OK == 0
    if abs(sum(weigh) - 1)<0.000001 && size(weigh,1) == 1 && size(weigh,2) == m\
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
S = D_N ./ (D_P+D_N)
disp('Result: ')
standard_S = S / sum(S)
[sorted_S,index] = sort(standard_S ,'descend')
