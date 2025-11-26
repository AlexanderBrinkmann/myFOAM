
clear, close all, clc

i = 0;
cases = [4, 8, 16, 32, 64, 128, 256];
for N = cases

    i = i + 1;
    thisMesh = OneDMesh(N);
    name = ['Case', num2str(i)];
    results.(name) = myFOAM(thisMesh, 50);

end

resultsArray = struct2cell(results);

figure
hold on

for i = 1:length(resultsArray)

    x = linspace(0,2, cases(i));
    plot(x, resultsArray{i})

end