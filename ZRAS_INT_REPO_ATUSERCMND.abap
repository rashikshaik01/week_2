*&---------------------------------------------------------------------*
*& Report ZRAS_INT_REPO_ATUSERCMND
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_INT_REPO_ATUSERCMND no standard page heading line-count 20(3)
line-size 500 message-id zras_class_msg.

load-of-program.

include ZRAS_ATUSERCMND_INC.

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

SET PF-STATUS 'ZRAS_PFS' EXCLUDING 'INFO'.

PERFORM GET_VBAP_DATA.

END-OF-SELECTION.
PERFORM DISP_VBAP_DATA.

DATA LV_COUNT TYPE I.
LV_COUNT = SY-LINCT - SY-LINNO.
SKIP LV_COUNT.

TOP-OF-PAGE.
 ULINE.
 WRITE :/ 'RECORDS ARE FOUND IN VBAP TABLE', 'THE CURRENT LIST INDEX IS :', SY-LSIND.
 WRITE :/ 'SALES DOCUMENT',
       30 'MATERIAL NO',
       42 'MATERIAL ENT',
       57 'ITEM CATEGORY',
       76 'SALES ORDER ITEM'.
 ULINE.
 END-OF-PAGE.
 WRITE :/ 'CURRENT LIST PAGENO : ',SY-PAGNO,
          'DATE:' , SY-DATUM,
          'TIME:', SY-UZEIT.

AT USER-COMMAND.

  CASE SY-UCOMM.
    WHEN 'DISP'.
      WRITE 'DISPLAY INFO'.
    WHEN 'INFO'.
      WRITE /: 'THE CURRENT DATE:', SY-DATUM,
               'TIMEL', SY-UZEIT.

    WHEN 'TCODE'.
      CALL TRANSACTION 'ZRAS_VBAP_TCODE'.

    WHEN 'WELCOME TO SAP'.
      WRITE 'SAP  UST GLOBAL'.

    WHEN 'ABAP'.
      WRITE 'SAP ABAP HYD'.
   ENDCASE.

*&---------------------------------------------------------------------*
*& Form GET_VBAP_DATA
*&---------------------------------------------------------------------*
*& text---------------*
FORM get_vbap_data .

SELECT VBELN MATNR MATWA PSTYV ARKTX
  INTO TABLE LT_TAB1
  FROM VBAP
  WHERE VBELN IN S_VBELN.

  IF SY-SUBRC EQ 0.
    WRITE :/ 'RECORDS ARE FOUND IN VBAP TABLE'.
   ELSE.
     WRITE :/ 'RECORDS ARE NOT FOUND IN TABLE'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISP_VBAP_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM disp_vbap_data .
 LOOP AT LT_TAB1 INTO WA_TAB1.
   WRITE :/ WA_TAB1-VBELN HOTSPOT,
         30 WA_TAB1-MATNR,
         42 WA_TAB1-MATWA,
         57 WA_TAB1-PSTYV,
         76 WA_TAB1-ARKTX.

   HIDE WA_TAB1-VBELN.
 ENDLOOP.

ENDFORM.