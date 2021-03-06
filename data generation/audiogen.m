function [audio,stretchFactor] = audiogen(clean_audio,Fs,n,FilePath)
%% 
%This code takes a cell containing a set of clean recordings and adds
%different types of noise to it
%Inputs: clean_audio  ->    a cell structure in which each cell represents an
%                           audio array
%        Fs           ->    Sampling rate of the audio files
%        n            ->    Number of audio files
%        FilePath     ->    File path to the location of the noise cheering
%                           audio files
%Outputs: audio       ->    A cell containing corrupted versions of the
%                           the audio in clean_audio
%         stretchFactor ->  Indicates the resample factor done on each
%                           audio file
%% Initializing
files = dir(FilePath);
%Setting the filter cutoffs
Wp = [(11000)*rand+5000 (11000)*rand+5000 400*rand+200 400*rand+200];
Ws = [Wp(1)+1000 Wp(2)+1000 70 70];
%Setting the type of filter
type = ['low ';'low ';'high';'high'];


%Setting the type of degradation
degrType = cell([2 1]);
degrType{1} = 'smartPhoneRecording';
degrType{2} = 'liveRecording';

audio = cell([n 1]);
for i = 1:n
    y = clean_audio{i};
y = mean(y,2);
y = y./max(abs(y));
e = 1;
    [noise,fs] = audioread(files(randi([1 4])).name);
    noise = mean(noise,2);
    noise = resample(noise,Fs,fs);
    if length(noise)<length(y)
        p = zeros([length(y)-length(noise) 1]);
        noise = [noise;p];
    elseif length(noise)>=length(y)
        noise = noise(1:length(y));
    end
    en =  sum(abs(noise).^2)/length(noise);
    noise = noise*sqrt(e/en);
    noise = circshift(noise,round(rand*length(noise)));
    x = y*(10^(0/20))+noise*(10^((6*rand-36)/20));
  
    temp = randi([1 4]);
    [r,Wr] = buttord(Wp(temp)*2/Fs,Ws(temp)*2/Fs,3,60);
    wrd = type(temp,:);
    wrd(wrd == ' ') = [];
    [b,a] = butter(r,Wr,wrd);
    x = filter(b,a,x);
    ex =  sum(abs(x).^2)/length(x);
    x = x*sqrt(e/ex);
    %Resampling
    FsNew = 44100+randi([-100 100]);
    stretchFactor(i) = FsNew/44100;
    x = resample(x,FsNew,44100);
    audio{i} = x;
        audio{i} = applyDegradation(degrType{randi([1 2])},audio{i},Fs);
         audio{i} = applyDegradation('liveRecording',audio{i},Fs);
         audio{i} = applyDegradation('smartPhoneRecording',audio{i},Fs);

    ex =  sum(abs(audio{i}).^2)/length(audio{i});
    audio{i} = audio{i}*sqrt(e/ex);
    
  
end
    
