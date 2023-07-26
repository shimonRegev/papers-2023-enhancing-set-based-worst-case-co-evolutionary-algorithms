function I=pareto(A,B,mode_A,mode_B)

r=[];
s=1;w=1;
tolA=-1e-5;
tolB=tolA;

if strcmp(mode_A,'min')
    A=-A;tolA=-tolA;
end

if strcmp(mode_B,'min')
    B=-B;tolB=-tolB; 
end


for i=1:length(A)
%     a=gt(A(i),A);
%     b=gt(B(i),B);
%     a=lt(A-A(i),-tolA);
%     b=lt(B-B(i),-tolB);
    a=gt(A(i),A+tolA)&gt(abs(A-A(i)),abs(tolA));
    b=gt(B(i),B+tolB)&gt(abs(B-B(i)),abs(tolB));
    d=le(abs(A-A(i)),abs(tolA))&lt(abs(B-B(i)),abs(tolB));
    c=ne(a+b+d,0);
    r(i)=sum(c);
end

I=find(r==max(r));I=I';

if nargout > 1
    R=r';
end
end
% for i=1:length(A)
%     [A(i) B(i)]
%     a=gt(A(i),A);
%     b=gt(B(i),B);
%     c=a+b;%gt(a+b,0);
%     [a b c gt(A(i),A)&ge(B(i),B) ge(A(i),A)&gt(B(i),B)]
%     r(i)=sum(c)
% end
% for i=1:length(A)
%     [A(i) B(i)]
%     a1=ge(A(i),A);
%     b1=ge(B(i),B);
%     a2=le(abs(A-A(i)),tol);
%     b2=le(abs(B-B(i)),tol);
%     c1=ge(A(i),A)&gt(B(i),B);
%     c2=gt(A(i),A)&ge(B(i),B);
%     [c1 c2]
%     c=ne(a1+b1,0);
%     c=c&~a2;
%     c=c&~b2;
%     r(i)=sum(c);
% end

% for i=1:length(A)
%     a=ge(A(i),A);
%     b=ge(B(i),B);
% %     c=a+b;
% %     a3=le(abs(A-A(i)),tol);
% %     b3=le(abs(B-B(i)),tol);
%     c=gt(a+b,0);
% %     c=ge(a-a3,0)+ge(b-b3,0);
% %     c=gt(a-a3,0)+ge(b-b3,0)+ge(a-a3,0)+gt(b-b3,0);
% % %     r(i)=sum(c);
% % end
% 
% I=find(r==max(r));
% 
% 
% end

