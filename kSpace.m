    % small Program,to play in k
    
    % load MR image data   
    % magnitude image
    open('./matlab_FLASH_MAGN.mat');
    abs_v=ans.root.voxel;
    
    % phase image
    open('./matlab_FLASH_PHASE.mat');
    phase_v=ans.root.voxel / 4096*pi ;
    
    % complex image data
    z = abs_v.*exp(1i*phase_v);
    
 
    % show input image
    figure(1); 
    imagesc(abs(z));
    colormap bone

    figure(2); 
    imagesc(angle(z));
    colormap bone
    
    % k-Space transform
    A=fft2(z);
    A=fftshift(A);




%Gradient delay artifact
  % every second k-space line -> is shifted to the left (EPI error)
%      for i=1:64      
%         A(2*i,1:128-4)=A(2*i,1+4:128);             
%       end

 

% Get rid of outer k-space lines
%   for j=1:128      
%         for k=1:128
%         if (j-64)*(j-64)+(k-64)*(k-64)-10*10>0
%             A(j,k)=0;
%        end
%        end
%   end
 

% Get rid of inner k-space lines
%   for j=1:128      
%         for k=1:128
%         if (j-64)*(j-64)+(k-64)*(k-64)-30*30<0
%             A(j,k)=0;
%        end
%        end
%   end
    
% every  k-space line -> is shifted 
% schift im K-space results in Phasenwraps in Image space
%       for i=1:120 
%         A(i,1:128)=A(i+8,1:128);  
%       end
      
      
% shift in both directions      
%      l=0;
%      for i=35:85
%        
%          A(i,1:128-l)=A(i,1+l:128);  
%          l=l+1;
%          
%          end
%     for m=35:85
%         for n=1:128
%         if m+n>128+35
%             A(m,n)=0;
%         end
%         end
%     end


%delete half of K-space in  Partial fourier Acquisition to simulieren
%      for y=70:128
%          for x=1:128
%            A(y,x)=0;
%          end
%       end


%T2 Effett for center out acquisition
% t2=1/8*128*128;
% for i=1:64
%    k=abs(32-i);
%    for j=1:128
%        A(2*i-1,j)=exp(-(j+(2*k-1)*128)/t2)*A(2*i-1,j);
%        A(2*i,j)=exp(-(128-j+(2*k)*128)/t2)*A(2*i,j);
%    end
% end

%T2 Effect for out-center out acquisition.
% t2=1/3*128*128;
% t=0;
% for i=1:64
%    for j=1:128
%        A(2*i-1,j)=exp(        -(j+t*128)/t2)*A(2*i-1,j); 
%        A(2*i,j)  =exp(-(128-j+(t+1)*128)/t2)*A(2*i,j);     
%    end
%     t=t+2;
% end

%Fat oszillation
%    N = 128*128;
%    t = 0;
%    t2= 0.5 * N;
%    T = 4.2; % time of oscillations per readout
%    for i=1:128
%    for j=1:128
%        A(i,j)=exp(-t/t2)*A(i,j)*(1-0.8*sin(t*T*2*pi/N));
%        t= t+1;
%    end
% end

  
%bright spot weighting
%   for j=1:128      
%        for k=1:128
%        if (j-65)*(j-65)+(k-65)*(k-65)-35*35<0
%            A(j,k)=3*A(j,k);
%       end
%       end
%  end

     % delete lower part and reconstruct from above
%      A(65:128,1:128)=0;
%      for y=65:128
%          for x=1:128
%            A(y,x)=A(129-y,129-x)*-1;
%          end
%       end

    figure(3);
    imagesc(angle(A));
    colormap bone

    figure(4);
    imagesc(abs(A));
    colormap jet
    
    % Back transformation in image space
    z3 = z;
    A=ifftshift(A);
    z3=ifft2(A);
   
   
    % Show figures in image space again
    figure(7);
    imagesc(abs(z3));
    colormap bone
     
    figure(8);
    imagesc(angle(z3));
    colormap bone
