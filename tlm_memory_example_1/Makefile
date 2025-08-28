
# SystemC installation path (override when invoking make if needed)
SYSTEMC ?= /usr/local/systemc

# Compiler and flags
CXX      ?= g++
WARNINGS  = -Wall -Wextra -Wpedantic
OPT       ?= -O2
STD       ?= -std=c++17
CXXFLAGS += -I$(SYSTEMC)/include $(WARNINGS) -g $(OPT) $(STD)

# Try both common lib directories (harmless if one does not exist)
LDFLAGS  += -L$(SYSTEMC)/lib -L$(SYSTEMC)/lib-linux64 -lsystemc \
            -Wl,-rpath,$(SYSTEMC)/lib -Wl,-rpath,$(SYSTEMC)/lib-linux64

# Sources (all .cpp files in this directory)
SRCS := $(wildcard *.cpp)
OBJS := $(SRCS:.cpp=.o)
TARGET ?= sim

.PHONY: all run clean print

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET)

print:
	@echo "SYSTEMC=$(SYSTEMC)"
	@echo "SRCS=$(SRCS)"
	@echo "OBJS=$(OBJS)"
	@echo "CXXFLAGS=$(CXXFLAGS)"
	@echo "LDFLAGS=$(LDFLAGS)"

clean:
	rm -f $(OBJS) $(TARGET) memory.vcd
