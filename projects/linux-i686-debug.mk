#
#   build.mk -- Build It Makefile to build Embedthis Appweb for linux on i686
#

PLATFORM  := linux-i686-debug
CC        := cc
CFLAGS    := -fPIC -g -mcpu=i686
DFLAGS    := -DPIC
IFLAGS    := -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc
LDFLAGS   := -L/Users/mob/git/appweb/$(PLATFORM)/lib -g
LIBS      := -lpthread -lm

all: prep \
        $(PLATFORM)/lib/libmpr.so \
        $(PLATFORM)/bin/manager \
        $(PLATFORM)/bin/makerom \
        $(PLATFORM)/lib/libpcre.so \
        $(PLATFORM)/lib/libhttp.so \
        $(PLATFORM)/bin/http \
        $(PLATFORM)/lib/libsqlite3.so \
        $(PLATFORM)/lib/libappweb.so \
        $(PLATFORM)/lib/mod_esp.so \
        $(PLATFORM)/bin/esp \
        $(PLATFORM)/lib/esp.conf \
        $(PLATFORM)/lib/esp-www \
        $(PLATFORM)/lib/mod_cgi.so \
        $(PLATFORM)/bin/auth \
        $(PLATFORM)/bin/cgiProgram \
        $(PLATFORM)/bin/setConfig \
        $(PLATFORM)/bin/appweb \
        $(PLATFORM)/bin/testAppweb \
        src/test/cgi-bin/testScript \
        src/test/web/caching/cache.cgi \
        src/test/web/basic/basic.cgi \
        src/test/cgi-bin/cgiProgram

.PHONY: prep

prep:
	@if [ ! -x $(PLATFORM)/inc ] ; then \
		mkdir -p $(PLATFORM)/inc $(PLATFORM)/obj $(PLATFORM)/lib $(PLATFORM)/bin ; \
		cp src/buildConfig.default $(PLATFORM)/inc/buildConfig.h ; \
	fi

clean:
	rm -rf $(PLATFORM)/lib/libmpr.so
	rm -rf $(PLATFORM)/lib/libmprssl.so
	rm -rf $(PLATFORM)/bin/manager
	rm -rf $(PLATFORM)/bin/makerom
	rm -rf $(PLATFORM)/lib/libpcre.so
	rm -rf $(PLATFORM)/lib/libhttp.so
	rm -rf $(PLATFORM)/bin/http
	rm -rf $(PLATFORM)/lib/libsqlite3.so
	rm -rf $(PLATFORM)/lib/libappweb.so
	rm -rf $(PLATFORM)/lib/mod_esp.so
	rm -rf $(PLATFORM)/bin/esp
	rm -rf $(PLATFORM)/lib/esp.conf
	rm -rf $(PLATFORM)/lib/esp-www
	rm -rf $(PLATFORM)/lib/mod_cgi.so
	rm -rf $(PLATFORM)/lib/mod_ejs.so
	rm -rf $(PLATFORM)/lib/mod_php.so
	rm -rf $(PLATFORM)/lib/mod_ssl.so
	rm -rf $(PLATFORM)/bin/auth
	rm -rf $(PLATFORM)/bin/cgiProgram
	rm -rf $(PLATFORM)/bin/setConfig
	rm -rf $(PLATFORM)/bin/appweb
	rm -rf $(PLATFORM)/bin/testAppweb
	rm -rf $(PLATFORM)/obj/mprLib.o
	rm -rf $(PLATFORM)/obj/mprSsl.o
	rm -rf $(PLATFORM)/obj/manager.o
	rm -rf $(PLATFORM)/obj/makerom.o
	rm -rf $(PLATFORM)/obj/pcre.o
	rm -rf $(PLATFORM)/obj/httpLib.o
	rm -rf $(PLATFORM)/obj/http.o
	rm -rf $(PLATFORM)/obj/sqlite3.o
	rm -rf $(PLATFORM)/obj/config.o
	rm -rf $(PLATFORM)/obj/convenience.o
	rm -rf $(PLATFORM)/obj/dirHandler.o
	rm -rf $(PLATFORM)/obj/fileHandler.o
	rm -rf $(PLATFORM)/obj/log.o
	rm -rf $(PLATFORM)/obj/server.o
	rm -rf $(PLATFORM)/obj/edi.o
	rm -rf $(PLATFORM)/obj/espAbbrev.o
	rm -rf $(PLATFORM)/obj/espFramework.o
	rm -rf $(PLATFORM)/obj/espHandler.o
	rm -rf $(PLATFORM)/obj/espHtml.o
	rm -rf $(PLATFORM)/obj/espSession.o
	rm -rf $(PLATFORM)/obj/espTemplate.o
	rm -rf $(PLATFORM)/obj/mdb.o
	rm -rf $(PLATFORM)/obj/sdb.o
	rm -rf $(PLATFORM)/obj/esp.o
	rm -rf $(PLATFORM)/obj/cgiHandler.o
	rm -rf $(PLATFORM)/obj/ejsHandler.o
	rm -rf $(PLATFORM)/obj/phpHandler.o
	rm -rf $(PLATFORM)/obj/sslModule.o
	rm -rf $(PLATFORM)/obj/auth.o
	rm -rf $(PLATFORM)/obj/cgiProgram.o
	rm -rf $(PLATFORM)/obj/setConfig.o
	rm -rf $(PLATFORM)/obj/appweb.o
	rm -rf $(PLATFORM)/obj/testAppweb.o
	rm -rf $(PLATFORM)/obj/testHttp.o

