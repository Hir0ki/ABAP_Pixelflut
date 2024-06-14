*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_dummy_apc_handler DEFINITION
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_apc_wsp_event_handler.
    DATA      : m_message TYPE string.
ENDCLASS.

CLASS lcl_dummy_apc_handler IMPLEMENTATION.

  METHOD if_apc_wsp_event_handler~on_close.

  ENDMETHOD.

  METHOD if_apc_wsp_event_handler~on_error.

  ENDMETHOD.

  METHOD if_apc_wsp_event_handler~on_message.

  ENDMETHOD.

  METHOD if_apc_wsp_event_handler~on_open.

  ENDMETHOD.

ENDCLASS.
