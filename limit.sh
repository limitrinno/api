#!/bin/bash
# version 0.1

# 参数区
jcxt=`cat /etc/redhat-release | awk '{ print $1 }'`

# 函数区
cxip(){
echo ""
echo "========================================================="
echo -ne "你所在地区的IP是:" && curl -s cip.cc | grep IP | awk '{ print $3 }'
echo -ne "你所在地区的地址是:" && curl -s cip.cc | grep 数据二 | awk '{ print $3 $5}'
echo -e "数据基于cip.cc获取！"
echo "========================================================="
echo ""
}

cxsystem(){
echo ""
echo "========================================================="
echo -ne "系统的处理器为:" && cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
echo -ne "系统的内存为:" && free -mh | grep Mem | awk '{print $2}'
echo -ne "系统的交换分区为:" && free -mh | grep Swap | awk '{print $2}'
echo "========================================================="
}

v2fly(){
yum makecache
yum install curl
cd ~
curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh
echo "开始安装V2fly最新脚本"
sleep 1
bash install-release.sh
echo "开始安装最新版的IP数据库"
bash install-dat-release.sh
systemctl restart v2ray && systemctl enable v2ray
echo "开始清理安装垃圾文件"
rm -rf install-releases.sh install-dat-release.sh
echo "请到目录修改文件(/usr/local/etc/v2ray)，V2ray已经安装完成！"
}

233v2ray(){
yum makecache && yum -y install curl
bash <(curl -s -L https://git.io/v2ray.sh)
}

dockerinstall(){
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io -y
systemctl enable docker
systemctl restart docke
echo "Docker 安装完成"
}

# 主界面
menu(){
cat <<-EOF
########## Welcome Limitauto V0.1 ##########

目前暂时只支持Centos

1.查询自己本机的IP
2.查询本机系统配置
3.搭建官方版本的V2ray(By v2fly)
4.搭建第三方版本V2ray(By 233Boy)
5.一键搭建Gost隧道
6.一键安装Docker(最简单的版本)
7.国内一键测速脚本(By coolaj)
8.检测服务器配置以及IO国内节点测速(By oooldking)
9.检测服务器网络信息以及相关流媒体设置(完整版 By LemonBenchIntl)
10.检测服务器网络信息以及相关流媒体设置(快速版 By LemonBenchIntl)

########## Welcome Limitauto V0.1 ##########

EOF
}
menu
read -p "请输入需要使用的脚本:" num

#控制程序
case $num in
	1)
	cxip
	;;
	2)
	cxsystem
	;;
	3)
	v2fly
	;;
	4)
	233v2ray
	;;
	5)
	yum -y install wget && wget https://raw.githubusercontent.com/limitrinno/limit/master/gost/gost.sh && chmod +x gost.sh && bash gost.sh && rm -rf gost.sh
	;;
	6)
	dockerinstall
	;;
	7)
	bash <(curl -Lso- https://git.io/Jlkmw)
	;;
	8)
	yum -y install curl && curl -Lso- -no-check-certificate https://raw.githubusercontent.com/oooldking/script/master/superbench.sh | bash	
	;;
	9)
	yum -y install curl && curl -fsSL http://ilemonra.in/LemonBenchIntl | bash -s full
	;;
	10)
	yum -y install curl && curl -fsSL http://ilemonra.in/LemonBenchIntl | bash -s fast
	;;
	*)
	echo "不存在的命令！重新执行"
	;;
esac