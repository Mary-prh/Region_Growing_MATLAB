clear all
close all
clc

I = imread('Axial_thoraxCT.jpg'); % insert a grayscale image
% I = rgb2gray(I); % Apply if image was RGB
figure(1);
imshow(I,[])
title('Original Image')
figure(2);
imhist(I)
title('Original Image Histogram')

%% Defining a threshold
figure(1);
imshow(I,[])
[x,y] = ginput(1)  % more seed points can be added by changing the number in ginput
Seed_x = round(y);
Seed_y = round(x);
UpperThreshold = input('What is the Upper Threshold?')
LowerThreshold = input('What is the Lower Threshold?')
% thresh_1 = double(I(Seed_x(1,1),Seed_y(1,1))) % first input intensity
% thresh_2 = double(I(Seed_x(2,1),Seed_y(2,1))) % second input intensity
Thr = (abs(UpperThreshold - LowerThreshold))/2
%% Define matrices to save the variables
[m,n] = size(I);
Seen_data = zeros(m,n); % the pixels that are already seen
Seen_data(Seed_x,Seed_y)= 1; % Seed is the first point that we already have seen (Label = 1)
neighbour_label = zeros(m,n); % neighbours of each pixel get labels in iteration
Output = zeros(m,n); % Output of region growing algorithm

while length(Seed_x)~=0 % the loop continues as long as there is no more 
    neighbour_label = zeros(m,n);
    
    for i=1:length(Seed_x) % taking all the seed points
        if Seed_x(i)-1 > 0 && Seed_x(i)+ 1 < m && Seed_y(i)-1 >0 && Seed_y(i)+1< n
            % 1: Computing the "Top" neighbour for each seed point
            if  Seen_data(Seed_x(i)-1,Seed_y(i))~= 1 % checking if we already evaluated the point
                Seen_data(Seed_x(i)-1,Seed_y(i))= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i)-1,Seed_y(i))- I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i)-1,Seed_y(i))= 1; % including the pixel in the set if the condition meets
                end
            end
            
            % 2: Computing the "Top-Left" neighbour for each seed point
            if  Seen_data(Seed_x(i)-1,Seed_y(i)-1)~= 1  % checking if we already evaluated the point
                Seen_data(Seed_x(i)-1,Seed_y(i)-1)= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i)-1,Seed_y(i)-1)- I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i)-1,Seed_y(i)-1)= 1; % including the pixel in the set if the condition meets
                end
            end
            
            
            % 3: Computing the "Top-right" neighbour for each seed point
            if Seen_data(Seed_x(i)-1,Seed_y(i)+1)~= 1 % checking if we already evaluated the point
                Seen_data(Seed_x(i)-1,Seed_y(i)+1)= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i)-1,Seed_y(i)+1)-I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i)-1,Seed_y(i)+1)= 1; % including the pixel in the set if the condition meets
                end
            end
            % 4: Computing the "Left" neighbour for each seed point
            if Seen_data(Seed_x(i)-1,Seed_y(i)+1)~= 1 % checking if we already evaluated the point
                Seen_data(Seed_x(i),Seed_y(i)-1)= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i),Seed_y(i)-1)-I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i),Seed_y(i)-1)= 1; % including the pixel in the set if the condition meets
                end
            end
            
            % 5: Computing the "Right" neighbour for each seed point
            if Seen_data(Seed_x(i),Seed_y(i)+1)~= 1 % checking if we already evaluated the point
                Seen_data(Seed_x(i),Seed_y(i)+1)= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i),Seed_y(i)+1)-I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i),Seed_y(i)+1)= 1; % including the pixel in the set if the condition meets
                end
            end
            
            % 6: Computing the "Bottom" neighbour for each seed point
            if Seen_data(Seed_x(i)+1,Seed_y(i))~= 1 % checking if we already evaluated the point
                Seen_data(Seed_x(i)+1,Seed_y(i))= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i)+1,Seed_y(i))-I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i)+1,Seed_y(i))= 1; % including the pixel in the set if the condition meets
                end
            end
            
            % 7: Computing the "Bottom-left" neighbour for each seed point
            if Seen_data(Seed_x(i)+1,Seed_y(i)-1)~= 1 % checking if we already evaluated the point
                Seen_data(Seed_x(i)+1,Seed_y(i)-1)= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i)+1,Seed_y(i)-1)-I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i)+1,Seed_y(i)-1)= 1; % including the pixel in the set if the condition meets
                end
            end
            
            % 8: Computing the "Bottom-right" neighbour for each seed point
            if Seen_data(Seed_x(i)+1,Seed_y(i)+1)~= 1 % checking if we already evaluated the point
                Seen_data(Seed_x(i)+1,Seed_y(i)+1)= 1; % the point is lebeled by 1 to show that it has been seen
                
                if abs(I(Seed_x(i)+1,Seed_y(i)+1)-I(Seed_x(i),Seed_y(i)))<= Thr % checking the condition
                    neighbour_label(Seed_x(i)+1,Seed_y(i)+1)= 1; % including the pixel in the set if the condition meets
                end
            end
            Output = Output + neighbour_label; % for each seed point the candidate neighbours are added to the output
        end
    end
    [Seed_x,Seed_y]= find(neighbour_label); % All points that are labeled as 1, will become candidates (new seed points)
    
    
    % when there is no neighbor that meets the condition, the output labels
    % all values in 'Output' with 1 and exits from the loop
    if length(Seed_x)==0
        [X_Val,Y_Val] = find(Output);
        for j = 1:length(X_Val)
            Output(X_Val(j),Y_Val(j)) = 1;
        end
        return
    end
end

figure(3)
imshow(Output,[])
title(['Detected Region Threshod = ',num2str(Thr)])
output = logical(Output);
%% colorize the region on the original image

  rgbImage = cat(3, I, I, I); % convert the image to RGB

% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

% Specify the color we want to make this area.
desiredColor = [20, 200, 80]; % Green

% Change the channels of the mask (output) of region growing
redChannel(output) = desiredColor(1);
greenChannel(output) = desiredColor(2);
blueChannel(output) = desiredColor(3);

% Recombine separate color channels into a single, true color RGB image.
rgbImage = cat(3, redChannel, greenChannel, blueChannel);
% Display the image.

figure(4)
imshow(rgbImage);
title('Masked region');





