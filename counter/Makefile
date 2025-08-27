
# SystemC installation path (update if needed)
SYSTEMC ?= /usr/local/systemc

# Compiler and flags
CXX = g++
CXXFLAGS = -I$(SYSTEMC)/include -Wall -g
LDFLAGS = -L$(SYSTEMC)/lib -lsystemc

# Source and target
SRCS = design.cpp testbench.cpp
OBJS = $(SRCS:.cpp=.o)
TARGET = counter_sim

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET) counter.vcd
