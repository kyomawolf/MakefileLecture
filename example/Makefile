
#OS detection
ifeq ($(OS),Windows_NT)
	NAME := .\programmname.exe
	NEW := "echo \n > "
	CC := gcc
	RM = erase $(WINDOWSREMOVEFILES)
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		NAME := ./programmname.app
	else
	NAME := ./programmname
	endif
	NEW := "touch "
	CC = gcc
	RM = rm $(OBJ) $(DEP)
endif

#adding variables
FLAGS = -Wall -Werror -Wextra
LIBS = -L ./relative/path/to/libs -l:lib_with_all.a -ljust_the_name

INCLUDES = -I ./relative/path/to/includes
SRC = ./relative/path/to/somefile.c \
		somother/files.C

OBJ = $(patsubst %.c, %.o, $(SRC))
DEP = $(patsubst %.c, %.d, $(SRC))
WINDOWSREMOVEFILES = $(subst /,\,$(OBJECTS), $(DEPENDS))



#rules: should have NAME and/or ALL, some kind of CLEAN rule and a RE rule
all : $(NAME)

#  takes every C-sourcefile and precompiles it:
#  $@ is the targetname (name of the rule), $< is the first dependency (sourcefile in our case)
%.o : %.c
	$(CC) $(INC) $(FLAGS) -MMD -MP -c -o $@ $<
#	-MMD -MP

$(NAME) : $(OBJ) otherules
	$(CC) $(FLAGS) $(OBJ) $(INCLUDES) $(LIBS)

execute : $(NAME)
	$(NAME)

re : clean all

otherrules :
	make -C --silent ./otherlib's/Makefile

clean :
	make fclean --silent ./otherlib's/Makefile
	$(RM) $(NAME)

help :
	@echo "rules:	all [default]"
	@echo "	re"
	@echo "	test"
	@echo "	clean"

include $(DEP)