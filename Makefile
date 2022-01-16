# macOS imgui setup with sdl2 (statically linked)


# You will need SDL2 (http://www.libsdl.org):
#   brew install sdl2
#

#CXX = g++
#CXX = clang++

EXE = app
SOURCES = main.mm
SOURCES += imgui.cpp imgui_demo.cpp imgui_draw.cpp imgui_tables.cpp imgui_widgets.cpp
SOURCES += imgui_impl_sdl.cpp imgui_impl_metal.mm
OBJS = $(addsuffix .o, $(basename $(notdir $(SOURCES))))
SDL2 = lib/libSDL2.a


LIBS = -framework Metal \
	   -framework MetalKit \
	   -framework Cocoa \
	   -framework IOKit \
	   -framework CoreVideo \
	   -framework QuartzCore \
	   -framework CoreAudio \
	   -framework AudioToolbox \
	   -framework CoreHaptics \
	   -framework ForceFeedback \
	   -framework GameController \
	   -framework Carbon \
	   -framework Appkit \
	   -framework CoreFoundation \
	   -framework Foundation \
	   -framework CoreGraphics \
	   -framework CoreServices

LIBS += -liconv
LIBS += -L/usr/local/lib

CXXFLAGS = -I./include -I/usr/local/include
CXXFLAGS += `sdl2-config --cflags`
CXXFLAGS += -Wall -Wformat
CFLAGS = $(CXXFLAGS)

%.o:%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.o:%.mm
	$(CXX) $(CXXFLAGS) -ObjC++ -fobjc-weak -fobjc-arc -c -o $@ $<

all: $(EXE)
	@echo Build complete

$(EXE): $(OBJS) $(SDL2)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(LIBS)

clean:
	rm -f $(EXE) $(OBJS)
