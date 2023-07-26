function L=one_path_langth_stations(path,Coord)

l=0;
path=[path path(1)];
L=[];
for i=1:length(path)-1
    l=l+sqrt((Coord(path(i+1),1)-Coord(path(i),1))^2+(Coord(path(i+1),2)-Coord(path(i),2))^2);
    L=[L l];
end

end
    

