function [image, sheet] = forward_image(beam_waist)

    pixel_size = 150E-9; volume_size = 15E-6;
    array_size = volume_size/pixel_size;

    lambda = 640E-9;
    NA = 1.4; 
    f_obj = 3E-3; f_TL = 200E-3; f_4f = 125E-3; 

    BFP_diameter = 2*f_obj*NA*(f_4f/f_TL);
    ulens_diameter = 1E-3;
    NA_mla = ulens_diameter/BFP_diameter;

    sigma_image = ((0.45*lambda)/(2*NA_mla))/pixel_size; %amount of gaussian blur on image - based on NA of microlens

    X = -volume_size/2:pixel_size:volume_size/2 - pixel_size;
    Y = -volume_size/2:pixel_size:volume_size/2 - pixel_size;
    Z = Y;
    Z_sheet =  -volume_size/2:pixel_size/10:volume_size/2 - pixel_size/10;

    %beam_waist = 5E-6;
    sheet = sheet_generator(beam_waist, lambda, 1.33, X, Y, Z); %creates gaussian beam focused in one dimension.

    camera_pixelsize = 5E-6; %not yet used - could use as parameter for downsampling image.

    %% Simulate image stack
    sphere = sphere_shell(array_size/4, array_size); sphere1 = circshift(sphere, [0 array_size/2 0]);

    skew_u = 1; %ideally want to calculate from lens coordinate - defines amount each z-position is shifted in z to form perspective view.
    skew_v = 0;

    shifted = zeros(numel(X), numel(Y), numel(Z));
    image = zeros(numel(X), numel(Y), numel(Z));

    for u = 1:numel(Z)

        sphere_translated = circshift(sphere1, [0 -u 0]);
        %%
        section = sphere_translated.*sheet; 

        for k = 1:numel(Z)
            shifted(:,:,k) = imtranslate(section(:,:,k), [skew_u*k - (numel(Z)/2), skew_v*k ]); 
        end

        image(:,:,u) =  imgaussfilt(sum(shifted, 3), sigma_image);

    end 
    
image = image;