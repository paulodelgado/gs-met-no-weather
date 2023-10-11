ifeq ($(GNUSTEP_MAKEFILES),)
 GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
  ifeq ($(GNUSTEP_MAKEFILES),)
    $(warning )
    $(warning Unable to obtain GNUSTEP_MAKEFILES setting from gnustep-config!)
    $(warning Perhaps gnustep-make is not properly installed,)
    $(warning so gnustep-config is not in your PATH.)
    $(warning )
    $(warning Your PATH is currently $(PATH))
    $(warning )
  endif
endif

ifeq ($(GNUSTEP_MAKEFILES),)
  $(error You need to set GNUSTEP_MAKEFILES before compiling!)
endif

include $(GNUSTEP_MAKEFILES)/common.make

-include config.make

PACKAGE_NAME = GSMetNoWeather
PACKAGE_VERSION = 0.0.1

NEEDS_GUI = NO

LIBRARIES_DEPEND_UPON = $(FND_LIBS) $(OBJC_LIBS)

LIBRARY_NAME=GSMetNoWeather
DOCUMENT_NAME=GSMetNoWeather

GSMetNoWeather_OBJC_FILES += \
	GSMetNoWeather.m


GSMetNoWeather_HEADER_FILES += \
	GSMetNoWeather.h


-include GNUmakefile.preamble

include $(GNUSTEP_MAKEFILES)/library.make
include $(GNUSTEP_MAKEFILES)/documentation.make

-include GNUmakefile.postamble
