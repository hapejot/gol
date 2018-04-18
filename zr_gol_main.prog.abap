*&---------------------------------------------------------------------*
*& Report zr_gol_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zr_gol_main.

DATA: go_container TYPE REF TO zcl_abapdi_container,
      go_display   TYPE REF TO zcl_gol_display,
      go_main      TYPE REF TO zcl_gol_main.

INITIALIZATION.
  CREATE OBJECT go_container.
  go_container->register( i_if = 'zif_gol_world' i_cl = 'zcl_gol_world' ).
  go_container->register( i_if = 'zcl_gol_main' i_single = abap_true ).
  go_container->register( i_if = 'zcl_gol_display' i_single = abap_true ).
  go_container->register( i_if = 'zcl_gol_settings' i_ob = NEW zcl_gol_settings( i_height = 50 i_width = 100 ) ).
  go_main ?= go_container->get_instance( 'zcl_gol_main' ).
  go_display ?= go_container->get_instance( 'zcl_gol_display' ).

START-OF-SELECTION.
  go_main->init_with_random( ).
  go_display->display( ).

AT USER-COMMAND.
  sy-lsind = sy-lsind - 1.
  go_display->display( ).
