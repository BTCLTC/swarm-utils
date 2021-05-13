#!/bin/sh

# ###########################################################
# 使用前配置 
AH_ArgsMeta="
# Usage: install.sh [OPTIONS]
# Auto install the bee into system.
# OPTIONS:
*   -w, --bee-work-dir      ### bee working place, like '-w /data/bee'
?       --help              ### display this help and exit
?       --version           ### output version information and exit
"  # 参数元数据配置
AH_ShowHelp="--help"  # 输出帮助信息的指令参数(可省略)
AH_DefaultHelpMeta="no"  # 因为AH_ArgsMeta中已经配置了--help和--version，无须使用默认配置
AH_ShowVersion="--version"  # 输出版本信息的指令参数（可省略）
AH_VersionInfo="version: 0.0.1, copyright by yaoming (2021)"  # 自定义版本信息（可省略）
AH_StrictParam="no"  # 不使用严格参数（支持以"-"开头的参数）
AH_LeastParamCount=0  # 参数数量不得少于1个（0表示不验证最少数量）

# ###########################################################
# 引入工具文件（这里按实际目录结构引入）
. `dirname $0`/shell-utils/lib/args-helper 

# 用户检测
if [ `whoami` != "root" ]; then
    echo "Must run by root user."
    exit 1
fi

mkdir -p /tmp/bee
cd /tmp/bee

# 安装工具
echo "Install tools ... "
yum install -y screen nc vim telnet wget > /dev/null 2>&1
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm > /dev/null 2>&1
ccc="$?"
if [ "$ccc" != "0" ]; then 
    echo Download epel.rpm error
    exit 1
fi
rpm -ivh epel-release-latest-7.noarch.rpm > /dev/null 2>&1
rm -f epel-release-latest-7.noarch.rpm > /dev/null 2>&1
yum install -y jq > /dev/null 2>&1

# 安装bee
wget https://github.com/ethersphere/bee/releases/download/v0.5.3/bee_0.5.3_amd64.rpm
ccc="$?"
if [ "$ccc" != "0" ]; then 
    echo Download bee.rpm error
    exit 1
fi
rpm -i bee_0.5.3_amd64.rpm
rm -f bee_0.5.3_amd64.rpm

# 初始化目录
beeWorkDir="${AH_OPTIONS['-w']}"
if [ -z "$beeWorkDir" ]; then
    beeWorkDir="/data/bee"
    echo "init BEE_WORK_DIR at default path $beeWorkDir"
else
    echo "init BEE_WORK_DIR at path $beeWorkDir"
fi

pathExists=`cat /etc/profile | grep "$beeWorkDir" | head -n 1`
if [ -n "$pathExists" ]; then
    echo bee has already installed.
else
    mkdir -p "$beeWorkDir"
    echo "export BEE_WORK_DIR=$beeWorkDir" >> /etc/profile
    echo install bee done.
fi