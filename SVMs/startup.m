%% Add path to pmtk3 and initialize it everytime you
%% create an instance of matlab
pd=pwd;
addpath ../pmtk3-3jan11
initPmtk3
cd(pd);
warning('off');
