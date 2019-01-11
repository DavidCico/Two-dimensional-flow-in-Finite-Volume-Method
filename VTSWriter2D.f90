subroutine VTSWriter(Time,Step,nx,ny,x,y,Quantity,opt)
!---------------------------------------------------------------------------------------!
!  Time    : Calculation time
!  Step    : Timestep = number in the file name, if Step<0 we write                     !
!             in exact_sol.vts                                                          !
!  nx       : an integer                                                                !
!  ny       : an integer                                                                !
!  x        : real table (of size nx,ny) of nodes abscissa                              !
!  y        : real table (of size nx,ny) of nodes ordinates                             !
!  Quantity : real table (of size nx * ny) of the value to trace                        !
!  opt      : type string variable that must be of one of the following values :        !
!              - 'ini' for the first call of VTSWriter                                  !
!              - 'int' for a standard call of VTSWriter                                 !
!              - 'end' for the last call of VTSWriter                                   !
!---------------------------------------------------------------------------------------!
  implicit none
  integer :: Step, i, j, nx, ny
  real :: Quantity(nx-1,ny-1),Time
  real :: x(nx,ny), y(nx,ny)
  character(100) :: num2char
  character(200) :: FileName, formatperso
  character(3) :: opt


  !  --- Writing a temporary file in Paraview format  ---
  if (Step >= 0) then
    write(num2char,'(i6.6)') Step
    FileName = 'sol_'//trim(num2char)//'.vts'
    open(8,file=FileName)
  else
    open(8,file='exact_sol.vts')
  end if
  write(num2char,*) 3*nx*ny
  formatperso = '('//trim(num2char)//'(F15.6,1x))'
  write(8,'(a)') '<?xml version="1.0"?>'
  write(8,'(a)') '<VTKFile type="StructuredGrid">'
  write(8,'(a,6i6,a)') '<StructuredGrid WholeExtent="', 0,nx-1,0,ny-1,0,0,'">'
  write(8,'(a,6i6,a)') '<Piece Extent="',0,nx-1,0,ny-1,0,0,'">'
  write(8,'(a)') '<Points>'
  write(8,'(a)') '<DataArray type="Float32" NumberOfComponents="3"/>'
  ! - Writing coordinates -
  DO j=1,ny
     write(8,formatperso) (x(i,j),y(i,j),0.,i=1,nx)
  END DO
  write(8,'(a)') '</Points>'
  write(8,'(a)') '<CellData Scalars="Concentration">'
  write(8,'(a)') '<DataArray type="Float32" Name="Concentration"/>'
  write(num2char,*) (nx-1)*(ny-1)
  formatperso = '('//trim(num2char)//'(F15.6,1x))'
  ! - Writing values -
  DO j=1,ny-1
     write(8,formatperso) (Quantity(i,j),i=1,nx-1)
  END DO
  write(8,'(a)') '</CellData>'
  write(8,'(a)') '</Piece>'
  write(8,'(a)') '</StructuredGrid>'
  write(8,'(a)') '</VTKFile>'
  close(8)


  ! - Fill in the "Collection" determining the temporal evolution  -
  if (opt == 'ini' ) then
    open(10,file='sol.pvd')
    write(10,'(a)') '<?xml version="1.0"?>'
    write(10,*) '<VTKFile type="Collection">'
    write(10,*) '<Collection>'
  else
    open(10,file='sol.pvd',position='append')
  end if
  if (Step >= 0) write(10,*) '<DataSet timestep="',Step,'" group="" part="0" file="',trim(FileName),'"/>'
  if ( opt == 'end') then
    write(10,*) '</Collection>'
    write(10,*) '</VTKFile>'
  end if
  close(10)

end subroutine VTSWriter

