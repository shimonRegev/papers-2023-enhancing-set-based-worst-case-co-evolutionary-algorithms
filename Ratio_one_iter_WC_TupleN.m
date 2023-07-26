function [R,IT,a,b]=Ratio_one_iter_WC_TupleN(A,B,Optim,Player,Hybrid)
% function [a,b,R,S,Ind,dom]=fronts_grads_WC_crow(A,B,mode,modeS)
% Anorm=(max(max(A))-min(min(A)));
% Bnorm=(max(max(B))-min(min(B)));
% A=A/Anorm;B=B/Bnorm;

%%%  A - the first objective
%%%  B - the second objective
%%%  mode - minimization = 'min' or maximization = 'max'
%%%  modeS - the type of in second score. 'IR' = in-rank-grade  or 'crow' = set crowding
%%% Player -'column' or 'row'
IT=[];
if strcmp(Hybrid,'HYBRID') 
    [~,rr,~,A,B]=Ration_KokkalaN(A,B,Optim,Optim,Player,'Strong');
    IT=[IT sum(rr)];
end



if strcmp(Optim,'min')
A=-A;B=-B;
end
if strcmp(Player,'row')
    A=A';B=B';
end

A=-A;B=-B;
    

a=nan(size(A));b=nan(size(B));

[s,n]=size(A);


for i=1:n
    I=pareto(A(:,i),B(:,i),'max','max');
%     [I,~]=pareto_mode(A(:,i),B(:,i),'max','max','deb');
    Ind{i}=I;
    m=length(I);
    a(1:m,i)=A(I,i);b(1:m,i)=B(I,i);
end


r(n,n)=0;


for i=1:n-1
       for j=i+1:n
        A=[a(:,i);a(:,j)];B=[b(:,i);b(:,j)];
        J=pareto(A,B,'max','max');
%         J=pareto_mode(A,B,'max','max','deb');
        Q=zeros(length(A(:)),1);
        Q(J)=1;
        Q=reshape(Q,s,2);
        Q=sum(Q,1);

        if Q(2)==0
            r(j,i)=1;
        end

        if Q(1)==0
            r(i,j)=1;
        end
       end
end

dom=r;

[~,q]=size(r);
J=1:q;
R=zeros(1,q);
c=0;
while q>0
    Q=sum(r);
    I=find(Q==0);
    c=c+1;
    if isempty(I)
        R(J)=c;break
    else
        R(J(I))=c;
        r(:,I)=[];r(I,:)=[];J(I)=[];
        [~,q]=size(r);
    end
end

R=max(R)+1-R';
IT=[IT sum(R==max(R))];

if strcmp(Hybrid,'HYBRID') 
    e=R;
    R=zeros(length(rr),1);
    R(rr)=e;
end





            
%%%%
% if strcmp(modeS,'IR')
%     S = in_rank_grad_new(a,b,R); 
% end
% 
% if strcmp(modeS,'crow')
%     S = OS_crowding(a,b,R);
% end

% if strcmp(modeS,'cm')
%     S = crowding_cm(a,b,R);
% end
% 
% if strcmp(modeS,'cong')
%     S = front_congruence(a,b,R);
% end
% 
% if strcmp(modeS,'none')
%     S = crowding_none(a,b,R);
% end

% if strcmp(modeS,'nonex2')
%     S = ones(n,1);
% end

if strcmp(Optim,'min')
a=-a;b=-b;
end
if strcmp(Player,'row')
    a=a';b=b';
end

end



% 




    