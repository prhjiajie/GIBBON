%% checkerBoard3D
% Below is a demonstration of the features of the |checkerBoard3D| function

%%
clear; close all; clc;

%% Syntax
% |M=checkerBoard3D(siz);|

%% Description 
% This function creates a checkboard image of the size siz whereby elements
% are either black (0) or white (1). The first element is white.

%% Examples 

%%
% Plot settings
fontSize=15; 

%% Example creating a 2D checkerboard image

siz=[4 6]; %Image size
M=checkerBoard3D(siz); %Create checkerboard image

%%
% Plotting results

cFigure;
title('A 2D checkerboard pattern','FontSize',fontSize);
xlabel('X','FontSize',fontSize);ylabel('Y','FontSize',fontSize); zlabel('Z','FontSize',fontSize);
hold on;
imagesc(M);

colormap gray;
axis equal; view(2); axis tight;
set(gca,'FontSize',fontSize);
drawnow;

%% Example creating a 3D checkerboard image

siz=[6 6 3]; %Image size
M=checkerBoard3D(siz); %Create checkerboard image

%%
% Plotting results

[Fv,Vv,Cv]=ind2patch(1:numel(M),M,'vu'); %Create patch data for plotting

cFigure;
title('A 3D checkerboard pattern','FontSize',fontSize);
xlabel('X','FontSize',fontSize);ylabel('Y','FontSize',fontSize); zlabel('Z','FontSize',fontSize);
hold on;
hp= patch('Faces',Fv,'Vertices',Vv,'FaceColor','flat','CData',Cv,'EdgeColor','r','FaceAlpha',1);

camlight('headlight');
colormap gray;
axis equal; view(3); axis tight;  grid on; box on; 
set(gca,'FontSize',fontSize);
drawnow;

%%
% 
% <<gibbVerySmall.gif>>
% 
% _*GIBBON*_ 
% <www.gibboncode.org>
% 
% _Kevin Mattheus Moerman_, <gibbon.toolbox@gmail.com>
 
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
