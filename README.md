# dotfiles

### Init:

```
git init --bare $HOME/.dotfiles
alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo "alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.{ba,z}shrc
conf config --local status.showUntrackedFiles no
conf remote add origin git@github.com:konlaasz/dotfiles.git
```

### New install:

```
git clone --bare git@github.com:konlaasz/dotfiles.git $HOME/.dotfiles
alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo "alias conf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.{ba,z}shrc
conf config --local status.showUntrackedFiles no
```

\* Backup any config files worth merging

```
conf checkout
```

---

\* Different branches can be used for different systems.

---

src: https://www.atlassian.com/git/tutorials/dotfiles

src: https://news.ycombinator.com/item?id=11071754

see: https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles
