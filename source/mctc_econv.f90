!> @brief unit conversion factors
module mctc_econv
   use iso_fortran_env, only : wp => real64
   use mctc_constants
   implicit none
!  convert bohr to Ångström and back
   real(wp),parameter :: autoaa = 0.52917726_wp  !< convert bohr to Ångström
   real(wp),parameter :: aatoau = 1.0_wp/autoaa  !< convert Ångström to bohr
!  convert Hartree to eV and back
   real(wp),parameter :: autoev = 27.21138505_wp !< convert Hartree to eV
   real(wp),parameter :: evtoau = 1.0_wp/autoev  !< convert eV to Hartree
!  convert Hartree to kcal/mol and back
   real(wp),parameter :: autokcal = 627.50947428_wp !< convert Hartree to kcal/mol
   real(wp),parameter :: kcaltoau = 1.0_wp/autokcal !< convert kcal/mol to Hartree
!  convert Hartree to kJ/mol and back
   real(wp),parameter :: autokj = 2625.49964038_wp  !< convert Hartree to kJ/mol
   real(wp),parameter :: kjtoau = 1.0_wp/autokj     !< convert kJ/mol to Hartree
!  convert Hartree to reciproce centimeters/wavenumbers and back
   real(wp),public,parameter :: autorcm = 219474.63067_wp
   real(wp),public,parameter :: autowav = autorcm
   real(wp),public,parameter :: rcmtoau = 1.0_wp/autorcm
   real(wp),public,parameter :: wavtoau = 1.0_wp/autowav
!  convert Hartree to nanometers and back
   real(wp),public,parameter :: autonm = 45.56335266_wp
   real(wp),public,parameter :: nmtoau = 1.0_wp/autonm
!  masses
!  amu -> kg :: conversion from atomic mass units to kg
!  me  -> kg :: electron mass (a.u.) in kg
!  amu -> au :: conversion from a.u. to amu
   real(wp),public,parameter :: amutokg = 1.660539040e-27_wp
   real(wp),public,parameter :: kgtoamu = 1.0_wp/amutokg
   real(wp),public,parameter :: metokg  = 9.10938356e-31_wp
   real(wp),public,parameter :: kgtome  = 1.0_wp/metokg
   real(wp),public,parameter :: amutoau = amutokg*kgtome
   real(wp),public,parameter :: autoamu = kgtoamu*metokg
!  femtosectons to atomic time units
   real(wp),public,parameter :: fstoau = 41.3413733365614_wp
   real(wp),public,parameter :: autofs = 1.0_wp/fstoau
!  Coulomb to atomic charge units (electrons)
   real(wp),public,parameter :: autoc = 1.6021766208e-19_wp
   real(wp),public,parameter :: ctoau = 1.0_wp/autoc
!  Debye to atomic units
   real(wp),public,parameter :: autod = autoc * lightspeed * autoaa**2 * fstoau * 1.0e+16_wp
   real(wp),public,parameter :: dtoau = 1.0_wp/autod

end module mctc_econv
