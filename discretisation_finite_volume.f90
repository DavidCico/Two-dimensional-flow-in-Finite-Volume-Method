  
	subroutine discretisation_finite_volume
	  use mod_vol
	  implicit none
          real :: time
	  allocate (c(m,n))
	  allocate (c1(m,n))
	  allocate (difx(m,n))
	  allocate (dify(m,n))
	  allocate (adv(m,n))
	  

			
!!!!!!!!!!!!!!!!!
!Initialisation : 
!!!!!!!!!!!!!!!!!

	  	  
	  call initial_condition())
	  call entrance_condition()

          call VTSWriter(0.,0,m+1,n+1,x,y,c1,'ini') 

 
!!!!!!!!!!!!!!!!!!
!Time loop : 
!!!!!!!!!!!!!!!!!!

			
       time = 0.
	  do k=1,nstep-1


		
		!entry boundary : 
		
		do i=1,m
		c(i,1)=c1(i,1)
		ENDDO
		
		
		
		
		!!!!!!!!!!!!!!!!!!
		!Flux calculation : 
		!!!!!!!!!!!!!!!!!!
		

	        !Advection flux : 

		do i=2,m 
		    do j = 2,n
                                          
                     adv(i,j)=V*(c1(i,j)*Syh(i,j)-c1(i-1,j)*Syb(i,j))      & !in y
                            + U*(c1(i,j)*Sxd(i,j)-c1(i,j-1)*Sxg(i,j))        !in x
                     	       
                    enddo              

		enddo
                
                !Diffusive flux for orthogonal mesh: 

                do i=2,m-1 
		    do j = 2,n-1
                                          
                     difx(i,j)= -Sxd(i,j)*D*(c1(i,j+1)-c1(i,j))/(dx)+Sxg(i,j)*D*(c1(i,j)-c1(i,j-1))/(dx)

                     dify(i,j)= -Syh(i,j)*D*(c1(i+1,j)-c1(i,j))/(dy)+Syb(i,j)*D*(c1(i,j)-c1(i-1,j))/(dy)
                     
                    enddo              
		enddo

                !Diffusion to the left


                do i=2,m-1
		difx(i,1)=-Sxd(i,1)*D*(c1(i,2)-c1(i,1))/(dx)
                dify(i,1)= -Syh(i,1)*D*(c1(i+1,1)-c1(i,1))/(dy)+Syb(i,1)*D*(c1(i,1)-c1(i-1,1))/(dy)
		enddo
                
                !Diffusion to the bottom

                do j=2,n-1
		difx(1,j)=-Sxd(1,j)*D*(c1(1,j+1)-c1(1,j))/(dx)+Sxg(1,j)*D*(c1(1,j)-c1(1,j-1))/(dx)
		enddo

                !!!!!!!!!!!!!!!!!!!!!!!!!!!!
		!Concentrations calculation : 
		!!!!!!!!!!!!!!!!!!!!!!!!!!!!


		!General case

                do i=2,m-1
		    do j = 2,n-1
                     
                     c(i,j)=c1(i,j)-dt/Vxy(i,j)*(adv(i,j)+difx(i,j)+dify(i,j))
                     
                    enddo              
                enddo


                !!!!!!!!!!!!!!!!!!!!
		!Boundary conditions : 
		!!!!!!!!!!!!!!!!!!!!


		!Right boundary

		do i=2,m-1
		c(i,n)=c1(i,n)-dt/Vxy(i,n)*(adv(i,n))
		enddo

                !Top boundary

                do j=2,n-1
		c(m,j)=c1(m,j)-dt/Vxy(m,j)*(adv(m,j))
		enddo

	        !Bottom boundary

                do j=2,n-1
		c(1,j)=c1(1,j)-dt/Vxy(1,j)*(difx(1,j))
		enddo

                
                !!!!!!!!!!!!!!!!
		!We implement : 
		!!!!!!!!!!!!!!!!

		do i=1,m
		   do j=1,n
              		c1(i,j) = c(i,j)    
		   enddo
		enddo
		   

      time = time + dt
      if (modulo(k,3).EQ.0) then 
	    

	  call VTSWriter(time,k,m+1,n+1,x,y,c,'int') ! We call the subroutine every 10 timesteps; This is explained in the subroutine VTSWriter


      endif


      if (k.eq.280) then
	OPEN (18,FILE='compadvnonortho.txt')
        DO i=1,m
         
        	WRITE (18,'(3F6.3)') c(i,20), yc(i,20)   
         
        ENDDO
        CLOSE(18)
      endif

	  

	  
	enddo
		





!!!!!!!!!!!!!!!
!Final step : 
!!!!!!!!!!!!!!!	


	  !same principle without the loop	

	  !entrance boundary : 
		
		do i=1,m
		c(i,1)=c1(i,1)
		ENDDO
		
				
		
	        !Advection flux : 

		do i=2,m 
		    do j = 2,n
                                          
                    adv(i,j)=V*(c1(i,j)*Syh(i,j)-c1(i-1,j)*Syb(i,j))      & ! in y 
                            + U*(c1(i,j)*(Sxd(i,j)+Sxh(i,j))-c1(i,j-1)*(Sxg(i,j)+Sxb(i,j))) ! in x
                     
                    enddo              

		enddo

               !Diffusive flux for orthogonal mesh: 

                do i=2,m-1 
		    do j = 2,n-1
                                          
                     difx(i,j)= -Sxd(i,j)*D*(c1(i,j+1)-c1(i,j))/(dx)+Sxg(i,j)*D*(c1(i,j)-c1(i,j-1))/(dx)

                     dify(i,j)= -Syh(i,j)*D*(c1(i+1,j)-c1(i,j))/(dy)+Syb(i,j)*D*(c1(i,j)-c1(i-1,j))/(dy)
                     
                    enddo              

		enddo

               !Diffusion to the left 

                do i=2,m-1
		difx(i,1)=-Sxd(i,1)*D*(c1(i,2)-c1(i,1))/(dx)
                dify(i,1)= -Syh(i,1)*D*(c1(i+1,1)-c1(i,1))/(dy)+Syb(i,1)*D*(c1(i,1)-c1(i-1,1))/(dy)
		enddo
                
                !Diffusion to the bottom

                do j=2,n-1
		difx(1,j)=-Sxd(1,j)*D*(c1(1,j+1)-c1(1,j))/(dx)+Sxg(1,j)*D*(c1(1,j)-c1(1,j-1))/(dx)
		enddo



		!General case

                do i=2,m-1
		    do j = 2,n-1
                     
                     c(i,j)=c1(i,j)-dt/Vxy(i,j)*(adv(i,j)+difx(i,j)+dify(i,j))
                     

                    enddo              
                enddo


                !!!!!!!!!!!!!!!!!!!!
		!Boundary conditions : 
		!!!!!!!!!!!!!!!!!!!!


		!Right boundary

		do i=2,m-1
		c(i,n)=c1(i,n)-dt/Vxy(m,j)*(adv(i,n)+dify(i,n))
		enddo

                !Top boundary

                do j=2,n-1
		c(m,j)=c1(m,j)-dt/Vxy(m,j)*(adv(m,j)+difx(m,j))
		enddo

	        !Bottom boundary

                do j=2,n-1
		c(1,j)=c1(1,j)-dt/Vxy(1,j)*(difx(1,j))
		enddo

               
		
	  call VTSWriter(t,nstep,m+1,n+1,x,y,c,'end')

	end subroutine discretisation_finite_volume
