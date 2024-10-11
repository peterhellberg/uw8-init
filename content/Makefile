TITLE="uw8-cart"
NAME=uw8-cart
ARCHIVE=${NAME}.zip
GAME_URL=https://${HOSTNAME}/${NAME}
SERVER_PATH=~/public_html/${NAME}
HOSTNAME=localhost
BACKUP_PATH=/tmp/

all:
	zig build

.PHONY: spy
spy:
	zig build spy

.PHONY: run
run:
	zig build run

.PHONY: clean
clean:
	rm -rf zig-out
