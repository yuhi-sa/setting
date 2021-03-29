# PCの設定
## 目次
- Ubuntu 16.04 の設定
- Macの設定
- Pythonの設定
  - for ubuntu
  - for mac
- latex on VScodeの設定

## Ubuntu 16.04 の設定
1. install ubuntu 16.04 with English edition
2. update (several times?)
```bash
sudo apt update
sudo apt upgrade
```
1. CUDA
    1. access [here](https://developer.nvidia.com/cuda-downloads) and choose
        1. Linux
        2. x86_64
        3. Ubuntu
        4. 16.04
        5. deb[network]
    2. install cuda from deb package
    3. add paths related to cuda
    ```
    echo -e "\n## CUDA and cuDNN paths"  >> ~/.bashrc
    echo 'export PATH=/usr/local/cuda/bin:${PATH}' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
    source ~/.bashrc
    ```
    1. reboot and check `nvidia-smi`
    2. install cuDNN
        1. access [here](https://developer.nvidia.com/cudnn)
            1. Download cuDNN
            2. Join now
            3. I Agree to ~~~
            4. download corresponding version
                - cuDNN v*.*.* Runtime Library for Ubuntu16.04 [Deb]
                - cuDNN v*.*.* Developer Library for Ubuntu16.04 [Deb]
                - cuDNN v*.*.* Code Samples and User Guide for Ubuntu16.04 [Deb]    
        2. install them
            ```bash
            cd the directory where the deb package is downloaded
            sudo dpkg -i libcudnn*_*+cuda*_amd64.deb
            sudo dpkg -i libcudnn*-dev_*+cuda*_amd64.deb
            sudo dpkg -i libcudnn*-doc_*+cuda*_amd64.deb
            ```    
       3. test samples
       ```bash
       cuda-install-samples-*.sh .
       cd NVIDIA_CUDA-*_Samples
       make -k
       # there other samples
       cd 2_Graphics/volumeRender
       ./volumeRender
       ```
2. ユーティリティー
```bash
sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev libpng-dev dvipng
sudo apt install exfat-fuse exfat-utils
sudo apt install mesa-utils
sudo apt install terminator kazam vlc ffmpeg imagemagick
```
3. git
```bash
sudo apt install git libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring/
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
git config --global push.default simple
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
# if this pc is your own pc
git config --global user.name "Account name of github or gitlab"
git config --global user.email "Your mail address for registration" 
```
4. latex
```bash
sudo apt install texlive-lang-cjk
sudo apt install texlive-latex-extra
sudo apt install ttf-mscorefonts-installer
sudo fc-cache
```
5. 日本語入力
```bash
sudo apt install ibus-mozc
killall ibus-daemon
ibus-daemon -d -x &
```

## Macの設定
### Homebrew
1. インストール方法
2. [Homebrew](https://brew.sh/index_ja)にアクセス：スクリプトをコピーし、ターミナルで実行
3. インストール確認
```bash
# スクリプト実行
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
 
# ログ
==> This script will install:
/usr/local/bin/brew
/usr/local/share/doc/homebrew
︙
==> The Xcode Command Line Tools will be installed.

# Xcode Command Line Toolsをインストールする場合は、RETURNを押下。
Press RETURN to continue or any other key to abort
==> /usr/bin/sudo /bin/chmod u+rwx /usr/local/bin
# ログイン時のPasswordを入力
Password:
==> /usr/bin/sudo /bin/chmod g+rwx /usr/local/bin
︙
Already up-to-date.
==> Installation successful!
 
# インストール確認
$ brew --version
# ログ
Homebrew 2.2.13
```

### pyenv
1. Homebrewでpyenvをインストール。
2. インストール確認。
3. pyenvにPathを通す。
4. 設定（Path）の適用。
```bash
# pyenvをインストール
$ brew install pyenv
 
# インストール確認
$ pyenv --version
# ログ
pyenv 1.2.17
 
# pyenvにPathを通す
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
 
# 設定の適用
$ source .bash_profile
```

### Anaconda
1. pyenvでインストール可能なAnacondaを検索。
2. Anacondaをインストール。
```bash
# インストール可能なAnacondaを検索
$ pyenv install -l | grep anaconda
 
# ログ
anaconda-1.4.0
︙
anaconda2-5.0.0
︙
anaconda3-5.3.1
 
# 3系の最新版をインストール
$ pyenv install anaconda3-5.3.1
 
# 切り替えられるをバージョン確認
$ pyenv versions
 
# ログ （*が現在指定しているバージョン）
  system
  anaconda2-5.3.1
  anaconda3-4.4.0
* anaconda3-5.3.1
 
# バージョン切り替え
# globalとすると全体に、localにするとそのカレントディレクトリ以下に指定したバージョンが反映される
$ pyenv global anaconda3-5.3.1
$ python --version
Python 3.7.0
 
$ pyenv local anaconda2-5.3.1
$ python --version
Python 2.7.16
```

## Pythonの設定
### for ubuntu
```bash
# anyenv for pyenv
git clone https://github.com/riywo/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(anyenv init -)"' >> ~/.bashrc
exec $SHELL -l
anyenv install --init
git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
anyenv install pyenv
anyenv update

# packages for python2 (mainly for ROS, so if ros is not used in your pc, please ignore)
# the latest numpy is only for python3, so this process would fail
# pip install cython numba numpy scipy pandas scikit-learn ruamel.yaml termcolor future fasteners pygame
# pip install networkx==2.2
# pip install hdbscan
# pip install gym "gym[box2d]"
# pytorch from official site
# pip install https://~~~.whl
# pip install torchvision

# python3 (anaconda)
pyenv install -l | grep anaconda
pyenv install anaconda* # choose latest
pyenv global anaconda*

# conda install conda=*.*.*=py37_0
# conda init bash

```

Save the following yaml as env.yaml (version will be changed, so please check here always!)

```yaml
name: team
channels:
  - conda-forge
  - pytorch
dependencies:
  - python=3.7
  - numpy
  - scipy
  - scikit-learn
  - matplotlib
  - seaborn
  - pandas
  - umap-learn
  - hdbscan
  - termcolor
  - pyhamcrest
  - ruamel.yaml
  - pytorch
  - torchvision
  - cudatoolkit=10.
  - tensorboard
  - psutil
  - pip
  - pip:
    - pygame
    - "gym[box2d]"
    - pybullet
    - pyprind
```

After that, in the directory with the above yaml, 

```bash
conda env create -f env.yaml
# if you use pyenv
pyenv global anaconda*/envs/team
# if you don't use pyenv
# conda init
# echo -e "\n## conda default activation" >> ~/.bashrc
# echo "conda activate team" >> ~/.bashrc
# source ~/.bashrc
```

### for mac

```bash
# anyenv for pyenv
brew install anyenv
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
exec $SHELL -l
anyenv install --init
git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
anyenv install pyenv
anyenv update

# python3 (anaconda)
pyenv install -l | grep anaconda
pyenv install anaconda* # choose latest
pyenv global anaconda*

# conda update conda=*.*.*=py37_0
# conda init bash

```

Save the following yaml as env.yaml 
```yaml
name: team
channels:
  - conda-forge
  - pytorch
dependencies:
  - python=3.7
  - numpy
  - scipy
  - scikit-learn
  - matplotlib
  - seaborn
  - pandas
  - umap-learn
  - hdbscan
  - termcolor
  - pyhamcrest
  - ruamel.yaml
  - pytorch
  - torchvision
  - tensorboard
  - psutil
  - opencv
  - ffmpeg
  - imagemagick
  - pip
  - pip:
    - pygame
    - "gym[box2d]"
    - pybullet
    - pyprind
```

After that, in the directory with the above yaml, 

```bash
conda env create -f env.yaml
# if you use pyenv
pyenv global anaconda*/envs/team
# if you don't use pyenv
# conda init
# echo -e "\n## conda default activation" >> ~/.bash_profile
# echo "conda activate team" >> ~/.bash_profile
# source ~/.bash_profile
```

## latex on VScodeの設定

参照元
- https://gist.github.com/Ikuyadeu/204d06fffd912f441b383eb02463e29b 

- https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile

1. [Latex-Workshop](<https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop>)をインストール
2. settings.json(Windows: `ファイル > 基本設定 > 設定` or `Ctrl` + `,`， Mac: `Code > 基本設定 > 設定` or `⌘` + `,`)の`{ }`内に以下を追加([設定ファイルの変更方法](https://qiita.com/y-w/items/614843b259c04bb91495))

```json
    "latex-workshop.latex.tools": [
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ],
            "name": "Step 1: ptex2pdf"
        },
        {
            "command": "pbibtex",
            "args": [
                "%DOCFILE%",
                "-kanji=utf8"
            ],
            "name": "Step 2: pbibtex"
        },
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ],
            "name": "Step 3: ptex2pdf"
        },
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ],
            "name": "Step 4: ptex2pdf"
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "toolchain",
            "tools": [
                "Step 1: ptex2pdf",
                "Step 2: pbibtex",
                "Step 3: ptex2pdf",
                "Step 4: ptex2pdf"
            ]
        }
    ],
    "latex-workshop.view.pdf.viewer": "tab",
    "editor.renderControlCharacters": true
```
* もしbibファイルがないなら
```json
"latex-workshop.latex.tools": [
        {
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOCFILE%.tex"
            ]
        }
],
"latex-workshop.latex.recipes": [
{
    "name": "toolchain",
    "tools": [
        "Step 1: ptex2pdf"
    ]
}],
"latex-workshop.view.pdf.viewer": "tab",
"editor.renderControlCharacters": true
```

1. ファイルを保存または`F1`キーを押して`Build Latex Project`を入力，実行するとコンパイルされる．
2. `F1`キーの後， `View PDF File in new tab`でPDFを見れる．
3. エラーが出た場合は `表示-> 統合ターミナル`で下に端末が出るのでその中の`出力`を確認
