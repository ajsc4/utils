function sphere = sphere(radius, array_size)

    if radius > array_size/2
        error('Radius exceeds array size');
    
    else
        centre = array_size/2;

        x = 1:array_size;  y = 1:array_size; z = 1:array_size;
        [X, Y, Z] = meshgrid(x, y, z);

        sphere1 = (X - centre).^2 + (Y - centre).^2 + (Z - centre).^2 <= radius.^2;
        sphere2 = (X - centre).^2 + (Y - centre).^2 + (Z - centre).^2 <= (radius - 1).^2;
        
    end
    
sphere = double(sphere1.*100 - sphere2.*100);



