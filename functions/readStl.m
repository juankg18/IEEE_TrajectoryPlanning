% ==========================================================
% Copyright (C) Damien Berget 2013
% This code is only usable for non-commercial purpose and 
% provided as is with no guaranty of any sort
% ==========================================================
% 
% Matlab STL Slicer step 1.
% See http://exploreideasdaily.wordpress.com for details.

function [vertices, mosaico] = readStl(fileName)

%check type of STL
fid = fopen(fileName, 'r');
strFile = fread(fid, 400, '*char')'
fclose(fid);
if isempty(strfind(strFile, 'facet normal'))
    disp('readBinayStl')
    [vertices, mosaico] = readBinaryStl(fileName);
else
    disp('readTxtStl')
    [vertices, mosaico] = readTxtStl(fileName);
end

function [vertices, mosaico] = readTxtStl(fileName)

%read each triangle
idx = 0;
mosaico =     zeros(1500, 3);
vertices     = zeros(1500*3, 3);

fid = fopen(fileName, 'r');
titleLine = fgetl(fid)
newline = fgetl(fid);
status = 'outface';
while feof(fid) == 0
    switch status
        case 'outface'
            if ~isempty(strfind(newline, 'facet normal'))
                idx = idx + 1;
                status = 'inface';
                triCoo = [];
                
                %grow the tables
                if idx > size(mosaico, 1)
                    mosaico(end+1500,1) = 0;
                    vertices(end+1500*3,1) = 0;
                end
            end
            
        case 'inface'
            if ~isempty(strfind(newline, 'endfacet'))
                status = 'outface';
                vertices((idx-1)*3+[1:3],:) = triCoo;
                mosaico(idx, :) = (idx-1)*3 + [1:3];
            elseif ~isempty(strfind(newline, 'vertex'))
                currCoo = sscanf(newline, '%s %f %f %f')';
                triCoo(end+1,1:3) = currCoo(end-2:end);
            end
    end
    
    newline = fgetl(fid);
end
fclose(fid)

%remove empty data
mosaico(idx+1:end, :) = [];
vertices(idx*3+1:end, :) = [];


function [vertices, mosaico] = readBinaryStl(fileName)

fid = fopen(fileName, 'rb')

%Header :
% UINT8[80] – Header
fread(fid, 80, '*char')

% UINT32 – Number of triangles
numTri = fread(fid, 1, 'uint32')

%read each triangle
%mosaico = zeros(numTri, 3);
mosaico=[];
%vertices     = zeros(numTri*3, 3);
vertices=[];
for idx = 1:numTri
    %write triangle
    % REAL32[3] – Normal vector
    % REAL32[3] – Vertex 1
    % REAL32[3] – Vertex 2
    % REAL32[3] – Vertex 3
    % UINT16 – Attribute byte count    
    
    %ditch normal
    fread(fid, 3, 'single')

    %3 points
    triCoo = fread(fid, 3*3, 'single')
    triCoo = reshape(triCoo, [3,3])'
    vertices((idx-1)*3+[1:3],:) = triCoo
    
    mosaico(idx, :) = (idx-1)*3 + [1:3]
    
    %ditch attibute
    fread(fid, 1, 'uint16');
end

fclose(fid);


