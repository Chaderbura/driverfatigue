 function feature_extraction(image)
im = imread(image);
% imshow(im);

% % % % % % % % % % Mouth%%%%%%%%%%%%%%%%%%%%%%%%%%
detector = vision.CascadeObjectDetector('Mouth'); 
threshold = 350;
detector.MergeThreshold = threshold;
bbox = step(detector,im);
[m n] = size(bbox);
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
out = insertObjectAnnotation(im, 'rectangle', bbox, 'detection');
 imshow(out);
x = imcrop(im, bbox);
[p q] = size(x);
x = x(2:p-2, 3:q-3);
subplot(1,6,1); imshow(x);
out = blockproc(x, [10 10], @otsublock);

subplot(1,6,2); imshow(out, []);

comp = imcomplement(out);

subplot(1,6,3); imshow(comp);

b = strel('diamond', 1);

out1 = imerode(comp,b);

subplot(1,6,4); imshow(out1);

y = edge(out1, 'log', 0.010);

subplot(1,6,5); imshow(y);

   [r1,c1] = find(y);
   x2 = max(r1);
   x1 = min(r1);
   mouth_h = x2-x1;
   disp('Mouth height:');
   disp(mouth_h);
   y2 = max(c1);
   y1 = min(c1);
   mouth_w = y2-y1;
   disp('Mouth width:');
  disp(mouth_w);

  
  % % % % % % % % % % Nose%%%%%%%%%%%%%%%%%%%%%%%%%%
detector = vision.CascadeObjectDetector('Nose'); 
threshold = 300;
detector.MergeThreshold = threshold;
bbox = step(detector,im);
[m n] = size(bbox);
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
out = insertObjectAnnotation(im, 'rectangle', bbox, 'detection');
% imshow(out);
x = imcrop(im, bbox);
[p q] = size(x);
x = x(2:p-7, 3:q-3);
subplot(1,6,1); imshow(x);
out = blockproc(x, [10 10], @otsublock);

subplot(1,6,2); imshow(out, []);

comp = imcomplement(out);

subplot(1,6,3); imshow(comp);

b = strel('square', 2);

out1 = imerode(comp,b);

subplot(1,6,4); imshow(out1);

   [r1,c1] = find(out1);
   x2 = max(r1);
   x1 = min(r1);
   nose_h = x2-x1;
   disp('Nose height:');
   disp(nose_h);
   y2 = max(c1);
   y1 = min(c1);
   nose_w = y2-y1;
   disp('Nose width:');
  disp(nose_w);

  
  % % % % % % % % % % Left Eye%%%%%%%%%%%%%%%%%%%%%%%%%%
detector = vision.CascadeObjectDetector('LeftEye'); 
threshold = 350;
detector.MergeThreshold = threshold;
bbox = step(detector,im);
[m n] = size(bbox);
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
out = insertObjectAnnotation(im, 'rectangle', bbox, 'detection');
% imshow(out);
x = imcrop(im, bbox);
[p q] = size(x);
x = x(8:p-7, 3:q-5);
subplot(1,6,1); imshow(x);
out = blockproc(x, [10 10], @otsublock);

subplot(1,6,2); imshow(out, []);

comp = imcomplement(out);

subplot(1,6,3); imshow(comp);

b = strel('square', 2);

out1 = imerode(comp,b);

subplot(1,6,4); imshow(out1);

y = edge(out1, 'log', 0.010);

subplot(1,6,5); imshow(y);

   [r1,c1] = find(y);
   x2 = max(r1);
   x1 = min(r1);
   lefteye_h = x2-x1;
   disp('Lefteye height:');
   disp(lefteye_h);
   y2 = max(c1);
   y1 = min(c1);
   lefteye_w = y2-y1;
   disp('Lefteye width:');
  disp(lefteye_w);

  
  % % % % % % % % % % Right Eye%%%%%%%%%%%%%%%%%%%%%%%%%%
%   im = imread('KR.SU1.80.tiff');
detector = vision.CascadeObjectDetector('RightEye'); 
threshold = 350;
detector.MergeThreshold = threshold;
bbox = step(detector,im);
[m n] = size(bbox);
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
out = insertObjectAnnotation(im, 'rectangle', bbox, 'detection');
imshow(out);
x = imcrop(im, bbox);
[p q] = size(x);
x = x(7:p-7, 3:q-5);
subplot(1,6,1); imshow(x);
out = blockproc(x, [10 10], @otsublock);

subplot(1,6,2); imshow(out, []);

comp = imcomplement(out);

subplot(1,6,3); imshow(comp);

b = strel('square', 2);

out1 = imerode(comp,b);

subplot(1,6,4); imshow(out1);

y = edge(out1, 'log', 0.010);

subplot(1,6,5); imshow(y);

   [r1,c1] = find(y);
   x2 = max(r1);
   x1 = min(r1);
   righteye_h = x2-x1;
   disp('Righteye height:');
   disp(righteye_h);
   y2 = max(c1);
   y1 = min(c1);
   righteye_w = y2-y1;
   disp('Righteye width:');
  disp(righteye_w);

  
  %%%%%%%save data to txt file%%%%%%%%%%%%%%%%%%%%%%
  
  fid = fopen('feature.txt','at');
  fprintf(fid,'%d %d %d %d %d %d %d %d \n',mouth_h, mouth_w, nose_h, nose_w, lefteye_h, lefteye_w, righteye_h, righteye_w);
  fclose(fid);
  
