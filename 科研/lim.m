function x=lim(a,b)
%‘x’是function的输出值，若调用该函数时，未键入'xxx=....'则不会有值输出（即nargout=0）
% 键入'xxx=....'才会有输出值（nargout=1）
%
% lim函数作用为，生成从 a 到 b 的自然数（a>=b，包括a，b）
% x    从a到b的自然数（包括a，b）
% a    指定自然数范围的最小值
% b    指定自然数范围的最大值
if nargin>2
    error('输入变量过多')
elseif nargin==1
    x=a;
elseif nargin==2
    if a>b
        x=b:a;
    else x=a:b;
    end
end

