%This program is written by my Supervisor YU. A. Moshinskii for me :)
%This program need to run together with Matriza.m
function dy = ad3sim(t,y);

    global  A G R pol Jr Mnom w1 Km Kj Un k
%Coefficients of differential equations
%Variable currents
% y(1) = iA  ; y(2) = iB ; y(3) = iC ;   %Stator Currents
% y(4) = ia  ; y(5) = ib ; y(6) = ic ;   %Rotor  Currents
% y(7) = wr  ;                           %frequency of rout
%==========================================================================
% Different Equations for stator current
    U1 = Un * sin(w1*t);
    U2 = Un * sin(w1 * t - 2*pi/3);
    U3 = Un * sin(w1 * t + 2*pi/3);
    dy(1) = A(1,1)*U1 - R(1,1)*y(1) - R(1,4)*y(4) -...
            0.577*y(7)* ( G(1,2)*y(2) + G(1,3)*y(3) + G(1,5)*y(5) + G(1,6)*y(6) );
    dy(2) = A(2,2)*U2 - R(2,2)*y(2) - R(2,5)*y(5) -...
            0.577*y(7) * ( G(2,1)*y(1) + G(2,3)*y(3) + G(2,4)*y(4) + G(2,6)*y(6) );
    dy(3) = A(3,3)*U3 - R(3,3)*y(3) - R(3,6)*y(6) -...
            0.577*y(7) * ( G(3,1)*y(1) + G(3,2)*y(2) + G(3,4)*y(4) + G(3,5)*y(5) );
%==========================================================================
%Differential Equations for Rotor currents
   dy(4) = A(4,1)*U1 - R(4,1)*y(1) - R(4,4)*y(4) -...
            0.577*y(7)* ( G(4,2)*y(2) + G(4,3)*y(3) + G(4,5)*y(5) + G(4,6)*y(6) );
    dy(5) = A(5,2)*U2 - R(5,2)*y(2) - R(5,5)*y(5) -...
            0.577*y(7) * ( G(5,1)*y(1) + G(5,3)*y(3) + G(5,4)*y(4) + G(5,6)*y(6) );
    dy(6) = A(6,3)*U3 - R(6,3)*y(3) - R(6,6)*y(6) -...
            0.577*y(7) * ( G(6,1)*y(1) + G(6,2)*y(2) + G(6,4)*y(4) + G(6,5)*y(5) ); 
%==========================================================================
%Equations of torque  (Load) limitation
    if t<=0.05
        Mc=0;
    else
        Mc=Mnom;
    end
%==========================================================================
%Torque Mem         Moment equation
    mem = Km * (   y(4)*( y(2)-y(3) ) + y(5)*( y(3)-y(1) ) + y(6)*( y(1)-y(2) )   );
%==========================================================================
%Equation of rout,
    dy(7) = Kj * ( mem-Mc ); %omega equation
    
    k = k+1 ;
    
    %if k == 500 
    %    disp('  <Calculation of Diff. Equation>....N=500');
    %end;
    %if k == 1500 
    %    disp('  <Calculation of Diff. Equation>....N=1500');
    %end;
    %if k == 5000 
    %    disp('  <Calculation of Diff. Equation>....N=5000');
    %end;  
  
    dy = [ dy(1), dy(2) , dy(3), dy(4) , dy(5) , dy(6) , dy(7) ]';
return
%The program END
