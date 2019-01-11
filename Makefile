F90 = g95 
OPT = -fbounds-check  -ftrace=full -Wall -g
#OPT = -O3
OBJ = data_calculation.o entrance_condition.o initial_condition.o \
      VTSWriter2D.o timestep.o discretisation_finite_volume.o reading_data.o \
      mod_vol.o main.o mesh_creation.o mod_mesh.o

%.o:%.f90
	$(F90) $(OPT) -c $<
finite_vol:	$(OBJ)
	$(F90) $(OPT) $(OBJ) -o finite_vol




mesh_creation.o: mod_mesh.o

main.o:	mod_vol.o

discretisation_finite_volume.o:	mod_vol.o

initial_condition.o: mod_vol.o

entrance_condition.o: mod_vol.o

timestep.o: mod_vol.o

reading_data.o: mod_vol.o

data_calculation.o: mod_vol.o








clean:
	/bin/rm -f $(OBJ) *.mod  vol_finis
solclean: 
	/bin/rm -f sol.pvd sol_*


