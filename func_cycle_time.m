
function[CT Uh Uta Utb Uua Uub UL Csys Efah T Lt Csys2]=func_cycle_time(Y,A,Cmh,Vh,Efmax,TRh,Iht,Vt,Dt,St,Nt,Thta,Ttua,Cmu,Lu)


% AT 3/10/16
%From Buckmaster's cycle analysis and ASABE 495
%Cycle anyalysis Onceharvester multiple transport machines

% Function for sensitivity analysis 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Calculations%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Vc=Vt*Nt;%Volume/cycle MgDm- One cycle is one "round" by all transporters
Ttuu=Vt/Cmu;% Transport unload time h/cycle
Tt=Dt/St; %Travel time h/cycle
Thtt=(1-Iht)*Vt/TRh;%transport harvester interaction time goes away with unload on the go h/cycle

%Harvest unload interaction if unload on the go takes into account if the
%capacity of the cart is greater than the combine
if Vt>Vh
    Thth=(Vt-Vh)/(Cmh*Efmax); %Time for harvest transport interacton hrs
else
    Thth=0;
end

%CT without idle time in hours

CTh=Vc/(Cmh*Efmax)+Thtt*Nt;%Combine cycle time: Time to harvest required volume+ time unloading extra capacity on the go
%%%% I think Cth might be double counting some
CTt=Ttua+Ttuu+Thtt+Thth+Tt; % Ct for transport drive time + load and unload time+ alighn \
CTu=Nt*(Ttua+Ttuu); %line up and unload

%Pick cycle time. Assigns responsiblity for harvester cart alignment to
%least busy piece of equipment
if (CTt+Thta>CTh+Nt*Thta)
    CT=max([CTh+Nt*Thta,CTt,CTu]);
else
    CT=max([CTh,CTt+Thta,CTu]);
end

%Idle time in hours Cycle time minus utilized time
if (CTt+Thta>CTh+Nt*Thta)
    Tih=CT-CTh-Nt*Thta;
    Tit=CT-CTt;
else
    Tih=CT-CTh;
    Tit=CT-CTt-Thta;
end

Tiu=CT-CTu;

L=1+Nt+Lu; % # of laborers (1 combine)

Li=Tih+Tit*Nt+Lu*Tiu;%Idle labor hours


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Outputs%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Uh=Vc/(Cmh*Efmax)/CT; %utilization harvester
Uta=Tt/CT;%Utilization for travel
Utb=(CT-Tit)/CT;%overal utilization
Uua=Nt*(Vt/Cmu)/CT;%Utilization to unload
Uub=CTu/CT;%Utilization overall
UL=1-Li/(L*CT);%Labor Utilization

Csys=Uh*Efmax*Cmh;%Harvest capacity of system
Efah=Csys/Cmh;%Actual effciencty

T=Y*A/Csys;%total time required
Lt=L*T;%Total labor costs
Csys2=Vc/CT;%check



end




