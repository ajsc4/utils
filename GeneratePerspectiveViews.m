%% Parameters
parameters.N_ulenses=3; parameters.MinViews = 5;
parameters.f_u=25;%200;%50;%25;%12.5
parameters.f_4f=75;%200;%120;%75;%55 

parameters.f_obj=3;parameters.n=1.518; 
parameters.NA=1.42; parameters.f_TL=200; parameters.lambda=630e-6; parameters.k=2*pi*parameters.n/parameters.lambda;
parameters.M=(parameters.f_TL/parameters.f_obj)*(parameters.f_u/parameters.f_4f); 
parameters.TotalPixels = 2000;
z = 0;          

size_BFP=(2*parameters.f_obj*parameters.NA*parameters.f_4f/parameters.f_TL);

size_ulens=size_BFP/parameters.N_ulenses;%0.5417;%1.625; %0.975
size_px = size_BFP/parameters.TotalPixels;

%% Inputs
objectIndex = [0 0 0];

u=(-size_BFP/2):size_px:(size_BFP/2);
v=u;
[u,v]=meshgrid(u,v);

FieldBFP = zeros(size(u));

%% Phase of Lenslet
size_ulens_pix=round(size_ulens/size_px);%-1
single_lens=-parameters.k/(2*parameters.f_u)*(u.^2+v.^2);
mid_pos=round(size(single_lens)/2);
single_lens=single_lens(mid_pos(1)+round((-size_ulens_pix/2:size_ulens_pix/2)),mid_pos(2)+round((-size_ulens_pix/2:size_ulens_pix/2)));

%% Phase of MLA
lens_array_ph=zeros(size(u));
pos_lens_x=round(size(u,1)/2)+size_ulens_pix*(-(parameters.N_ulenses-1)/2:(parameters.N_ulenses-1)/2);pos_lens_y=round(size(u,2)/2)+size_ulens_pix*(-(parameters.N_ulenses-1)/2:(parameters.N_ulenses-1)/2);
[pos_lens_x,pos_lens_y]=meshgrid(pos_lens_x,pos_lens_y);
lens_array_ph(sub2ind(size(lens_array_ph),pos_lens_x,pos_lens_y))=1;

apperture=(u.^2+v.^2)<(size_BFP/2)^2;
lens_array_ph=conv2(lens_array_ph,single_lens,'same');
lens_array=exp(1j*(lens_array_ph)).*apperture;%.*exp(1i*z*k*1E-3*axial_ph)


