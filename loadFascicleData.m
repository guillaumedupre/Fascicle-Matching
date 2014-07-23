% names = {'LTR';'RTR';'LC';'RC';'LCC';'RCC';'LCH';'RCH';'CFM';'CFm';'LIFOF';'RIFOF';'LILF';'RILF';'LSLF';'RSLF';'LU';'RU';'LA';'RA'}
directory_name = uigetdir;
files = dir(directory_name);
ind = 1;
for file = 1:length(files)
    filename = files(file).name;
    [~,~,ext] = fileparts(filename) ;
    if(strcmp(ext,'.mat'))
        fascicles(ind) = load(fullfile(directory_name,filename));
        %do something
        ind = ind + 1;
    end
    sprintf('finished processing subject number %d',file)
end
 