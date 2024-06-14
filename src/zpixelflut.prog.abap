*&---------------------------------------------------------------------*
*& Report ZPIXELFLUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPIXELFLUT.


" [ ] Image loading (Hard Coded SAP Icon (or some other stuff)
" [ ] Convert image into pre-made messages
" [ ] Create class for sending pre made messages


data(lt_commands) = value zpixelflut_commands(
                                                ( command_string = 'PX 20 20 ff0000' )
                                                ( command_string = 'PX 21 21 ff0000' )
                                                ( command_string = 'PX 22 22 ff0000' )
                                                ( command_string = 'PX 23 23 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ( command_string = 'PX 21 24 ff0000' )
                                                ).
                                                data(lo_tcp) = new zcl_pixelflut_tcp( iv_ip_addressv4 = '172.17.0.1'
                                                                                      iv_port = '1234' ).

                                               lo_tcp->connect(  ).
                                               do 10000 times.
                                               lo_tcp->create_messages( CHANGING ct_commands = lt_commands ).
                                               lo_tcp->send_commands( it_commands = lt_commands ).
                                               ENDDO.
                                               lo_tcp->close(  ).
                                               write: 'Done'.
