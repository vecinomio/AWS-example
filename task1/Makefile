
SHELL=/bin/bash
PACKAGE=ccc
RELEASE_VERSION=1.0
BUILDDIR=./TMP/debian-build
CHANGELOG=$(BUILDDIR)/debian/changelog
TIMESTAMP=`date -R`
LC_DEST=$(DESTDIR)/test
RULES=debian/rules

create:
	dh_make -i --native -y

build:
	dpkg-buildpackage -b -uc -rfakeroot
	rm -f build-arch-stamp  build-indep-stamp  configure-stamp


stage:
	echo "#!/usr/bin/make -f" > $(RULES)
	echo "" >> $(RULES)
	echo "export DH_VERBOSE=1" >> $(RULES)
	echo "" >> $(RULES)
	echo "%:" >> $(RULES)
	echo '	dh $$@' >> $(RULES)
	echo "" >> $(RULES)
	echo "override_dh_auto_build:" >> $(RULES)
	echo "" >> $(RULES)
	echo "override_dh_installdocs:" >> $(RULES)
	echo "" >> $(RULES)
	echo "override_dh_installchangelogs:" >> $(RULES)
	mkdir -p $(BUILDDIR)
	cp Makefile $(BUILDDIR)
	cp *.war $(BUILDDIR)
	cp -r debian/ $(BUILDDIR)
	echo "$(PACKAGE) ($(RELEASE_VERSION)) unstable; urgency=low" > $(CHANGELOG)
	echo "" >> $(CHANGELOG)
	echo "  * Initial release " >> $(CHANGELOG)
	echo "" >> $(CHANGELOG)
	echo " -- Test <test@example.com>  $(TIMESTAMP)" >> $(CHANGELOG)
	echo "" >> $(CHANGELOG)
	echo "$(RELEASE_VERSION)" > FAI_VERSION
	echo "$(PACKAGE).war /home/project" > $(BUILDDIR)/debian/install

package: rmdeb clean create stage
	$(MAKE) -C $(BUILDDIR) build

clean:
	rm -rf $(BUILDDIR)

rmdeb:
	rm -rf debian
