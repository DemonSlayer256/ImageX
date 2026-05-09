function image_filter()

pkg load image;

args = argv();

% ---------------- HELP / ARG CHECK ----------------
if length(args) < 2 || strcmp(args{1}, '--help')

    fprintf('\n========================================\n');
    fprintf(' IMAGE FILTER TOOL (Octave CLI)\n');
    fprintf('========================================\n\n');

    fprintf('USAGE:\n');
    fprintf('  octave -qf image_filter.m <filter> <input> [value]\n\n');

    fprintf('FILTERS:\n');
    fprintf('  g  - grayscale\n');
    fprintf('  r  - reflect\n');
    fprintf('  b  - blur\n');
    fprintf('  e  - edges\n');
    fprintf('  s  - sepia\n');
    fprintf('  l  - brightness (requires value)\n');
    fprintf('  c  - contrast (requires value)\n');
    fprintf('  t  - threshold (requires value)\n\n');

    fprintf('EXAMPLES:\n');
    fprintf('  octave -qf image_filter.m g images/courtyard.bmp\n');
    fprintf('  octave -qf image_filter.m l images/courtyard.bmp 60\n');
    fprintf('  octave -qf image_filter.m c images/courtyard.bmp 1.8\n');
    fprintf('  octave -qf image_filter.m t images/courtyard.bmp 140\n\n');

    return;
end

filter = args{1};
inputfile = args{2};

if ~isfile(inputfile)
    error('Input file does not exist.');
end

[~, name, ext] = fileparts(inputfile);

fprintf('[INFO] Loading: %s\n', inputfile);
img = imread(inputfile);

tic;

% FILTER ROUTER

switch filter

    % ---------------- GRAYSCALE ----------------
    case 'g'
        output = grayscale(img);
        outputfile = strcat(name, '_grayscale', ext);

    % ---------------- REFLECT ----------------
    case 'r'
        output = fliplr(img);
        outputfile = strcat(name, '_reflect', ext);

    % ---------------- BLUR ----------------
    case 'b'
        output = blur(img, 3);
        outputfile = strcat(name, '_blur', ext);

    % ---------------- EDGES ----------------
    case 'e'
        output = edges(img);
        outputfile = strcat(name, '_edges', ext);

    % ---------------- SEPIA ----------------
    case 's'
        output = sepia(img);
        outputfile = strcat(name, '_sepia', ext);

    % ---------------- BRIGHTNESS ----------------
    case 'l'

        if length(args) < 3
            error('Brightness requires value: l <image> <value>');
        end

        val = str2double(args{3});
        output = brightness(img, val);

        outputfile = strcat(name, '_brightness_', num2str(val), ext);

    % ---------------- CONTRAST ----------------
    case 'c'

        if length(args) < 3
            error('Contrast requires value: c <image> <value>');
        end

        val = str2double(args{3});
        output = contrast(img, val);

        outputfile = strcat(name, '_contrast_', num2str(val), ext);

    % ---------------- THRESHOLD ----------------
    case 't'

        if length(args) < 3
            error('Threshold requires value: t <image> <value>');
        end

        val = str2double(args{3});
        output = threshold(img, val);

        outputfile = strcat(name, '_threshold_', num2str(val), ext);

    otherwise
        error('Invalid filter option.');
end

% ---------------- SAVE OUTPUT ----------------

imwrite(output, outputfile);

fprintf('[INFO] Saved: %s\n', outputfile);
fprintf('[INFO] Time: %.4f sec\n', toc);

end

% HELPER FUNCTIONS

function out = grayscale(img)
    if size(img,3) == 3
        out = uint8(0.299*double(img(:,:,1)) + ...
                    0.587*double(img(:,:,2)) + ...
                    0.114*double(img(:,:,3)));
    else
        out = img;
    end
end

function out = blur(img, k)
    kernel = ones(k,k)/(k*k);

    if size(img,3) == 3
        out = zeros(size(img), 'uint8');
        for c = 1:3
            out(:,:,c) = uint8(conv2(double(img(:,:,c)), kernel, 'same'));
        end
    else
        out = uint8(conv2(double(img), kernel, 'same'));
    end
end

function out = edges(img)

    if size(img,3) == 3
        img = rgb2gray(img);
    end

    img = double(img);

    Gx = [-1 0 1; -2 0 2; -1 0 1];
    Gy = [-1 -2 -1; 0 0 0; 1 2 1];

    gx = conv2(img, Gx, 'same');
    gy = conv2(img, Gy, 'same');

    mag = sqrt(gx.^2 + gy.^2);
    mag(mag > 255) = 255;

    out = uint8(mag);
end

function out = sepia(img)

    if size(img,3) ~= 3
        img = repmat(img,1,1,3);
    end

    T = [
        0.393 0.769 0.189;
        0.349 0.686 0.168;
        0.272 0.534 0.131
    ];

    reshaped = reshape(double(img), [], 3);

    sepia = reshaped * T';
    sepia = min(sepia, 255);

    out = uint8(reshape(sepia, size(img)));
end

function out = brightness(img, val)

    img = double(img) + val;

    img(img > 255) = 255;
    img(img < 0) = 0;

    out = uint8(img);
end

function out = contrast(img, factor)

    img = double(img);

    meanVal = mean(img(:));

    img = (img - meanVal) * factor + meanVal;

    img(img > 255) = 255;
    img(img < 0) = 0;

    out = uint8(img);
end

function out = threshold(img, thresh)

    if size(img,3) == 3
        img = rgb2gray(img);
    end

    img = double(img);

    img(img >= thresh) = 255;
    img(img < thresh) = 0;

    out = uint8(img);
end