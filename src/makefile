#

CFLAGS = -std=c++11 -g -Wall

FILES = atpg.o tpgmain.o input.o level.o sim.o podem.o test.o init_flist.o faultsim.o display.o

atpg : $(FILES) 
	g++ $(CFLAGS) $(FILES) -lm -o atpg

atpg.o : atpg.h atpg.cpp
	g++ $(CFLAGS) -c atpg.cpp
tpgmain.o : atpg.h tpgmain.cpp
	g++ $(CFLAGS) -c tpgmain.cpp
input.o : atpg.h input.cpp
	g++ $(CFLAGS) -c input.cpp
level.o : atpg.h level.cpp
	g++ $(CFLAGS) -c level.cpp
sim.o : atpg.h logic_tbl.h sim.cpp
	g++ $(CFLAGS) -c sim.cpp
podem.o : atpg.h podem.cpp
	g++ $(CFLAGS) -c podem.cpp
init_flist.o : atpg.h init_flist.cpp
	g++ $(CFLAGS) -c init_flist.cpp
faultsim.o : atpg.h faultsim.cpp
	g++ $(CFLAGS) -c faultsim.cpp
test.o : atpg.h test.cpp
	g++ $(CFLAGS) -c test.cpp
display.o : atpg.h display.cpp
	g++ $(CFLAGS) -c display.cpp
clean:
	rm *.o
direct:
	g++ $(CFLAGS)$(FILES:.o=.cpp) -o atpg
