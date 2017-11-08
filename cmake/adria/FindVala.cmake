##
# Copyright 2009-2010 Jakob Westhoff, 2014 Raster Software Vigo
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
#    1. Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
# 
#    2. Redistributions in binary form must reproduce the above copyright notice,
#       this list of conditions and the following disclaimer in the documentation
#       and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY JAKOB WESTHOFF ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL JAKOB WESTHOFF OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies,
# either expressed or implied, of Jakob Westhoff
##

##
# Find module for the Vala compiler (valac)
#
# This module determines wheter a Vala compiler is installed on the current
# system and where its executable is.
#
# Call the module using "find_package(Vala) from within your CMakeLists.txt.
#
# The following variables will be set after an invocation:
#
#  VALA_FOUND       Whether the vala compiler has been found or not
#  VALA_EXECUTABLE  Full path to the valac executable if it has been found
#  VALA_VERSION     Version number of the available valac
##


# Search for the valac executable in the usual system paths.
find_program(VALA_EXECUTABLE NAMES valac)
# Get the custom wrapper. We need to ensure both.
find_program(ADRIA_EXECUTABLE NAMES adriac)

# if (ADRIA_EXECUTABLE STREQUAL "ADRIA_EXECUTABLE-NOTFOUND")
# 	message (STATUS "ADRIAC not found.")
# else()
# 	message(STATUS "  found Adriac. Praise the Ori.")
# endif()

if (VALA_EXECUTABLE STREQUAL "VALA_EXECUTABLE-NOTFOUND")

# if valac executable is not found, it can be that valac is not installed, or
# that the OS is source-based (like gentoo), and doesn't do a link from
# valac-X.YY to valac. In that case, search for the specific valac binary after

	if (NOT VALA_DEFERRING_COMPILER_SEARCH)
		message (STATUS "VALAC not found. Deferring compiler search")
	endif(NOT VALA_DEFERRING_COMPILER_SEARCH)
	set(VALA_DEFERRING_COMPILER_SEARCH TRUE)
	unset(VALA_EXECUTABLE)
	unset(VALA_VERSION)

else(VALA_EXECUTABLE STREQUAL "VALA_EXECUTABLE-NOTFOUND")

# Handle the QUIETLY and REQUIRED arguments, which may be given to the find call.
# Furthermore set VALA_FOUND to TRUE if Vala has been found (aka.
# VALA_EXECUTABLE is set)

	include(FindPackageHandleStandardArgs)
	find_package_handle_standard_args(Vala DEFAULT_MSG VALA_EXECUTABLE)

	mark_as_advanced(VALA_EXECUTABLE)

# Determine the valac version
	if(VALA_FOUND)
	    execute_process(COMMAND ${VALA_EXECUTABLE} "--version" OUTPUT_VARIABLE "VALA_VERSION")
	    string(REPLACE "Vala" "" "VALA_VERSION" ${VALA_VERSION})
	    string(STRIP ${VALA_VERSION} "VALA_VERSION")
	endif(VALA_FOUND)
endif(VALA_EXECUTABLE STREQUAL "VALA_EXECUTABLE-NOTFOUND")