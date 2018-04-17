CLASS zcl_gol_settings DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_width  TYPE i OPTIONAL
        i_height TYPE i OPTIONAL.
    METHODS get
      EXPORTING
        e_width  TYPE i
        e_height TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      m_width  TYPE i,
      m_height TYPE i.

ENDCLASS.

CLASS zcl_gol_settings IMPLEMENTATION.

  METHOD constructor.
    m_width = i_width.
    m_height = i_height.
  ENDMETHOD.

  METHOD get.
    e_width = m_width.
    e_height = m_height.
  ENDMETHOD.

ENDCLASS.
