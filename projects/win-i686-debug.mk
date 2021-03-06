#
#   build.mk -- Build It Makefile to build Embedthis Appweb for win on i686
#

PLATFORM  := win-i686-debug
CC        := cl
CFLAGS    := -nologo -GR- -W3 -Zi -Od -MDd
DFLAGS    := -D_REENTRANT -D_MT
IFLAGS    := -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc
LDFLAGS   := -nologo -nodefaultlib -incremental:no -libpath:/Users/mob/git/appweb/$(PLATFORM)/bin -debug -machine:x86
LIBS      := ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib

export PATH := %VS%/Bin:%VS%/VC/Bin:%VS%/Common7/IDE:%VS%/Common7/Tools:%VS%/SDK/v3.5/bin:%VS%/VC/VCPackages
export INCLUDE := %VS%/INCLUDE:%VS%/VC/INCLUDE
export LIB := %VS%/lib:%VS%/VC/lib
all: prep \
        $(PLATFORM)/bin/libmpr.dll \
        $(PLATFORM)/bin/manager.exe \
        $(PLATFORM)/bin/makerom.exe \
        $(PLATFORM)/bin/libpcre.dll \
        $(PLATFORM)/bin/libhttp.dll \
        $(PLATFORM)/bin/http.exe \
        $(PLATFORM)/bin/libsqlite3.dll \
        $(PLATFORM)/bin/libappweb.dll \
        $(PLATFORM)/bin/mod_esp.dll \
        $(PLATFORM)/bin/esp.exe \
        $(PLATFORM)/bin/esp.conf \
        $(PLATFORM)/bin/esp-www \
        $(PLATFORM)/bin/mod_cgi.dll \
        $(PLATFORM)/bin/auth.exe \
        $(PLATFORM)/bin/cgiProgram.exe \
        $(PLATFORM)/bin/setConfig.exe \
        $(PLATFORM)/bin/appweb.exe \
        $(PLATFORM)/bin/testAppweb.exe \
        src/test/cgi-bin/testScript \
        src/test/web/caching/cache.cgi \
        src/test/web/basic/basic.cgi \
        src/test/cgi-bin/cgiProgram.exe

.PHONY: prep

prep:
	@if [ ! -x $(PLATFORM)/inc ] ; then \
		mkdir -p $(PLATFORM)/inc $(PLATFORM)/obj $(PLATFORM)/lib $(PLATFORM)/bin ; \
		cp src/buildConfig.default $(PLATFORM)/inc/buildConfig.h ; \
	fi

