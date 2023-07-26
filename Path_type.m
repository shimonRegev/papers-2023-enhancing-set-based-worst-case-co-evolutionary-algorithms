function Path_t_new=Path_type(Path_new,Path_old,Path_t_old,n_station)


% [~,k]=size(Path_old);
Path={Path_old Path_new};
for p=1:2
    P=Path{p};
    n=length(Path{p});
    T{p}=zeros(n,n_station);
    for i=1:n
        t=P{i};
        T{p}(i,1:length(t))=t;
    end
end


Told=T{1};Tnew=T{2};
% Path_t_new=cell(1,2);

Path_t_new=nan(size(Tnew,1),1);
t=size(Told,1);
for i=1:size(Tnew,1)
    q=ismember(Told,Tnew(i,:),'rows');
    if sum(q)==0
        t=t+1;
        Path_t_new(i)=t;
    else
        Path_t_new(i)=Path_t_old(q);
    end
end

end


