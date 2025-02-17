MACRO(USE_HDF5)
    set(opt "")
    set(component "c")
    foreach(comp ${ARGV})
        set(curcomp ${comp})
        if (curcomp STREQUAL "optional")
            set(opt "optional")
            using_message("Using HDF5: OPTIONAL")
        elseif(NOT curcomp STREQUAL "")
            set(component ${comp})
        endif()
    endforeach(comp ${ARGV})
    using_message("Using HDF5 ${opt}: component=${component}")

    IF (NOT HDF5_FOUND)
      USING_MESSAGE("Skipping because of missing HDF5")
      RETURN()
    ENDIF()
    IF (NOT HDF5_LIBRARIES)
      SET(HDF5_FOUND FALSE)
      if ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
          USING_MESSAGE("Skipping because of missing HDF5_LIBRARIES")
          RETURN()
      endif ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
    ENDIF()
    IF (NOT HDF5_CXX_LIBRARIES AND (component STREQUAL "cxx" OR component STREQUAL "all"))
      SET(HDF5_FOUND FALSE)
      if ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
          USING_MESSAGE("Skipping because of missing HDF5_CXX_LIBRARIES")
          RETURN()
      endif ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
    ENDIF()
    IF (NOT HDF5_HL_LIBRARIES AND (component STREQUAL "hl" OR component STREQUAL "all"))
      SET(HDF5_FOUND FALSE)
      if ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
          USING_MESSAGE("Skipping because of missing HDF5_HL_LIBRARIES")
          RETURN()
      endif ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
    ENDIF()
    IF (NOT HDF5_HL_CXX_LIBRARIES AND (component STREQUAL "cxx_hl" OR component STREQUAL "all"))
      SET(HDF5_FOUND FALSE)
      if ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
          USING_MESSAGE("Skipping because of missing HDF5_hdf5_hl_CXX_LIBRARY")
          RETURN()
      endif ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
  ENDIF()
  if ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
      USING_MESSAGE("Skipping because of missing HDF5")
      RETURN()
  endif ((NOT HDF5_FOUND) AND (NOT opt STREQUAL "optional"))
  IF(NOT HDF5_USED AND HDF5_FOUND)
    SET(HDF5_USED TRUE)
    INCLUDE_DIRECTORIES(SYSTEM ${HDF5_INCLUDE_DIR})
  ENDIF()
  if (component STREQUAL "all")
      SET(EXTRA_LIBS ${EXTRA_LIBS} ${HDF5_LIBRARIES} ${HDF5_HL_LIBRARIES})
  elseif (component STREQUAL "hl")
      SET(EXTRA_LIBS ${EXTRA_LIBS} ${HDF5_LIBRARIES} ${HDF5_HL_LIBRARIES})
  elseif (component STREQUAL "c")
      SET(EXTRA_LIBS ${EXTRA_LIBS} ${HDF5_LIBRARIES})
  endif()
ENDMACRO(USE_HDF5)

