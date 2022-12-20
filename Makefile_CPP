#update on every project

CFILES=
BIN=

#update to match c or cpp

CC=c++
CEXT=.cpp
HEXT=.hpp
CPPFLAGS=-std=c++98

#update if needed

CFLAGS=-Wall -Wextra -Werror -MD -I $(INCLDIR)
SRCDIR=src
SUBDIR=.

#shouldn't need to update

RM=rm -rf
MD=mkdir -p
OBJDIR=.obj
INCLDIR=incl

OBJ_FILES=$(addprefix $(OBJDIR)/,$(addsuffix .o,$(CFILES)))
DEP_FILES=$(addprefix $(OBJDIR)/,$(addsuffix .d,$(CFILES)))
SUB_DIR=$(addprefix $(OBJDIR)/,$(SUBDIR))

all: $(BIN)

re: fclean all

fclean: clean
	$(RM) $(BIN)

clean:
	$(RM) $(OBJDIR)

$(BIN): $(OBJ_FILES)
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $^

$(OBJDIR)/%.o: $(SRCDIR)/%$(CEXT) Makefile | $(SUB_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<

$(SUB_DIR):
	$(MD) $@

.PHONY: all clean fclean re

-include $(DEP_FILES)
