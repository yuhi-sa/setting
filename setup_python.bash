echo "Start Setup Python(pyenv+anaconda)"

echo "install pyenv? [y/n]: "
    read is_pyenv

    if [ ${is_pyenv} = "y" ];then
        pyenv
        if [ $? -eq 1 ]; then
            echo "pyenv is already installed"
        else
            # Machine Name
            if [ "$(uname)" = "Darwin" ]; then
                machine="mac"
            elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
                machine="linux"
            fi

            # Pyenv
            echo "start to install pyenv"
            if [ ${machine} = "mac" ]; then
                brew install pyenv
                echo 'PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
                echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
                echo 'eval "$(pyenv init -)"' >> ~/.zshrc
                source ~/.zshrc
            elif [ ${machine} = "linux" ]; then
                git clone https://github.com/pyenv/pyenv.git ~/.pyenv
                # パスを通す
                echo 'PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
                echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
                echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
                source ~/.bashrc
            fi
        fi
    fi

# Anaconda
echo "install Anaconda? [y/n]: "
    read is_Anaconda

    if [ ${is_Anaconda} = "y" ];then
        echo "start to install Anaconda"
        pyenv install anaconda3-5.3.1
        pyenv global anaconda3-5.3.1
        conda create --name team python=3.8
        pyenv global anaconda3-5.3.1/envs/team

        # 足りないパッケージをインストール
        pip install -r requirements.txt
    fi

# 実験環境インストール
echo "Install odrl and gym_collection and torch_collection? [y/n]: "
    read is_Inst

    if [ ${is_Inst} = "y" ];then
        cd ..

        git clone http://git.monolith.naist.jp/kobayashi/torch_collection.git
        git clone http://git.monolith.naist.jp/kobayashi/gym_collection.git
        git clone https://github.com/yuhi-sa/odrl.git

        cd setting
    fi

# 実験環境セットアップ
echo "Set up odrl and gym_collection and torch_collection? [y/n]: "
    read is_set

    if [ ${is_set} = "y" ];then
        cd ..

        cd torch_collection
        pip install -e .
        cd ..

        cd gym_collection
        pip install -e .
        cd ..

        cd odrl
        pip install -e .
        cd ..

        cd setting

    fi

echo "finish"
