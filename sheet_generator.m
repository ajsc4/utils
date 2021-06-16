function [I] = sheet_generator(w_0, lambda, n, X, Y, Z)
%SHEET_GENERATOR Summary of this function goes here
%   Detailed explanation goes here

[X, Y, Z] = meshgrid(X, Y, Z);

z_R = (pi * w_0^2 *n) / lambda;

w_z = w_0 * sqrt(1 + (Z/z_R).^2);

I = (w_0 ./ w_z).^2 .* exp((-X.^2)./w_z.^2); 
%generalise to X and Y dimensions - check maths (sep exponentials)


end

