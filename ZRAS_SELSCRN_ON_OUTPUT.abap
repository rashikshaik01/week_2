*&---------------------------------------------------------------------*
*& Report ZRAS_SELSCRN_ON_OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_SELSCRN_ON_OUTPUT.

INCLUDE ZRAS_ATSLSCRN_TOP.

SELECT-OPTIONS S_MATNR FOR LV_MATNR DEFAULT '1' TO '1000'.

***BLOCK 1 FOR RADIO BUTTONS

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

  PARAMETERS : RAD1 RADIOBUTTON GROUP RAD USER-COMMAND FLAG DEFAULT 'X',
               RAD2 RADIOBUTTON GROUP RAD.

  SELECTION-SCREEN END OF BLOCK B1.

***BLOCK 2 FOR CHECKBOXES.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002.

  PARAMETERS : P_MBRSH TYPE MBRSH MODIF ID M1,
               P_MTART TYPE MTART MODIF ID M2.

  PARAMETERS : C1 AS CHECKBOX,
               C2 AS CHECKBOX DEFAULT 'X'.

  SELECTION-SCREEN END OF BLOCK B2.

AT SELECTION-SCREEN OUTPUT.

LOOP AT SCREEN.

  IF RAD1 = 'X' AND
    SCREEN-GROUP1 = 'M2'.
    SCREEN-ACTIVE = 0.
  ELSEIF RAD2 = 'X' AND
    SCREEN-GROUP1 = 'M1'.
    SCREEN-ACTIVE = 0.
    ENDIF.
    MODIFY SCREEN.
ENDLOOP.

START-OF-SELECTION.

IF RAD1 = 'X'.
  PERFORM GET_MATIND.
ELSE.
  PERFORM GET_MATTYPE.
ENDIF.
*&---------------------------------------------------------------------*
*& Form GET_MATIND

FORM get_matind .

SELECT MATNR MBRSH MTART MEINS
  INTO TABLE LT_TAB
  FROM MARA
  WHERE MATNR IN S_MATNR AND MBRSH EQ P_MBRSH.
  SORT LT_TAB BY MATNR.

  LOOP AT LT_TAB INTO WA_TAB.
    WRITE :/ WA_TAB-MATNR,
             WA_TAB-MBRSH,
             WA_TAB-MTART,
             WA_TAB-MEINS.
    ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_MATTYPE
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
FORM get_mattype .

SELECT MATNR MBRSH MTART MEINS
  INTO TABLE LT_TAB
  FROM MARA
  WHERE MATNR IN S_MATNR AND MTART EQ P_MTART.
  SORT LT_TAB BY MATNR.

  LOOP AT LT_TAB INTO WA_TAB.
    WRITE :/ WA_TAB-MATNR,
             WA_TAB-MBRSH,
             WA_TAB-MTART,
             WA_TAB-MEINS.
  ENDLOOP.

ENDFORM.