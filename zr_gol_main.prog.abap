*&---------------------------------------------------------------------*
*& Report zr_gol_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zr_gol_main.

DATA: go_container TYPE REF TO zcl_abapdi_container,
      go_display   TYPE REF TO zif_gol_display.

INITIALIZATION.
  CREATE OBJECT go_container.
  go_container->register( i_if = 'zif_gol_world'    i_cl = 'zcl_gol_world' ).
  go_container->register( i_if = 'zcl_gol_main'                               i_single = abap_true ).
  go_container->register( i_if = 'zif_gol_display'  i_cl = 'zcl_gol_display'  i_single = abap_true ).
  go_container->register( i_if = 'zcl_gol_settings' i_ob = NEW zcl_gol_settings( i_height = 50 i_width = 100 ) ).

  go_display ?= go_container->get_instance( 'zif_gol_display' ).

START-OF-SELECTION.
  SET PF-STATUS 'MAIN'.
  go_display->start_of_selection( ).

AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
      go_display->at_user_command( ).
  ENDCASE.
