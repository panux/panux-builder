all: perm

perm:
	chmod 0755 *.sh

dump: perm
	test -d $(DESTDIR)
	mkdir $(DESTDIR)/scripts
	cp *.sh $(DESTDIR)/scripts
