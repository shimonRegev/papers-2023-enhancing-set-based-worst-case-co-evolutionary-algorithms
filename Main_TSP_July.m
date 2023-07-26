close all
clear 
rng('shuffle')

% HYBRID={'Tuple','WC','Hybrid','Hybrid_Gen'};
ploting=0;
saving=1;
NofCities=12;
for arena=1

FN=['Arenas\',num2str(NofCities),'_cities\Arena_No',num2str(arena)];
load(FN)
n_station=length(station_x);
n=n_station;
station_coord=[station_x, station_y];


%%%  Maximizer -1    Minimizer - 2
OPTIM={'max','min'};
Player={'column','row'};
optim=OPTIM;

% SC the number of sucssesiv generations without chance
SC=10;

%%%%%%%%%%%% general parameters
POP=50;
pop=[1 1]*POP;
pop_h=POP;
n_run=30;
no_gener=100;
Pcross=[1 1]*0.6;
Pmuta=[1 1]*0.1;
CROW={'crow','cong','cm','none','nonex2'};
Type_cowd=CROW{2};
DOMODE={'WC','POSS','Strong','WcRegular','StrongEq','Weak'};
DomMode=DOMODE{4};
col=[0 8 10;6 4 10;0 6 0;8 0 6;2 0 8;10 8 10]/10;


Paremeters.pop=[pop pop_h];
Paremeters.Nruns=n_run;
Paremeters.Ngener=no_gener;
Paremeters.Pcross=Pcross;
Paremeters.Pmuta=Pmuta;
Paremeters.CrowType=Type_cowd;
Paremeters.SC=SC;
Paremeters.Pop=POP;
% Initializing
run_time=nan(1,n_run);
sc_gen=nan(n_run,no_gener);
Time{1}=nan(n_run,no_gener);Time{2}=Time{1};
REP_Path=cell(n_run,no_gener,2);
PATH_norep=cell(n_run,no_gener,2);
PATH_ty=cell(n_run,no_gener,2);
NuSrateIter=cell(n_run,1);
v1=cell(n_run,no_gener,2);v2=v1;v3=v1;v4=v1;v5=v1;
erpl=cell(1,2);E1=cell(1,2);E2=cell(1,2);E1p=cell(1,2);E2p=cell(1,2);
EH1=cell(1,2);EH2=cell(1,2);EH1p=cell(1,2);EH2p=cell(1,2);
N_gener=nan(1,n_run);





%     Arena_name=Arenas{ar};
%     load(['Arenas\',Arena_name])


station_coord=[station_x, station_y];
n_station=length(station_x);


Arena.station_coord=station_coord;
Arena.name=FN;
Arena.n_station=n_station;
Arena.first_station=first_station;
Arena.Limit=LIMIT;
Arena.Values=v_station;

%%

for ru=1:n_run
t=0;
Paremeters.ru=ru;


for k=1:2
    Elite{k}=cell(1,2);
    O{k}=first_pop(pop(k),n_station,first_station(k));
    Elite{k}=O{k};
    for h=1:2
        P{k}{h}=[Elite{k}{h};O{k}{h}];
    end
end 



i=1;
stop_crit=0;sc_new=0;sc_old=0;sc=0;stop_crit(1,2)=0;
Elite_old=Elite;
for k=1:2
    [Elite_norep{k},rep{k},rep_Path{k},Path_norep{k}]=HoF_no_rep_new(Elite{k});
    Path_ty{k}=[1:length(Path_norep{k})]';
end

Path_norep_old=Path_norep;
NuS=[0 pop*2];
for i=1:no_gener
    Paremeters.gener=i;
    %%%%
    ['NuOfCities=',num2str(NofCities),' Arena=', num2str(arena),' Run=',num2str(ru),' Generation=',num2str(i), ' sc='   num2str(sc)]
    %%%%
    a=cell(1,2);b=cell(1,2);R=cell(1,2);r=cell(1,2);C=cell(1,2);Ind=cell(1,2);
    aa=cell(1,2);bb=cell(1,2);Rr=cell(1,2);Cc=cell(1,2);J=[0 0];
    J_old=[1 1];
    ti=0;
    [Ob1,Ob2,~,~,~,~]=fitt_2xP_new(P{1},P{2},station_coord,v_station);
    IT=[];
    tic
    for k=1:2
        [Rr{k},IT(k,:),~,~]=Ratio_one_iter_WC_TupleN(Ob1,Ob2,OPTIM{k},Player{k},'HYBRID');
    end
    th=toc;

    tic
    for k=1:2
        [Rr{k},~,~]=Ratio_one_iter_WC_Tuple(Ob1,Ob2,OPTIM{k},Player{k},'WC');
    end
    tw=toc;

    Time{1}(ru,i)=tw;Time{2}(ru,i)=th;
    N_gener(ru)=i;
    Iteration{ru,i}=IT';
 %%%%%%%%%%%%  Reproduction
        for k=1:2
            Elite_old{k}=Elite{k};
            Elite_norep_old{k}=Elite_norep{k};
            rep_old{k}=rep{k};
            rep_Path_old{k}=rep_Path{k};
            REP_Path{ru,i,k}=rep_Path{k};
            PATH_norep{ru,i,k}=Path_norep{k};
            PATH_ty{ru,i,k}=Path_ty{k};

            Cc{k}=zeros(size(Rr{k}));
            Elite{k}=elite(P{k},Rr{k},Cc{k},pop(k));          
            O{k}=tournament(P{k},pop(k),Rr{k},Cc{k});
            O{k}=cross_over_ordered2(O{k},Pcross(k),pop(k));
            O{k}=mutation(O{k},Pmuta(k));
            for h=1:2
                P{k}{h}=[Elite{k}{h};O{k}{h}];
            end
            [Elite_norep{k},rep{k},rep_Path{k},Path_norep{k}]=HoF_no_rep_new(Elite{k});
            Path_ty{k}=Path_type(Path_norep{k},Path_norep_old{k},Path_ty{k},n_station);
            if eq(length(Path_norep_old{k}),length(Path_norep{k}))
                stop_crit(k)=1;
            else
               stop_crit(k)=0;
            end
            Path_norep_old{k}=Path_norep{k};
        end
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5         
        
        
Results.Ngener=N_gener;
Results.Rep=REP_Path;
Results.Path=PATH_norep;
Results.PathType=PATH_ty;
Results.SRS=v4;
Results.Rep_SRS=v5;
Results.Iteration=Iteration;

sc_new=sum(stop_crit);
if sc_new>1 && sc_old>1
    sc=sc+1;
else
    sc=0;
end
sc_old=sc_new;
sc_gen(ru,i)=sc;
Results.sc_gen=sc_gen;
NuSrateIter{ru}=NuS;
%     if ploting==1
%         n_of_path=4;
%         run('ploting_strategy_space')
%         pause(0.5)
%     end
       
end
run_time(ru)=t;
Results.Total_Run_Time=run_time;
Results.Run_Time=Time;
Results.NuSrateIter=NuSrateIter;
n_of_path=4;
%run('ploting_strategy_space')
if saving==1
    AreName=['NumCities_',num2str(NofCities),'_Arena_No',num2str(arena)];
%   AreName=['NumCities_',num2str(NofCities),'_Arena_No',num2str(arena),'_pop_',num2str(POP),'b'];
  save(['Results\Elite_Results_',AreName],'Results','Paremeters','Arena')
end

end
end



