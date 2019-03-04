subroutine initial_condition()
  
  use mod_vol
	do i=1,m
	  do j=1,n
        c(i,j)= 0.
    enddo
	enddo
	
end subroutine initial_condition
