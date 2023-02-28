NAME 		= famine
NASM 		= nasm

SRCS 		= elf.c \
	elf_read.c \
	elf_write.c \
	elf_modify.c \
	elf_save.c \
	tools.c \
	woody_mod.c \
	famine.c \
	g_syscall \
	g_unpacker

OBJS		= $(SRCS:.c=.o)
LIBFT		= ./libft/libft.a
LIBFT_SOURCES := $(shell find libft -name "*.c")
LIBFT_OBJECTS := $(LIBFT_SOURCES:.c=.o)
# CFLAGS		= -Wall -Werror -Wextra -I$(dir $(LIBFT)) -MMD
CFLAGS		= -Werror -I$(dir $(LIBFT)) -MMD
CC			= gcc

all:		$(NAME)

$(NAME):	$(OBJS) $(LIBFT)
			nasm -f bin syscall.s -o g_syscall
			xxd -i -c8 g_syscall g_syscall.c
			nasm -f bin unpacker.s -o g_unpacker
			xxd -i -c8 g_unpacker g_unpacker.c
			gcc  -o $(NAME) -L$(dir $(LIBFT)) -lft $(OBJS) $(LIBFT_OBJECTS)
			@echo ""
			@echo "▂▃▅▇█▓▒░ DONE ░▒▓█▇▅▃▂"
			@echo ""

$(NASM):
			nasm -f bin syscall.s -o g_syscall
			xxd -i -c8 g_syscall g_syscall.c
			nasm -f bin unpacker.s -o g_unpacker
			xxd -i -c8 g_unpacker g_unpacker.c

$(LIBFT):	FORCE
			make bonus -C $(dir $(LIBFT))

FORCE:

-include	$(SRCS:.c=.d)

clean:
			make clean -C $(dir $(LIBFT))
			$(RM) $(OBJS) $(SRCS:.c=.d)

fclean:		clean
			$(RM) $(LIBFT)
			$(RM) $(NAME)

re:			fclean all

run:		$(NAME)
			./$(NAME)

.PHONY: 	all clean fclean re run norm


# nasm -f bin inject.s -o g_decryptor