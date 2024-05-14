*&---------------------------------------------------------------------*
*& Report ZRAS_ITAB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_ITAB.

TYPES : BEGIN OF LS_TAB,
  STU_ID TYPE ZID, "STUDENT ID
  ST_NAME TYPE ZST_NAME, "STUDENT NAME
  ST_PHNO TYPE ZST_PHNO, "PHONE NO
  ORT01 TYPE ORT01, "CITY
  END OF LS_TAB.

  DATA : LT_TAB TYPE STANDARD TABLE OF LS_TAB, "ITAB
        WA_TAB TYPE LS_TAB, "WORK AREA.
        LV_STU_ID TYPE ZID.

  SELECT-OPTIONS S_STU_ID FOR LV_STU_ID OBLIGATORY.

  PARAMETERS P_ORT01 TYPE ZRASSTUDENT-ORT01.

  START-OF-SELECTION.

  SELECT STU_ID ST_NAME ST_PHNO ORT01
    INTO TABLE LT_TAB
    FROM ZRASSTUDENT
    WHERE STU_ID IN S_STU_ID.

    IF SY-SUBRC EQ 0.
      WRITE : / 'RECORDS ARE FOUND IN STUDENT TABLE', SY-DBCNT.
    ELSE.
      WRITE : / 'RECORDS ARE NOT FOUND IN STUDENT TABLE', SY-DBCNT.
    ENDIF.
    SKIP 3.

    WRITE : / 'ROW NO',
         10 'STUDENT_ID',
         25 'STUD_NAME',
         38 'STUD_PHNO',
         55 'CITY'.
    ULINE.

    END-OF-SELECTION.

    FORMAT COLOR COL_POSITIVE.

    LOOP AT LT_TAB INTO WA_TAB.
    WRITE : / SY-TABIX,
          10 WA_TAB-STU_ID,
          25 WA_TAB-ST_NAME,
          38 WA_TAB-ST_PHNO,
          55 WA_TAB-ORT01.
    ENDLOOP.