function img_orth=parc_orthview(img_bg,img_parc,opt)
% Overlay labels on the image file and depict three orthogonal views. The
% labels are drawn as color patches.
%     img_bg, image for the background
%     img_parc, image of the parcellation results
%     img_orth, image for orthview
% 2014-10-9 09:21:42

[a,b,c]=size(img_parc);

% add space between the imgs
d=2; % the space between imgs

% left up, y-plane
py0=parc_slice(img_bg,img_parc,[0,ceil(b/2),0]);
py=zeros(c,a,3);
for i=1:3
    py(:,:,i)=rot90(py0(:,:,i));
end

% right up, x-plane
px0=parc_slice(img_bg,img_parc,[ceil(a/2),0,0]);
px=zeros(c,b,3);
for i=1:3
    px(:,:,i)=fliplr(rot90(px0(:,:,i)));
end

% left down, z-plane
pz0=parc_slice(img_bg,img_parc,[0,0,ceil(c/2)]);
pz=zeros(b,a,3);
for i=1:3
    pz(:,:,i)=flipud(pz0(:,:,i)');
end

if nargin<3 || opt==0
    img_orth=ones(c+d+b,a+d+b,3);
    img_orth(1:c,1:a,:)=py;
    img_orth(1:c,a+1+d:a+b+d,:)=px;
    img_orth(c+1+d:c+b+d,1:a,:)=pz;
elseif opt==1
    img_orth=ones(b,2*a+2*d+b,3);
    img_orth(1:b,1:a,:)=pz;
    img_orth(ceil((b-c)/2)+1:ceil((b-c)/2)+c,a+d+1:a+d+a,:)=py;
    img_orth(ceil((b-c)/2)+1:ceil((b-c)/2)+c,2*a+2*d+1:2*a+2*d+b,:)=px;
end

% imshow(img_orth);