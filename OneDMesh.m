
function output = OneDMesh(N)
H = 20;
W = 100;
e = 2;

lamda = 5;
qv = 1000;
alphaa = 0;
alphab = 500;
Ta = 10;
Tb = 10;

%N = 1;
div = e/N;


%adiabatic = ;
%convectionA = (alphaa, Ta);
%convectionB = (alphab, Tb);



point_1 = myPoint([0, 0, 0]);
point_2 = myPoint([0, W, 0]);
point_3 = myPoint([0, W, H]);
point_4 = myPoint([0, 0, H]);

faceList(1) = myFace([point_1, point_4, point_3, point_2]);
pointList = [point_1, point_2, point_3, point_4];

for c = 1:N

    l = c*div;
    f = (c-1)*5 + 1;
    p = (c-1)*4 + 1;

    point_1 = pointList(p);   %vertex([l-div, 0, 0]);
    point_2 = pointList(p+1); %vertex([l-div, H, 0]);
    point_3 = pointList(p+2); %vertex([l-div, H, W]);
    point_4 = pointList(p+3); %vertex([l-div, 0, W]);
    point_5 = myPoint([l, 0, 0]);
    point_6 = myPoint([l, W, 0]);
    point_7 = myPoint([l, W, H]);
    point_8 = myPoint([l, 0, H]);

    pointList = [pointList, point_5, point_6, point_7, point_8];

    faceList(f+1) = myFace([point_1, point_5, point_6, point_2], 'patch', 'adiabatic');
    faceList(f+2) = myFace([point_2, point_6, point_7, point_3], 'patch', 'adiabatic');
    faceList(f+3) = myFace([point_8, point_4, point_3, point_7], 'patch', 'adiabatic');
    faceList(f+4) = myFace([point_1, point_4, point_8, point_5], 'patch', 'adiabatic');
    faceList(f+5) = myFace([point_5, point_6, point_7, point_8]);

%     faceList(f+1).owner = c;
%     faceList(f+2).owner = c;
%     faceList(f+3).owner = c;
%     faceList(f+4).owner = c;
%     faceList(f+5).owner = c;
%     faceList(f+5).neighbour = c+1;
% 
%     faceList(f+1).patch_face = adiabatic;
%     faceList(f+2).patch_face = adiabatic;
%     faceList(f+3).patch_face = adiabatic;
%     faceList(f+4).patch_face = adiabatic;



    facesOfCell = faceList(f:(f+5));
    thisCell = myCell(facesOfCell, 'id', c);
%     thisCell.id = c;
    cellList(c) = thisCell;

    faceList(f+1).owner = thisCell;
    faceList(f+2).owner = thisCell;
    faceList(f+3).owner = thisCell;
    faceList(f+4).owner = thisCell;
    faceList(f+5).owner = thisCell;
    faceList(f).neighbour = thisCell;

end

cellList(1).faces(1).owner = cellList(1);
cellList(1).faces(1).neighbour = [];
cellList(1).faces(1).patch_name = 'convectionHot';
cellList(N).faces(6).patch_name = 'convectionCold';
cellList(N).faces(6).neighbour = [];

thisMesh = myMesh();
thisMesh.cellList = cellList;
thisMesh.faceList = faceList;
thisMesh.pointList = pointList;
thisMesh.cellnum = N;

for c = 1:thisMesh.cellnum
    thisMesh.cellList(c).patch_name = 'internalSource';
end

output = thisMesh;

end

% for p = 1:length(thisMesh.pointList)
% 
%     xVector(p) = thisMesh.pointList(p).coordinates(1,1);
%     yVector(p) = thisMesh.pointList(p).coordinates(1,2);
%     zVector(p) = thisMesh.pointList(p).coordinates(1,3);
% 
% end
% 
% plot3(xVector, yVector, zVector)
% hold on
% 
% for f = 1:length(thisMesh.faceList)
% 
%     xFace(f) = thisMesh.faceList(f).centre(1,1);
%     yFace(f) = thisMesh.faceList(f).centre(1,2);
%     zFace(f) = thisMesh.faceList(f).centre(1,3);
% 
% end
% 
% plot3(xFace, yFace, zFace)
% 
% for c = 1:length(thisMesh.cellList)
% 
%     xCentre(c) = thisMesh.cellList(c).centre(1,1);
%     yCentre(c) = thisMesh.cellList(c).centre(1,2);
%     zCentre(c) = thisMesh.cellList(c).centre(1,3);
% 
% end
% 
% plot3(xCentre, yCentre, zCentre)
%axis equal