# Display information about the operating system
cat /etc/os-release

# Install git
sudo yum install git -y


# ================== git =====================

git config --global init.defaultBranch main     # Set default branch as main

git log --graph --decorate --oneline    # Check the compact (shorter) version of git log


# After initializing local repo, connect the remote one
git remote add origin https://github.com/your_github_name/your_git_repo_name.git

git push -u origin main     # Push changes from local -> GitHub

git reset --hard <commit>   # Reverts code back to a previous target commit (for local)
git revert branch           # use for remote

git rebase main         # rebase from branch to main -> branch after main


# use HEAD to checkout a commit (rather than branch)
git checkout branch1
git checkout HEAD~3     # move HEAD up to 3 previous commits

git checkout main^      # checkout the commit above

git branch -f main HEAD~3/commit       # move the current code to previous 3 commits version