function new_mouth(image)
im = imread(image);

%face detect
FaceDetect = vision.CascadeObjectDetector('FrontalFaceLBP');
g = rgb2gray(im);
BBox = step(FaceDetect,g);
face = imcrop(g,BBox);
  subplot(2,6,1),imshow(face),title('Original image');

%eye detect
eyedetect = vision.CascadeObjectDetector('EyePairSmall');
BB = step(eyedetect,g);
eye = imcrop(g,BB);
  subplot(2,6,7),imshow(eye),title('eye seperation');

%mouth_detect
detector = vision.CascadeObjectDetector('Mouth'); 
threshold = 200;
detector.MergeThreshold = threshold;
bbox = step(detector,g);
[m, n] = size(bbox);
if m==0
while 1
    threshold = threshold-10;
    detector.MergeThreshold = threshold;
    bbox = step(detector,im);
    [a b] = size(bbox);
    if a~=0
        break;
    end
end
end
%   out = insertObjectAnnotation(g, 'rectangle', bbox, 'detection');
%   imshow(out);
bbox(2) = bbox(2)-10;
bbox(4) = bbox(4)-10
x = imcrop(g, bbox);
subplot(2,6,2),imshow(x),title('mouth seperation');
[p,q] = size(x);
x = x(2:p-10, 1:q);
mask = x>108;
subplot(2,6,3),imshow(mask),title('masked image');
mask = imcomplement(mask);

mask = imfill(mask,'holes');
subplot(2,6,4),imshow(mask),title('complemented im and filled holes');

b = strel('diamond', 3);

out = imerode(mask,b);
 subplot(2,6,5),imshow(out),title('After erosion');
y = edge(out, 'log', 0.010);
 subplot(2,6,6),imshow(y),title('Egde detection');

[r1,c1] = find(y);
   x2 = max(r1);
   x1 = min(r1);
   h = x2-x1;
   disp('Mouth height:');
   disp(h);
   y2 = max(c1);
   y1 = min(c1);
   w = y2-y1;
   disp('Mouth width:');
  disp(w);
%mouth detection ended

%-----------------------------------------------------------
%eye detection started
 
[g, h] = size(eye);
eye = eye(3:g-5,1:h);
eyemask = eye>40;
subplot(2,6,8),imshow(eyemask),title('Masked image');
eyecomp = imcomplement(eyemask);
eyecomp = imfill(eyecomp,'holes');
subplot(2,6,9),imshow(eyecomp),title('Complemented im and fill holes');

c = strel('diamond', 4);
out1 = imerode(eyecomp,c);
% y = edge(out1, 'log', 0.010);
subplot(2,6,10), imshow(out1),title('After erosion');

[B,L] = bwboundaries(out1,'noholes');

% Display the label matrix and draw each boundary
subplot(2,6,11),imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

stats = regionprops(L,'Area','Centroid');

threshold = 0.94;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;

  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end

  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','r',...
       'FontSize',10,'FontWeight','bold');

end

title('Round objects');


