function [v1,v2,V1,V2]=value_path_length(path1,path2,v_station,Coord)

    

L1=one_path_langth_stations(path1,Coord);
L2=one_path_langth_stations(path2,Coord);
N=zeros(1,length(v_station));

d1=N;L1(end)=[];d1(path1(2:end))=L1;
d2=N;L2(end)=[];d2(path2(2:end))=L2;

k1=(gt(d1,0).*eq(d2,0)+gt(d1,0).*lt(d1,d2));
k2=(gt(d2,0).*eq(d1,0)+gt(d2,0).*lt(d2,d1));
k1(path1(1))=1;k2(path2(1))=1;
k1(path2(1))=0;k2(path1(1))=0;
s1=k1.*v_station;
s2=k2.*v_station;

v1=sum(s1);v2=sum(s2);
V1=s1(path1);V2=s2(path2);

end
        
            
  