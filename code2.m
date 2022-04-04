%初始博弈策略
start = rand(1,200);
start(start <=0.5) = 0; %A 决策个体
start(start > 0.5) = 1; %B 决策个体
numberoa = sum(1-start); %初始 A 决策个体数(number of A)
strategy = [start(200),start,start(1)]; %环状结构，便于矩阵运算
for i = 1:20
%一轮收益
U = game(strategy(2:201),strategy(1:200)) + game(strategy(2:201),strategy(3:202));
U = [U(200),U,U(1)]; %环状结构，便于矩阵运算
%策略更新准备
leaobject=2*round(rand(1,200))-1+[2:201]; %学习对象(learning object)随机选择
(邻居)
%策略调整概率
porenew = renew(U(2:201),U(leaobject));
%是否调整策略
act = rand(1,200);
act(act < 1-porenew)=0; %不调整策略
act(act >=1-porenew)=1; %调整策略
%策略更新
strategy(2:201)=act.*strategy(leaobject)+(1-act).*strategy(2:201);
%环状结构更新
strategy(1) = strategy(201);
13
strategy(202) = strategy(2);
numberoa = [numberoa,sum((1-strategy(2:201)))]; %添加此轮 A 决策个体数
end
plot(0:20,numberoa)
function profit = game(a,b)
profit = -8 + 8*b - 2*a + a.*b;
%容易知道 a 与 b 博弈后收益满足上式
end
function porenew = renew(a,b)
porenew = 1./(1+exp((a-b)/0.5));
%策略调整概率,possibility of renewing
end