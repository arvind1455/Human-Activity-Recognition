function [inputs,targets] = irisdataset
load('workplace.mat')
load irisdataset irisInputs irisTargets
inputs = irisInputs;
targets = irisTargets;
[x,t] = irisdataset;
net = patternnet(18);
[net,tr] = train(net,x,t);
view(net)
y = net(x);
plotperform(tr);
plotconfusion(y,t);
