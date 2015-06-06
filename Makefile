#*********************************************************************************************************
# chocolate-doom Makefile
# target -> chocolate-doom
#*********************************************************************************************************

#*********************************************************************************************************
# include config.mk
#*********************************************************************************************************
CONFIG_MK_EXIST = $(shell if [ -f ../config.mk ]; then echo exist; else echo notexist; fi;)
ifeq ($(CONFIG_MK_EXIST), exist)
include ../config.mk
else
CONFIG_MK_EXIST = $(shell if [ -f config.mk ]; then echo exist; else echo notexist; fi;)
ifeq ($(CONFIG_MK_EXIST), exist)
include config.mk
else
CONFIG_MK_EXIST =
endif
endif

#*********************************************************************************************************
# check configure
#*********************************************************************************************************
check_defined = \
    $(foreach 1,$1,$(__check_defined))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $(value 2), ($(strip $2)))))

$(call check_defined, CONFIG_MK_EXIST, Please configure this project in RealCoder or \
create a config.mk file!)
$(call check_defined, SYLIXOS_BASE_PATH, SylixOS base project path)
$(call check_defined, TOOLCHAIN_PREFIX, the prefix name of toolchain)
$(call check_defined, DEBUG_LEVEL, debug level(debug or release))

#*********************************************************************************************************
# configure area you can set the following config to you own system
# FPUFLAGS (-mfloat-abi=softfp -mfpu=vfpv3 ...)
# CPUFLAGS (-mcpu=arm920t ...)
# NOTICE: libsylixos, BSP and other kernel modules projects CAN NOT use vfp!
#*********************************************************************************************************
FPUFLAGS = 
CPUFLAGS = -mcpu=arm920t $(FPUFLAGS)

#*********************************************************************************************************
# toolchain select
#*********************************************************************************************************
CC  = $(TOOLCHAIN_PREFIX)gcc
CXX = $(TOOLCHAIN_PREFIX)g++
AS  = $(TOOLCHAIN_PREFIX)gcc
AR  = $(TOOLCHAIN_PREFIX)ar
LD  = $(TOOLCHAIN_PREFIX)g++

