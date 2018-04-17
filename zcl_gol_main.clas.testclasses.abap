*"* use this source file for your ABAP unit test classes
CLASS ltcl_gol DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS main_four FOR TESTING RAISING cx_static_check.
    METHODS birth FOR TESTING RAISING cx_static_check.
    METHODS new_state_alive FOR TESTING RAISING cx_static_check.
    METHODS new_state_birth FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_gol IMPLEMENTATION.

  METHOD new_state_alive.

    DATA(world) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    DATA(cut) = NEW zcl_gol_main( i_settings = new zcl_gol_settings( i_width = 10 i_height = 10 ) i_world = world ).
    cl_abap_unit_assert=>assert_equals( msg = 'msg'
                            exp = zif_gol_world=>c_alive
                            act = cut->calc_new_state(
                                                EXPORTING
                                                  neighbours = 2
                                                  state      = zif_gol_world=>c_alive
                                              ) ).

  ENDMETHOD.

  METHOD new_state_birth.

    DATA(world) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    DATA(cut) = NEW zcl_gol_main( i_settings = new zcl_gol_settings( i_width = 10 i_height = 10 ) i_world = world ).
    cl_abap_unit_assert=>assert_equals( msg = 'msg'
                            exp = zif_gol_world=>c_alive
                            act = cut->calc_new_state(
                                                EXPORTING
                                                  neighbours = 3
                                                  state      = zif_gol_world=>c_dead
                                              ) ).

  ENDMETHOD.

  METHOD main_four.

    DATA(world) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    DATA(cut) = NEW zcl_gol_main( i_settings = new zcl_gol_settings( i_width = 10 i_height = 10 ) i_world = world ).
    world->set_state( x = 3 y = 2 state = abap_true ).
    world->set_state( x = 4 y = 2 state = abap_true ).
    world->set_state( x = 3 y = 3 state = abap_true ).
    world->set_state( x = 4 y = 3 state = abap_true ).
    DO 1000 TIMES.
      world = cut->main( ).
    ENDDO.

    cl_abap_unit_assert=>assert_equals( msg = '1' exp = abap_false act = world->get_state( x = 2 y = 2 ) ).
    cl_abap_unit_assert=>assert_equals( msg = '2' exp = abap_true act = world->get_state( x = 3 y = 2 ) ).
    cl_abap_unit_assert=>assert_equals( msg = '3' exp = abap_true act = world->get_state( x = 4 y = 2 ) ).
    cl_abap_unit_assert=>assert_equals( msg = '4' exp = abap_true act = world->get_state( x = 3 y = 3 ) ).
    cl_abap_unit_assert=>assert_equals( msg = '5' exp = abap_true act = world->get_state( x = 4 y = 2 ) ).

  ENDMETHOD.

  METHOD birth.
    DATA(world) = CAST zif_gol_world( NEW zcl_gol_world( ) ).
    world->set_state( x = 1 y = 3 state = abap_true ).
    world->set_state( x = 2 y = 3 state = abap_true ).
    world->set_state( x = 3 y = 3 state = abap_true ).
    DATA(cut) = NEW zcl_gol_main( i_settings = new zcl_gol_settings( i_width = 10 i_height = 10 ) i_world = world ).
    world = cut->main( ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg'
                                        exp = abap_true
                                        act = world->get_state( x = 2 y = 2 ) ).
  ENDMETHOD.

ENDCLASS.
