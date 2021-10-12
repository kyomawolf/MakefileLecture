
#OS detection
ifeq ($(OS),Windows_NT)
	HELP = rulewin
	CC := gcc
	RM = erase $(WINDOWSREMOVEFILES)
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
	HELP = ruleelse
	else
	HELP = ruleelse
	endif
endif

all : $(HELP)

ruleelse :
	@echo "\033[1m HI \033[0m"
	@echo "\033[3;36m\033[1m\n		---This is a (not so) simple Makefile challenge---\n\033[0m\033[0;0m"
	@echo "\033[3;30m\033[1mLevel1\033[0m\033[0;0m\n	Create a simple makefile, that can compile the given sourcecode with 'make'"
	@echo "\033[3;33m\033[1mLevel2\033[0m\033[0;0m\n	Create a makefile which has a library as a dependency, also create rules to clean up!\n	Kinda bonus?(you are not allowed to compile or clean in the library subfolder directly)"
	@echo "\033[3;35m\033[1mLevel3\033[0m\033[0;0m\n	Create a makefile which uses *.o files to compile"
	@echo "\033[3;31m\033[1mLevel4\033[0m\033[0;0m\n	Create a makefile that will do everything from the other levels and also recompiles sources of you change the content of a header"
	@echo

rulewin :
	@windows.bat