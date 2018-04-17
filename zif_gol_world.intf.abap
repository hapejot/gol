INTERFACE zif_gol_world
  PUBLIC .
  TYPES:
    t_state TYPE c LENGTH 1,
    t_index TYPE i.
  CONSTANTS:
    c_alive TYPE t_state VALUE 'X',
    c_dead  TYPE t_state VALUE space.
  METHODS set_state
    IMPORTING
      x     TYPE t_index
      y     TYPE t_index
      state TYPE t_state.
  METHODS get_neighbours
    IMPORTING
      x              TYPE t_index
      y              TYPE t_index
    RETURNING
      VALUE(r_count) TYPE t_index.
  METHODS get_state
    IMPORTING
      x               TYPE t_index
      y               TYPE t_index
    RETURNING
      VALUE(r_result) TYPE t_state.
  METHODS clone
    RETURNING
      VALUE(r_result) TYPE REF TO zif_gol_world.

ENDINTERFACE.
