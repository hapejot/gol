CLASS zcl_gol_main DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_settings TYPE REF TO zcl_gol_settings
        i_world    TYPE REF TO zif_gol_world.
    METHODS main
      RETURNING
        VALUE(new_world) TYPE REF TO zif_gol_world.
    METHODS get_size
      EXPORTING
        e_width  TYPE i
        e_height TYPE i.
    METHODS calc_new_state
      IMPORTING
        neighbours      TYPE i
        state           TYPE zif_gol_world=>t_state
      RETURNING
        VALUE(r_result) TYPE zif_gol_world=>t_state.
    METHODS init_with_random.
    METHODS get_world
      RETURNING
        VALUE(r_result) TYPE REF TO zif_gol_world.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      m_max_x TYPE i,
      m_max_y TYPE i,
      m_world TYPE REF TO zif_gol_world.

ENDCLASS.



CLASS ZCL_GOL_MAIN IMPLEMENTATION.


  METHOD calc_new_state.
    CASE neighbours.
      WHEN 2.
        r_result = state.
      WHEN 3.
        r_result = abap_true.
      WHEN OTHERS.
        r_result = abap_false.
    ENDCASE.
  ENDMETHOD.


  METHOD constructor.
    CALL METHOD i_settings->get
      IMPORTING
        e_width  = m_max_x
        e_height = m_max_y.
    m_world = i_world.

  ENDMETHOD.


  METHOD get_size.
    e_height = m_max_y.
    e_width = m_max_x.
  ENDMETHOD.


  METHOD get_world.
    r_result = m_world.
  ENDMETHOD.


  METHOD init_with_random.

    DATA(lr_random) = CAST if_random_number( NEW cl_random_number( ) ).
    lr_random->init( ).
    DATA(l_threshold) = CONV float( 1 ) / 3.
    DO m_max_y TIMES.
      DATA(l_y) = sy-index.
      DO m_max_x TIMES.
        DATA(l_x) = sy-index.
        IF  l_threshold < lr_random->get_random_float( ).
          m_world->set_state( x = l_x y = l_y state = abap_true ).
        ENDIF.
      ENDDO.
    ENDDO.

  ENDMETHOD.


  METHOD main.

    new_world = m_world->clone( ).
    DO m_max_x TIMES.
      DATA(l_x) = sy-index.
      DO m_max_y TIMES.
        DATA(l_y) = sy-index.
        new_world->set_state(   x = l_x
                                y = l_y
                                state = calc_new_state( neighbours = m_world->get_neighbours( x = l_x y = l_y )
                                                        state      = m_world->get_state( x = l_x y = l_y ) ) ).
      ENDDO.
    ENDDO.
    m_world = new_world.

  ENDMETHOD.
ENDCLASS.