clean:
	rm -rf $(PLATFORM)/bin/libmpr.dll
	rm -rf $(PLATFORM)/bin/libmprssl.dll
	rm -rf $(PLATFORM)/bin/manager.exe
	rm -rf $(PLATFORM)/bin/makerom.exe
	rm -rf $(PLATFORM)/bin/libpcre.dll
	rm -rf $(PLATFORM)/bin/libhttp.dll
	rm -rf $(PLATFORM)/bin/http.exe
	rm -rf $(PLATFORM)/bin/libsqlite3.dll
	rm -rf $(PLATFORM)/bin/libappweb.dll
	rm -rf $(PLATFORM)/bin/mod_esp.dll
	rm -rf $(PLATFORM)/bin/esp.exe
	rm -rf $(PLATFORM)/bin/esp.conf
	rm -rf $(PLATFORM)/bin/esp-www
	rm -rf $(PLATFORM)/bin/mod_cgi.dll
	rm -rf $(PLATFORM)/bin/mod_ejs.dll
	rm -rf $(PLATFORM)/bin/mod_php.dll
	rm -rf $(PLATFORM)/bin/mod_ssl.dll
	rm -rf $(PLATFORM)/bin/auth.exe
	rm -rf $(PLATFORM)/bin/cgiProgram.exe
	rm -rf $(PLATFORM)/bin/setConfig.exe
	rm -rf $(PLATFORM)/bin/appweb.exe
	rm -rf $(PLATFORM)/bin/testAppweb.exe
	rm -rf $(PLATFORM)/obj/mprLib.obj
	rm -rf $(PLATFORM)/obj/mprSsl.obj
	rm -rf $(PLATFORM)/obj/manager.obj
	rm -rf $(PLATFORM)/obj/makerom.obj
	rm -rf $(PLATFORM)/obj/pcre.obj
	rm -rf $(PLATFORM)/obj/httpLib.obj
	rm -rf $(PLATFORM)/obj/http.obj
	rm -rf $(PLATFORM)/obj/sqlite3.obj
	rm -rf $(PLATFORM)/obj/config.obj
	rm -rf $(PLATFORM)/obj/convenience.obj
	rm -rf $(PLATFORM)/obj/dirHandler.obj
	rm -rf $(PLATFORM)/obj/fileHandler.obj
	rm -rf $(PLATFORM)/obj/log.obj
	rm -rf $(PLATFORM)/obj/server.obj
	rm -rf $(PLATFORM)/obj/edi.obj
	rm -rf $(PLATFORM)/obj/espAbbrev.obj
	rm -rf $(PLATFORM)/obj/espFramework.obj
	rm -rf $(PLATFORM)/obj/espHandler.obj
	rm -rf $(PLATFORM)/obj/espHtml.obj
	rm -rf $(PLATFORM)/obj/espSession.obj
	rm -rf $(PLATFORM)/obj/espTemplate.obj
	rm -rf $(PLATFORM)/obj/mdb.obj
	rm -rf $(PLATFORM)/obj/sdb.obj
	rm -rf $(PLATFORM)/obj/esp.obj
	rm -rf $(PLATFORM)/obj/cgiHandler.obj
	rm -rf $(PLATFORM)/obj/ejsHandler.obj
	rm -rf $(PLATFORM)/obj/phpHandler.obj
	rm -rf $(PLATFORM)/obj/sslModule.obj
	rm -rf $(PLATFORM)/obj/auth.obj
	rm -rf $(PLATFORM)/obj/cgiProgram.obj
	rm -rf $(PLATFORM)/obj/setConfig.obj
	rm -rf $(PLATFORM)/obj/appweb.obj
	rm -rf $(PLATFORM)/obj/testAppweb.obj
	rm -rf $(PLATFORM)/obj/testHttp.obj

$(PLATFORM)/obj/mprLib.obj: \
        src/deps/mpr/mprLib.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/mprLib.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/mpr/mprLib.c

$(PLATFORM)/bin/libmpr.dll:  \
        $(PLATFORM)/obj/mprLib.obj
	"link" -dll -out:$(PLATFORM)/bin/libmpr.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/libmpr.def -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/mprLib.obj $(LIBS)

$(PLATFORM)/obj/manager.obj: \
        src/deps/mpr/manager.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/manager.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/mpr/manager.c

$(PLATFORM)/bin/manager.exe:  \
        $(PLATFORM)/bin/libmpr.dll \
        $(PLATFORM)/obj/manager.obj
	"link" -out:$(PLATFORM)/bin/manager.exe -entry:WinMainCRTStartup -subsystem:Windows -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/manager.obj $(LIBS) mpr.lib shell32.lib

$(PLATFORM)/obj/makerom.obj: \
        src/deps/mpr/makerom.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/makerom.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/mpr/makerom.c

$(PLATFORM)/bin/makerom.exe:  \
        $(PLATFORM)/bin/libmpr.dll \
        $(PLATFORM)/obj/makerom.obj
	"link" -out:$(PLATFORM)/bin/makerom.exe -entry:mainCRTStartup -subsystem:console -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/makerom.obj $(LIBS) mpr.lib

$(PLATFORM)/obj/pcre.obj: \
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
	"$(CC)" -c -Fo$(PLATFORM)/obj/pcre.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/pcre/pcre.c

$(PLATFORM)/bin/libpcre.dll:  \
        $(PLATFORM)/obj/pcre.obj
	"link" -dll -out:$(PLATFORM)/bin/libpcre.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/libpcre.def -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/pcre.obj $(LIBS)

$(PLATFORM)/obj/httpLib.obj: \
        src/deps/http/httpLib.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/http/http.h \
        src/deps/pcre/pcre.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/httpLib.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/http/httpLib.c

