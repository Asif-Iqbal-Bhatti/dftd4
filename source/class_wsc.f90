!> @brief defines the Wigner--Seitz-cell (ws_cell) data type
!!
!! The Wigner--Seitz cell is used to define periodic boundary conditions
!! by the cyclic cluster model (CCM). This type is usually bound to
!! the molecule class but can in principle be used independently.
module class_wsc
   use iso_fortran_env, only : wp => real64
   implicit none

   public :: ws_cell

   private

!> @brief definition of the the Wigner--Seitz-cell (ws_cell) data type
   type :: ws_cell
      integer  :: n = 0       !< number of atoms in the WSC
      integer  :: cells = 0   !< number of cells used to generate WSC
      integer  :: rep(3) = 0  !< translations defining the number of cells
      real(wp) :: lattice(3,3) = 0.0_wp    !< lattice parameters
      integer, allocatable :: at(:,:)      !< define species
      real(wp),allocatable :: xyz(:,:,:,:) !< define pbc xyz
      real(wp),allocatable :: w(:,:)       !< define weights
      integer, allocatable :: itbl(:,:)    !< define index table
      real(wp),allocatable :: cn(:)        !< GFN0 derived max. CNs
   contains
   procedure :: allocate => allocate_wsc
   procedure :: deallocate => deallocate_wsc
   procedure :: write => write_wsc
   end type ws_cell

contains

!> @brief constructor for Wigner--Seitz cell
subroutine allocate_wsc(self,n,rep,lattice)
   implicit none
   class(ws_cell),intent(inout) :: self
   integer,intent(in) :: n      !< number of atoms
   integer,intent(in) :: rep(3) !< translations
   real(wp),intent(in) :: lattice(3,3) !< lattice parameters
   integer :: cells
   cells = product(2*rep+1)
   self%n       = n
   self%rep     = rep
   self%cells   = cells
   self%lattice = lattice
   call self%deallocate
   allocate( self%at(n,n));          self%at   = 0
   allocate( self%xyz(3,cells,n,n)); self%xyz  = 0.0_wp
   allocate( self%w(n,n));           self%w    = 0.0_wp
   allocate( self%itbl(n,n));        self%itbl = 0
end subroutine allocate_wsc

!> @brief deconstructor for Wigner--Seitz cell
subroutine deallocate_wsc(self)
   implicit none
   class(ws_cell),intent(inout) :: self
   if (allocated(self%at))   deallocate(self%at)
   if (allocated(self%xyz))  deallocate(self%xyz)
   if (allocated(self%w))    deallocate(self%w)
   if (allocated(self%itbl)) deallocate(self%itbl)
end subroutine deallocate_wsc

subroutine write_wsc(self,iunit,comment)
   implicit none
   class(ws_cell),  intent(in) :: self
   integer,         intent(in) :: iunit
   character(len=*),intent(in) :: comment
   character(len=*),parameter :: dfmt = '(1x,a,1x,"=",1x,g0)'

   write(iunit,'(72(">"))')
   write(iunit,'(1x,"*",1x,a)') "Writing 'ws_cell' class"
   write(iunit,'(  "->",1x,a)') comment
   write(iunit,'(72("-"))')
   write(iunit,'(1x,"*",1x,a)') "status of the fields"
   write(iunit,dfmt) "integer :: n           ",self%n
   write(iunit,dfmt) "integer :: cells       ",self%cells
   write(iunit,dfmt) "integer :: rep(1)      ",self%rep(1)
   write(iunit,dfmt) "        &  rep(2)      ",self%rep(2)
   write(iunit,dfmt) "        &  rep(3)      ",self%rep(3)
   write(iunit,dfmt) "real    :: lattice(1,1)",self%lattice(1,1)
   write(iunit,dfmt) "        &  lattice(2,1)",self%lattice(2,1)
   write(iunit,dfmt) "        &  lattice(3,1)",self%lattice(3,1)
   write(iunit,dfmt) "        &  lattice(1,2)",self%lattice(1,2)
   write(iunit,dfmt) "        &  lattice(2,2)",self%lattice(2,2)
   write(iunit,dfmt) "        &  lattice(3,2)",self%lattice(3,2)
   write(iunit,dfmt) "        &  lattice(1,3)",self%lattice(1,3)
   write(iunit,dfmt) "        &  lattice(2,3)",self%lattice(2,3)
   write(iunit,dfmt) "        &  lattice(3,3)",self%lattice(3,3)
   write(iunit,'(72("-"))')
   write(iunit,'(1x,"*",1x,a)') "allocation status"
   write(iunit,dfmt) "allocated? at(:)       ",allocated(self%at)
   write(iunit,dfmt) "allocated? xyz(:,:,:,:)",allocated(self%xyz)
   write(iunit,dfmt) "allocated? w(:,:)      ",allocated(self%w)
   write(iunit,dfmt) "allocated? itbl(:,:)   ",allocated(self%itbl)
   write(iunit,dfmt) "allocated? cn(:)       ",allocated(self%cn)
   write(iunit,'(72("-"))')
   write(iunit,'(1x,"*",1x,a)') "size of memory allocation"
   if (allocated(self%at)) then
   write(iunit,dfmt) "size(1) :: at(*,:)     ",size(self%at,1)
   write(iunit,dfmt) "size(2) :: at(:,*)     ",size(self%at,2)
   endif
   if (allocated(self%xyz)) then
   write(iunit,dfmt) "size(1) :: xyz(*,:,:,:)",size(self%xyz,1)
   write(iunit,dfmt) "size(2) :: xyz(:,*,:,:)",size(self%xyz,2)
   write(iunit,dfmt) "size(3) :: xyz(:,:,*,:)",size(self%xyz,3)
   write(iunit,dfmt) "size(4) :: xyz(:,:,:,*)",size(self%xyz,4)
   endif
   if (allocated(self%w)) then
   write(iunit,dfmt) "size(1) :: w(*,:)      ",size(self%w,1)
   write(iunit,dfmt) "size(2) :: w(:,*)      ",size(self%w,2)
   endif
   if (allocated(self%w)) then
   write(iunit,dfmt) "size(1) :: itbl(*,:)   ",size(self%itbl,1)
   write(iunit,dfmt) "size(2) :: itbl(:,*)   ",size(self%itbl,2)
   endif
   if (allocated(self%cn)) then
   write(iunit,dfmt) "size(1) :: cn(*)       ",size(self%cn,1)
   endif
   write(iunit,'(72("<"))')

end subroutine write_wsc

end module class_wsc
