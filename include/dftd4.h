/* This file is part of dftd4.
 * SPDX-Identifier: LGPL-3.0-or-later
 *
 * dftd4 is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * dftd4 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with dftd4.  If not, see <https://www.gnu.org/licenses/>.
**/
#pragma once

#ifdef __cplusplus
#define DFTD4_API_ENTRY extern "C"
#else
#define DFTD4_API_ENTRY extern
#include <stdbool.h>
#endif
#define DFTD4_API_CALL
#define DFTD4_API_SUFFIX__V_3_0

/// Error handle class
typedef struct _dftd4_error* dftd4_error;

/// Molecular structure data class
typedef struct _dftd4_structure* dftd4_structure;

/// Dispersion model class
typedef struct _dftd4_model* dftd4_model;

/// Damping parameter class
typedef struct _dftd4_param* dftd4_param;

/*
 * Global API queries
**/

/// Obtain library version as major * 10000 + minor + 100 + patch
DFTD4_API_ENTRY int DFTD4_API_CALL
dftd4_get_version() DFTD4_API_SUFFIX__V_3_0;

/*
 * Error handle class
**/

/// Create new error handle object
DFTD4_API_ENTRY dftd4_error DFTD4_API_CALL
dftd4_new_error() DFTD4_API_SUFFIX__V_3_0;

/// Check error handle status
DFTD4_API_ENTRY int DFTD4_API_CALL
dftd4_check_error(dftd4_error /* error */) DFTD4_API_SUFFIX__V_3_0;

/// Get error message from error handle
DFTD4_API_ENTRY void DFTD4_API_CALL
dftd4_get_error(dftd4_error /* error */,
                char* /* buffer */,
                const int* /* buffersize */) DFTD4_API_SUFFIX__V_3_0;

/// Delete error handle object
DFTD4_API_ENTRY void DFTD4_API_CALL
dftd4_delete_error(dftd4_error* /* error */) DFTD4_API_SUFFIX__V_3_0;

/*
 * Molecular structure data class
**/

/// Create new molecular structure data (quantities in Bohr)
DFTD4_API_ENTRY dftd4_structure DFTD4_API_CALL
dftd4_new_structure(dftd4_error /* error */,
                    const int /* natoms */,
                    const int* /* numbers [natoms] */,
                    const double* /* positions [natoms][3] */,
                    const double* /* charge */,
                    const double* /* lattice [3][3] */,
                    const bool* /* periodic [3] */) DFTD4_API_SUFFIX__V_3_0;

/// Delete molecular structure data
DFTD4_API_ENTRY void DFTD4_API_CALL
dftd4_delete_structure(dftd4_structure* /* mol */) DFTD4_API_SUFFIX__V_3_0;

/// Update coordinates and lattice parameters (quantities in Bohr)
DFTD4_API_ENTRY void DFTD4_API_CALL
dftd4_update_structure(dftd4_error /* error */,
                       dftd4_structure /* mol */,
                       const double* /* positions [natoms][3] */,
                       const double* /* lattice [3][3] */) DFTD4_API_SUFFIX__V_3_0;

/*
 * Dispersion model class
**/

/// Create new D4 dispersion model
DFTD4_API_ENTRY dftd4_model DFTD4_API_CALL
dftd4_new_d4_model(dftd4_error /* error */,
                   dftd4_structure /* mol */) DFTD4_API_SUFFIX__V_3_0;

/// Delete dispersion model
DFTD4_API_ENTRY void DFTD4_API_CALL
dftd4_delete_model(dftd4_model* /* disp */) DFTD4_API_SUFFIX__V_3_0;

/*
 * Damping parameter class
**/

/// Create new rational damping parameters
DFTD4_API_ENTRY dftd4_param DFTD4_API_CALL
dftd4_new_rational_damping(dftd4_error /* error */,
                           double /* s6 */,
                           double /* s8 */,
                           double /* s9 */,
                           double /* a1 */,
                           double /* a2 */,
                           double /* alp */) DFTD4_API_SUFFIX__V_3_0;

/// Load rational damping parameters from internal storage
DFTD4_API_ENTRY dftd4_param DFTD4_API_CALL
dftd4_load_rational_damping(dftd4_error /* error */,
                            char* /* method */,
                            bool /* mdb */) DFTD4_API_SUFFIX__V_3_0;

/// Delete damping parameters
DFTD4_API_ENTRY void DFTD4_API_CALL
dftd4_delete_param(dftd4_param* /* param */) DFTD4_API_SUFFIX__V_3_0;

/*
 * Perform dispersion calculations
**/

DFTD4_API_ENTRY void DFTD4_API_CALL
dftd4_get_dispersion(dftd4_error /* error */,
                     dftd4_structure /* mol */,
                     dftd4_model /* disp */,
                     dftd4_param /* param */,
                     double* /* energy */,
                     double* /* gradient[n][3] */,
                     double* /* sigma[3][3] */) DFTD4_API_SUFFIX__V_3_0;