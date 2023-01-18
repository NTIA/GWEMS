% Calls GWEMS.m to create PsiM and PsiP for 6 different audio files.
% Results are saved in .mat and .csv files.
%
% Also contains example code to compare new results with reference results
%
% Written January 12, 2023 by S. Voran at Institute for Telecommunication
% Sciences in Boulder, Colorado, United States: svoran@ntia.gov

fnames = {...
'audioShort16k.wav'     %fs = 16k,      length appx. 1.6 sec
'audioLong16k.wav'      %fs = 16k,      length appx. 3.5 sec
'audio22k.wav'          %fs = 22.05k,   length appx. 3.3 sec
'audio32k.wav'          %fs = 32k,      length appx. 2.9 sec
'audio44k.wav'          %fs = 44.1k,    length appx. 5.8 sec
'audio48k.wav'};        %fs = 48k,      length appx. 3.0 sec

for i= 1:6 %Loop over audio files listed
    [PsiM, PsiP] = GWEMS(fnames{i});     %Apply GWEMS.m
    [~, name, ~] = fileparts(fnames{i}); %Extract base filename
    save([name,'.mat'], 'PsiM', 'PsiP'); %Save both variables in .mat
    writematrix(PsiM,[name,'PsiM.csv']);    %Save PsiM in .csv
    writematrix(PsiP,[name,'PsiP.csv']);    %Save PsiP in .csv
end

%Example of how to compare new results with reference results
Ref  = load('audio48kRef.mat'); %load reference results
New = load('audio48k.mat');     %load new results

absError = abs(Ref.PsiM - New.PsiM); %calc. absolute difference for PsiM
%Display mean
disp(['Mean absolute PsiM error is: ', num2str( mean( absError(:) ) )])

absError = abs(Ref.PsiP - New.PsiP); %calc. absolute difference for PsiM
%Display mean
disp(['Mean absolute PsiP error is: ', num2str( mean( absError(:) ) )])