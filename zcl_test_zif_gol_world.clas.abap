CLASS zcl_test_zif_gol_world DEFINITION FOR TESTING
  PUBLIC
  ABSTRACT
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PUBLIC SECTION.
    METHODS:
      get_cell FOR TESTING RAISING cx_static_check,
      set_cell FOR TESTING RAISING cx_static_check,
      set_two_cells FOR TESTING RAISING cx_static_check,
      reset_two_cells FOR TESTING RAISING cx_static_check,
      neighbours_nine FOR TESTING RAISING cx_static_check,
      neighbours_eight FOR TESTING RAISING cx_static_check,
      neighbours_seven FOR TESTING RAISING cx_static_check.
    METHODS neighbours_seven_plus_one FOR TESTING RAISING cx_static_check.
    METHODS clone FOR TESTING RAISING cx_static_check.

  PRIVATE SECTION.



ENDCLASS.



CLASS zcl_test_zif_gol_world IMPLEMENTATION.


  METHOD get_cell.
    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).

    cl_abap_unit_assert=>assert_equals( msg = 'cell not dead'
                                        exp = cut->c_dead
                                        act = cut->get_state( x = 5  y = 5 ) ).

  ENDMETHOD.


  METHOD neighbours_eight.

    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    cut->set_state( x = 2 y = 3 state = abap_true ).
    cut->set_state( x = 3 y = 3 state = abap_true ).
*    cut->set_state( x = 4 y = 3 state = abap_true ).
    cut->set_state( x = 2 y = 4 state = abap_true ).
    cut->set_state( x = 3 y = 4 state = abap_true ).
    cut->set_state( x = 4 y = 4 state = abap_true ).
    cut->set_state( x = 2 y = 5 state = abap_true ).
    cut->set_state( x = 3 y = 5 state = abap_true ).
    cut->set_state( x = 4 y = 5 state = abap_true ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 7 act = cut->get_neighbours( x = 3 y = 4 ) ).

  ENDMETHOD.


  METHOD neighbours_nine.

    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    cut->set_state( x = 2 y = 3 state = abap_true ).
    cut->set_state( x = 3 y = 3 state = abap_true ).
    cut->set_state( x = 4 y = 3 state = abap_true ).
    cut->set_state( x = 2 y = 4 state = abap_true ).
    cut->set_state( x = 3 y = 4 state = abap_true ).
    cut->set_state( x = 4 y = 4 state = abap_true ).
    cut->set_state( x = 2 y = 5 state = abap_true ).
    cut->set_state( x = 3 y = 5 state = abap_true ).
    cut->set_state( x = 4 y = 5 state = abap_true ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 8 act = cut->get_neighbours( x = 3 y = 4 ) ).

  ENDMETHOD.


  METHOD neighbours_seven.

    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    cut->set_state( x = 2 y = 3 state = abap_true ).
    cut->set_state( x = 3 y = 3 state = abap_true ).
*    cut->set_state( x = 4 y = 3 state = abap_true ).
    cut->set_state( x = 2 y = 4 state = abap_true ).
    cut->set_state( x = 3 y = 4 state = abap_true ).
    cut->set_state( x = 4 y = 4 state = abap_true ).
*    cut->set_state( x = 2 y = 5 state = abap_true ).
    cut->set_state( x = 3 y = 5 state = abap_true ).
    cut->set_state( x = 4 y = 5 state = abap_true ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 6 act = cut->get_neighbours( x = 3 y = 4 ) ).

  ENDMETHOD.

  METHOD neighbours_seven_plus_one.

    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    cut->set_state( x = 2 y = 3 state = abap_true ).
    cut->set_state( x = 3 y = 3 state = abap_true ).
*    cut->set_state( x = 4 y = 3 state = abap_true ).
    cut->set_state( x = 2 y = 4 state = abap_true ).
    cut->set_state( x = 3 y = 4 state = abap_true ).
    cut->set_state( x = 4 y = 4 state = abap_true ).
*    cut->set_state( x = 2 y = 5 state = abap_true ).
    cut->set_state( x = 3 y = 5 state = abap_true ).
    cut->set_state( x = 4 y = 5 state = abap_true ).

    cut->set_state( x = 4 y = 8 state = abap_true ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 6 act = cut->get_neighbours( x = 3 y = 4 ) ).

  ENDMETHOD.

  METHOD reset_two_cells.
    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    cut->set_state( x = 2 y = 8 state = cut->c_alive ).
    cut->set_state( x = 15 y = 11 state = cut->c_alive ).
    cut->set_state( x = 2 y = 8 state = cut->c_dead ).
    cl_abap_unit_assert=>assert_equals( msg = 'cell not dead'
                                        exp = cut->c_dead
                                        act = cut->get_state( x = 2  y = 8 ) ).
    cl_abap_unit_assert=>assert_equals( msg = 'cell not alive'
                                        exp = cut->c_alive
                                        act = cut->get_state( x = 15  y = 11 ) ).
  ENDMETHOD.


  METHOD set_cell.
    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    cut->set_state( x = 5 y = 5 state = cut->c_alive ).
    cl_abap_unit_assert=>assert_equals( msg = 'cell not alive'
                                        exp = cut->c_alive
                                        act = cut->get_state( x = 5  y = 5 ) ).
  ENDMETHOD.


  METHOD set_two_cells.
    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    cut->set_state( x = 2 y = 8 state = cut->c_alive ).
    cut->set_state( x = 15 y = 11 state = cut->c_alive ).
    cl_abap_unit_assert=>assert_equals( msg = 'cell not alive'
                                        exp = cut->c_alive
                                        act = cut->get_state( x = 2  y = 8 ) ).
    cl_abap_unit_assert=>assert_equals( msg = 'cell not alive'
                                        exp = cut->c_alive
                                        act = cut->get_state( x = 15  y = 11 ) ).
  ENDMETHOD.

  METHOD clone.
    DATA(cut) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    DATA(result) = cut->clone( ).
    cl_abap_unit_assert=>assert_bound( msg = 'msg'  act = result ).
  ENDMETHOD.
ENDCLASS.
