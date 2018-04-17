*&---------------------------------------------------------------------*
*& Report zr_gol_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zr_gol_main.

DATA: go_container TYPE REF TO zcl_abapdi_container,
      go_display   TYPE REF TO zcl_gol_display,
      go_main      TYPE REF TO zcl_gol_main,
      go_world     TYPE REF TO zif_gol_world.

INITIALIZATION.
  CREATE OBJECT go_container.
  go_container->register( i_if = 'zif_gol_world' i_cl = 'zcl_gol_world' ).
  go_container->register( i_if = 'zcl_gol_settings' i_ob = new zcl_gol_settings( i_height = 50 i_width = 100 ) ).
  go_world ?= NEW zcl_gol_world( ).

go_main ?= go_container->get_instance( 'zcl_gol_main' ).
go_display ?= go_container->get_instance( 'zcl_gol_display' ).

START-OF-SELECTION.
  go_main->init_with_random( ).
  go_display->display( ).

AT USER-COMMAND.
  sy-lsind = sy-lsind - 1.
  go_display->display( ).
