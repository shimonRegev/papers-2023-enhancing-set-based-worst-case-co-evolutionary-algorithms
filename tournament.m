function P_tourn=tournament(P,pop,r,c)

P_tourn=cell(1,2);
[p,~]=size(r);
% pop=p/2;
[~,H]=size(P);

for i=1:pop
    I=randi(p,2,1);
    if r(I(1))>r(I(2))
%         P_tourn=[P_tourn;P(I(1),:)];
        for h=1:H
            P_tourn{h}=[P_tourn{h};P{h}(I(1),:)];
        end
    elseif r(I(1))<r(I(2))
%         P_tourn=[P_tourn;P(I(2),:)];
        for h=1:H
            P_tourn{h}=[P_tourn{h};P{h}(I(1),:)];
        end
        elseif r(I(1))==r(I(2))
            if c(I(1))>=c(I(2))
%                 P_tourn=[P_tourn;P(I(1),:)];
                for h=1:H
                    P_tourn{h}=[P_tourn{h};P{h}(I(1),:)];
                end
            else
%                P_tourn=[P_tourn;P(I(2),:)];
               for h=1:H
                    P_tourn{h}=[P_tourn{h};P{h}(I(1),:)];
                end
            end
    end
end
end
        