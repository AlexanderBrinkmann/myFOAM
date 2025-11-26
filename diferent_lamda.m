
clear, close all, clc

i = 0;
cases = [5, 10, 25, 50, 100, 150, 170, 200, 220, 230, 240, 241, 242];
for N = cases

    i = i + 1;
    thisMesh = OneDMesh(32);
    name = ['Case', num2str(i)];
    results.(name) = myFOAM(thisMesh, N);

end

resultsArray = struct2cell(results);

figure
hold on

for i = 1:length(resultsArray)

    x = linspace(0,2, 32);
    plot(x, resultsArray{i})

end