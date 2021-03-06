# Project: CROPLinux
OBJ  = alignment.o Unique.o bayesianclustering.o CROP.o Main.o
LINKOBJ  = alignment.o Unique.o bayesianclustering.o CROP.o Main.o
LIBS =  -g3 -lgsl -lgslcblas -fopenmp -m64
BIN  = CROPLinux
CXXFLAGS = -g3 -fopenmp -m64
RM = rm -rf

.PHONY: all all-before all-after clean clean-custom

all: all-before CROPLinux all-after

clean: clean-custom
	${RM} $(OBJ) $(BIN) $(BIN).dSYM

$(BIN): $(OBJ)
	$(CXX) $(LINKOBJ) -o CROPLinux $(LIBS)

alignment.o: alignment.c alignment.h common.h
	$(CXX) -c alignment.c -o alignment.o $(CXXFLAGS)

Unique.o: Unique.cpp Unique.h common.h
	$(CXX) -c Unique.cpp -o Unique.o $(CXXFLAGS)

bayesianclustering.o: bayesianclustering.cpp bayesianclustering.h alignment.h common.h
	$(CXX) -c bayesianclustering.cpp -o bayesianclustering.o $(CXXFLAGS)

CROP.o: CROP.cpp CROP.h bayesianclustering.h common.h
	$(CXX) -c CROP.cpp -o CROP.o $(CXXFLAGS)

Main.o: Main.cpp CROP.h Unique.h
	$(CXX) -c Main.cpp -o Main.o $(CXXFLAGS)
