*$*--------------------------------------------------------------------*
*$* Copyright ©2021 PT Astragraphia ITechnology Group                  *
*$*--------------------------------------------------------------------*
*& Title       : [MII]Create Master Data Internal Order                *
*& Functional  : Ayu Bulan                                             *
*& Author      : Yulian Averil                                         *
*& Description : [MII]Create Master Data Internal Order                *
*&---------------------------------------------------------------------*
*& REVISION LOG                                                        *
*&                                                                     *
*&   #      DATE       AUTHOR       DESCRIPTION                        *
*& ----     ----       ------       -----------
*&####### 24.11.2022   ABAP-YAV     Initial coding                     *
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*
* Copy From ZANDFOP_SP_ULCIO for MII Implementation
REPORT zmiifop_c00001
       NO STANDARD PAGE HEADING
       LINE-SIZE 255
       LINE-COUNT 99
       MESSAGE-ID zabp.

*&---------------------------------------------------------------------*
*& INCLUDE
*&---------------------------------------------------------------------*
* Standard Include
INCLUDE zabpxin_form.
INCLUDE zabpxin_bdc.
INCLUDE zabpxin_udf.
* TOP Include
INCLUDE zmiifin_c00001_top.
* Program Include
INCLUDE zmiifin_c00001_f01.

*&---------------------------------------------------------------------*
*& INITIALIZATION
*&---------------------------------------------------------------------*
INITIALIZATION.
  PERFORM f_initialization.

*&---------------------------------------------------------------------*
*& TOP-OF-PAGE
*&---------------------------------------------------------------------*
TOP-OF-PAGE.
  PERFORM f_top_of_page.

*&---------------------------------------------------------------------*
*& END-OF-PAGE
*&---------------------------------------------------------------------*
END-OF-PAGE.
  PERFORM f_end_of_page.

*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM f_process_report.

*&---------------------------------------------------------------------*
*& END-OF-SELECTION
*&---------------------------------------------------------------------*
END-OF-SELECTION.

*&---------------------------------------------------------------------*
*& Events in Selection Screen
*&---------------------------------------------------------------------*
AT SELECTION-SCREEN.
* Value request for parameters
  macro_udf_f4_parameters p_finput.

* AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 = '77'.
      screen-input   = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

AT SELECTION-SCREEN ON p_finput.
* Check for parameters
  macro_udf_check_file_exist p_finput 'R'.

AT SELECTION-SCREEN ON p_output.
* Check for parameters
  macro_udf_check_file_exist p_output 'W'.


*&---------------------------------------------------------------------*
*&      Form  f_process_report
*&---------------------------------------------------------------------*
*       Processing Report
*----------------------------------------------------------------------*
FORM f_process_report.
  PERFORM f_init_data.
  PERFORM f_get_data.
  PERFORM f_batch_ko01.
  IF d_frm_subrc = 0.
    PERFORM f_write_data.
  ELSE.
    MESSAGE ID 'AQ' TYPE 'I' NUMBER '260'.
  ENDIF.
  macro_udf_download p_output 'DAT' t_report.
ENDFORM.                    " f_process_report