#*********************************************************************************************************
# do not change the following code
# buildin internal application source
#*********************************************************************************************************
#*********************************************************************************************************
# src(s) file
#*********************************************************************************************************
SRCS = \
chocolate-doom/opl/dbopl.c \
chocolate-doom/opl/ioperm_sys.c \
chocolate-doom/opl/opl.c \
chocolate-doom/opl/opl_queue.c \
chocolate-doom/opl/opl_sdl.c \
chocolate-doom/opl/opl_timer.c \
chocolate-doom/pcsound/pcsound.c \
chocolate-doom/pcsound/pcsound_sdl.c \
chocolate-doom/src/aes_prng.c \
chocolate-doom/src/deh_io.c \
chocolate-doom/src/deh_main.c \
chocolate-doom/src/deh_mapping.c \
chocolate-doom/src/deh_str.c \
chocolate-doom/src/deh_text.c \
chocolate-doom/src/d_event.c \
chocolate-doom/src/d_iwad.c \
chocolate-doom/src/d_loop.c \
chocolate-doom/src/d_mode.c \
chocolate-doom/src/gusconf.c \
chocolate-doom/src/icon.c \
chocolate-doom/src/i_cdmus.c \
chocolate-doom/src/i_endoom.c \
chocolate-doom/src/i_joystick.c \
chocolate-doom/src/i_main.c \
chocolate-doom/src/i_oplmusic.c \
chocolate-doom/src/i_pcsound.c \
chocolate-doom/src/i_scale.c \
chocolate-doom/src/i_sdlmusic.c \
chocolate-doom/src/i_sdlsound.c \
chocolate-doom/src/i_sound.c \
chocolate-doom/src/i_system.c \
chocolate-doom/src/i_timer.c \
chocolate-doom/src/i_sylixos.c \
chocolate-doom/src/i_videohr.c \
chocolate-doom/src/memio.c \
chocolate-doom/src/midifile.c \
chocolate-doom/src/mus2mid.c \
chocolate-doom/src/m_argv.c \
chocolate-doom/src/m_bbox.c \
chocolate-doom/src/m_cheat.c \
chocolate-doom/src/m_config.c \
chocolate-doom/src/m_controls.c \
chocolate-doom/src/m_fixed.c \
chocolate-doom/src/m_misc.c \
chocolate-doom/src/net_client.c \
chocolate-doom/src/net_common.c \
chocolate-doom/src/net_dedicated.c \
chocolate-doom/src/net_gui.c \
chocolate-doom/src/net_io.c \
chocolate-doom/src/net_loop.c \
chocolate-doom/src/net_packet.c \
chocolate-doom/src/net_query.c \
chocolate-doom/src/net_sdl.c \
chocolate-doom/src/net_server.c \
chocolate-doom/src/net_structrw.c \
chocolate-doom/src/sha1.c \
chocolate-doom/src/tables.c \
chocolate-doom/src/v_video.c \
chocolate-doom/src/w_checksum.c \
chocolate-doom/src/w_file.c \
chocolate-doom/src/w_file_posix.c \
chocolate-doom/src/w_file_stdc.c \
chocolate-doom/src/w_main.c \
chocolate-doom/src/w_merge.c \
chocolate-doom/src/w_wad.c \
chocolate-doom/src/z_native.c \
chocolate-doom/src/doom/am_map.c \
chocolate-doom/src/doom/deh_ammo.c \
chocolate-doom/src/doom/deh_bexstr.c \
chocolate-doom/src/doom/deh_cheat.c \
chocolate-doom/src/doom/deh_doom.c \
chocolate-doom/src/doom/deh_frame.c \
chocolate-doom/src/doom/deh_misc.c \
chocolate-doom/src/doom/deh_ptr.c \
chocolate-doom/src/doom/deh_sound.c \
chocolate-doom/src/doom/deh_thing.c \
chocolate-doom/src/doom/deh_weapon.c \
chocolate-doom/src/doom/doomdef.c \
chocolate-doom/src/doom/doomstat.c \
chocolate-doom/src/doom/dstrings.c \
chocolate-doom/src/doom/d_items.c \
chocolate-doom/src/doom/d_main.c \
chocolate-doom/src/doom/d_net.c \
chocolate-doom/src/doom/f_finale.c \
chocolate-doom/src/doom/f_wipe.c \
chocolate-doom/src/doom/g_game.c \
chocolate-doom/src/doom/hu_lib.c \
chocolate-doom/src/doom/hu_stuff.c \
chocolate-doom/src/doom/info.c \
chocolate-doom/src/doom/m_menu.c \
chocolate-doom/src/doom/m_random.c \
chocolate-doom/src/doom/p_ceilng.c \
chocolate-doom/src/doom/p_doors.c \
chocolate-doom/src/doom/p_enemy.c \
chocolate-doom/src/doom/p_floor.c \
chocolate-doom/src/doom/p_inter.c \
chocolate-doom/src/doom/p_lights.c \
chocolate-doom/src/doom/p_map.c \
chocolate-doom/src/doom/p_maputl.c \
chocolate-doom/src/doom/p_mobj.c \
chocolate-doom/src/doom/p_plats.c \
chocolate-doom/src/doom/p_pspr.c \
chocolate-doom/src/doom/p_saveg.c \
chocolate-doom/src/doom/p_setup.c \
chocolate-doom/src/doom/p_sight.c \
chocolate-doom/src/doom/p_spec.c \
chocolate-doom/src/doom/p_switch.c \
chocolate-doom/src/doom/p_telept.c \
chocolate-doom/src/doom/p_tick.c \
chocolate-doom/src/doom/p_user.c \
chocolate-doom/src/doom/r_bsp.c \
chocolate-doom/src/doom/r_data.c \
chocolate-doom/src/doom/r_draw.c \
chocolate-doom/src/doom/r_main.c \
chocolate-doom/src/doom/r_plane.c \
chocolate-doom/src/doom/r_segs.c \
chocolate-doom/src/doom/r_sky.c \
chocolate-doom/src/doom/r_things.c \
chocolate-doom/src/doom/sounds.c \
chocolate-doom/src/doom/statdump.c \
chocolate-doom/src/doom/st_lib.c \
chocolate-doom/src/doom/st_stuff.c \
chocolate-doom/src/doom/s_sound.c \
chocolate-doom/src/doom/wi_stuff.c \
chocolate-doom/textscreen/txt_button.c \
chocolate-doom/textscreen/txt_checkbox.c \
chocolate-doom/textscreen/txt_desktop.c \
chocolate-doom/textscreen/txt_dropdown.c \
chocolate-doom/textscreen/txt_fileselect.c \
chocolate-doom/textscreen/txt_gui.c \
chocolate-doom/textscreen/txt_inputbox.c \
chocolate-doom/textscreen/txt_io.c \
chocolate-doom/textscreen/txt_label.c \
chocolate-doom/textscreen/txt_radiobutton.c \
chocolate-doom/textscreen/txt_scrollpane.c \
chocolate-doom/textscreen/txt_sdl.c \
chocolate-doom/textscreen/txt_separator.c \
chocolate-doom/textscreen/txt_spinctrl.c \
chocolate-doom/textscreen/txt_strut.c \
chocolate-doom/textscreen/txt_table.c \
chocolate-doom/textscreen/txt_utf8.c \
chocolate-doom/textscreen/txt_widget.c \
chocolate-doom/textscreen/txt_window.c \
chocolate-doom/textscreen/txt_window_action.c

