      subroutine reading_data
	  use mod_vol
	  implicit none
	 
	  open(10,FILE='coordinates.txt')
	  read(10,'(2I6)') n,m                        !We read n and m
	  ALLOCATE (x(m+1,n+1))
      allocate (y(m+1,n+1))		!We can now defined the sizes of x, y, z, TO,z0
	 	do i=1,m+1
	    	do j=1,n+1
	             read(10, *) x(i,j), y(i,j) ! x and y values are read from the file created in the previous program
		    enddo
	    enddo
	  close(10)
		 
	   open(7,file='physical_data.txt') ! The other necessary values are read in the file 'physical_data.txt'
		   
	  
           read(7,*) 
           read(7,*) 
           read(7,*) L1
           read(7,*) L2 
           read(7,*) L3
           read(7,*) D
           read(7,*) U                 ! Velocity in x direction
           read(7,*) V
           read(7,*) T
           read(7,*) CFL
           read(7,*) f
           

	   close(7)

    open(10,FILE='coordread.txt')
	 	do i=1,m+1
	        do j=1,n+1
	             write(10, *) x(i,j), y(i,j) ! On lit les valeurs des x et y dans les fichier texte créé dans le 1er programme
		    enddo
	    enddo
	close(10)
		 

           end subroutine reading_data