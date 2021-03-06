#
#	Makefile for the Appweb unit tests
#
#	Copyright (c) Embedthis Software LLC, 2003-2012. All Rights Reserved.
#

BUILD_DEPTH		?= 2

include 		.makedep

ifeq ($(BUILDING_DEV),1)
	TARGETS		+= $(BLD_BIN_DIR)/testAppweb$(BLD_EXE) 
else
    OBJECTS     := $(patsubst $(BLD_OBJ_DIR)/testAppweb$(BLD_OBJ),,$(OBJECTS))
    OBJECTS     := $(patsubst $(BLD_OBJ_DIR)/testHttp$(BLD_OBJ),,$(OBJECTS))
endif
ifeq ($(BUILDING_TARGET),1)
	ifeq ($(BLD_FEATURE_CGI),1)
		CGIP	+= $(BLD_BIN_DIR)/cgiProgram$(BLD_EXE)
		TARGETS	+= $(CGIP)
		TARGETS	+= cgi-bin/testScript web/cgiProgram.cgi web/caching/cache.cgi web/basic/basic.cgi
	endif
endif

compileExtra: $(TARGETS)

#
#	Build testAppweb
#
$(BLD_BIN_DIR)/testAppweb$(BLD_EXE): $(OBJECTS)
	bld --exe $(BLD_BIN_DIR)/testAppweb$(BLD_EXE) --search "$(BLD_APPWEB_LIBPATHS)" \
		--libs "$(BLD_HTTP_LIBS) $(BLD_MPR_LIBS) $(BLD_SSL_LIBS)" \
		testHttp$(BLD_OBJ) testAppweb$(BLD_OBJ)

#
#	Update the shbang path in testScript. Must be an absolute path on some systems and for valgrind.
#
cgi-bin/testScript: Makefile $(BLD_INC_DIR)/buildConfig.h
	dir=`getpath -a "$(BLD_BIN_DIR)"` ; \
	echo "#!$$dir/cgiProgram$(BLD_EXE)" >cgi-bin/testScript
	chmod +x cgi-bin/testScript

web/caching/cache.cgi: Makefile $(BLD_INC_DIR)/buildConfig.h
ifeq ($(BLD_WIN_LIKE),1)
	path=`type -p sh` ; path=`cygpath -m "$$path"` ; \
	echo -e "#!$${path}\n" >web/caching/cache.cgi
else
	echo -e "#!`type -p sh`\n" >web/caching/cache.cgi
endif
	echo -e "echo 'HTTP/1.0 200 OK'\necho 'Content-Type: text/plain'\necho ''\necho '{ number: ' $$$$ ' }'" \
		>>web/caching/cache.cgi
	chmod +x web/caching/cache.cgi

web/basic/basic.cgi: Makefile $(BLD_INC_DIR)/buildConfig.h
ifeq ($(BLD_WIN_LIKE),1)
	path=`type -p sh` ; path=`cygpath -m "$$path"` ; \
	echo -e "#!$${path}\n" >web/basic/basic.cgi
else
	echo -e "#!`type -p sh`\n" >web/basic/basic.cgi
endif
	echo -e "echo 'Content-Type: text/plain'\n/usr/bin/env" \ >>web/basic/basic.cgi
	chmod +x web/basic/basic.cgi

#
#	cgiProgram
#
web/cgiProgram.cgi: Makefile $(BLD_INC_DIR)/buildConfig.h
	cp $(CGIP)  cgi-bin/cgiProgram$(BLD_EXE)
	cp $(CGIP)  cgi-bin/nph-cgiProgram$(BLD_EXE)
	cp $(CGIP) 'cgi-bin/cgi Program$(BLD_EXE)'
	cp $(CGIP)  web/cgiProgram.cgi
	chmod +x cgi-bin/* web/cgiProgram.cgi

test-utest::
	true
ifeq ($(BUILDING_TARGET),1)
	ulimit -c unlimited ; $(BLD_EJS) $(BLD_TOOLS_DIR)/utest -v -d $(BUILD_DEPTH)
endif

valgrindTest:
	if type valgrind >/dev/null 2>/dev/null ; then \
		$(call log) "[Test]" "Valgrind tests" ; \
		valgrind -q --tool=memcheck --suppressions=appweb.supp $(BLD_BIN_DIR)/appweb --log stdout:0 --timeout 20 ; \
	fi

server: 
	$(BLD_BIN_DIR)/appweb --log stdout:1

first:
	utest -n -v -i 9999999 --threads 8 -d $(BUILD_DEPTH); \

second:
	utest -2 -v -i 9999999 --threads 8 -d $(BUILD_DEPTH); \

#
#	Test using the http program
#
http:
	TEST_SYSTEM=127.0.0.1:4100
	iterations=4000 ; \
	set -e ; while : ; \
	do \
		set -x ; \
		$(BLD_BIN_DIR)/http -v -t 1 -w 1 -i $$iterations -q $(TEST_SYSTEM)/index.html ; \
		$(BLD_BIN_DIR)/http -v -t 2 -w 2 -i $$iterations -q $(TEST_SYSTEM)/index.html ; \
		$(BLD_BIN_DIR)/http -v -t 4 -w 4 -i $$iterations -q $(TEST_SYSTEM)/index.html ; \
		$(BLD_BIN_DIR)/http -v -t 8 -w 8 -i $$iterations -q $(TEST_SYSTEM)/index.html ; \
		set +x ; \
	done

mem:
	ejs $(BLD_TOOLS_DIR)/memmon APPWEB

users.db:
	echo "# Make authorization databases"
	rm -f users.db groups.db
	@set -e ; \
	httpPassword -c -p pass1 users.db "Acme Inc" joshua ; \
	httpPassword -p pass2 users.db "Acme Inc" mary ; \
	httpPassword -p pass3 users.db "Coyote Corp" peter ; \
	httpPassword -p pass4 users.db "Coyote Corp" julie ; \
	echo "1: 1023: coyoteUsers: peter julie" >groups.db ; \
	echo "1: FFFF: acmeUsers: joshua mary" >>groups.db ; \
	echo "1: FFFF: acmeExec: mary" >>groups.db

scan:
	cd ~/src/nikto ; perl nikto.pl -h 127.0.0.1 -p 4010
	# cd ~/src/nikto ; perl nikto.pl -h 127.0.0.1 -p 4010,4011,4012,4443

scanUpdate:
	perl ~/src/nikto/nikto.pl -update

apacheBench:
	ab -k -c 10 -n 1000 http://127.0.0.1:4100/numbers.html 

testPrep:
	mkdir -p cache app/cache
	rm -f cache/* app/cache/*
	mkdir -p web/tmp
	rm -f web/tmp/*
	find . -name '*.mod' | xargs rm -f >/dev/null 2>&1 ; true

cleanExtra: testPrep
	rm -f *.obj *.pdb
	rm -f access.log error.log leak.log
	rm -f *.o *.lo *.obj *.out */*.mod */*/*.mod
	rm -f cgi-bin/*cgi* ../cgi-bin/testScript
	rm -f web/cgiProgram.cgi
	rm -f cache/* app/cache/*
	rm -f error.log* access.log*

#
#	Don't copy this. Ensure you set minimal permissions on upload and temp directories
#
dependExtra:
	mkdir -p cgi-bin
	rm -f cache/* app/cache/*
	mkdir -p web/tmp cache app/cache
	chmod 777 web/tmp cache app/cache

#
#   Local variables:
#   tab-width: 4
#   c-basic-offset: 4
#   End:
#   vim: sw=4 ts=4 noexpandtab
#
