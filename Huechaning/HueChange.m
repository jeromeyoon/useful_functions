function ConvertImages = HueChange(f ,Size)

getd = @(p)path(p,path); % scilab users must *not* execute this
getd('toolbox_signal/');
getd('toolbox_general/');

Value = @(f)sum(f, 3) / sqrt(3);

A = @(f)( f(:,:,2)-f(:,:,3) )/sqrt(2);
B = @(f)( 2*f(:,:,1) - f(:,:,2) - f(:,:,3) )/sqrt(6);

T = [   1/sqrt(3) 1/sqrt(3) 1/sqrt(3); ...
    0 1/sqrt(2) -1/sqrt(2); ...
    2/sqrt(6) -1/sqrt(6) -1/sqrt(6)];

Saturation = @(f)sqrt( A(f).^2 + B(f).^2 );

Hue = @(f)atan2(B(f),A(f));
rgb2hsv1 = @(f)cat(3, Hue(f), Saturation(f), Value(f));
g = rgb2hsv1(f);

% clf;
% imageplot({g(:,:,1) g(:,:,2) g(:,:,3)}, {'H' 'S' 'V'}, 1,3);

a = @(g)g(:,:,2) .* cos(g(:,:,1));
b = @(g)g(:,:,2) .* sin(g(:,:,1));
% This ugly code is for Scilab compatibility
c = @(g)cat(3, g(:,:,3), a(g), b(g));
applymat = @(f,T)reshape( reshape(f, [Size(1)*Size(2) 3])*T, [Size(1) Size(2) 3] );
hsv12rgb = @(g)applymat(c(g),T);
% clf;
theta = linspace(0,pi/2,6);
for i=1:6
    g1 = g;
    g1(:,:,1) = g1(:,:,1) + theta(i);
%     imageplot(rgb2gray(clamp(hsv12rgb(g1))), ['\theta=' num2str(theta(i))], 2,3,i);
    ConvertImages{i} = clamp(hsv12rgb(g1));    
end