$(PLATFORM)/obj/mprLib.o: \
        src/deps/mpr/mprLib.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	$(CC) -c -o $(PLATFORM)/obj/mprLib.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/mpr/mprLib.c

$(PLATFORM)/lib/libmpr.so:  \
        $(PLATFORM)/obj/mprLib.o
	$(CC) -shared -o $(PLATFORM)/lib/libmpr.so -L$(PLATFORM)/lib -g $(PLATFORM)/obj/mprLib.o $(LIBS)

$(PLATFORM)/obj/manager.o: \
        src/deps/mpr/manager.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	$(CC) -c -o $(PLATFORM)/obj/manager.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/mpr/manager.c

$(PLATFORM)/bin/manager:  \
        $(PLATFORM)/lib/libmpr.so \
        $(PLATFORM)/obj/manager.o
	$(CC) -o $(PLATFORM)/bin/manager -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/manager.o $(LIBS) -lmpr -L$(PLATFORM)/lib -g

$(PLATFORM)/obj/makerom.o: \
        src/deps/mpr/makerom.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	$(CC) -c -o $(PLATFORM)/obj/makerom.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/mpr/makerom.c

$(PLATFORM)/bin/makerom:  \
        $(PLATFORM)/lib/libmpr.so \
        $(PLATFORM)/obj/makerom.o
	$(CC) -o $(PLATFORM)/bin/makerom -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/makerom.o $(LIBS) -lmpr -L$(PLATFORM)/lib -g

$(PLATFORM)/obj/pcre.o: \
        src/deps/pcre/pcre.c \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/pcre/pcre.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/pcre.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/pcre/pcre.c

$(PLATFORM)/lib/libpcre.so:  \
        $(PLATFORM)/obj/pcre.o
	$(CC) -shared -o $(PLATFORM)/lib/libpcre.so -L$(PLATFORM)/lib -g $(PLATFORM)/obj/pcre.o $(LIBS)

$(PLATFORM)/obj/httpLib.o: \
        src/deps/http/httpLib.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/http/http.h \
        src/deps/pcre/pcre.h
	$(CC) -c -o $(PLATFORM)/obj/httpLib.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/http/httpLib.c

$(PLATFORM)/lib/libhttp.so:  \
        $(PLATFORM)/lib/libmpr.so \
        $(PLATFORM)/lib/libpcre.so \
        $(PLATFORM)/obj/httpLib.o
	$(CC) -shared -o $(PLATFORM)/lib/libhttp.so -L$(PLATFORM)/lib -g $(PLATFORM)/obj/httpLib.o $(LIBS) -lmpr -lpcre

$(PLATFORM)/obj/http.o: \
        src/deps/http/http.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/http/http.h
	$(CC) -c -o $(PLATFORM)/obj/http.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/http/http.c

$(PLATFORM)/bin/http:  \
        $(PLATFORM)/lib/libhttp.so \
        $(PLATFORM)/obj/http.o
	$(CC) -o $(PLATFORM)/bin/http -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/http.o $(LIBS) -lhttp -lmpr -lpcre -L$(PLATFORM)/lib -g

$(PLATFORM)/obj/sqlite3.o: \
        src/deps/sqlite/sqlite3.c \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/sqlite/sqlite3.h
	$(CC) -c -o $(PLATFORM)/obj/sqlite3.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/sqlite/sqlite3.c

