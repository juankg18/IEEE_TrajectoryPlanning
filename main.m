%
%   Author: Juan Guacheta
% - 15 Jun 2023: Version 1.0
%% Add Folders to Path 
addpath(genpath('./codeForPlanningGeneration/'))
addpath(genpath('./functions/'))
addpath(genpath('./functionsToContour/'))
addpath(genpath('./functionsToMetrics/'))
%% Execute Trajectory Planning for Piece Sphere
Sphere;
%% Execute Trajectory Planning for Piece Star
Star;
%% Execute Trajectory Planning for Piece Spinning
Spinning;
%% Execute Trajectory Planning for Piece Icosahedron
Icosahedron;
%% Execute Trajectory Planning for Piece Queen
Queen;