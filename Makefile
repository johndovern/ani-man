TARGET_BIN=${HOME}/.local/bin
TARGET_MPV=${HOME}/.config/mpv/scripts
CONFIG_DIR=${HOME}/.config/ani-man

install:
	echo "Installing ani-man into $(TARGET_BIN)"
	mkdir -p "$(TARGET_BIN)"
	cp ./ani-man "$(TARGET_BIN)"
	echo "Installing ani-man.lua into $(TARGET_MPV)"
	mkdir -p "$(TARGET_MPV)"
	cp ./ani-man.lua "$(TARGET_MPV)"
	echo "Installing ani-man.conf and ani-man.filters into $(CONFIG_DIR)"
	mkdir -p "$(CONFIG_DIR)"
	cp ./ani-man.conf "$(CONFIG_DIR)"
	cp ./ani-man.filters "$(CONFIG_DIR)"
