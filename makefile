#makefile for PARSEK PROJECT
  CPP=    mpicxx
# OPTFLAGS= -Wl,-z,muldefs
# OPTFLAGS=  -Wl,--start-group  -lhdf5 -lhdf5_hl -lm -lz -Wl,--end-group
  OPTFLAGS= -DMPICH_IGNORE_CXX_SEEK -O2

# include files
 INC_KVF = -I${PWD}/ConfigFile/src
#INC_KVF = -I${PWD}/kvf/src

# INC_HDF5 = -I/opt/cray/hdf5/1.6.7/hdf5-gnu/include
# INC_MPI = 
 INC_HDF5 = -I/Users/adivin/distribs_other_stuff/hdf5-1.8.12/hdf5/include
#INC_MPI =  -I/opt/local/include/mpich2
#INC_MPI = -I/usr/lib/mpich-gcc/include -I/apps/prod/mpich/pgi/include

# libs
#LIB_KVF = -L${PWD}/kvf/src
 LIB_KVF = -L${PWD}/ConfigFile/src
#LIB_HDF5 = -L/opt/cray/hdf5/1.6.7/hdf5-gnu/lib 
LIB_HDF5 = -L/Users/adivin/distribs_other_stuff/hdf5-1.8.12/hdf5/lib

#HDF5LIBS = -lhdf5 -lhdf5_hl 
HDF5LIBS = -lhdf5 -lhdf5_hl -lz
#KVFLIB = -lkvf 
#MPELIB = -lmpe

ipic3D: iPIC3D.cpp iPIC3D.o Particles3Dcomm.o Particles3D.o ConfigFile.o
	${CPP} ${OPTFLAGS} -o  iPIC3D ${INC_HDF5} ${INC_MPI} ${INC_KVF}\
	iPIC3D.cpp iPIC3D.o Particles3Dcomm.o Particles3D.o ConfigFile.o\
	 ${LIB_KVF} ${LIB_HDF5} ${LIB_MPI} ${HDF5LIBS}

#${LIB_KVF} ${LIB_HDF5} ${LIB_KVF} ${LIB_MPI} \
#${HDF5LIBS}	${KVFLIB}	${MPELIB}
# BCStructure.o: ./fields/BCStructure.cpp
#	${CPP}  ${OPTFLAGS} -c ./fields/BCStructure.cpp

iPIC3D.o:	iPIC3D.cpp
	${CPP} ${OPTFLAGS} ${INC_HDF5} ${INC_MPI} ${INC_KVF} -c iPIC3D.cpp 

Particles3Dcomm.o:	./particles/Particles3Dcomm.cpp
	${CPP}	${OPTFLAGS}	${INC_HDF5} ${INC_KVF} ${LIB_KVF}  -c ./particles/Particles3Dcomm.cpp

Particles3D.o:	./particles/Particles3D.cpp 
	${CPP}	${OPTFLAGS} ${INC_HDF5} ${INC_KVF} ${LIB_KVF}  -c ./particles/Particles3D.cpp

ConfigFile.o: ./ConfigFile/src/ConfigFile.cpp
	${CPP}  ${OPTFLAGS} -c ./ConfigFile/src/ConfigFile.cpp



clean:
	rm -rf *.o iPIC3D 
