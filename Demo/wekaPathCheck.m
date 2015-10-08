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

function bool = wekaPathCheck()
%Add the line 'C:\program files\Weka-3-5\weka.jar' to the classpath.txt
%file and restart matlab. Replace '3-5' as necessary depending on the
%version. (To edit, type 'edit classpath.txt').
%
    bool = true;
    w = strfind(javaclasspath('-all'),'weka.jar');
    if(isempty([w{:}]))
        bool = false;
        fprintf('\nPlease add weka.jar to the matlab java class path.\n');
        help wekaPathCheck;
    end
end