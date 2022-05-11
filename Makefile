TARGET_BIN=${HOME}/.local/bin

install:
	echo "Installing into $(TARGET_BIN)"
	mkdir -p "$(TARGET_BIN)"
	cp ./ani-man "$(TARGET_BIN)"
