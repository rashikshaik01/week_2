*&---------------------------------------------------------------------*
*& Report ZRAS_CLSREP_INNJOIN_STCR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_CLSREP_INNJOIN_STCR NO STANDARD PAGE HEADING LINE-COUNT 20(3)
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

START-OF-SELECTION.

PERFORM Z_RAS_GETJOIN_STCR.

PERFORM ZRAS_DISPLOOP.

IF SY-SUBRC EQ 0.
  MESSAGE S000(ZRAS_CLASS_MSG).
ELSE.
  MESSAGE E001(ZRAS_CLASS_MSG).
ENDIF.

END-OF-SELECTION.

TOP-OF-PAGE.
WRITE :/ 'STUD-ID',
      20 'STUD-NAME',
      35 'STUD-PHNO',
      52 'CITY',
      63 'COURSE-ID',
      73 'COURSE-NAME',
      95 'COURSE-PRICE',
      110 'COURSE ENROLLED'.

*&---------------------------------------------------------------------*
*& Form Z_RAS_GETJOIN_STCR
*&---------------------------------------------------------------------*

FORM z_ras_getjoin_stcr .
   SELECT ZRASSTUDENT~STU_ID ST_NAME ST_PHNO ORT01
          ZRASCOURSE~CR_ID CR_NAME CR_PRICE CR_ENR
     INTO TABLE LT_TAB FROM ZRASSTUDENT INNER JOIN ZRASCOURSE
     ON ZRASSTUDENT~STU_ID = ZRASCOURSE~STU_ID
     WHERE ZRASCOURSE~STU_ID IN S_STU_ID.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form ZRAS_DISPLOOP
*&---------------------------------------------------------------------*
FORM zras_disploop .
  LOOP AT LT_TAB INTO WA_TAB.
    WRITE :/ WA_TAB-STU_ID,
          20 WA_TAB-ST_NAME,
          35 WA_TAB-ST_PHNO,
          52 WA_TAB-ORT01,
          63 WA_TAB-CR_ID,
          73 WA_TAB-CR_NAME,
          95 WA_TAB-CR_PRICE,
          110 WA_TAB-CR_ENR.
    ENDLOOP.
ENDFORM.