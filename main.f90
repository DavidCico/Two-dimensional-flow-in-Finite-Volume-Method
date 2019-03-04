program Finite_volume_scalar_transportation
  use mod_vol
  implicit none
  call mesh_creation()
  call reading_data()
  call data_calculation()

			
  call timestep()
  print*,'Dt = ',dt

  !verify stability!!!
  nstep = int(T/dt)+1
  dt = T/nstep
  print*,'Dt reel=',dt 
   
  call discretisation_finite_volume()
  
  
  deallocate (x)
  deallocate (y)
  deallocate (c)
  deallocate (c1)
  deallocate (xc)
  deallocate (yc)
  deallocate (difx)
  deallocate (dify)
  deallocate (adv)
  deallocate (Vxy)
  deallocate (Sxg)
  deallocate (Syg)
  deallocate (Sxd)
  deallocate (Syd)
  deallocate (Sxh)
  deallocate (Syh)
  deallocate (Sxb)
  deallocate (Syb)
  
end program Finite_volume_scalar_transportation
			