$(PLATFORM)/bin/libhttp.dll:  \
        $(PLATFORM)/bin/libmpr.dll \
        $(PLATFORM)/bin/libpcre.dll \
        $(PLATFORM)/obj/httpLib.obj
	"link" -dll -out:$(PLATFORM)/bin/libhttp.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/libhttp.def -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/httpLib.obj $(LIBS) mpr.lib pcre.lib

$(PLATFORM)/obj/http.obj: \
        src/deps/http/http.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/http/http.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/http.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/http/http.c

$(PLATFORM)/bin/http.exe:  \
        $(PLATFORM)/bin/libhttp.dll \
        $(PLATFORM)/obj/http.obj
	"link" -out:$(PLATFORM)/bin/http.exe -entry:mainCRTStartup -subsystem:console -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/http.obj $(LIBS) http.lib mpr.lib pcre.lib

$(PLATFORM)/obj/sqlite3.obj: \
        src/deps/sqlite/sqlite3.c \
        $(PLATFORM)/inc/buildConfig.h \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/sqlite/sqlite3.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/sqlite3.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/deps/sqlite/sqlite3.c

$(PLATFORM)/bin/libsqlite3.dll:  \
        $(PLATFORM)/obj/sqlite3.obj
	"link" -dll -out:$(PLATFORM)/bin/libsqlite3.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/libsqlite3.def -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/sqlite3.obj $(LIBS)

$(PLATFORM)/obj/config.obj: \
        src/config.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/deps/pcre/pcre.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/config.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/config.c

$(PLATFORM)/obj/convenience.obj: \
        src/convenience.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/convenience.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/convenience.c

$(PLATFORM)/obj/dirHandler.obj: \
        src/dirHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/dirHandler.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/dirHandler.c

$(PLATFORM)/obj/fileHandler.obj: \
        src/fileHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/fileHandler.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/fileHandler.c

$(PLATFORM)/obj/log.obj: \
        src/log.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/log.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/log.c

$(PLATFORM)/obj/server.obj: \
        src/server.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/server.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/server.c

$(PLATFORM)/bin/libappweb.dll:  \
        $(PLATFORM)/bin/libmpr.dll \
        $(PLATFORM)/bin/libhttp.dll \
        $(PLATFORM)/bin/libpcre.dll \
        $(PLATFORM)/obj/config.obj \
        $(PLATFORM)/obj/convenience.obj \
        $(PLATFORM)/obj/dirHandler.obj \
        $(PLATFORM)/obj/fileHandler.obj \
        $(PLATFORM)/obj/log.obj \
        $(PLATFORM)/obj/server.obj
	"link" -dll -out:$(PLATFORM)/bin/libappweb.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/libappweb.def -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/config.obj $(PLATFORM)/obj/convenience.obj $(PLATFORM)/obj/dirHandler.obj $(PLATFORM)/obj/fileHandler.obj $(PLATFORM)/obj/log.obj $(PLATFORM)/obj/server.obj $(LIBS) mpr.lib http.lib pcre.lib pcre.lib

$(PLATFORM)/obj/edi.obj: \
        src/esp/edi.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/edi.h \
        src/deps/pcre/pcre.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/edi.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/edi.c

$(PLATFORM)/obj/espAbbrev.obj: \
        src/esp/espAbbrev.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/espAbbrev.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espAbbrev.c

$(PLATFORM)/obj/espFramework.obj: \
        src/esp/espFramework.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/espFramework.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espFramework.c

$(PLATFORM)/obj/espHandler.obj: \
        src/esp/espHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/esp/esp.h \
        src/esp/edi.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/espHandler.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espHandler.c

$(PLATFORM)/obj/espHtml.obj: \
        src/esp/espHtml.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h \
        src/esp/edi.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/espHtml.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espHtml.c

$(PLATFORM)/obj/espSession.obj: \
        src/esp/espSession.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/espSession.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espSession.c

$(PLATFORM)/obj/espTemplate.obj: \
        src/esp/espTemplate.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/espTemplate.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/espTemplate.c

$(PLATFORM)/obj/mdb.obj: \
        src/esp/mdb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/esp/edi.h \
        src/esp/mdb.h \
        src/deps/pcre/pcre.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/mdb.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/mdb.c

$(PLATFORM)/obj/sdb.obj: \
        src/esp/sdb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h \
        src/esp/edi.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/sdb.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/sdb.c

