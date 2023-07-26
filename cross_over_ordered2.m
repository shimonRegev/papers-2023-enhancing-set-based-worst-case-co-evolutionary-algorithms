function P_cross=cross_over_ordered2(P,Pcross,pop)

Q=P{1};q=P{2};
[m,n]=size(Q);

%isa(gg,'chart')
k=min([m-1 max([round(m*Pcross) 1])]);

P_cross=cell(1,2);
Qn=[];
for i=1:2:k
    p=[0 0];
    while abs(p(1)-p(2))<1
        p=randi(n-2,2,1)+1;p=sort(p);
    end
    l=randi(m,2,1);
    P1=Q(l(1),:);P2=Q(l(2),:);
    c=P1(p(1):p(2));
    e=P2(~ismember(P2,c));
    C1=[e(1:p(1)) c e(p(1)+1:end)];
    c=P2(p(1):p(2));
    e=P1(~ismember(P1,c));
    C2=[e(1:p(1)) c e(p(1)+1:end)];
    Qn=[Qn;C1;C2];
%     qn=[qn;q(l(1),:);q(l(2),:)];
end

qn=[];
for i=1:2:k
    l=randi(m,2,1);
    p=randi(n,1);
    P1=q(l(1),:);P2=q(l(2),:);
    C1=[P1(1:p) P2(p+1:end)];
    C2=[P2(1:p) P1(p+1:end)];
    qn=[qn;C1;C2];
end

   
% Qn=[Qn;[Q(l1,1:p) Q(l2,p+1:end)];[Q(l2,1:p) Q(l1,p+1:end)]];
      
[k,~]=size(Qn);
I=randperm(m);
J=I(1:pop-k);
Qn=[Qn;Q(J,:)];
qn=[qn;q(J,:)];

P_cross{1}=Qn;P_cross{2}=qn;
% P_cross{1}=P{1};P_cross{2}=Qn;
end
