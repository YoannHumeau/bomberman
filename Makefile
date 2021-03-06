CC      = gcc
SDL_FLAGS = -I/usr/include/SDL2 -D_REENTRANT
CFLAGS  = -I. -Wall -Wextra -g $(SDL_FLAGS)
LDFLAGS = -lpthread

ifeq ($(shell uname), Linux)
	LDFLAGS  += -L/usr/lib/x86_64-linux-gnu -lSDL2 -lSDL2_image -lSDL2_ttf
endif

ifeq ($(shell uname), Darwin)
	LDFLAGS += -lSDL2 -lSDL2_image -lSDL2_ttf
endif


RM		= rm -f
TARGET	= bomberman

SRC		=	$(wildcard src/*.c)

OBJ		= $(SRC:.c=.o)

.PHONY: all $(TARGET) clean fclean re

all : $(TARGET)

$(TARGET): $(OBJ) 
	@echo "LD	$@"
	@$(CC) $(OBJ) -o $@ $(LDFLAGS) 

src/%.o : src/%.c
	@echo "CC	$<"
	@$(CC) $(CFLAGS) -c $< -o $@

coffee: all clean

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(TARGET)

re : fclean all
