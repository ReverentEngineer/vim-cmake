# Installation

Install using your favorite plugin manager such as [Pathogen](https://github.com/tpope/vim-pathogen), 
[Vundle](https://github.com/VundleVim/Vundle.vim), or [vim-plug](https://github.com/junegunn/vim-plug).

# Usage

Configure a project:

```
CMake
```

Build a project:

```
make (or Make for vim-dispatch users)
```

Run tests using CTest:

```
CTest
```

# Dispatch

When available, this plugin makes use of [vim-dispatch](https://github.com/tpope/vim-dispatch) 
for asynchronous commands. Otherwise, it will default to synchronous commands.
