subroutine timestep()

use mod_vol
! Timestep calculation

dt = 1.e10

do j = 1,n
   do i = 1,m
     dt1 = U*(Sxg(i,j)+Sxd(i,j))/(Vxy(i,j)*CFL)+V*(Syh(i,j)+Syb(i,j))/(Vxy(i,j)*CFL)+D/F*(1/(dx*dx)+1/(dy*dy))
     dt = min(dt,1./dt1)
   end do
end do


return
end
