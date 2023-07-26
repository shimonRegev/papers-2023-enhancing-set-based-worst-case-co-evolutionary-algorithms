function [HoF_norep,rep,rep_Path,Path_norep]=HoF_no_rep_new(HoF)

[n,m]=size(HoF{1});
H=[HoF{1} HoF{2}];
[sn,a,b]=unique(H,'rows');
HoF_norep{1}=sn(:,1:m);
HoF_norep{2}=sn(:,m+1:end);

rep=nan(size(a));

for i=1:size(a,1)
    rep(i)=sum(b==i);
end
T=zeros(n,m);
for i=1:n
    t=HoF{1}(i,HoF{2}(i,:)==1);
    T(i,1:length(t))=t;
end

[Tt,a,b]=unique(T,'rows');
rep_Path=nan(size(a));
for i=1:size(a,1)
    rep_Path(i)=sum(b==i);
    Path_norep{i}=Tt(i,Tt(i,:)>0);
end

end
