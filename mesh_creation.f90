
	  
subroutine mesh_creation
  use mod_mesh
  implicit none

  open(8,file='physical_data.txt')
 
  read(8,*) n
  read(8,*) m
  read(8,*) L1
  read(8,*) L2 
  read(8,*) L3
  close(8)
 write(*,*) n, m ,L1, L2, L3
  allocate (x(m+1,n+1))
  allocate (y(m+1,n+1)) 
  
  ! Dynamic allocation of memory
    
  DO i=1,INT(m/2)   !We calculate the equations of the different lines of the bottom part (of the mesh) and we deduce the coordinates knowing x
     DO j=1,n+1
        x(i,j)=(j-1)*L1/n
        y(i,j)=(-(L3-L2)/2+(i-1)*(L3-L2)/m)*1/L1*x(i,j)-L2/2+(i-1)*L2/m
     ENDDO
  ENDDO


 !By symmetry we obtain the ordinates of the points of the top part of the mesh

         IF (modulo(m,2).EQ.0) THEN                 
            DO j=1,n+1
              y(int(m/2)+1,j)=0   !If m is even,  there will be a line where all the points have y = 0
            ENDDO
 
            DO i=1,int(m/2)
               DO j=1,n+1
                 y(m+1-(i-1),j)=-y(i,j)
               ENDDO
            ENDDO

         ELSE
            DO i=1,int(m/2)
               DO j=1,n+1
                 y(m+1-(i-1),j)=-y(i,j)
               ENDDO
            ENDDO

         ENDIF
	      

 !We calculate the other abscissa of the mesh points

      DO i=int(m/2), m+1
         DO j=1,n+1                                
           x(i,j)=(j-1)*L1/n
         ENDDO
      ENDDO

 !Results are stored in the file	'coordinates.txt'

      OPEN (7,FILE='coordinates.txt')
      WRITE(7,'(2I6)') n,m
      DO i=1,m+1
         DO j=1,n+1
           WRITE (7,'(F6.3,a,F6.3)') x(i,j),'      ', y(i,j)    
         ENDDO
      ENDDO
      CLOSE(7)

  
  deallocate (x)
  deallocate (y)	
end subroutine mesh_creation
