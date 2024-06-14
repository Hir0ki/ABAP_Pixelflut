CLASS zcl_pixelflut_tcp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: constructor
      IMPORTING iv_ip_addressv4 TYPE char16
                iv_port         TYPE char5
      RAISING
                cx_apc_error.
    METHODS connect
      RAISING
        cx_apc_error.
    METHODS close
      RAISING
        cx_apc_error.
    METHODS send_commands
      IMPORTING it_commands TYPE zpixelflut_commands
      RAISING
        cx_apc_error.
    METHODS create_messages
      CHANGING ct_commands TYPE zpixelflut_commands
      RAISING
        cx_apc_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mcv_frame_terminator  TYPE string VALUE '0A'. " frame terminator bytes, e.g. line feed 0A
    DATA mo_client TYPE REF TO if_apc_wsp_client.
ENDCLASS.



CLASS zcl_pixelflut_tcp IMPLEMENTATION.
  METHOD constructor.
    DATA(lo_dummy_event_handler) = NEW lcl_dummy_apc_handler( ).
    DATA lv_frame TYPE apc_tcp_frame.

    lv_frame-frame_type = if_apc_tcp_frame_types=>co_frame_type_terminator. " frames are terminated with specific bytes
    lv_frame-terminator = mcv_frame_terminator. " frame termination bytes
    mo_client = cl_apc_tcp_client_manager=>create( i_protocol      = cl_apc_tcp_client_manager=>co_protocol_type_tcp
                                                   i_host          = CONV string( iv_ip_addressv4 )
                                                   i_port          = '1234'" CONV string( iv_port )
                                                   i_frame         = lv_frame
                                                   i_event_handler = lo_dummy_event_handler ).
  ENDMETHOD.

  METHOD close.
    mo_client->close(  ).
  ENDMETHOD.

  METHOD connect.
    mo_client->connect(  ).
  ENDMETHOD.

  METHOD send_commands.
    DATA: lo_message_manager TYPE REF TO if_apc_wsp_message_manager.

    lo_message_manager ?= mo_client->get_message_manager( ).

    loop at it_commands into data(ls_commands).
        lo_message_manager->send( i_message = ls_commands-message_object ).
    ENDLOOP.

  ENDMETHOD.

  METHOD create_messages.
    DATA: lo_message_manager TYPE REF TO if_apc_wsp_message_manager.
    DATA: lo_message         TYPE REF TO if_apc_wsp_message.

    lo_message_manager ?= mo_client->get_message_manager( ).
    DATA(lv_terminator) = CONV  xstring( mcv_frame_terminator ).
    LOOP AT ct_commands ASSIGNING FIELD-SYMBOL(<ls_command>).
      lo_message         ?= lo_message_manager->create_message( ).
      DATA(lv_binary_message) =  cl_abap_codepage=>convert_to( source = <ls_command>-command_string ).
      CONCATENATE lv_binary_message lv_terminator INTO lv_binary_message IN BYTE MODE.
      lo_message->set_binary( lv_binary_message ).
      <ls_command>-message_object = lo_message.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
