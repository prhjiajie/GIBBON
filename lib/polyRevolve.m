function [F,V,C]=polyRevolve(Vc,controlParameterStruct)
 
%% Parse input
controlParameterStructDefault.numSteps=[];
controlParameterStructDefault.theta=2*pi;
controlParameterStructDefault.w=[0 0 1];
controlParameterStructDefault.closeLoopOpt=1;

[controlParameterStruct]=structComplete(controlParameterStruct,controlParameterStructDefault,0);

theta=controlParameterStruct.theta;
numSteps=controlParameterStruct.numSteps;
w=controlParameterStruct.w;
closeLoopOpt=controlParameterStruct.closeLoopOpt;

%% Cope with 2D input
if size(Vc,2)==2
    Vc(:,3)=0;
end

%% 
D=pathLength(Vc);
d=max(pathLength(Vc)); %Compute curve length for point sampling
% numPointsCurve=size(Vc,1);
pointSpacingCurve=mean(diff(D));

if isempty(numSteps)
    W=w(ones(size(Vc,1),1),:); %replicated w
    Vc2=vecnormalize(cross(W,Vc,2));
    Vc22=vecnormalize(cross(Vc2,W,2));
    arcMax=max(abs(dot(Vc22,Vc,2)))*theta;
    numSteps=ceil(arcMax/pointSpacingCurve);
end



%% Define rotation matrix

thetaRange=linspace(0,theta,numSteps);

X=zeros(size(Vc,1),numSteps);
Y=X;
Z=Z;
for q=1:1:numSteps
    [R]=vecAngle2Rot(thetaRange(q),w);
    Vc_now=(R*Vc')'; %Rotate the polygon
    X(:,q)=Vc_now(:,1);
    Y(:,q)=Vc_now(:,2);
    Z(:,q)=Vc_now(:,3);
end

%% Create patch data
c=(1:1:size(Z,1))';
C=c(:,ones(1,size(Z,2)));

%Create quad patch data
[F,V,C] = surf2patch(X,Y,Z,C);

indStart=1:numSteps:size(V,1);
indEnd=numSteps:numSteps:size(V,1);

%% Close patch if required
if closeLoopOpt
    I=[(2:size(Z,1))' (2:size(Z,1))' (1:size(Z,1)-1)' (1:size(Z,1)-1)'];
    J=[ones(size(Z,1)-1,1) size(Z,2).*ones(size(Z,1)-1,1) size(Z,2).*ones(size(Z,1)-1,1) ones(size(Z,1)-1,1)];
    F_sub=sub2ind(size(Z),I,J);
    F=[F;F_sub];
    [C]=vertexToFaceMeasure(F,C);
    C(end-size(F_sub,1):end,:)=C(end-size(F_sub,1):end,:)+0.5;
else
    [C]=vertexToFaceMeasure(F,C);
end
C=round(C);


%% 
% _*GIBBON footer text*_ 
% 
% License: <https://github.com/gibbonCode/GIBBON/blob/master/LICENSE>
% 
% GIBBON: The Geometry and Image-based Bioengineering add-On. A toolbox for
% image segmentation, image-based modeling, meshing, and finite element
% analysis.
% 
% Copyright (C) 2018  Kevin Mattheus Moerman
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