#*********************************************************************************************************
# build path
#*********************************************************************************************************
ifeq ($(DEBUG_LEVEL), debug)
OUTDIR = Debug
else
OUTDIR = Release
endif

OUTPATH = ./$(OUTDIR)
OBJPATH = $(OUTPATH)/obj
DEPPATH = $(OUTPATH)/dep

#*********************************************************************************************************
# target
#*********************************************************************************************************
EXE = $(OUTPATH)/chocolate-doom

#*********************************************************************************************************
# chocolate-doom objects
#*********************************************************************************************************
OBJS = $(addprefix $(OBJPATH)/, $(addsuffix .o, $(basename $(SRCS))))
DEPS = $(addprefix $(DEPPATH)/, $(addsuffix .d, $(basename $(SRCS))))

#*********************************************************************************************************
# include path
#*********************************************************************************************************
INCDIR  = -I"$(SYLIXOS_BASE_PATH)/libsylixos/SylixOS"
INCDIR += -I"$(SYLIXOS_BASE_PATH)/libsylixos/SylixOS/include"
INCDIR += -I"$(SYLIXOS_BASE_PATH)/libsylixos/SylixOS/include/inet"
INCDIR += -I"./"
INCDIR += -I"./chocolate-doom"
INCDIR += -I"./chocolate-doom/src/doom"
INCDIR += -I"./chocolate-doom/src"
INCDIR += -I"./chocolate-doom/opl"
INCDIR += -I"./chocolate-doom/pcsound"
INCDIR += -I"./chocolate-doom/textscreen"
INCDIR += -I"../libsdl/SDL/include"
INCDIR += -I"../libsdl/SDL_net"
INCDIR += -I"../libsdl/SDL_mixer"

#*********************************************************************************************************
# compiler preprocess
#*********************************************************************************************************
DSYMBOL  = -DSYLIXOS

#*********************************************************************************************************
# depend dynamic library
#*********************************************************************************************************
DEPEND_DLL = -lSDL -lvpmpdm

#*********************************************************************************************************
# depend dynamic library search path
#*********************************************************************************************************
DEPEND_DLL_PATH = -L"$(SYLIXOS_BASE_PATH)/libsylixos/$(OUTDIR)"
DEPEND_DLL_PATH += -L"../libsdl/Debug"

