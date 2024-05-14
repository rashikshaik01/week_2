*&---------------------------------------------------------------------*
*& Report ZRAS_INT_REPO_ATLINE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_INT_REPO_ATLINE NO STANDARD PAGE HEADING LINE-COUNT 25(3)
LINE-SIZE 500 MESSAGE-ID ZRAS_CLASS_MSG.

DATA get_vbap_data.
LOAD-OF-PROGRAM.

INCLUDE ZRAS_INT_ATLINE_INC.

SELECT-OPTIONS S_VBELN FOR WA_TAB1-VBELN OBLIGATORY.

INITIALIZATION.
CLEAR : WA_TAB1, LT_TAB1.
S_VBELN-LOW = '1'.
S_VBELN-HIGH = '100'.

APPEND S_VBELN.

AT SELECTION-SCREEN ON S_VBELN.

SELECT SINGLE VBELN
  INTO LV_VBELN
  FROM VBAP
  WHERE VBELN IN S_VBELN.

  IF SY-SUBRC EQ 0.
    MESSAGE S000.
  ELSE.
    MESSAGE E001.
  ENDIF.

START-OF-SELECTION.
  PERFORM GET_VBAP_INT_DATA.

END-OF-SELECTION.
  PERFORM DISPLAY_VBAP_DATA.

 LV_COUNT = SY-LINCT - SY-LINNO.
 SKIP LV_COUNT.

 TOP-OF-PAGE.
 ULINE.
 WRITE :/ 'RECORDS ARE FOUND IN VBAP TABLE', 'THE CURRENT LIST INDEX IS :' , SY-LSIND.
 WRITE :/ 'SALES DOC',
       30 'MATERIAL NO',
       42 'MATERAIL ENT',
       57 'ITEM CATEGORY',
       75 'SALES ORDER ITEM'.
 ULINE.

 END-OF-PAGE.
 WRITE :/ 'CURRENT LIST PAGE NO:' , SY-PAGNO,
          'DATE:' , SY-DATUM,
          'TIME:', SY-UZEIT.

 AT LINE-SELECTION.

   CASE SY-LSIND.
     WHEN 1.

       SELECT VBELN ERDAT ERZET ERNAM ANGDT
         INTO TABLE LT_TAB2
         FROM VBAK
         WHERE VBELN EQ WA_TAB1-VBELN.

       LOOP AT LT_TAB2 INTO WA_TAB2.
         WRITE :/7 WA_TAB2-VBELN HOTSPOT,
                30 WA_TAB2-ERDAT,
                42 WA_TAB2-ERZET,
                56 WA_TAB2-ERNAM,
                75 WA_TAB2-ANGDT.

         HIDE WA_TAB2-VBELN.

       ENDLOOP.

      WHEN 2.

        SELECT VBELN UEPOS FKIMG VRKME MEINS
          INTO TABLE LT_TAB3
          FROM VBRP
          WHERE VBELN EQ WA_TAB2-VBELN.

       LOOP AT LT_TAB3 INTO WA_TAB3.
         WRITE :/7 WA_TAB3-VBELN,
                30 WA_TAB3-UEPOS,
                42 WA_TAB3-FKIMG,
                56 WA_TAB3-VRKME,
                75 WA_TAB3-MEINS.
       ENDLOOP.

    ENDCASE.

    TOP-OF-PAGE DURING LINE-SELECTION.

    CASE SY-LSIND.
      WHEN 1.
        WRITE :/ 'RECORDS ARE FOUND IN VBAK-HEADER TABLE', 'THE CURRENT LIST INDEX IS', SY-LSIND.
        ULINE.
        WRITE :/7 'SALES DOC',
               30 'MATERAIL NO',
               42 'MATERAIL ENT',
               56 'ITEM CATEGORY',
               75 'SALES ORDER ITEM'.
        ULINE.

      WHEN 2.
        WRITE :/ 'RECORDS ARE FOUND IN VBRP TABLE', 'THE CURENT LIST INDEX IS :', SY-LSIND.
        ULINE.
        WRITE:/7 'BILLING DOC',
              30 'HIGHER BILL',
              42 'ACTUAL QUAN',
              56 'SALES UNIT',
              75 'BASE UOM'.
        ULINE.
     ENDCASE.
*&---------------------------------------------------------------------*
*& Form GET_VBAP_INT_DATA
*&---------------------------------------------------------------------*
*& text---------*
FORM get_vbap_int_data .

 SELECT VBELN MATNR MATWA PSTYV ARKTX
   INTO TABLE LT_TAB1
   FROM VBAP
   WHERE VBELN IN S_VBELN.

   IF SY-SUBRC EQ 0.
     MESSAGE S000.
   ELSE.
     MESSAGE E001.
   ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_VBAP_DATA
*&---------------------------------------------------------------------*
*& text---------*
FORM display_vbap_data .
  LOOP AT LT_TAB1 INTO WA_TAB1.
    WRITE :/ WA_TAB1-VBELN,
          30 WA_TAB1-MATNR,
          42 WA_TAB1-MATWA,
          57 WA_TAB1-PSTYV,
          75 WA_TAB1-ARKTX.

    HIDE WA_TAB1-VBELN.
  ENDLOOP.
ENDFORM.