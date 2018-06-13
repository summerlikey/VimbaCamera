PROJECT_NAME            = ByronTest

PROJECT_DIR             = ../..
EXAMPLES_DIR            = $(PROJECT_DIR)/..
VIMBASDK_DIR			= $(EXAMPLES_DIR)/../..
MAKE_INCLUDE_DIR        = $(CURDIR)/$(EXAMPLES_DIR)/Build/Make

include $(MAKE_INCLUDE_DIR)/Common.mk

CONFIG_DIR          = $(ARCH)_$(WORDSIZE)bit
BIN_FILE            = $(PROJECT_NAME)
BIN_DIR             = binary/$(CONFIG_DIR)
BIN_PATH            = $(BIN_DIR)/$(BIN_FILE)

all: $(BIN_PATH)

include $(MAKE_INCLUDE_DIR)/VimbaCPP.mk

SOURCE_DIR          = $(PROJECT_DIR)/Source
INCLUDE_DIRS        = -I$(SOURCE_DIR) \
                      -I$(EXAMPLES_DIR) \

LIBS                = $(VIMBACPP_LIBS)

DEFINES             =

CFLAGS              = $(COMMON_CFLAGS) \
                      $(VIMBACPP_CFLAGS)

OBJ_FILES           = $(OBJ_DIR)/$(PROJECT_NAME).o

DEPENDENCIES        = VimbaCPP

$(OBJ_DIR)/%.o: $(SOURCE_DIR)/%.cpp $(OBJ_DIR)
	$(CXX) -c $(INCLUDE_DIRS) $(DEFINES) $(CFLAGS) -o $@ $<

$(BIN_PATH): $(DEPENDENCIES) $(OBJ_FILES) $(BIN_DIR)
	$(CXX) $(ARCH_CFLAGS) -o $(BIN_PATH) $(OBJ_FILES) $(LIBS) -Wl,-rpath,'$$ORIGIN'

clean:
	$(RM) binary -r -f

$(BIN_DIR):
	$(MKDIR) -p $(BIN_DIR)