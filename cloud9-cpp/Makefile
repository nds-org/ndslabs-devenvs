CC      = gcc
CPPC    = g++
CFLAGS  =  -g
RM      = rm -rf
OUTPUT  = bin


default: all

all: hello-c hello-cpp

hello-c: hello.c 
	mkdir -p $(OUTPUT)
	$(CC) $(CFLAGS) -o $(OUTPUT)/hello hello.c
	
hello-cpp: hello.cpp
	mkdir -p $(OUTPUT)
	$(CPPC) $(CFLAGS) -o $(OUTPUT)/hello2 hello.cpp

clean veryclean:
	$(RM) $(OUTPUT)