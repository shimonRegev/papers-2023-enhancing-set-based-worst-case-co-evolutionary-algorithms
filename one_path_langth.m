function L=one_path_langth(path,Coord)

L=0;
path=[path path(1)];
for i=1:length(path)-1
    L=L+sqrt((Coord(path(i+1),1)-Coord(path(i),1))^2+(Coord(path(i+1),2)-Coord(path(i),2))^2);
end

end
    

