subroutine data_calculation()
    use mod_vol
	
	
	
	allocate (xc(m,n))
	allocate (yc(m,n))
    allocate (Sxb(m,n))
	allocate (Sxh(m,n))
	allocate (Sxd(m,n))
	allocate (Sxg(m,n))
	allocate (Syb(m,n))
	allocate (Syh(m,n))
	allocate (Syd(m,n))
	allocate (Syg(m,n))
    allocate (Vxy(m,n))

dx=L2/n
dy=L1/m
	  
!!!  Calculate coordinates at the center of the mesh cell :


	do i=1,m
		do j=1,n
        	xc(i,j)=(x(i,j)+x(i,j+1))/2
			yc(i,j)=(y(i,j)+y(i+1,j))/2
    	enddo
    enddo

!!! Calculate the different surfaces around the volume :


    do i=1,m
		do j=1,n

! left side : 

	Sxg(i,j)= y(i+1,j)-y(i,j)
	Syg(i,j)= x(i+1,j)-x(i,j)

! right side : 

	Sxd(i,j)=y(i+1,j+1)-y(i,j+1)
	Syd(i,j)=x(i+1,j+1)-x(i,j+1)

	
! top side : 

	Sxh(i,j)=y(i+1,j+1)-y(i+1,j)
	Syh(i,j)=x(i+1,j+1)-x(i+1,j)


! bottom side : 	
	
	Sxb(i,j)=y(i,j+1)-y(i,j)
	Syb(i,j)=x(i,j+1)-x(i,j)


!!! Volumes calculation : 


	Vxy(i,j)=	(x(i,j+1)-x(i,j))*(y(i+1,j)-y(i,j)+y(i+1,j+1)-y(i,j+1))/2 !Trapezoid formula!


    	enddo
    enddo
			

end subroutine data_calculation
