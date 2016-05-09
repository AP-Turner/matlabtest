% AT 3/10/16
%From Buckmaster's cycle analysis and ASABE 495
%Cycle anyalysis Onceharvester multiple transport machines
%BAE 502 HW week 9
clc; clear;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Crop parmeters

%default
%%{

%Crop parmeters
Y=12; %yield in MgDm/ha
A=150; %Harvest area in ha

Cmh=40; %Max capacity MgDm/ hr
Vh=0; %volume storage capacity Mg/Dm
Efmax=0.8; %Field Effciency
TRh=40; %unload rate MgDm/hr
Iht=1; %unload on the go? (1 yes 0 no)

%Transport
Vt=6; %capacity of transport MgDm/transporter
Dt=12; % Distance traveled round trip km
St=24; %Speed traveled km/hr
Nt=4; %Number of transporters

%Vt=4;
%Nt=6;

Thta=0.03;%Alignment time of transporter h/transporter/cycle
Ttua=0.03;%Alignment time of transporter h/transporter/cycle unload

%Unloader
Cmu=70; %Capacity unloader MgDm/ hr
Lu=0; %Labor at unloader
%}


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



fprintf('The total time to complete the operation is %.2f hours\n',T)
fprintf('The cycle time is %.2f hours\n',CT)
fprintf('The harvest capacity of the system is %.2f MgDm/hr \n',Csys)
fprintf('The actual effciency is %.2f percent \n',Efah)

fprintf('The harvester utilization is %.2f percent \n',Uh)
fprintf('The transporter utilization is %.2f percent \n',Utb)
fprintf('The unloader utilization is %.2f percent \n',Uub)
fprintf('The labor utilization is %.2f percent \n',UL)

% 
% The total time to complete the operation is 62.49 hours
% The cycle time is 0.83 hours
% The harvest capacity of the system is 28.80 MgDm/hr 
% The actual effciency is 0.72 percent 
% The harvester utilization is 0.90 percent 
% The transporter utilization is 1.00 percent 
% The unloader utilization is 0.56 percent 
% The labor utilization is 0.98 percent 
% VT=8 Nt=3
% The total time to complete the operation is 67.07 hours
% The cycle time is 0.89 hours
% The harvest capacity of the system is 26.84 MgDm/hr 
% The actual effciency is 0.67 percent 
% The harvester utilization is 0.84 percent 
% The transporter utilization is 1.00 percent 
% The unloader utilization is 0.48 percent 
% The labor utilization is 0.98 percent 
%  VT=6 Nt=4
% % The total time to complete the operation is 62.49 hours
% The cycle time is 0.83 hours
% The harvest capacity of the system is 28.80 MgDm/hr 
% The actual effciency is 0.72 percent 
% The harvester utilization is 0.90 percent 
% The transporter utilization is 1.00 percent 
% The unloader utilization is 0.56 percent 
% The labor utilization is 0.98 percent 
% %  VT=4 Nt=6
% The total time to complete the operation is 56.25 hours
% The cycle time is 0.75 hours
% The harvest capacity of the system is 32.00 MgDm/hr 
% The actual effciency is 0.80 percent 
% The harvester utilization is 1.00 percent 
% The transporter utilization is 0.99 percent 
% The unloader utilization is 0.70 percent 
% The labor utilization is 0.99 percent 
% 

