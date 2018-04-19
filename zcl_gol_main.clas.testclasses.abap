*"* use this source file for your ABAP unit test classes
CLASS ltcl_gol DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: mo_container TYPE REF TO zcl_abapdi_container,
          cut          TYPE REF TO zcl_gol_main.
    METHODS main_four FOR TESTING RAISING cx_static_check.
    METHODS birth FOR TESTING RAISING cx_static_check.
    METHODS new_state_alive FOR TESTING RAISING cx_static_check.
    METHODS new_state_birth FOR TESTING RAISING cx_static_check.
    METHODS setup.

ENDCLASS.


CLASS ltcl_gol IMPLEMENTATION.

  METHOD setup.
    mo_container = NEW zcl_abapdi_container( ).
    mo_container->register( i_if = 'zif_gol_world' i_cl = 'zcl_gol_world' ).
    mo_container->register( i_if = 'zcl_gol_settings' i_ob = NEW zcl_gol_settings( i_width = 10 i_height = 10 ) ).
    cut ?= mo_container->get_instance( 'zcl_gol_main' ).
  ENDMETHOD.


  METHOD new_state_alive.

    cl_abap_unit_assert=>assert_equals( msg = 'msg'
                            exp = zif_gol_world=>c_alive
                            act = cut->calc_new_state(
                                                EXPORTING
                                                  neighbours = 2
                                                  state      = zif_gol_world=>c_alive
                                              ) ).

  ENDMETHOD.

  METHOD new_state_birth.

    cl_abap_unit_assert=>assert_equals( msg = 'msg'
                            exp = zif_gol_world=>c_alive
                            act = cut->calc_new_state(
                                                EXPORTING
                                                  neighbours = 3
                                                  state      = zif_gol_world=>c_dead
                                              ) ).

  ENDMETHOD.

  METHOD main_four.

    DATA(world) = cut->get_world( ).
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

    DATA(world) = cut->get_world( ).
    world->set_state( x = 1 y = 3 state = abap_true ).
    world->set_state( x = 2 y = 3 state = abap_true ).
    world->set_state( x = 3 y = 3 state = abap_true ).
    world = cut->main( ).

    cl_abap_unit_assert=>assert_equals( msg = 'msg'
                                        exp = abap_true
                                        act = world->get_state( x = 2 y = 2 ) ).
  ENDMETHOD.

ENDCLASS.
