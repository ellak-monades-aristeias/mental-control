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

function [predictedClass, classProbs] = wekaClassify(testData,classifier)
% Return the predicted classes for the instances of testData as well as the
% normalized class distributions. Entry classProbs(i,j) represents the
% probability that example i is in class j. Classes are indexed from 0 and
% if originally nominal, the returned values represent the enumerated
% indices. Supposing the training data is called 'data', the class label
% for class j is given by data.classAttribute.value(j). 
%
% classifier    - a trained weka classifier (i.e. trained via
%                 trainWekaClassifier()).
%
% testData      - a weka java Instances object holding the test data. Use
%                 the matlab2weka() function to convert from matlab data to
%                 weka data if necessary.
%
% classProbs    - a matlab n-by-d numeric array. Each row sums to one and
%                 entry classProbs(i,j) represents the probability that 
%                 example i is in class j.
% 
% Written by Matthew Dunham

    if(~wekaPathCheck),classProbs = []; return,end
    for t=0:testData.numInstances -1  
       classProbs(t+1,:) = (classifier.distributionForInstance(testData.instance(t)))';
    end
    [prob,predictedClass] = max(classProbs,[],2);
    predictedClass = predictedClass - 1;  
end