#*********************************************************************************************************
# compiler optimize
#*********************************************************************************************************
ifeq ($(DEBUG_LEVEL), debug)
OPTIMIZE = -O0 -g3 -gdwarf-2
else
OPTIMIZE = -O2 -g1 -gdwarf-2											# Do NOT use -O3 and -Os
endif										    						# -Os is not align for function
																		# loop and jump.
#*********************************************************************************************************
# depends and compiler parameter (cplusplus in kernel MUST NOT use exceptions and rtti)
#*********************************************************************************************************
DEPENDFLAG  = -MM
CXX_EXCEPT  = -fno-exceptions -fno-rtti
COMMONFLAGS = $(CPUFLAGS) $(OPTIMIZE) -Wall -fmessage-length=0 -fsigned-char -fno-short-enums
ASFLAGS     = -x assembler-with-cpp $(DSYMBOL) $(INCDIR) $(COMMONFLAGS) -c
CFLAGS      = $(DSYMBOL) $(INCDIR) $(COMMONFLAGS) -fPIC -c
CXXFLAGS    = $(DSYMBOL) $(INCDIR) $(CXX_EXCEPT) $(COMMONFLAGS) -fPIC -c
ARFLAGS     = -r

#*********************************************************************************************************
# define some useful variable
#*********************************************************************************************************
DEPEND          = $(CC)  $(DEPENDFLAG) $(CFLAGS)
DEPEND.d        = $(subst -g ,,$(DEPEND))
COMPILE.S       = $(AS)  $(ASFLAGS)
COMPILE_VFP.S   = $(AS)  $(ASFLAGS)
COMPILE.c       = $(CC)  $(CFLAGS)
COMPILE.cxx     = $(CXX) $(CXXFLAGS)

#*********************************************************************************************************
# target
#*********************************************************************************************************
all: $(EXE)
		@echo create "$(EXE)" success.

#*********************************************************************************************************
# include depends
#*********************************************************************************************************
ifneq ($(MAKECMDGOALS), clean)
ifneq ($(MAKECMDGOALS), clean_project)
sinclude $(DEPS)
endif
endif

#*********************************************************************************************************
# create depends files
#*********************************************************************************************************
$(DEPPATH)/%.d: %.c
		@echo creating $@
		@if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi
		@rm -f $@; \
		echo -n '$@ $(addprefix $(OBJPATH)/, $(dir $<))' > $@; \
		$(DEPEND.d) $< >> $@ || rm -f $@; exit;

$(DEPPATH)/%.d: %.cpp
		@echo creating $@
		@if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi
		@rm -f $@; \
		echo -n '$@ $(addprefix $(OBJPATH)/, $(dir $<))' > $@; \
		$(DEPEND.d) $< >> $@ || rm -f $@; exit;

#*********************************************************************************************************
# compile source files
#*********************************************************************************************************
$(OBJPATH)/%.o: %.S
		@if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi
		$(COMPILE.S) $< -o $@

$(OBJPATH)/%.o: %.c
		@if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi
		$(COMPILE.c) $< -o $@

$(OBJPATH)/%.o: %.cpp
		@if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi
		$(COMPILE.cxx) $< -o $@

#*********************************************************************************************************
# link chocolate-doom object files
#*********************************************************************************************************
$(EXE): $(OBJS)
		$(LD) $(CPUFLAGS) -nostdlib -fPIC -shared -o $(EXE) $(OBJS) \
		$(DEPEND_DLL_PATH) $(DEPEND_DLL) -lm -lgcc

#*********************************************************************************************************
# clean
#*********************************************************************************************************
.PHONY: clean
.PHONY: clean_project

#*********************************************************************************************************
# clean objects
#*********************************************************************************************************
clean:
		-rm -rf $(EXE)
		-rm -rf $(OBJPATH)
		-rm -rf $(DEPPATH)

#*********************************************************************************************************
# clean project
#*********************************************************************************************************
clean_project:
		-rm -rf $(OUTPATH)

#*********************************************************************************************************
# END
#*********************************************************************************************************
