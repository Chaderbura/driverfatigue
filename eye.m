vid = videoinput('winvideo',1);
set(vid,'FramesPerTrigger',1);
set(vid,'TriggerRepeat',inf);
set(vid,'ReturnedColorspace','rgb');
set(vid,'Timeout',50);
vid.FrameGrabInterval = 5;

triggerconfig(vid,'manual');
start(vid)
for ii = 1:50
FaceDetect = vision.CascadeObjectDetector('FrontalFaceLBP');
I = getsnapshot(vid);
trigger(vid);
%figure(1);
%imshow(I);

BB= step(FaceDetect,I);
if(numel(BB)==0)
	continue;
end;

%a=size(BB);
%disp(BB);

rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
Face = imcrop(I,BB);
figure(2); imshow(Face);
EyeDetect=vision.CascadeObjectDetector('EyePairSmall');
BB2=step(EyeDetect,I);
%Face = imcrop(I,BB);
%figure(3); imshow(Face);
%rectangle('Position',BB2,'LineWidth',4,'LineStyle','-','EdgeColor','b');
b=size(BB2)
if(numel(BB2)==0)
	disp('Not Detected');
    
	continue;
else
	disp('Detected');
end;
end;
