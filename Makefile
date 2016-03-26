CC=$(CROSS_COMPILE)gcc
CCFLAGS=-Wall -pedantic

bpi_ledset: bpi_ledset.c
	$(CC) $(CCFLAGS) -o $@ $<

install: bpi_ledset
	sudo install -o root -g root -m 744 bpi_ledset /usr/local/bin/bpi_ledset
	sudo install -o root -g root -m 644 bpi_ledset.service /etc/systemd/system/bpi_ledset.service
	sudo systemctl enable bpi_ledset.service
	sudo systemctl start bpi_ledset.service

uninstall:
	sudo systemctl stop bpi_ledset.service
	sudo systemctl disable bpi_ledset.service
	sudo rm -i /usr/local/bin/bpi_ledset
	sudo rm -i /etc/systemd/system/bpi_ledset.service
	sudo systemctl daemon-reload
