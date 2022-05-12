TARGET_BIN=${HOME}/.local/bin
TARGET_MPV=${HOME}/.config/mpv/scripts

install:
	echo "Installing ani-man into $(TARGET_BIN)"
	mkdir -p "$(TARGET_BIN)"
	cp ./ani-man "$(TARGET_BIN)"
	echo "Installing ani-man.lua into $(TARGET_MPV)"
	mkdir -p "$(TARGET_MPV)"
	cp ./ani-man.lua "$(TARGET_MPV)"
