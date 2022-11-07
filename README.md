# Makefile Tutorial - 42
a step-by-step guide for Makefiles

--- 

### What the hell is a Makefile?
The Makefile is a tool to help you compile bigger and complicated projects. 
With just one `make` and an underlying script you have written you can compile
your code.

The Makefile is Mandatory in (almost) every core-project of the 42 curriculum.
So knowing your way around it will help you a lot. This guide is not complete. It covers the basics of how I use the tool,
if you want to learn more about it, [here is the official documentation](https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents).
There may be mistakes, so if you spot one, feel free to create a pull request/issue and provide a solution and of course I'm open to additions and new sections.
___
### Da rulez
All your commands and scripts will be executed by calling a Makefile rule, if the rulename is not specified it will run
the first rule it encounters.
below the declaration you can write whatever shell command you what to be executed
here an example:
```makefile
all:                         #the rule-name
    echo "Hello world!"      #your shell command
```
as you may noticed, the command has an indent. Thats because you have to know where the rule
stops and instead of brackets you are using the indent

Now, in this example there is no compiling so lets check out an easy example:
```makefile
NAME = executable.out              #useful variables
SRC  = main.c second.c file.c

all: $(SRC)                        #the rule-name, dependency
    gcc $(SRC) -o $(NAME)          #your shell command
```
Dependecies are useful when you want to (re)compile your code only under certain conditions,
in this case only when a file in the variable `SRC` has been modified since the last compile.
Dependencies will be revisited later in this guide.

the command will expand to: `gcc main.c second.c file.c -o executable.out`\
as you can see variables able to hold lists of words, numbers etc.
Variables are there for you to be lazy, so use them!

Some more examples of variable stuff:
```makefile
SRC    = main.c          #holds { main.c }
SRC   += second.c        #holds { main.c second.c }
SRC   := different.c     #holds { different.c }
NAME  ?= isempty         #holds { isempty } but only if it was nothing in there to begin with
SECOND = $(SRC) file.c   #holds { $(SRC) file.c } this variable is dynamic, if you change SRC, SECOND will change as well
```
[More about rules.](https://www.gnu.org/software/make/manual/html_node/Rules.html#Rules)

[More about variables.](https://www.gnu.org/software/make/manual/html_node/Using-Variables.html#Using-Variables)
### Compiling and linking

When converting code to a program you call the compiler (on campus we use `clang`) which checks the logic for compile-time errors
and then optimizes your code, breaks it down to machine code, throws some metadata into the mix and then gives it  to the linker.
(of course its more complicated than that: [here is the wikipedia article](https://en.wikipedia.org/wiki/Compiler))

The linker then takes all the different [object files](https://en.wikipedia.org/wiki/Object_file) and creates an executable. [And of course there is more to that as well](https://en.wikipedia.org/wiki/Linker_(computing))

### how to use object files?
Using object files in your compiling process is not only useful, but also good practice as it saves you a lot of time
when building a bigger project.

you can create object files by using the `-c` flag when compiling. So it makes sense to create one object file for each source file,
so that whenever you edit a source file only the edited file will be recompiled, while the other object files are just being reused.

to accomplish that you need a rule that takes each file alone and compiles it individually to an object file, and that the 
part where the _magic_ begins...
### the Makefile magic
to understand how magic variables work you need to understand how dependencies work. Whenever you add a dependency the program
will look if the file or rule exists or has changed. It then tries to use a rule named like the file.
here is a simple example:
```makefile
DIR = new_directory/

all: $(DIR)
    touch $(DIR)new_file
$(DIR):
    mkdir $(DIR)
```
The script will look if the directory exists. it then tries to find a rule for it (if its not there it will throw an error).
it executes the prerequisite rule first and the proceeds to its own execution. If you have a file named like a rule, but it
has nothing to do with the file you can list it as under `.PHONY: all rule names`.

Now, we could use that for our source files, right?:
```makefile
NAME = executable
SRC  = main.c second.c file.c
OBJ  = main.o second.o file.o

all: $(OBJ)
    gcc $(OBJ) -o $(NAME)
$(OBJ): $(SRC)
    gcc -c $(SRC) -o $(OBJ)
```
Well, this won't work. As you may remember it just expands, but won't pass it individually. So we need a new player in the game:
```makefile
NAME = executable
SRC  = main.c second.c file.c
OBJ  = main.o second.o file.o

all: $(OBJ)
    gcc $(OBJ) -o $(NAME)
%.o: %.c
    gcc -c $< -o $@
```
so what happens there?

the `%` in `%.c`/`%.o` is a pattern variable, so for every word that ends with .o should call this rule.
in this case it expands it to:
`main.o: main.c` `second.o: second.c` `file.o: file.c`
now there is also `$<` and `$@`. these variables are called [automatic variables](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables):
```makefile
$@      #target (rulename)
$(@D)   #target's directory
$<      #first prerequisite
$^      #all prerequisites
```
so in conclusion the rule fully expanded looks something like this:

```makefile
main.o: 42/main.c
    gcc -c main.c -o main.o
```

### Libraries
a library is just a bunch of precompiled code, ready to be linked. all you need is a header which holds the function declaration.
They either consist of object files zipped together in an archive file format recognizable by the .a filetype or are dynamic, which will then be linked at runtime.
you can include them at the linking stage by simply giving the compiler the library name and its location.
take your .o files and zip them with the `ar -crs liblibrary_name.a $(OBJ)` command. Now you can link them like this:
```makefile
gcc -L lib_directory -l library_name -o $(NAME)
```

Important when naming the library is, that you always have a "lib" in front of the name, because the compiler will look for 
a file with the pattern `lib{name}.a`. the `-L` is for specifying the directory, with either a relative or absolute path.

### Functions
```makefile
SRC  = main.c second.c file.c
OBJ  = main.o second.o file.o
```
it's annoying to retype everything, right? Well, I can help you with that!
There are many ways to do that:
```makefile
SRC  = main.c second.c file.c
OBJ  = $(patsubst %.c,%.o,$(SRC))
OBJ  = $($(SRC):.c=.o)
...
```
`$(function_name first_argument, second_argument, ...)`
there are also some other useful functions more on them [here](https://www.gnu.org/software/make/manual/html_node/Functions.html#Functions).
### Conclusion
So lets put all of that together:
```makefile
NAME    = executable
SRC     = main.c second.c file.c
OBJ     = $($(SRC):.c=.o)
CC      = clang
CFLAGS  = -Wall -Wextra -Werror
LDFLAGS = -L lib -l ft

all: $(NAME)

$(NAME): $(OBJ)
    $(CC) $(OBJ) $(LDFLAGS) -o $(NAME)

%.o: %.c
    $(CC) -c $(CFLAGS) $< -o $@

clean:
    rm -f $(NAME)
    rm -f $(OBJ)
.PHONY: all clean
```
---
### nice to know

- putting an `@` in front of the command tells make to not print it to the terminal
- putting an `-` in front of the command tells make to ignore errors omitted from that line
- you can multithread your compilation by adding `--jobs={number}` (something like a 9) as a parameter, speeds things up by a lot!
- if you use subdirectories for your sourcefiles you can use the `VPATH` variable. just set every foldername that contains sourcefiles in the variable and make will automatically search these directories for sourcefiles.
