module assertion

   interface assert_eq
      module procedure :: assert_eq_int16
      module procedure :: assert_eq_int32
      module procedure :: assert_eq_int64
   end interface assert_eq

   interface assert_close
      module procedure :: assert_close_int16
      module procedure :: assert_close_int32
      module procedure :: assert_close_int64
      module procedure :: assert_close_real32
      module procedure :: assert_close_real64
   end interface assert_close

contains

subroutine assert(bool)
   use iso_fortran_env, istderr => error_unit
   logical,intent(in) :: bool

   if (.not.bool) then
      write(istderr,'("assertion FAILED")')
      call terminate(1)
   endif
end subroutine assert

subroutine assert_eq_int16(val1,val2)
   use iso_fortran_env, istderr => error_unit
   integer(int16),intent(in) :: val1,val2

   if (val1 /= val2) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_eq_int16

subroutine assert_eq_int32(val1,val2)
   use iso_fortran_env, istderr => error_unit
   integer(int32),intent(in) :: val1,val2

   if (val1 /= val2) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_eq_int32

subroutine assert_eq_int64(val1,val2)
   use iso_fortran_env, istderr => error_unit
   integer(int64),intent(in) :: val1,val2

   if (val1 /= val2) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_eq_int64

subroutine assert_eq(val1,val2)
   use iso_fortran_env, istderr => error_unit
   integer,intent(in) :: val1,val2

   if (val1 /= val2) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_eq

subroutine assert_close_real64(val1,val2,thr)
   use iso_fortran_env, istderr => error_unit
   real(real64),intent(in) :: val1,val2,thr
   real(real64) :: diff

   diff = val1 - val2
   if (abs(diff) > thr) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_close_real64

subroutine assert_close_real32(val1,val2,thr)
   use iso_fortran_env, istderr => error_unit
   real(real32),intent(in) :: val1,val2,thr
   real(real32) :: diff

   diff = val1 - val2
   if (abs(diff) > thr) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_close_real32

subroutine assert_close_int16(val1,val2,thr)
   use iso_fortran_env, wp => real64, istderr => error_unit
   integer(int16),intent(in) :: val1,val2,thr
   integer(int16) :: diff

   diff = val1 - val2
   if (abs(diff) > thr) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_close_int16

subroutine assert_close_int32(val1,val2,thr)
   use iso_fortran_env, wp => real64, istderr => error_unit
   integer(int32),intent(in) :: val1,val2,thr
   integer(int32) :: diff

   diff = val1 - val2
   if (abs(diff) > thr) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_close_int32

subroutine assert_close_int64(val1,val2,thr)
   use iso_fortran_env, wp => real64, istderr => error_unit
   integer(int64),intent(in) :: val1,val2,thr
   integer(int64) :: diff

   diff = val1 - val2
   if (abs(diff) > thr) then
      write(istderr,'("assertion:",1x,g21.14," == ",g21.14,1x,"FAILED")') &
         val1,val2
      call terminate(1)
   endif
end subroutine assert_close_int64

end module assertion
