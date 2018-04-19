CLASS zcl_gol_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES: zif_gol_world.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF ts_state_line,
        x TYPE i,
        y TYPE i,
      END OF ts_state_line.
    TYPES:
             ltt_state TYPE SORTED TABLE OF ts_state_line WITH UNIQUE KEY y x.
    DATA: mt_state TYPE ltt_state.
ENDCLASS.



CLASS ZCL_GOL_WORLD IMPLEMENTATION.


  METHOD zif_gol_world~clone.

    "    r_result = CAST zif_gol_world( me->if_os_clone~clone( ) ).
    SYSTEM-CALL OBJMGR CLONE me TO r_result.

  ENDMETHOD.


  METHOD zif_gol_world~get_neighbours.
    DATA: ls_state LIKE LINE OF mt_state.
    DATA(x_0) = x - 1.
    DATA(x_1) = x + 1.
    DATA(y_0) = y - 1.
    DATA(y_1) = y + 1.
    LOOP AT mt_state INTO ls_state.
      IF ls_state-y > y_1. EXIT. ENDIF.
      IF ls_state-x BETWEEN x_0 AND x_1
          AND ls_state-y BETWEEN y_0 AND y_1
          AND ( ls_state-x <> x OR ls_state-y <> y ).
        ADD 1 TO r_count.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD zif_gol_world~get_state.

    r_result = COND #(  WHEN line_exists( mt_state[ x = x y = y ] )
                        THEN zif_gol_world=>c_alive
                        ELSE zif_gol_world=>c_dead ).

  ENDMETHOD.


  METHOD zif_gol_world~set_state.

    DATA(l_index) = line_index( mt_state[ x = x y = y ] ).
    IF l_index > 0 AND state = zif_gol_world=>c_dead.
      DELETE mt_state INDEX l_index.
    ELSEIF l_index = 0 AND state = zif_gol_world=>c_alive.
      INSERT  VALUE #(  x = x y = y ) INTO TABLE mt_state.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
