vuetorrent.lpk: lzc-* scripts/*
	lzc-cli project build -o vuetorrent.lpk

clean:
	rm -f vuetorrent.lpk

install: vuetorrent.lpk
	lzc-cli app install vuetorrent.lpk

uninstall:
	lzc-cli app uninstall `yq .package lzc-manifest.yml`

update:
	./update.sh
