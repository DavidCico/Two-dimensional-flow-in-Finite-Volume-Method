# Passive scalar transport in a 2D flow using Finite Volume Method (FVM)
This code is a FORTRAN implementation of a 2D flow using FVM. The flow of a passive scalar is modelled, and visualization of the field is done with Paraview.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

The code being implemented in Fortran 90, and Fortran being a compiled language, it requires a compiler such as <a href="https://gcc.gnu.org/wiki/GFortran">GFortran</a>.

In Ubuntu, Mint and Debian you can install GFortran like this:

    sudo apt-get install gfortran
    
Alongside the GFortran compiler, the open-source platform for data analysis and visualization, <a href="https://www.paraview.org/">ParaView</a>, is also required and installed through the commands:

    sudo apt-get update
    sudo apt-get install paraview

For other Linux flavors, OS X and Windows, packages are available at:

https://gcc.gnu.org/wiki/GFortranBinaries for GFortran    
https://www.paraview.org/download/ for ParaView


## File descriptions

* 'ETF_data' which is a univariate time series of the price history of the ETF.
* 'Main.py' which contains the main procedure, as well as the data pre-processing of the xlsx file 'ETF_data.xlsx'
* 'Monte_Carlo_GBM.py' which contains the different algorithms used for comparison.
* 'Post_processing.py' where all the functions for post-processing (plots, information, descriptive statistics) are implemented.

### Running the program

1. Input numerical values in the file physical_data.txt

80            ! n  number of mesh cells in y    
70            ! m  number of mesh cells in x    
5             ! Length L1 of the domain    
2             ! Height L2 (Left side of the domain)    
2             ! Height L3 (Right side of the domain)     
0.01          ! Diffusion coefficient    
0             ! Velocity U (x direction)     
0             ! Velocity V (y direction)          
5             ! Final time    
0.9           ! CFL number    
0.4           ! Fourier number    

Modifying and tuning these values in order to have an orthogonal mesh or not, diffusion and/or advection...

2. Use the makefile to compile all the files and create the executable (run the command 'make' while being in the main directory of the program).

3. Launch the executable, which will create the mesh and run the discretised calculation on the latter.

4. Observe the concentration field on the domain thanks to Paraview (open sol.pvd).

5. Remove the created files thanks to the commands 'make clean' et 'make solclean'.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/DavidCico/Study-of-buy-and-hold-investment/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **David Cicoria** - *Initial work* - [DavidCico](https://github.com/DavidCico)

See also the list of [contributors](https://github.com/DavidCico/Study-of-buy-and-hold-investment/graphs/contributors) who participated in this project.
