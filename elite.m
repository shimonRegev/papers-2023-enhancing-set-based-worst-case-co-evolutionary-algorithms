function P_elite=elite(P,r,c,pop)


[~,q]=sortrows(-[r,c]);%q
for h=1:2
    P_elite{h}=P{h}(q(1:pop),:);
end

% w=unique(r);w=sort(w,'descend');
% W=1;
% I=find(r==w(W));
% n=length(I);
% [p,~]=size(P_elite);
% while n+p<=pop
%     P_elite=[P_elite;P(I,:)];
%     W=W+1;
%     I=find(r==w(W));
%     n=length(I);
%     [p,~]=size(P_elite);
% end
% 
% m=pop-p;
% s=P(I,:);
% [~,J]=sort(c(I),'descend');
% P_elite=[P_elite;s(J(1:m),:)];
end

