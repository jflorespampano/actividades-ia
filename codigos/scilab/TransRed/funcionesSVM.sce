//grafica region recibe el vector de alfas, X, Y y b=sesgo
function graficaRegion(alfa,X,Y,b)
   ///grafica la región de decisión
   xmin=min(X(:,1));
   xmax=max(X(:,1));
   ymin=min(X(:,2));
   ymax=max(X(:,2));
   //axis([xmin-0.5 xmax+0.5 ymin-0.5 ymax+0.5]);
   xg=[];
   yg=[];
   zg=[];
   for ix=xmin-0.5:(xmax-xmin+1)/50:xmax+0.5
       for iy=ymin-0.5:(ymax-ymin+1)/50:ymax+0.5
          v=[ix iy];
          d=0;
          for s=1:length(Y)
             d=d+alfa(s)*Y(s)*mi_kernel(X(s,:),v);
          end
          d=d+b;
          xg=[xg ix];
          yg=[yg iy];
          zg=[zg d];
          pentr=find(v(:,1) == X(:,1) & v(:,2) == X(:,2));
          if (length(pentr) == 0)
             if (d >= 1)
                //plot(ix,iy,'gre.');
             else
                if (d >= 0 & d < 1)
                   plot(ix,iy,'cya.');
                else
                    if (d <= -1)
                       //plot(ix,iy,'mag.');
                    else
                       if (d < 0 & d > -1)
                          plot(ix,iy,'yel.');
                       end
                    end
                end 
             end
          end
       end
   end
endfunction
