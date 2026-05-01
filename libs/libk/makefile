LIBK_DIR   := libs/libk
LIBK_INC   := $(LIBK_DIR)/include
LIBK_BUILD := $(BUILD_DIR)/libk

LIBK_SRCS  := $(wildcard $(LIBK_DIR)/src/*.c)
LIBK_OBJS  := $(patsubst $(LIBK_DIR)/src/%.c,$(LIBK_BUILD)/%.o,$(LIBK_SRCS))
LIBK       := $(BUILD_DIR)/libk.a

$(LIBK_BUILD):
	mkdir -p $@

$(LIBK_BUILD)/%.o: $(LIBK_DIR)/src/%.c | $(LIBK_BUILD)
	$(CC32) -I$(LIBK_INC) -c $< -o $@

$(LIBK): $(LIBK_OBJS)
	ar rcs $@ $^
