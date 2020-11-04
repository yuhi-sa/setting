import os
import gym
import sys
import gym
import numpy as np
import pybullet_envs
import time
from gym.spaces import *
os.environ['MKL_THREADING_LAYER'] = 'GNU'


#環境ID
ENV_ID = "InvertedPendulumBulletEnv-v0"

#空間の出力
def print_spaces(label, space):
    #空間の出力
    print(label, space)

    if isinstance(space, Box):
        print(' 最小値：', space.low)
        print(' 最大値；', space.high)
    if isinstance(space, Discrete):
        print(' 最小値：', 0)
        print(' 最大値', space.n-1)

#環境の生成
env = gym.make(ENV_ID)

#行動空間状態空間の型の出力
print('環境ID:', env.action_space)
print_spaces('行動空間：', env.action_space)
print_spaces('状態空間：', env.observation_space)