$(PLATFORM)/lib/libsqlite3.so:  \
        $(PLATFORM)/obj/sqlite3.o
	$(CC) -shared -o $(PLATFORM)/lib/libsqlite3.so -L$(PLATFORM)/lib -g $(PLATFORM)/obj/sqlite3.o $(LIBS)

$(PLATFORM)/obj/config.o: \
        src/config.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/deps/pcre/pcre.h
	$(CC) -c -o $(PLATFORM)/obj/config.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/config.c

$(PLATFORM)/obj/convenience.o: \
        src/convenience.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	$(CC) -c -o $(PLATFORM)/obj/convenience.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/convenience.c

$(PLATFORM)/obj/dirHandler.o: \
        src/dirHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	$(CC) -c -o $(PLATFORM)/obj/dirHandler.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/dirHandler.c

$(PLATFORM)/obj/fileHandler.o: \
        src/fileHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	$(CC) -c -o $(PLATFORM)/obj/fileHandler.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/fileHandler.c

$(PLATFORM)/obj/log.o: \
        src/log.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	$(CC) -c -o $(PLATFORM)/obj/log.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/log.c

$(PLATFORM)/obj/server.o: \
        src/server.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	$(CC) -c -o $(PLATFORM)/obj/server.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/server.c

$(PLATFORM)/lib/libappweb.so:  \
        $(PLATFORM)/lib/libmpr.so \
        $(PLATFORM)/lib/libhttp.so \
        $(PLATFORM)/lib/libpcre.so \
        $(PLATFORM)/obj/config.o \
        $(PLATFORM)/obj/convenience.o \
        $(PLATFORM)/obj/dirHandler.o \
        $(PLATFORM)/obj/fileHandler.o \
        $(PLATFORM)/obj/log.o \
        $(PLATFORM)/obj/server.o
	$(CC) -shared -o $(PLATFORM)/lib/libappweb.so -L$(PLATFORM)/lib -g $(PLATFORM)/obj/config.o $(PLATFORM)/obj/convenience.o $(PLATFORM)/obj/dirHandler.o $(PLATFORM)/obj/fileHandler.o $(PLATFORM)/obj/log.o $(PLATFORM)/obj/server.o $(LIBS) -lmpr -lhttp -lpcre -lpcre

$(PLATFORM)/obj/edi.o: \
        src/esp/edi.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/edi.h \
        src/deps/pcre/pcre.h
	$(CC) -c -o $(PLATFORM)/obj/edi.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/edi.c

$(PLATFORM)/obj/espAbbrev.o: \
        src/esp/espAbbrev.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	$(CC) -c -o $(PLATFORM)/obj/espAbbrev.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espAbbrev.c

$(PLATFORM)/obj/espFramework.o: \
        src/esp/espFramework.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	$(CC) -c -o $(PLATFORM)/obj/espFramework.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espFramework.c

$(PLATFORM)/obj/espHandler.o: \
        src/esp/espHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/esp/esp.h \
        src/esp/edi.h
	$(CC) -c -o $(PLATFORM)/obj/espHandler.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espHandler.c

$(PLATFORM)/obj/espHtml.o: \
        src/esp/espHtml.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h \
        src/esp/edi.h
	$(CC) -c -o $(PLATFORM)/obj/espHtml.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espHtml.c

$(PLATFORM)/obj/espSession.o: \
        src/esp/espSession.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	$(CC) -c -o $(PLATFORM)/obj/espSession.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espSession.c

$(PLATFORM)/obj/espTemplate.o: \
        src/esp/espTemplate.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	$(CC) -c -o $(PLATFORM)/obj/espTemplate.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espTemplate.c

$(PLATFORM)/obj/mdb.o: \
        src/esp/mdb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/esp/edi.h \
        src/esp/mdb.h \
        src/deps/pcre/pcre.h
	$(CC) -c -o $(PLATFORM)/obj/mdb.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/mdb.c

$(PLATFORM)/obj/sdb.o: \
        src/esp/sdb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/esp/edi.h
	$(CC) -c -o $(PLATFORM)/obj/sdb.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/sdb.c

