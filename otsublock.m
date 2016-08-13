function out = graythresh(im)
if isstruct(im)
    im = im.data;
end

if ~isempty(im)
   I = im2uint8(im(:));
   num_bins = 256;
   counts = imhist(I,num_bins);
   p = counts/sum(counts);
   omega = cumsum(p);
   mu = cumsum(p .*(1:num_bins)');
   mu_t = mu(end);

    previous_state = warning('off','MATLAB:divideByZero');
    sigma_b_squared = (mu_t * omega - mu).^2./(omega.*(1-omega));
    warning(previous_state);

    maxval = max(sigma_b_squared);
    isfinite_maxval = isfinite(maxval);
    if isfinite_maxval
        idx = mean(find(sigma_b_squared == maxval));
        level = (idx-1)/(num_bins-1);
        else
        level = 0.0;
    end
else
    level = 0.0;
end

if nargout > 1
    if isfinite_maxval
     em = maxval/(sum(p.*((1:num_bins).^2)')-mu_t^2);
    else
        em = 0;
    end
end

out = (im>level*max(im(:)));
% disp(['Threshold = ',num2str(round(255*level))]);