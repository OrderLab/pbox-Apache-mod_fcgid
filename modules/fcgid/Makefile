##
##  Makefile.apxs -- Build procedure for mod_fcgid Apache module
##
##  Do not use this target; build from the mod_fcgid dir root
##
 
# top_builddir and top_srcdir are misnomers, because build/*.mk
# scripts expect it them be the parent of the build directory,
# and fail to trust the installbuilddir.
exp_installbuilddir=/home/chandy/project/psandbox/apache/apache2/build
top_srcdir=/home/chandy/project/psandbox/apache/apache2
top_builddir=/home/chandy/project/psandbox/apache/apache2

fcgid_builddir=/home/chandy/project/psandbox/apache/mod_fcgid-2.3.9
fcgid_srcdir=/home/chandy/project/psandbox/apache/mod_fcgid-2.3.9
builddir=/home/chandy/project/psandbox/apache/mod_fcgid-2.3.9/modules/fcgid
srcdir=/home/chandy/project/psandbox/apache/mod_fcgid-2.3.9/modules/fcgid

CLEAN_TARGETS = *.loT
include /home/chandy/project/psandbox/apache/apache2/build/special.mk

all: local-shared-build all-recursive

#   additional defines, includes and libraries
DEFS=-DFCGID_APXS_BUILD
INCLUDES=-I$(builddir) -I$(srcdir) -I$(fcgid_srcdir)/include
#LIBS=-Lmy/lib/dir -lmylib

