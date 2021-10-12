#simple make call functions in this makefile from your own makefile

ifdef OS
	CP = copy
	NAME= .\libuseful.a
	HEADER = \usefullib.h
	APATH = ..\..\inc
	RM = erase 
else
	CP = cp
	NAME= .\libuseful.a
	HEADER = /usefullib.h
	APATH = ../../inc
endif


all :
	gcc -c usefulfunc.c 
	ar -crs $(NAME) usefulfunc.o
	$(CP) $(NAME) .$(NAME)
	$(CP) .$(HEADER) $(APATH)$(HEADER)


re : clean all

clean : 
	$(RM) libuseful.a usefulfunc.o