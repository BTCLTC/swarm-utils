#!/bin/sh

# ###########################################################
# 使用前配置 
AH_ArgsMeta="
# For example cat:
# 
# Usage: install.sh <bee|bee-clef>
# Concatenate FILE(s), or standard input, to standard output.
#
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
. `dirname $0`/../shell-utils/lib/args-helper 

for arg in 

wget https://github.com/ethersphere/bee/releases/download/v0.5.3/bee_0.5.3_amd64.rpm
rpm -i bee_0.5.3_amd64.rpm