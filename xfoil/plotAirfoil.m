%%%%%
% Copyright (c) 2016 Zach Hazen & A^3 by Airbus Group
%
% Permission is hereby granted, free of charge, to any person obtaining a copy of
% this software and associated documentation files (the "Software"), to deal in
% the Software without restriction, including without limitation the rights to
% use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
% the Software, and to permit persons to whom the Software is furnished to do so,
% subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
% FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
% COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
% IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
% CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%%%%%

function t=plotAirfoil(filename)

%Read airfoil file
fid=fopen(filename);
tline=fgetl(fid); tline=fgetl(fid);
j=1; x=[];
while ischar(tline)
    if ~isempty(tline) && sum(isstrprop(tline,'alpha'))<2 && ~any(strfind(tline,'...'))
        x(j,:)=str2num(tline); j=j+1;
    end
    tline=fgetl(fid);
end
fclose(fid);

%Calculate thickness if requested
if nargout==1
    xu=x([-1;diff(x(:,1))]<=0,:);
    xl=x([-1;diff(x(:,1))]>0,:);
    
    t=0;
    for j=1:length(xu)
        t=max(t,xu(j,2)-interp1(xl(:,1),xl(:,2),xu(j,1)));
    end
    t=t/max(x(:,1));
end

%Plot arifoil
plot(x(:,1),x(:,2))
xlabel('x');ylabel('y');
axis equal