#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
#============================================================
# Modify default IP（修改默认后台IP地址从199.1为1.1）
sed -i 's/192.168.1.1/192.168.199.1/g' package/base-files/files/bin/config_generate
#============================================================
# Modify WiFi ON（修改使WIFI默认打开）
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#============================================================
# Modify default SSID（修改主机名从Panzy为Openwrt）
# sed -i 's/ssid=OpenWrt/ssid=Panzy/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#============================================================
# Add the default password for the 'root' user（给root账户增加密码：password）
# sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow
#============================================================
# echo '修改默认WIFI名称'
sed -i 's/ssid=OpenWrt/ssid=CDMA2021/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#============================================================
# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i 's/OpenWrt /编译时间 $(TZ=UTC-8 date "+%Y.%m.%d") @ 无限远 /g' package/lean/default-settings/files/zzz-default-settings
#============================================================
# 修改主题，删除自带，拉取新主题
# rm -rf package/lean/luci-theme-argon
# rm -rf package/lean/luci-theme-bootstrap
# rm -rf package/lean/luci-theme-material
# rm -rf package/lean/luci-theme-netgear
# rm -rf package/kenzo/luci-theme-ifit
rm -rf package/lean/luci-theme-design
git clone https://github.com/XXKDB/luci-theme-argon_armygreen.git package/lean/luci-theme-argon_armygreen
git clone https://github.com/YL2209/luci-theme-ifit.git package/lean/luci-theme-ifit
git clone https://github.com/gngpp/luci-theme-design.git package/lean/luci-theme-design
#============================================================
# 修改luci-theme-argon_armygreen主题渐变色，16进制RGB
#登录页面背景颜色+半透明
sed -i 's/#f7fafc/rgba(134,176,197, .5)/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#渐变色开始
# sed -i 's/#f9ffff/#80ABC3/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#渐变色结束b8 57
# sed -i 's/#7fffffb8/#5C859B/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
sed -i 's/#9effff57/#9FC4D5/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#主机名 导航栏-状态-文字的颜色
sed -i 's/#4fc352/#B7E0F3/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#加载背景
sed -i 's/#5e72e4/#407994/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#============================================================
#取消原主题luci-theme-bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#修改argon为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon_armygreen/g' ./feeds/luci/collections/luci/Makefile
#============================================================
# 修改默认wifi名称ssid为Xiaomi_R4A
sed -i 's/ssid=OpenWrt/ssid=CDMA2021/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# 修改默认wifi密码key为password
sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#使用sed 在第四行后添加新字
sed -i '/set wireless.default_radio${devidx}.encryption=psk2/a\set wireless.default_radio${devidx}.key=MJ14041404...' package/kernel/mac80211/files/lib/wifi/mac80211.sh
