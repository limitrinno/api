#!/bin/bash
# version 0.1

addtz(){
read -p "探针服务器IP:(默认:43.132.193.125)" tzip
tzip=${tzip:-43.132.193.125}
read -p "探针用户名:(默认:S99)" tzuser
tzuser=${tzuser:-S99}
read -p "探针密码:(默认:S99)" tzpwd
tzpwd=${tzpwd:-S99}
mkdir /tz && wget --no-check-certificate -qO /tz/client-linux.py 'https://docs.2331314.xyz/api/service/client-linux.py' && nohup python3 /tz/client-linux.py SERVER={$tzip} USER={$tzuser} PASSWORD={$tzpwd} >/dev/null 2>&1 &
}


# 主界面
menu(){
cat <<-EOF
########## Welcome Limitauto V0.1 ##########

目前暂时只支持Centos

1.增加一个探针客户端

########## Welcome Limitauto V0.1 ##########

EOF
}
menu
read -p "请输入需要使用的脚本:" num
case $num in
        1)
        addtz
        ;;
        *)
        echo "不存在的命令！重新执行"
        ;;
esac