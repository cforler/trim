CFLAGS += -W -Wall -Wextra -Werror -Wformat-security -Wformat -O2 -fPIE 
CFLAGS += -fstack-protector-all -fstack-clash-protection -D_FORTIFY_SOURCE=2

LDFLAGS += -pie -Wl,-z,relro,-z,now -s

trim:

install: trim install_manpages
	sudo cp trim /usr/local/bin/

install_manpages:
	sudo mkdir -p /usr/local/share/man/man1
	sudo mkdir -p /usr/local/share/man/de/man1/
	sudo cp trim_en.1 /usr/local/share/man/man1/trim.1
	sudo cp trim_de.1 /usr/local/share/man/de/man1/trim.1
	sudo gzip /usr/local/share/man/man1/trim.1
	sudo gzip /usr/local/share/man/de/man1/trim.1
	sudo mandb

uninstall_manpages: 
	sudo rm -f /usr/local/share/man/man1/trim.1.gz
	sudo rm -f /usr/local/share/man/de/man1/trim.1.gz
	sudo rm -f /usr/local/share/bash-completion/completions/trim
	sudo mandb

uninstall: uninstall_manpages 
	sudo rm -f /usr/local/bin/trim



clean:
	$(RM) trim *~
