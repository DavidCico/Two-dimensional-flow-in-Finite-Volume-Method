# Passive scalar transport in a 2D flow using Finite Volume Method (FVM)
<p align="justify">This code is a Fortran implementation of a 2D flow using FVM. The flow of a passive scalar is modelled, and visualization of the field is done with Paraview.</p>

## Getting Started

<p align="justify">These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.</p>

### Prerequisites

<p align="justify">The code being implemented in Fortran 90, and Fortran being a compiled language, it requires a compiler such as <a href="https://gcc.gnu.org/wiki/GFortran">GFortran</a>.</p>

In Ubuntu, Mint and Debian you can install GFortran like this:

    sudo apt-get install gfortran
    
<p align="justify">Alongside the GFortran compiler, the open-source platform for data analysis and visualization, <a href="https://www.paraview.org/">ParaView</a>, is also required and installed through the commands:</p>

    sudo apt-get update
    sudo apt-get install paraview

For other Linux flavors, OS X and Windows, packages are available at:

https://gcc.gnu.org/wiki/GFortranBinaries for GFortran    
https://www.paraview.org/download/ for ParaView


## File descriptions
<ul>
<li>'<em>.f90</em>' files in which the main code, as well as the different subroutines are programmed.</li>
<li><p align="justify">'<em>physical_data.txt</em>' which contains the different parameters to define the domain of computation, mesh size, and other parameters such as CFL or Fourier numbers.</p></li>
<li>In the output directory '<em>ex_output_files</em>', there are four files: 
     <ul>
       <li> 2 output *.vts files at t=0 and Tf/2</li>  
       <li>2 output *.txt files of velocity profile in x=1 for different data</li>
    </ul>
</li>
<li>4 animations in the '<em>animations</em>' directory.</li>
</ul> 

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

2. Use the **Makefile** to compile all the files and create the executable (run the command 'make' while being in the main directory of the program).

3. Launch the executable , which will create the mesh and run the discretised calculation on the latter.

4. Observe the concentration field on the domain using Paraview (open sol.pvd).

5. Remove the created files thanks to the commands 'make clean' and 'make solclean'.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/DavidCico/Two-dimensional-flow-in-Finite-Volume-Method/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **David Cicoria** - *Initial work* - [DavidCico](https://github.com/DavidCico)

See also the list of [contributors](https://github.com/DavidCico/Two-dimensional-flow-in-Finite-Volume-Method/graphs/contributors) who participated in this project.
