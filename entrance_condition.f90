subroutine entrance_condition()  
use mod_vol


do i=1,m
	If (y(i,1).LE.-L2/4) then
	      c1(i,1)= 0
		else if (y(i,1).GE.L2/4) then
		   c1(i,1)=0
		else
		   c1(i,1)=1
		endif 
enddo

end subroutine entrance_condition
