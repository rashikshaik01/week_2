*&---------------------------------------------------------------------*
*& Report ZRAS_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_SELECTION_SCREEN NO STANDARD PAGE HEADING LINE-SIZE 350
MESSAGE-ID ZRAS_CLASS_MSG LINE-COUNT 25(3).

TYPES : BEGIN OF LS_TAB, "STRUCTURE DECALARTION
  MATNR TYPE MATNR,  " MATERIAL NUMBER
  MBRSH TYPE MBRSH, " MATERIAL INDUSTRY
  MTART TYPE MTART, " BASE UNIT OF MEASURE
  MEINS TYPE MEINS,
  BRGEW TYPE BRGEW, " GROSS WEIGHT
  NTGEW TYPE NTGEW,  "NET WEIGHT

  END OF LS_TAB.

  DATA : LT_TAB TYPE STANDARD TABLE OF LS_TAB, "INTERNAL TABLE
        WA_TAB TYPE LS_TAB.  " WORK AREA

  DATA LV_MATNR TYPE MATNR.

****BLOCK1

 SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

 SELECT-OPTIONS S_MATNR FOR WA_TAB-MATNR OBLIGATORY.

 SELECTION-SCREEN END OF BLOCK B1.

***BLOCK 2

 SELECTION-SCREEN : BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002.

PARAMETERS P_MTART TYPE MTART.

SELECTION-SCREEN END OF BLOCK B2.

***BLOCK 3 FOR RADIO BUTTONS

SELECTION-SCREEN : BEGIN OF BLOCK B3 WITH FRAME TITLE TEXT-003.

PARAMETERS : R1 RADIOBUTTON GROUP RAD1,
             R2 RADIOBUTTON GROUP RAD1 DEFAULT 'X',
             R3 RADIOBUTTON GROUP RAD1,

             R4 RADIOBUTTON GROUP RAD2,
             R5 RADIOBUTTON GROUP RAD2.

SELECTION-SCREEN END OF BLOCK B3.

***BLOCK 4 FOR CHECKBOXES

SELECTION-SCREEN : BEGIN OF BLOCK B4 WITH FRAME TITLE TEXT-004.

PARAMETERS : C1 AS CHECKBOX,
             C2 AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK B4.

INITIALIZATION.

CLEAR : WA_TAB, LT_TAB.

S_MATNR-LOW = '1'.
S_MATNR-HIGH = '1000'.
APPEND S_MATNR.


AT SELECTION-SCREEN ON S_MATNR.   "1 TO 100 DEFAULT INPUT AS WE INITIALIZED

  SELECT SINGLE MATNR
    INTO LV_MATNR
    FROM MARA
    WHERE MATNR IN S_MATNR.

    IF SY-SUBRC EQ 0.
      MESSAGE S000.
    ELSE.
      MESSAGE E001.
    ENDIF.


 START-OF-SELECTION.
    PERFORM GET_MATERIAL_DATA.

END-OF-SELECTION.
    PERFORM DISP_MATERIAL_DATA.

    DATA LV_COUNT TYPE I.
    LV_COUNT = SY-LINCT - SY-LINNO.
    SKIP LV_COUNT.

TOP-OF-PAGE.
    ULINE.
    WRITE :/ 'MATERIAL NO',
    20 'MATERIAL INDUSTRY',
    40 'MATERIAL TYPE',
    54 'UNIT OF MEASURE',
    75 'GROSS WEIGHT',
    99 'NET WEIGHT'.
    ULINE.

END-OF-PAGE.
    WRITE :/ 'CURRENT LIST PAGE NUMBER :', SY-PAGNO,
             'DATE : ' , SY-DATUM,
             'TIME : ' , SY-UZEIT.

*&---------------------------------------------------------------------*
*& Form GET_MATERIAL_DATA

FORM get_material_data .

SELECT MATNR MBRSH MTART MEINS BRGEW NTGEW
  INTO TABLE LT_TAB
  FROM MARA
  WHERE MATNR IN S_MATNR AND MTART EQ P_MTART.

  IF SY-SUBRC EQ 0.
    WRITE : / 'RECORDS ARE FOUND IN MARA TABLE'.
  ELSE.
    WRITE : / 'RECORDS ARE NOT FOUND IN MARA TABLE'.
  ENDIF.
ENDFORM.


*&---------------------------------------------------------------------*
*& Form DISP_MATERIAL_DATA

FORM disp_material_data .

LOOP AT LT_TAB INTO WA_TAB.
  WRITE : / WA_TAB-MATNR,
         20 WA_TAB-MBRSH,
         40 WA_TAB-MTART,
         54 WA_TAB-MEINS,
         72 WA_TAB-BRGEW,
         92 WA_TAB-NTGEW.
  ENDLOOP.

ENDFORM.