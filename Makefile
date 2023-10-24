# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gpernas- <gpernas-@student.42madrid.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/05 18:36:42 by gpernas-          #+#    #+#              #
#    Updated: 2021/11/21 02:42:27 by gpernas-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Project compilation files and directories
NAME            =	cub3D

C_CUB        =  	cub3D.c 		\
					parse_map.c		\
					parse_data.c	\
					parse_data2.c	\
					key_hook.c		\
					manage_window.c	\
					minimap.c		\
					create_rays.c	\
					walls.c			\
					ray_utils.c		\
					texture_utils.c	\

SRCSFD          =    src/
OBJSFD          =    objs/
HDR_INC         =    -I./includes
LIBFT_HDR 		= 	 -I./libft/includes/
LIB_BINARY 		= 	 -L./libft -lft
LIBFT 			= 	 libft/libft.a

MLX_DIR = minilibx-linux
MLX = libmlx.a 
# LINUXLIBS		= 	-I ./Includes -I ./libft/ -L. -lmlx_Linux -lm -lXext -lX11 -lbsd -L ./libft -lft

OBJS_CUB     =    $(addprefix $(OBJSFD), $(C_CUB:.c=.o))
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Compilation
CFLAGS			=    -Wall -Wextra -Werror #-fsanitize=address # FOR LEAKS
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Colors
RED             = \033[0;31m
GREEN           = \033[0;32m
NONE            = \033[0m
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

all: check_libft project $(NAME) 
	@echo "Project ready"

check_libft: $(LIBFT)

project:
	@echo "Checking project ..."
	@echo "\t[ $(GREEN)✔$(NONE) ] libft loaded"

projectb:
	@echo "Checking project bonus ..."

$(LIBFT):
	@make -C libft bonus

$(OBJSFD):
	@mkdir $@
	@echo "\t[ $(GREEN)✔$(NONE) ] $@ directory"

$(NAME): $(OBJSFD) $(OBJS_CUB)
	@gcc $(CFLAGS) $(OBJS_CUB) -lmlx -framework OpenGL -framework AppKit libft/libft.a -o $@
	@echo "\t[ $(GREEN)✔$(NONE) ] cub3D executable"

$(OBJSFD)%.o: $(SRCSFD)%.c
	@gcc $(CFLAGS) $(HDR_INC) -c $< -o $@
	@echo "\t[ $(GREEN)✔$(NONE) ] $@ object"

bonus: projectb $(NAME)
	@echo "... bonus project ready"

clean:
	@/bin/rm -rf $(OBJSFD)
	@echo "\t[ $(RED)✗$(NONE) ] objects directory"
	@make -C ./libft fclean
	@echo "\t[ $(RED)✗$(NONE) ] libft objects"

fclean: clean
	@/bin/rm -f cub3D
	@echo "\t[ $(RED)✗$(NONE) ] cub3D executable"
	@make -C ./libft fclean

re: fclean all

.PHONY: project all clean fclean re