REPORT zlfa1_alv_demo.

TYPES: BEGIN OF ty_lfa1,
         lifnr TYPE lfa1-lifnr,
         name1 TYPE lfa1-name1,
         ort01 TYPE lfa1-ort01,
       END OF ty_lfa1.

DATA: gt_lfa1 TYPE TABLE OF ty_lfa1,
      go_alv  TYPE REF TO cl_salv_table.

START-OF-SELECTION.

  SELECT lifnr name1 ort01
    FROM lfa1
    INTO TABLE gt_lfa1.

  IF sy-subrc = 0.
    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = go_alv
          CHANGING
            t_table      = gt_lfa1 ).

        go_alv->get_functions( )->set_all( abap_true ).
        go_alv->display( ).

      CATCH cx_salv_msg INTO DATA(lx_msg).
        MESSAGE lx_msg->get_text( ) TYPE 'E'.
    ENDTRY.
  ELSE.
    MESSAGE 'No vendor data found in LFA1.' TYPE 'I'.
  ENDIF.
