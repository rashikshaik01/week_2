*&---------------------------------------------------------------------*
*& Report ZRAS_INTERACTIVE_REPO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_INTERACTIVE_REPO NO STANDARD PAGE HEADING LINE-COUNT 20(3)
LINE-SIZE 350 MESSAGE-ID ZRAS_CLASS_MSG.

LOAD-OF-PROGRAM.

INCLUDE ZRAS_INNRJOIN_STCR.

SELECT-OPTIONS S_STU_ID FOR WA_TAB-STU_ID OBLIGATORY.

INITIALIZATION.

"CLEAR : WA_TAB, LT_TAB.

S_STU_ID-LOW = '101'.
S_STU_ID-HIGH = '105'.
APPEND S_STU_ID.

AT SELECTION-SCREEN ON S_STU_ID.

SELECT SINGLE STU_ID
  INTO LV_STU_ID
  FROM ZRASSTUDENT
  WHERE STU_ID IN S_STU_ID.

IF SY-SUBRC EQ 0.
  MESSAGE S000(ZRAS_CLASS_MSG).
ELSE.
  MESSAGE E001(ZRAS_CLASS_MSG).
ENDIF.

START-OF-SELECTION.
PERFORM Z_RAS_GETJOIN_STCR.

END-OF-SELECTION.
PERFORM ZRAS_DISPLOOP.

DATA LV_COUNT TYPE I.
LV_COUNT = SY-LINCT - SY-LINNO.
SKIP LV_COUNT.

TOP-OF-PAGE.
ULINE.
WRITE : / 'RECORDS ARE FOUND IN ZRASSTUDENT',
          'THE CURRENT LIST INDEX IS :', SY-LSIND.
WRITE :/ 'STUD-ID',
      20 'STUD-NAME',
      35 'STUD-PHNO',
      52 'CITY'.
ULINE.

END-OF-PAGE.
WRITE :/ 'CURRENT LIST PAGE NO:', SY-PAGNO,
         'DATE: ', SY-DATUM,
         'TIME: ', SY-UZEIT.

AT LINE-SELECTION.

  CASE SY-LSIND.
    WHEN 1.
      SELECT STU_ID CR_ID CR_NAME CR_PRICE CR_ENR
        INTO TABLE LT_TAB2
        FROM ZRASCOURSE
        WHERE STU_ID EQ WA_TAB-STU_ID.

        loop at lt_tab2 INTO wa_tab2.
      WRITE : / wa_tab2-STU_ID HOTSPOT,
               30 wa_tab2-CR_ID,
               40 wa_tab2-CR_NAME,
               55 wa_tab2-CR_PRICE,
               70 WA_TAB2-CR_ENR.

      hide   wa_tab2-STU_ID.

      ENDLOOP.

      ENDCASE.

TOP-OF-PAGE DURING LINE-SELECTION.

CASE SY-LSIND.
  WHEN 1.
    WRITE :/ 'THE CURRENT LIST INDEX IS : ', SY-LSIND.
    ULINE.
    WRITE : 'STUD_ID',
    20'COURSE-ID',
      30 'COURSE-NAME',
      40 'COURSE-PRICE',
      55 'COURSE ENROLLED'.
    ULINE.
    ENDCASE.
*&---------------------------------------------------------------------*
*& Form Z_RAS_GETJOIN_STCR
*&---------------------------------------------------------------------*

FORM z_ras_getjoin_stcr .
   SELECT ZRASSTUDENT~STU_ID ST_NAME ST_PHNO ORT01
     INTO TABLE LT_TAB
     FROM ZRASSTUDENT
     WHERE STU_ID IN S_STU_ID.

   IF SY-SUBRC EQ 0.
     WRITE :/ 'RECORDS ARE FOUND IN ZRASSTUDENT TABLE'.
   ELSE.
     WRITE :/ 'RECORDS ARE NOT FOUND IN ZRASSTUDENT TABLE'.
   ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form ZRAS_DISPLOOP
*&---------------------------------------------------------------------*
FORM zras_disploop .
  LOOP AT LT_TAB INTO WA_TAB.
    WRITE :/ WA_TAB-STU_ID HOTSPOT,
          20 WA_TAB-ST_NAME,
          35 WA_TAB-ST_PHNO,
          47 WA_TAB-ORT01.

    HIDE WA_TAB-STU_ID.
    ENDLOOP.
ENDFORM.