function x=lim(a,b)
%��x����function�����ֵ�������øú���ʱ��δ����'xxx=....'�򲻻���ֵ�������nargout=0��
% ����'xxx=....'�Ż������ֵ��nargout=1��
%
% lim��������Ϊ�����ɴ� a �� b ����Ȼ����a>=b������a��b��
% x    ��a��b����Ȼ��������a��b��
% a    ָ����Ȼ����Χ����Сֵ
% b    ָ����Ȼ����Χ�����ֵ
if nargin>2
    error('�����������')
elseif nargin==1
    x=a;
elseif nargin==2
    if a>b
        x=b:a;
    else x=a:b;
    end
end

