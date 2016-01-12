% First, get the name of the folder you're using.
% For example if your folder is 'D:\photos\Info', parentFolder  would = 'D:\photos, and deepestFolder would = 'Info'.
yourFolder = pwd;

[parentFolder, deepestFolder] = fileparts(yourFolder);
% Next, create a name for a subfolder within that.
% For example 'D:\photos\Info\DATA-Info'
newSubFolder = sprintf('%s/DATA-%s', yourFolder, deepestFolder)
% Finally, create the folder if it doesn't exist already.
if ~exist(newSubFolder, 'dir')
  mkdir(newSubFolder);
end