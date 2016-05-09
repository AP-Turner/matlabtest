%AT
%3/18/16
%Sensitivity analysis for Buckmaster article
%Look at how # and size of transporters effect the system
%Bae 502 wk9
%r
clear; clc; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Crop parmeters
Y=12; %yield in harvest units/ha
A=150; %Harvest area in ha

Cmh=40; %Max capacity harvest units/ hr
Vh=0; %volume storage capacity Harvest units
Efmax=0.8; %Field Effciency
TRh=40; %unload rate harvest units/hr
Iht=1; %unload on the go? (1 yes 0 no)

%Transport
Vt=[2:10]; %capacity of transport harvest units/transporter
Dt=12; % Distance traveled round trip 
St=24; %Speed traveled di
Nt=[1:6]; %Number of transporters

Thta=0.03;%Alignment time of transporter h/transporter/cycle
Ttua=0.03;%Alignment time of transporter h/transporter/cycle unload

%Unloader
Cmu=70; %Capacity unloader harvest units/ hr
Lu=0; %Labor at unloader
%}
for ii=1:length(Vt)
   for jj=1:length(Nt) 
[CT(ii,jj) Uh(ii,jj) Uta(ii,jj) Utb(ii,jj) Uua(ii,jj) Uub(ii,jj) UL(ii,jj) Csys(ii,jj) Efah(ii,jj) T(ii,jj) Lt(ii,jj) Csys2(ii,jj)]=...
    func_cycle_time(Y,A,Cmh,Vh,Efmax,TRh,Iht,Vt(ii),Dt,St,Nt(jj),Thta,Ttua,Cmu,Lu);
   end
end

 plot(Vt,Csys(:,3),Vt,Csys(:,4),Vt,Csys(:,5))
 xlabel('Transporter Capacity, MgDm'); ylabel('System Capacity, MgDm')
 legend('Three Transporters','Four Transporters','Five Transporters', 'location', 'Southeast')
figure
 plot(Vt,Uh(:,3),'b',Vt,Uh(:,4),'r',Vt,Uh(:,5),'y',Vt,Utb(:,3),'--b',Vt,Utb(:,4),'--r',Vt,Utb(:,5),'--y')
 ylim([0.2 1.1])
 xlabel('Transporter Capacity, MgDm'); ylabel('Utilization, hr/hr')
  legend('Uh Three Transporters','Uh Four Transporters','Uh Five Transporters',...
     'Ut Three Transporters','Ut Four Transporters','Ut Five Transporters', 'location', 'Southeast')
figure
 
surf(Nt,Vt,Csys)

xlabel('Number of Trucks'); ylabel('Transporter capacity, MgDm'); zlabel('System capacity MgDm/hr');


