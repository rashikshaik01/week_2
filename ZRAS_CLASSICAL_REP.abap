*&---------------------------------------------------------------------*
*& Report ZRAS_CLASSICAL_REP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_CLASSICAL_REP NO STANDARD PAGE HEADING LINE-COUNT 20(3)
LINE-SIZE 350 MESSAGE-ID ZRAS_CLASS_MSG.

LOAD-OF-PROGRAM.

INCLUDE ZRAS_GETVBAP_TOP.

SELECT-OPTIONS S_VBELN FOR WA_TAB-VBELN OBLIGATORY.
INITIALIZATION.

CLEAR: WA_TAB, LT_TAB.

S_VBELN-LOW = '1'.
S_VBELN-HIGH = '100'.
APPEND S_VBELN.

AT SELECTION-SCREEN ON S_VBELN.   "1 TO 100

  SELECT SINGLE VBELN
    INTO LV_VBELN
    FROM VBAP
    WHERE VBELN IN S_VBELN.

IF SY-SUBRC EQ 0.
  MESSAGE S000.   " SE-91 TCODE
ELSE.
  MESSAGE E001.   " SE-91 TCODE

ENDIF.

START-OF-SELECTION.
   PERFORM GET_VBAP_DATA.

END-OF-SELECTION.
   PERFORM DISP_VBAP_DATA.

   DATA LV_COUNT TYPE I.
   LV_COUNT = SY-LINCT - SY-LINNO.
   SKIP LV_COUNT.

   TOP-OF-PAGE.
   ULINE.
   WRITE :/ 'SALES DOC',
          30 'MATERIAL NO',
          50 'MAT ENTERED',
          70 'ITEM CATEGORY',
          85 'SALES ORDER ITEM'.
   ULINE.

   END-OF-PAGE.
   WRITE :/ 'CURRENT LIST PAGE NO:' , SY-PAGNO,
            'DATE: ', SY-DATUM,
             'TIME: ', SY-UZEIT.

   FORM GET_VBAP_DATA.

     SELECT VBELN MATNR MATWA PSTYV ARKTX
       INTO TABLE LT_TAB
       FROM VBAP
       WHERE VBELN IN S_VBELN.

    IF SY-SUBRC EQ 0.
      WRITE :/ 'RECORDS ARE FOUND IN VBAP TABLE'.
    ELSE.
      WRITE :/ 'RECORDS ARE NOT FOUND IN VBAP TABLE'.
    ENDIF.

   ENDFORM.


   FORM DISP_VBAP_DATA.
     LOOP AT LT_TAB INTO WA_TAB.
       WRITE :/ WA_TAB-VBELN,
                30 WA_TAB-MATNR,
                50 WA_TAB-MATWA,
                70 WA_TAB-PSTYV,
                85 WA_TAB-ARKTX.
     ENDLOOP.
   ENDFORM.