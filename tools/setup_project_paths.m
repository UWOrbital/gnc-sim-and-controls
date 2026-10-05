%% setup_project_paths.m
% One-time (and safe to re-run) fix-up of the MATLAB project after the repo
% reorganization.
%
% What changed:
%   adcs_full_model.prj and resources/ moved from adcs_full_model/ to the
%   repo root, and every model moved into config/ or models/<area>/.
%   The project files in resources/project/ still list the old locations
%   (e.g. "environment.slx" at the root) and the project path is only the
%   root folder.
%
% What this script does (through the project API, never by editing the
% hashed XML by hand):
%   1. Opens the project at the repo root.
%   2. Removes file entries whose file no longer exists on disk (stale).
%   3. Adds the active folders and their files to the project.
%   4. Puts config/, models/** and libraries/** on the project path.
%   5. Removes the bare repo root from the project path (nothing runs from
%      there anymore).
%
% archived/ is NEVER added to the project or the path. It contains older
% copies of models with the same names, which would shadow the real ones.
%
% Usage (from MATLAB, any current folder):
%   run('<repo>/tools/setup_project_paths.m')
% Then review the changes in the project and commit resources/project/.

%% 0. Locate the repo root
% This file lives in <repo>/tools/, so the root is one folder up.
thisFile = mfilename('fullpath');
repoRoot = fileparts(fileparts(thisFile));
fprintf('Repo root: %s\n', repoRoot);

%% 1. Open the project
% openProject closes any other open project first.
proj = openProject(repoRoot);

%% 2. Remove stale file entries
% After the moves, entries like <root>/environment.slx point at files that
% no longer exist. Loop over a copy of the paths because removing entries
% changes proj.Files while we iterate.
stalePaths = {};
for k = 1:numel(proj.Files)
    p = char(proj.Files(k).Path);
    if ~isfile(p) && ~isfolder(p)
        stalePaths{end+1} = p; %#ok<AGROW>
    end
end

for k = 1:numel(stalePaths)
    try
        removeFile(proj, stalePaths{k});
        fprintf('Removed stale entry: %s\n', stalePaths{k});
    catch err
        warning('Could not remove %s: %s', stalePaths{k}, err.message);
    end
end

%% 3. Add the active folders (and everything inside them) to the project
% These are the folders the team works in. archived/ is deliberately left
% out. Folders that do not exist yet are skipped.
projectFolders = {'config', 'models', 'libraries', 'tools', 'tests', ...
                  'analysis', 'flight_software', 'docs'};

for k = 1:numel(projectFolders)
    folder = fullfile(repoRoot, projectFolders{k});
    if isfolder(folder)
        addFolderIncludingChildFiles(proj, folder);
        fprintf('Added to project: %s\n', projectFolders{k});
    end
end

% The top-level README is useful to see inside the project too.
readme = fullfile(repoRoot, 'README.md');
if isfile(readme)
    addFile(proj, readme);
end

%% 4. Build the list of folders that belong on the project path
% config/     : only the top folder. Future per-mission parameter sets will
%               likely reuse file names in subfolders, so those should be
%               loaded on purpose by init.m, not all put on the path.
% models/**   : every subfolder, so model references resolve by name.
% libraries/**: every subfolder, for shared blocks and functions.
% genpath returns all subfolders (skipping private/, +pkg/, @class/ and
% resources/ folders, which MATLAB handles on its own).
pathFolders = {fullfile(repoRoot, 'config')};

for base = {'models', 'libraries'}
    baseFolder = fullfile(repoRoot, base{1});
    if isfolder(baseFolder)
        % genpath gives one long string separated by pathsep (';' on Windows)
        subFolders = strsplit(genpath(baseFolder), pathsep);
        subFolders = subFolders(~cellfun(@isempty, subFolders));
        pathFolders = [pathFolders, subFolders]; %#ok<AGROW>
    end
end

%% 5. Add those folders to the project path (skip ones already on it)
% Read the current project path once so re-running the script is harmless.
currentPath = arrayfun(@(f) char(f.File), proj.ProjectPath, ...
                       'UniformOutput', false);

for k = 1:numel(pathFolders)
    folder = pathFolders{k};

    % Safety net: never let anything under archived/ onto the path.
    if startsWith(folder, fullfile(repoRoot, 'archived'))
        continue
    end

    if ~any(strcmpi(currentPath, folder))
        addPath(proj, folder);
        fprintf('On path: %s\n', erase(folder, [repoRoot filesep]));
    end
end

%% 6. Remove the bare repo root from the project path
% It was the only path entry before the reorganization. Nothing needs to
% run from the root now, so it comes off the path.
if any(strcmpi(currentPath, repoRoot))
    removePath(proj, repoRoot);
    fprintf('Removed repo root from project path\n');
end

%% 7. Summary
finalPath = arrayfun(@(f) char(f.File), proj.ProjectPath, ...
                     'UniformOutput', false);
fprintf('\nProject path now has %d folders:\n', numel(finalPath));
fprintf('  %s\n', finalPath{:});
fprintf('\nDone. Open models/top/adcs_model.slx to check that it loads,\n');
fprintf('then commit the changes under resources/project/.\n');
