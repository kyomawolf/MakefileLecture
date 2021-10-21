#simple make call functions in this makefile from your own makefile

ifdef OS
	CP = copy
	NAME=libuseful.a
	HEADER =usefullib.h
	INCPATH = ..\..\inc\$(HEADER)
	LIBPATH = ..\$(NAME) 
	RM = erase 
else
	CP = cp
	NAME=libuseful.a
	HEADER =usefullib.h
	INCPATH = ../../inc/$(HEADER)
	LIBPATH = ../$(NAME) 
endif


all :
	gcc -c usefulfunc.c 
	ar -crs $(NAME) usefulfunc.o
	$(CP) $(NAME) $(LIBPATH)
	$(CP) $(HEADER) $(INCPATH)


re : clean all

clean : 
	$(RM) libuseful.a usefulfunc.o