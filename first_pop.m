function P=first_pop(pop,n_station,first_station)
    
S=[];V=[];
for i=1:pop
    s=randperm(n_station);
    v=randi(2,1,n_station)-1;
    if nargin==3
        w=find(s==first_station);
        s(w)=[];v(w)=[];
        s=[first_station s];
        v=[1 v];
    end
    S(i,:)=s;
    V(i,:)=v;
end

P={S,V};

end


