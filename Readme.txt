 
HOW TO USE THE PROGRAM ''FINITE VOLUME SCALAR TRANSPORTATION''??

1. Input numerical values in the file physical_data.txt

80            ! n  number of mesh cells in y
70            ! m  number of mesh cells in x
5             ! Length L1 of the domain
2             ! Height L2 (Left side of the domain)
2             ! Height L3 (Right side of the domain)
0.01          ! Diffusion coefficient
0             ! Velocity U (x direction)
0             ! Velocity V (y direction
5             ! Final time
0.9           ! CFL number
0.4           ! Fourier number

Modifying and tuning these values in order to have an orthogonal mesh or not, diffusion and/or advection...

2. Use the makefile to compile all the files and create the executable (run the command 'make' while being in the main directory of the program).

3. Launch the executable, which will create the mesh and run the discretised calculation on the latter.

4. Observe the concentration field on the domain thanks to Paraview (open sol.pvd).

5. Remove the created files thanks to the commands 'make clean' et 'make solclean'.



What are the other files present in this directory?

-> *.f90 files
-> Text file physical_data.txt

For the output files : 
-> 2 output *.vts files at t=0 et TF/2
-> 2 output *.txt files of velocity profile in x=1 for different data 

In the animations directory : 

-> 4 animations for different conditions (see PDF)

In the PDF directory :

-> Report in PDF format






