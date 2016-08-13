I = imread('F:\8th sem\thesis\yawn.png');
%imshow(I);

FaceDetect = vision.CascadeObjectDetector('FrontalFaceLBP');

g = rgb2gray(I);

BBox = step(FaceDetect,g);

face = imcrop(g,BBox);

imresize(face,1);

eyedetect = vision.CascadeObjectDetector('EyePairSmall');

BB = step(eyedetect,face);

 eye = imcrop(face,BB);
 
 MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',200);

  BBm = step(MouthDetect,face);
 c = insertObjectAnnotation(face,'rectangle',BBm,'mouth');
% mouth = imcrop(face,BBm);
 imshow(c);
   subplot(2,2,1),imshow(I),title('Original Image');subplot(2,2,2),imshow(face),title('Face detection');
  subplot(2,2,3),imshow(eye),title('Eye detection');subplot(2,2,4),imshow(c),title('Mouth seperation');
