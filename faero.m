%% Difine aerodynamic function

function  [Fd,Fl]   =  faero(h,v,alpha)
%  Calculate  aerodynamic forces
    % Call the ATMOSFER function
    %h=sqrt(x^2+y^2);
[ro, Vsound] = ATMOSFER(h);
Mach=v/Vsound;
% reading the Cd & Cla from file 
fid=fopen('CA.txt','r');
CD=fscanf(fid, '%g', [2 inf])';
fclose(fid);
fid=fopen('CA.txt','r');
CLa=fscanf(fid, '%g', [2 inf])';
fclose(fid);

for ii=1:44
    if ii == 44
        Cd=CD(44,2);
        Cla=CLa(44,2);
        break
    end
    if Mach == CD(ii,1)
        Cd=CD(ii,2);
        Cla=CLa(ii,2);
        break
    elseif Mach == CD(ii+1,1)
        Cd=CD(ii+1,2);
        Cla=CLa(ii+1,2);
        break
    elseif Mach > CD(ii,1) && Mach < CD(ii+1,1)
        Cd=CD(ii,2)+(CD(ii+1,2)-CD(ii,2))/(CD(ii+1,1)-CD(ii,1))*(Mach-CD(ii,1));
        Cla=CLa(ii,2)+(CLa(ii+1,2)-CLa(ii,2))/(CLa(ii+1,1)-CLa(ii,1))*(Mach-CLa(ii+1,1));
        break
    end
end
s=pi*(2.4/2)^2;
Fd = 0.5*ro*v^2*s*Cd;
Fl=0.5*ro*v^2*s*Cla*alpha;

end
