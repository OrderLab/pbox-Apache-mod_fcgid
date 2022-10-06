##
##  Makefile.apxs -- Build procedure for mod_fcgid Apache module
##
##  Do not use this target; build from the mod_fcgid dir root
##
 
# top_builddir and top_srcdir are misnomers, because build/*.mk
# scripts expect it them be the parent of the build directory,
# and fail to trust the installbuilddir.
exp_installbuilddir=/home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist/build
top_srcdir=/home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist
top_builddir=/home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist

fcgid_builddir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid
fcgid_srcdir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid
builddir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid/modules/fcgid
srcdir=/home/yigonghu/research/perfIsolation/software/httpd/perfIsolation-Apache-mod_fcgid/modules/fcgid

CLEAN_TARGETS = *.loT
include /home/yigonghu/research/perfIsolation/software/httpd/2.4.38/../dist/build/special.mk

all: local-shared-build all-recursive

#   additional defines, includes and libraries
DEFS=-DFCGID_APXS_BUILD
INCLUDES=-I$(builddir) -I$(srcdir) -I$(fcgid_srcdir)/include
#LIBS=-Lmy/lib/dir -lmylib