$(PLATFORM)/lib/mod_esp.so:  \
        $(PLATFORM)/lib/libappweb.so \
        $(PLATFORM)/obj/edi.o \
        $(PLATFORM)/obj/espAbbrev.o \
        $(PLATFORM)/obj/espFramework.o \
        $(PLATFORM)/obj/espHandler.o \
        $(PLATFORM)/obj/espHtml.o \
        $(PLATFORM)/obj/espSession.o \
        $(PLATFORM)/obj/espTemplate.o \
        $(PLATFORM)/obj/mdb.o \
        $(PLATFORM)/obj/sdb.o
	$(CC) -shared -o $(PLATFORM)/lib/mod_esp.so -L$(PLATFORM)/lib -g $(PLATFORM)/obj/edi.o $(PLATFORM)/obj/espAbbrev.o $(PLATFORM)/obj/espFramework.o $(PLATFORM)/obj/espHandler.o $(PLATFORM)/obj/espHtml.o $(PLATFORM)/obj/espSession.o $(PLATFORM)/obj/espTemplate.o $(PLATFORM)/obj/mdb.o $(PLATFORM)/obj/sdb.o $(LIBS) -lappweb -lmpr -lhttp -lpcre

$(PLATFORM)/obj/esp.o: \
        src/esp/esp.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	$(CC) -c -o $(PLATFORM)/obj/esp.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/esp.c

$(PLATFORM)/bin/esp:  \
        $(PLATFORM)/lib/libappweb.so \
        $(PLATFORM)/obj/edi.o \
        $(PLATFORM)/obj/esp.o \
        $(PLATFORM)/obj/espAbbrev.o \
        $(PLATFORM)/obj/espFramework.o \
        $(PLATFORM)/obj/espHandler.o \
        $(PLATFORM)/obj/espHtml.o \
        $(PLATFORM)/obj/espSession.o \
        $(PLATFORM)/obj/espTemplate.o \
        $(PLATFORM)/obj/mdb.o \
        $(PLATFORM)/obj/sdb.o
	$(CC) -o $(PLATFORM)/bin/esp -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/edi.o $(PLATFORM)/obj/esp.o $(PLATFORM)/obj/espAbbrev.o $(PLATFORM)/obj/espFramework.o $(PLATFORM)/obj/espHandler.o $(PLATFORM)/obj/espHtml.o $(PLATFORM)/obj/espSession.o $(PLATFORM)/obj/espTemplate.o $(PLATFORM)/obj/mdb.o $(PLATFORM)/obj/sdb.o $(LIBS) -lappweb -lmpr -lhttp -lpcre -L$(PLATFORM)/lib -g

linux-i686-debug/lib/esp.conf: 
	rm -fr /Users/mob/git/appweb/linux-i686-debug/lib/esp.conf
	cp -r /Users/mob/git/appweb/src/esp/esp.conf /Users/mob/git/appweb/linux-i686-debug/lib/esp.conf

linux-i686-debug/lib/esp-www: 
	rm -fr /Users/mob/git/appweb/linux-i686-debug/lib/esp-www
	cp -r /Users/mob/git/appweb/src/esp/www /Users/mob/git/appweb/linux-i686-debug/lib/esp-www

$(PLATFORM)/obj/cgiHandler.o: \
        src/modules/cgiHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	$(CC) -c -o $(PLATFORM)/obj/cgiHandler.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/modules/cgiHandler.c

$(PLATFORM)/lib/mod_cgi.so:  \
        $(PLATFORM)/lib/libappweb.so \
        $(PLATFORM)/obj/cgiHandler.o
	$(CC) -shared -o $(PLATFORM)/lib/mod_cgi.so -L$(PLATFORM)/lib -g $(PLATFORM)/obj/cgiHandler.o $(LIBS) -lappweb -lmpr -lhttp -lpcre

$(PLATFORM)/obj/auth.o: \
        src/utils/auth.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/http/http.h
	$(CC) -c -o $(PLATFORM)/obj/auth.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/utils/auth.c

$(PLATFORM)/bin/auth:  \
        $(PLATFORM)/lib/libmpr.so \
        $(PLATFORM)/obj/auth.o
	$(CC) -o $(PLATFORM)/bin/auth -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/auth.o $(LIBS) -lmpr -L$(PLATFORM)/lib -g

$(PLATFORM)/obj/cgiProgram.o: \
        src/utils/cgiProgram.c \
        $(PLATFORM)/inc/buildConfig.h
	$(CC) -c -o $(PLATFORM)/obj/cgiProgram.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/utils/cgiProgram.c

