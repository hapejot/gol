CLASS zcl_gol_display DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_world TYPE REF TO zif_gol_world
        i_main  TYPE REF TO zcl_gol_main.
    METHODS display.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      m_world  TYPE REF TO zif_gol_world,
      m_main   TYPE REF TO zcl_gol_main,
      m_count  TYPE i,
      m_width  TYPE i,
      m_timer  TYPE REF TO cl_gui_timer,
      m_height TYPE i.
    METHODS handle_finished FOR EVENT finished OF cl_gui_timer.
ENDCLASS.



CLASS zcl_gol_display IMPLEMENTATION.


  METHOD constructor.

    m_world = i_world.
    m_main = i_main.
    CALL METHOD i_main->get_size
      IMPORTING
        e_width  = m_width
        e_height = m_height.
    IF cl_gui_alv_grid=>offline( ) IS INITIAL.
      CREATE OBJECT m_timer.
      SET HANDLER handle_finished FOR m_timer.
      m_timer->interval = 1.
    ENDIF.
  ENDMETHOD.


  METHOD display.

    GET TIME STAMP FIELD DATA(ts0).
    DATA(lr_world) = m_main->main( ).

    WRITE / m_count.
    WRITE /.
    DO m_height TIMES.
      DATA(l_y) = sy-index.
      WRITE / l_y.
      DO m_width TIMES.
        DATA(l_x) = sy-index.
        WRITE lr_world->get_state( x = l_x y = l_y ) NO-GAP.
      ENDDO.
    ENDDO.
    CALL METHOD m_timer->run.
    GET TIME STAMP FIELD DATA(ts1).
    DATA(l_msec) =  ts1 - ts0.
    WRITE: / ts0, ts1.

  ENDMETHOD.


  METHOD handle_finished.

    ADD 1 TO m_count.
    CALL METHOD cl_gui_cfw=>set_new_ok_code
      EXPORTING
        new_code = 'REFR'.

  ENDMETHOD.
ENDCLASS.
