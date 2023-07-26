function  [R,r,cr,a,b]=Ration_KokkalaN(A,B,modeA,modeB,Player,DomMode)

if strcmp(modeA,'min')
    A=-A;
end
if strcmp(modeB,'min')
    B=-B;
end
if strcmp(Player,'row')
    A=A';B=B';
end

tol=1e-5;
N=size(A,2);n=size(A,1);
R=nan(N);Rr=R;
cr=zeros(N);
if lt(nargin,6)
    DomMode='Weak';
end
    
if strcmp(DomMode,'Weak')
    for i=1:N-1
        C=zeros(size(A,1),N-i);
        for j=i+1:N
            x=A(:,i)-A(:,j);y=B(:,i)-B(:,j);
    %%%%  if the payoff vector of strategy i dominats the payoff vector of
    %%%%  strategy j Ci=1
            c1=ge(x,0)+gt(y,0);c2=gt(x,0)+ge(y,0);
            Ci=or(eq(c1,2),eq(c2,2));
    %%%%  if the payoff vector of strategy j dominats the payoff vector of
    %%%%  strategy i Cj=1
            c1=le(x,0)+lt(y,0);c2=lt(x,0)+le(y,0);
            Cj=or(eq(c1,2),eq(c2,2));
            C(:,j-i)=Ci-Cj;
            cr(i,j)=and(eq(sum(Cj),0),gt(sum(Ci),0));
            cr(j,i)=and(eq(sum(Ci),0),gt(sum(Cj),0));
            if cr(i,j)==1
               cr(j,i)=-cr(i,j);
            end
            if cr(j,i)==1
               cr(i,j)=-cr(j,i);
            end
        end
        c=sum(C);
        R(i+1:end,i)=c;R(i,i+1:end)=-c;
    end
    o=cr;o(le(o,0))=0;r=gt(sum(o),0);r=eq(r,0); 
end

if strcmp(DomMode,'Strong')
    for i=1:N-1
        C=zeros(size(A,1),N-i);
        for j=i+1:N
            x=A(:,i)-A(:,j);y=B(:,i)-B(:,j);
    %%%%  if the payoff vector of strategy i dominats the payoff vector of
    %%%%  strategy j Ci=1
            c1=ge(x,0)+gt(y,0);c2=gt(x,0)+ge(y,0);
            Ci=or(eq(c1,2),eq(c2,2));
    %%%%  if the payoff vector of strategy j dominats the payoff vector of
    %%%%  strategy i Cj=1
            c1=le(x,0)+lt(y,0);c2=lt(x,0)+le(y,0);
            Cj=or(eq(c1,2),eq(c2,2));
            C(:,j-i)=Ci-Cj;
            cr(i,j)=and(eq(sum(Cj),0),gt(sum(Ci),0));
            cr(j,i)=and(eq(sum(Ci),0),gt(sum(Cj),0));
            if cr(i,j)==1
               cr(j,i)=-cr(i,j);
            end
            if cr(j,i)==1
               cr(i,j)=-cr(j,i);
            end
        end
        c=sum(C);
        R(i+1:end,i)=c;R(i,i+1:end)=-c;
    end
    o=eq(R,-n);o=sum(o);irr=ge(o,1);r=eq(irr,0); 
end

if strcmp(DomMode,'StrongEq')
    for i=1:N-1
        C=zeros(size(A,1),N-i);Cc=C;
        for j=i+1:N
            x=A(:,i)-A(:,j);y=B(:,i)-B(:,j);
    %%%%  if the payoff vector of strategy i dominats the payoff vector of
    %%%%  strategy j Ci=1
            c1=ge(x,0)+ge(y,0);
            Ci=and(ge(x,0),ge(y,0));
    %%%%  if the payoff vector of strategy j dominats the payoff vector of
    %%%%  strategy i Cj=1
            Cj=and(le(x,0),le(y,0));
            C0=and(eq(x,0),eq(y,0));
            Cc(:,j-i)=Ci-Cj-C0;
            C(:,j-i)=Ci-Cj;
            if eq(sum(Ci),n)
                cr(i,j)=1;cr(j,i)=-1;
            end
            if eq(sum(Cj),n)
               cr(i,j)=-1;cr(j,i)=1;
            end
            if and(eq(sum(Ci),n),eq(sum(Cj),n))
               cr(i,j)=0;cr(j,i)=0;
            end
        end
        c=sum(Cc);
        Rr(i+1:end,i)=c;Rr(i,i+1:end)=-c;
        c=sum(C);
        R(i+1:end,i)=c;R(i,i+1:end)=-c;
    end
    o=eq(Rr,-n);o=sum(o);irr=ge(o,1);r=eq(irr,0); 
end

a=A(:,r);b=B(:,r);
if strcmp(modeA,'min')
    a=-a;
end
if strcmp(modeB,'min')
    b=-b;
end
if strcmp(Player,'row')
    a=a';b=b';
end

end

           

            
        