$(PLATFORM)/bin/mod_esp.dll:  \
        $(PLATFORM)/bin/libappweb.dll \
        $(PLATFORM)/obj/edi.obj \
        $(PLATFORM)/obj/espAbbrev.obj \
        $(PLATFORM)/obj/espFramework.obj \
        $(PLATFORM)/obj/espHandler.obj \
        $(PLATFORM)/obj/espHtml.obj \
        $(PLATFORM)/obj/espSession.obj \
        $(PLATFORM)/obj/espTemplate.obj \
        $(PLATFORM)/obj/mdb.obj \
        $(PLATFORM)/obj/sdb.obj
	"link" -dll -out:$(PLATFORM)/bin/mod_esp.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/mod_esp.def -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/edi.obj $(PLATFORM)/obj/espAbbrev.obj $(PLATFORM)/obj/espFramework.obj $(PLATFORM)/obj/espHandler.obj $(PLATFORM)/obj/espHtml.obj $(PLATFORM)/obj/espSession.obj $(PLATFORM)/obj/espTemplate.obj $(PLATFORM)/obj/mdb.obj $(PLATFORM)/obj/sdb.obj $(LIBS) appweb.lib mpr.lib http.lib pcre.lib

$(PLATFORM)/obj/esp.obj: \
        src/esp/esp.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/esp/esp.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/esp.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/esp/esp.c

$(PLATFORM)/bin/esp.exe:  \
        $(PLATFORM)/bin/libappweb.dll \
        $(PLATFORM)/obj/edi.obj \
        $(PLATFORM)/obj/esp.obj \
        $(PLATFORM)/obj/espAbbrev.obj \
        $(PLATFORM)/obj/espFramework.obj \
        $(PLATFORM)/obj/espHandler.obj \
        $(PLATFORM)/obj/espHtml.obj \
        $(PLATFORM)/obj/espSession.obj \
        $(PLATFORM)/obj/espTemplate.obj \
        $(PLATFORM)/obj/mdb.obj \
        $(PLATFORM)/obj/sdb.obj
	"link" -out:$(PLATFORM)/bin/esp.exe -entry:mainCRTStartup -subsystem:console -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/edi.obj $(PLATFORM)/obj/esp.obj $(PLATFORM)/obj/espAbbrev.obj $(PLATFORM)/obj/espFramework.obj $(PLATFORM)/obj/espHandler.obj $(PLATFORM)/obj/espHtml.obj $(PLATFORM)/obj/espSession.obj $(PLATFORM)/obj/espTemplate.obj $(PLATFORM)/obj/mdb.obj $(PLATFORM)/obj/sdb.obj $(LIBS) appweb.lib mpr.lib http.lib pcre.lib

win-i686-debug/bin/esp.conf: 
	rm -fr /Users/mob/git/appweb/win-i686-debug/bin/esp.conf
	cp -r /Users/mob/git/appweb/src/esp/esp.conf /Users/mob/git/appweb/win-i686-debug/bin/esp.conf

win-i686-debug/bin/esp-www: 
	rm -fr /Users/mob/git/appweb/win-i686-debug/bin/esp-www
	cp -r /Users/mob/git/appweb/src/esp/www /Users/mob/git/appweb/win-i686-debug/bin/esp-www

$(PLATFORM)/obj/cgiHandler.obj: \
        src/modules/cgiHandler.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/cgiHandler.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/modules/cgiHandler.c

$(PLATFORM)/bin/mod_cgi.dll:  \
        $(PLATFORM)/bin/libappweb.dll \
        $(PLATFORM)/obj/cgiHandler.obj
	"link" -dll -out:$(PLATFORM)/bin/mod_cgi.dll -entry:_DllMainCRTStartup@12 -def:$(PLATFORM)/bin/mod_cgi.def -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/cgiHandler.obj $(LIBS) appweb.lib mpr.lib http.lib pcre.lib

$(PLATFORM)/obj/auth.obj: \
        src/utils/auth.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/http/http.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/auth.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/utils/auth.c

$(PLATFORM)/bin/auth.exe:  \
        $(PLATFORM)/bin/libmpr.dll \
        $(PLATFORM)/obj/auth.obj
	"link" -out:$(PLATFORM)/bin/auth.exe -entry:mainCRTStartup -subsystem:console -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/auth.obj $(LIBS) mpr.lib

