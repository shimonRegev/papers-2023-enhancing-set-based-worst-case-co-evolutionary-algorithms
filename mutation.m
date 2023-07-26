function P_mut=mutation(P,Pmutat)

[m,n]=size(P{1});
k=min([m-1 max([round(m*Pmutat) 1])]);

Pp=P;
P=Pp{1};
for i=1:k
    I=randi(m,1);
    p=randi(n-1,1,2)+1;
    p1=P(I,p(1));p2=P(I,p(2));
    P(I,p(1))=p2;P(I,p(2))=p1;
end
P_mut{1}=P;
P=Pp{2};
for i=1:k
    I=randi(m,1);
    p=randi(n-1,1)+1;
    P(I,p)=setdiff([0 1],P(I,p));
end
P_mut{2}=P;

end


   