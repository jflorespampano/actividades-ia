function [Kxcxc]=Kdexcixcj(Xmenos,Xmas)
Kxcxc=0;
for j=1:length(Xmenos)
   for i=1:length(Xmas)
      Kxcxc=Kxcxc+kernel(Xmas([i],:),Xmenos([j],:));
   end
end
Kxcxc=Kxcxc/(length(Xmenos)*length(Xmas));