$(PLATFORM)/obj/cgiProgram.obj: \
        src/utils/cgiProgram.c \
        $(PLATFORM)/inc/buildConfig.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/cgiProgram.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/utils/cgiProgram.c

$(PLATFORM)/bin/cgiProgram.exe:  \
        $(PLATFORM)/obj/cgiProgram.obj
	"link" -out:$(PLATFORM)/bin/cgiProgram.exe -entry:mainCRTStartup -subsystem:console -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/cgiProgram.obj $(LIBS)

$(PLATFORM)/obj/setConfig.obj: \
        src/utils/setConfig.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/deps/mpr/mpr.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/setConfig.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/utils/setConfig.c

$(PLATFORM)/bin/setConfig.exe:  \
        $(PLATFORM)/bin/libmpr.dll \
        $(PLATFORM)/obj/setConfig.obj
	"link" -out:$(PLATFORM)/bin/setConfig.exe -entry:WinMainCRTStartup -subsystem:Windows -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/setConfig.obj $(LIBS) mpr.lib shell32.lib

$(PLATFORM)/obj/appweb.obj: \
        src/server/appweb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/appweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/appweb.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc src/server/appweb.c

$(PLATFORM)/bin/appweb.exe:  \
        $(PLATFORM)/bin/libappweb.dll \
        $(PLATFORM)/obj/appweb.obj
	"link" -out:$(PLATFORM)/bin/appweb.exe -entry:mainCRTStartup -subsystem:console -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/appweb.obj $(LIBS) appweb.lib mpr.lib http.lib pcre.lib

$(PLATFORM)/obj/testAppweb.obj: \
        src/test/testAppweb.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/test/testAppweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/testAppweb.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc -Isrc/test src/test/testAppweb.c

$(PLATFORM)/obj/testHttp.obj: \
        src/test/testHttp.c \
        $(PLATFORM)/inc/buildConfig.h \
        src/test/testAppweb.h
	"$(CC)" -c -Fo$(PLATFORM)/obj/testHttp.obj -Fd$(PLATFORM)/obj $(CFLAGS) $(DFLAGS) -I$(PLATFORM)/inc -Isrc/deps/mpr -Isrc/deps/pcre -Isrc/deps/http -Isrc/deps/sqlite -Isrc -Isrc/esp -Isrc -Isrc/test src/test/testHttp.c

$(PLATFORM)/bin/testAppweb.exe:  \
        $(PLATFORM)/bin/libappweb.dll \
        $(PLATFORM)/obj/testAppweb.obj \
        $(PLATFORM)/obj/testHttp.obj
	"link" -out:$(PLATFORM)/bin/testAppweb.exe -entry:mainCRTStartup -subsystem:console -nologo -nodefaultlib -incremental:no -libpath:$(PLATFORM)/bin -debug -machine:x86 $(PLATFORM)/obj/testAppweb.obj $(PLATFORM)/obj/testHttp.obj $(LIBS) appweb.lib mpr.lib http.lib pcre.lib

src/test/cgi-bin/testScript: 
	echo '#!/Users/mob/git/appweb/win-i686-debug/bin/cgiProgram.exe' >/Users/mob/git/appweb/src/test/cgi-bin/testScript ; chmod +x /Users/mob/git/appweb/src/test/cgi-bin/testScript

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

src/test/cgi-bin/cgiProgram.exe: 
	cp /Users/mob/git/appweb/win-i686-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/cgi-bin/cgiProgram.exe
	cp /Users/mob/git/appweb/win-i686-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/cgi-bin/nph-cgiProgram.exe
	cp /Users/mob/git/appweb/win-i686-debug/bin/cgiProgram '/Users/mob/git/appweb/src/test/cgi-bin/cgi Program.exe'
	cp /Users/mob/git/appweb/win-i686-debug/bin/cgiProgram /Users/mob/git/appweb/src/test/web/cgiProgram.cgi
	chmod +x /Users/mob/git/appweb/src/test/cgi-bin/* /Users/mob/git/appweb/src/test/web/cgiProgram.cgi

