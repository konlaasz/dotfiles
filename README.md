# dotfiles

### Init:
```
git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

### New install:
```
git clone --bare git@github.com:konlaasz/dotfiles.git $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```
\* Backup any config files worth merging

---

src: https://www.atlassian.com/git/tutorials/dotfiles

src: https://news.ycombinator.com/item?id=11071754

see: https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles
