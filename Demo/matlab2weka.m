%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Copyright (c) 2009, Matt Dunham
% % All rights reserved.
% % 
% % Redistribution and use in source and binary forms, with or without
% % modification, are permitted provided that the following conditions are
% % met:
% % 
% %     * Redistributions of source code must retain the above copyright
% %       notice, this list of conditions and the following disclaimer.
% %     * Redistributions in binary form must reproduce the above copyright
% %       notice, this list of conditions and the following disclaimer in
% %       the documentation and/or other materials provided with the distribution
% % 
% % THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% % AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% % IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% % ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% % LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% % CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% % SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% % INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% % CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% % ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% % POSSIBILITY OF SUCH DAMAGE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function wekaOBJ = matlab2weka(name, featureNames, data,targetIndex)
% Convert matlab data to a weka java Instances object for use by weka
% classes. 
%
% name           - A string, naming the data/relation
%
% featureNames   - A cell array of d strings, naming each feature/attribute
%
% data           - An n-by-d matrix with n, d-featured examples or a cell
%                  array of the same dimensions if string values are
%                  present. You cannot mix numeric and string values within
%                  the same column. 
%
% wekaOBJ        - Returns a java object of type weka.core.Instances
%
% targetIndex    - The column index in data of the target/output feature.
%                  If not specified, the last column is used by default.
%                  Use the matlab convention of indexing from 1.
%
% Written by Matthew Dunham

    if(~wekaPathCheck),wekaOBJ = []; return,end
    if(nargin < 4)
        targetIndex = numel(featureNames); %will compensate for 0-based indexing later
    end

    import weka.core.*;
    vec = FastVector();
    if(iscell(data))
        for i=1:numel(featureNames)
            if(ischar(data{1,i}))
                attvals = unique(data(:,i));
                values = FastVector();
                for j=1:numel(attvals)
                   values.addElement(attvals{j});
                end
                vec.addElement(Attribute(featureNames{i},values));
            else
                vec.addElement(Attribute(featureNames{i})); 
            end
        end 
    else
        for i=1:numel(featureNames)
            vec.addElement(Attribute(featureNames{i})); 
        end
    end
    wekaOBJ = Instances(name,vec,size(data,1));
    if(iscell(data))
        for i=1:size(data,1)
            inst = Instance(numel(featureNames));
            for j=0:numel(featureNames)-1
               inst.setDataset(wekaOBJ);
               inst.setValue(j,data{i,j+1});
            end
            wekaOBJ.add(inst);
        end
    else
        for i=1:size(data,1)
            wekaOBJ.add(Instance(1,data(i,:)));
        end
    end
    wekaOBJ.setClassIndex(targetIndex-1);
end