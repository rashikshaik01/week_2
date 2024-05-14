*&---------------------------------------------------------------------*
*& Report ZRAS_SELSCREEN_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_SELSCREEN_REPORT.

DATA lv_matnr TYPE matnr.   " FIELD NAME TYPE DATA ELEMENT

TYPES : BEGIN OF LS_TAB,   " local strs
          matnr TYPE matnr,
          mbrsh TYPE mbrsh,
          mtart TYPE mtart,
          meins TYPE meins,
          brgew TYPE brgew,
          ntgew TYPE ntgew,
        END OF LS_TAB .

DATA : it_tab TYPE STANDARD TABLE OF LS_TAB,  " INTERNAL TABLE
       wa_tab TYPE LS_TAB. " WORK AREA

SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

  SELECT-options s_matnr FOR lv_matnr OBLIGATORY .

SELECTION-SCREEN : END OF BLOCK B1.

SELECTION-SCREEN : BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002.

PARAMETERS P_MTART TYPE MTART OBLIGATORY.

SELECTION-SCREEN : END OF BLOCK B2.

SELECTION-SCREEN : BEGIN OF BLOCK B3 WITH FRAME TITLE TEXT-003.

PARAMETERS : R1 RADIOBUTTON GROUP RAD1,
             R2 RADIOBUTTON GROUP RAD1,
             R3 RADIOBUTTON GROUP RAD1 DEFAULT 'X'.

SELECTION-SCREEN ULINE /20(50).
SELECTION-SCREEN COMMENT /50(70) LV_COMNT.
SELECTION-SCREEN SKIP 3.
SELECTION-SCREEN ULINE.

SELECTION-SCREEN : END OF BLOCK B3.

INITIALIZATION.

LV_COMNT = 'UST Global Hyderabad'.

SELECTION-SCREEN : BEGIN OF BLOCK B4 WITH FRAME TITLE TEXT-004.

PARAMETERS : C1 AS CHECKBOX ,
             C2 AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN : END OF BLOCK B4.

LOOP AT s_matnr.
  ULINE.
WRITE : 'Mat Low :' , s_matnr-low,
        'Mat High :' , s_matnr-high,
        'Range Sign :' , s_matnr-sign,
        'Range Options :' , s_matnr-option.
ULINE.
  ENDLOOP.

start-OF-selection.
SELECT matnr mbrsh mtart meins brgew ntgew
FROM mara
INTO TABLE it_tab
WHERE matnr IN s_matnr AND
      MTART EQ P_MTART.

 END-OF-selection.
LOOP AT it_tab INTO wa_tab.  " B TO W
  WRITE :/10 wa_tab-matnr ,   "  58
  30 wa_tab-mbrsh,   " W-F
  40 wa_tab-mtart,
  55 wa_tab-meins,
  60 wa_tab-brgew,
  90 wa_tab-ntgew.
ENDLOOP.