$(PLATFORM)/bin/cgiProgram:  \
        $(PLATFORM)/obj/cgiProgram.o
	$(CC) -o $(PLATFORM)/bin/cgiProgram -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/cgiProgram.o $(LIBS) -L$(PLATFORM)/lib -g

$(PLATFORM)/obj/setConfig.o: \
        src/utils/setConfig.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	$(CC) -c -o $(PLATFORM)/obj/setConfig.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/utils/setConfig.c

$(PLATFORM)/bin/setConfig:  \
        $(PLATFORM)/lib/libmpr.so \
        $(PLATFORM)/obj/setConfig.o
	$(CC) -o $(PLATFORM)/bin/setConfig -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/setConfig.o $(LIBS) -lmpr -L$(PLATFORM)/lib -g

$(PLATFORM)/obj/appweb.o: \
        src/server/appweb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	$(CC) -c -o $(PLATFORM)/obj/appweb.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/server/appweb.c

$(PLATFORM)/bin/appweb:  \
        $(PLATFORM)/lib/libappweb.so \
        $(PLATFORM)/obj/appweb.o
	$(CC) -o $(PLATFORM)/bin/appweb -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/appweb.o $(LIBS) -lappweb -lmpr -lhttp -lpcre -L$(PLATFORM)/lib -g

$(PLATFORM)/obj/testAppweb.o: \
        src/test/testAppweb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/test/testAppweb.h
	$(CC) -c -o $(PLATFORM)/obj/testAppweb.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc -Isrc/test src/test/testAppweb.c

$(PLATFORM)/obj/testHttp.o: \
        src/test/testHttp.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/test/testAppweb.h
	$(CC) -c -o $(PLATFORM)/obj/testHttp.o $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc -Isrc/test src/test/testHttp.c

$(PLATFORM)/bin/testAppweb:  \
        $(PLATFORM)/lib/libappweb.so \
        $(PLATFORM)/obj/testAppweb.o \
        $(PLATFORM)/obj/testHttp.o
	$(CC) -o $(PLATFORM)/bin/testAppweb -L$(PLATFORM)/lib -g -L$(PLATFORM)/lib $(PLATFORM)/obj/testAppweb.o $(PLATFORM)/obj/testHttp.o $(LIBS) -lappweb -lmpr -lhttp -lpcre -L$(PLATFORM)/lib -g

src/test/cgi-bin/testScript: 
	echo '#!/Users/mob/git/appweb/linux-i686-debug/bin/cgiProgram' >/Users/mob/git/appweb/src/test/cgi-bin/testScript ; chmod +x /Users/mob/git/appweb/src/test/cgi-bin/testScript

src/test/web/caching/cache.cgi: 
	echo -e '#!`type -p sh`' >/Users/mob/git/appweb/src/test/web/caching/cache.cgi
	echo -e '' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
	echo -e 'echo HTTP/1.0 200 OK' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
	echo -e 'echo Content-Type: text/plain' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
	echo -e 'date' >>/Users/mob/git/appweb/src/test/web/caching/cache.cgi
	chmod +x /Users/mob/git/appweb/src/test/web/caching/cache.cgi

src/test/web/basic/basic.cgi: 
	echo -e '#!`type -p sh`' >/Users/mob/git/appweb/src/test/web/basic/basic.cgi
	echo -e '' >>/Users/mob/git/appweb/src/test/web/basic/basic.cgi
	echo -e 'echo Content-Type: text/plain' >>/Users/mob/git/appweb/src/test/web/basic/basic.cgi
	echo -e '/usr/bin/env' >>/Users/mob/git/appweb/src/test/web/basic/basic.cgi
	chmod +x /Users/mob/git/appweb/src/test/web/basic/basic.cgi

src/test/cgi-bin/cgiProgram: 
	cp /Users/mob/git/appweb/linux-i686-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/cgi-bin/cgiProgram
	cp /Users/mob/git/appweb/linux-i686-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/cgi-bin/nph-cgiProgram
	cp /Users/mob/git/appweb/linux-i686-debug/bin/cgiProgram '/Users/mob/git/appweb/src/test/cgi-bin/cgi Program'
	cp /Users/mob/git/appweb/linux-i686-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/web/cgiProgram.cgi
	chmod +x /Users/mob/git/appweb/src/test/cgi-bin/* /Users/mob/git/appweb/src/test/web/cgiProgram.cgi

