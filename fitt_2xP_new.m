function [difL,difV,L,V,PATH,Vs]=fitt_2xP_new(Pop1,Pop2,Coord,value)

% P1 colomn player P2 row player
Pop{1}=Pop1;Pop{2}=Pop2;n=zeros(1,2);m=n;
P=cell(1,2);S=P;PATH=P;l=P;
for q=1:2
    P{q}=Pop{q}{1};
    S{q}=Pop{q}{2};
    [n(q),m(q)]=size(P{q});
    for i=1:n(q)
        PATH{q}{i}=P{q}(i,S{q}(i,:)==1);
        l{q}{i}=one_path_langth(PATH{q}{i},Coord);
    end
end

for i=1:n(1)
    p1=PATH{1}{i};
    for j=1:n(2)
        p2=PATH{2}{j};
        L1(j,i)=l{1}{i};
        L2(j,i)=l{2}{j};
        [v1,v2,v1_all,v2_all]=value_path_length(p1,p2,value,Coord);
%         [v1,v2,v1_all,v2_all]=value_path(p1,p2,value);
        V1(j,i)=v1;V2(j,i)=v2;
        Vs1{j,i}=v1_all;Vs2{j,i}=v2_all;
    end
end
difL=L2-L1;
difV=V1-V2;
L{1}=L1;L{2}=L2;
V{1}=V1;V{2}=V2;
Vs{1}=Vs1;Vs{2}=Vs2;
% PATH1=PATH{1};PATH2=PATH{2};
end

