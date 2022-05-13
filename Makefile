TARGET_BIN=${HOME}/.local/bin
TARGET_MPV=${HOME}/.config/mpv/scripts
ALT_MPV=${HOME}/.config/mpv/script-opts
CONFIG_DIR=${HOME}/.config/ani-man

install:
	echo "Installing ani-man into $(TARGET_BIN)"
	mkdir -p "$(TARGET_BIN)"
	cp ./ani-man "$(TARGET_BIN)"
	echo "Installing ani-man.conf and ani-man.filters into $(CONFIG_DIR)"
	mkdir -p "$(CONFIG_DIR)"
	cp ./conf/bash/ani-man.conf "$(CONFIG_DIR)"
	cp ./conf/bash/ani-man.filters "$(CONFIG_DIR)"
	echo "Installing ani-man.lua into $(TARGET_MPV)"
	mkdir -p "$(TARGET_MPV)"
	cp ./conf/lua/ani-man.lua "$(TARGET_MPV)"
	echo "Installing ani-man.conf into $(ALT_MPV)"
	mkdir -p "$(ALT_MPV)"
	cp ./conf/lua/ani-man.conf "$(ALT_MPV)"

uninstall:
	echo "Uninstalling ani-man "
	rm -f "$(TARGET_BIN)"/ani-man
	echo "Uninstalling ani-man.conf and ani-man.filters"
	rm -f "$(CONFIG_DIR)"/ani-man.conf
	rm -f "$(CONFIG_DIR)"/ani-man.filters
	echo "Uninstalling ani-man.lua and ani-man.conf"
	rm -f "$(TARGET_MPV)"/ani-man.lua
	rm -f "$(ALT_MPV)"/ani-man.conf
