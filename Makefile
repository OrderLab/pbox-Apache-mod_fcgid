##
##  Makefile.apxs -- Build procedure for mod_fcgid Apache module
##
##  Do not use the .apxs makefile, run ./configure.apxs and build from 'Makefile'
##
 
# top_builddir and top_srcdir are misnomers, because build/*.mk scripts
# expect each of them to be the parent of the build directory, and fail
# to trust the installbuilddir.
exp_installbuilddir=/home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist/build
top_srcdir=/home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist
top_builddir=/home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist

fcgid_builddir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid
fcgid_srcdir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid
builddir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid
srcdir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid
awk=gawk

SUBDIRS = modules/fcgid
CLEAN_SUBDIRS = 

TARGETS         = 
INSTALL_TARGETS = install-conf install-manual
## no such targets yet; install-include
DISTCLEAN_TARGETS  = config.apxs.log modules/fcgid/fcgid_config.h
EXTRACLEAN_TARGETS = 

include /home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist/build/rules.mk

x-local-distclean:
	rm -rf docs/manual/build docs/manual/style

# Dang nabbit, these are stripped!  Reconstitute them;
rel_libexecdir=modules
rel_sysconfdir=conf
rel_logfiledir=logs
httpd_conffile=/home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist/conf/httpd.conf
httpd_origconffile=$(exp_sysconfdir)/original/$(progname).conf

install-conf:
	@echo Installing configuration files
	@$(MKINSTALLDIRS) $(DESTDIR)$(exp_sysconfdir) \
			  $(DESTDIR)$(exp_sysconfdir)/original
	for i in $(DESTDIR)$(httpd_conffile) $(DESTDIR)$(httpd_origconffile); do \
	    if test -f $$i; then \
		($(awk) -f $(fcgid_srcdir)/build/addloadexample.awk \
		    -v MODULE=fcgid -v DSO=.so -v LIBPATH=$(rel_libexecdir) \
		    < $$i > $$i.new && \
		 mv $$i $$i.bak && mv $$i.new $$i \
	        ) || true; \
	    fi; \
	done
#	Todo - add this flag to awk above, if/when this Include is distributed
#		    -v EXAMPLECONF=$(rel_sysconfdir)/extra/httpd-fcgid.conf

install-conf-unused:
	@$(MKINSTALLDIRS) $(DESTDIR)$(exp_sysconfdir)/extra \
			  $(DESTDIR)$(exp_sysconfdir)/original/extra
	@cd $(fcgid_srcdir)/docs/conf; \
	for j in $(fcgid_srcdir)/docs/conf; do \
	    cd $$j ; \
	    for i in extra/httpd-fcgid.conf; do \
	    	if test -f $$i; then \
	    	    sed -e '/^\#@@LoadFcgidModules@@/d;' \
			-e 's#@exp_runtimedir@#$(exp_runtimedir)#;' \
	    		-e 's#@exp_sysconfdir@#$(exp_sysconfdir)#;' \
	    		-e 's#@rel_sysconfdir@#$(rel_sysconfdir)#;' \
	    		-e 's#@rel_logfiledir@#$(rel_logfiledir)#;' \
	    		< $$i > $(DESTDIR)$(exp_sysconfdir)/original/$$i; \
	    	    chmod 0644 $(DESTDIR)$(exp_sysconfdir)/original/$$i; \
	    	    if test ! -f $(DESTDIR)$(exp_sysconfdir)/$$i; then \
	    		cp $(DESTDIR)$(exp_sysconfdir)/original/$$i \
			    $(DESTDIR)$(exp_sysconfdir)/$$i; \
	    		chmod 0644 $(DESTDIR)$(exp_sysconfdir)/$$i; \
	    	    fi; \
	    	fi; \
	    done ; \
	done

svnroot=http://svn.apache.org/repos/asf/httpd
manualdir=$(fcgid_srcdir)/docs/manual

# Note; by default,  make generate-docs  rebuilds the local pages
# To regenerate the installed pages (after using make install to
# drop in the fcgid content), simply
#
#   make manualdir=/path/to/manual generate-docs
#
generate-docs:
	@if test ! -d $(manualdir)/build; then \
	  cd $(manualdir); \
	  svn export $(svnroot)/docs-build/trunk build; \
	fi
	@if test ! -d $(manualdir)/style; then \
	  cd $(manualdir); \
	  svn export $(svnroot)/httpd/trunk/docs/manual/style; \
	fi
	cd $(manualdir)/build; \
	  ./build.sh all

generate-dox:
	cd $(fcgid_srcdir); \
	  doxygen $(fcgid_srcdir)/docs/doxygen-fcgid.conf

install-manual:
	@echo Installing online manual
	@test -d $(DESTDIR)$(exp_manualdir) \
          || $(MKINSTALLDIRS) $(DESTDIR)$(exp_manualdir)
	@if test "x$(RSYNC)" != "x" && test -x $(RSYNC) ; then \
	  $(RSYNC) --exclude .svn -rlpt --numeric-ids \
		$(fcgid_srcdir)/docs/manual/ $(DESTDIR)$(exp_manualdir)/; \
	else \
	  cp -rp $(fcgid_srcdir)/docs/manual/* $(DESTDIR)$(exp_manualdir)/ && \
	  find $(DESTDIR)$(exp_manualdir) -name ".svn" -type d -print \
	    | xargs rm -rf 2>/dev/null || true; \
	fi

install-include-unused:
	@echo Installing header files
	@$(MKINSTALLDIRS) $(DESTDIR)$(exp_includedir) && \
	  cp $(fcgid_srcdir)/include/mod_fcgid.h $(DESTDIR)$(exp_includedir)/ && \
	  chmod 0644 $(DESTDIR)$(exp_includedir)/mod_fcgid.h

.PHONY: generate-dox generate-docs
