MODULE mod_vol
implicit none  !This module gathers all structures and variable declarations. The different variables don't need to be redefined and this file can just be called in the subroutines.
integer :: n,m,i,j,k,p,nstep
real :: L1, L2, L3, T,dt,D,U,V,cFL,F,dx,dy
real, dimension(:,:) :: x,y,c,c1,xc,yc,adv,difx,dify,Sxg,Sxd,Sxh,Sxb,Vxy,Syg,Syd,Syh,Syb
allocatable x,y,c,c1,xc,yc,adv,difx,dify,Sxg,Sxd,Sxh,Sxb,Vxy,Syg,Syd,Syh,Syb
end module
