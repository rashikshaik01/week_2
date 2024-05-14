*&---------------------------------------------------------------------*
*& Report ZRAS_ITAB_PROGRAMS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_ITAB_PROGRAMS NO STANDARD PAGE HEADING.

**INTERNAL TABLE
**DATA: BEGIN OF LINE,  " field string
* col_1(10) TYPE C,
* col_2(20) TYPE C,
*END OF LINE.
*
*DATA itab LIKE TABLE OF LINE.
*
*LINE-col_1  =  'UST'.
*LINE-col_2  =  'TECHNOLOGIES'.
*APPEND LINE TO itab.
*CLEAR line.
*
*REFRESH itab.
*IF itab IS INITIAL.
*  WRITE 'INTERNAL TABLE IS EMPTY'.
*  FREE itab.
*ENDIF.

***INSERT PROGRAM

*DATA: BEGIN OF LINE,   " FIELD STRNG
*  name(20) TYPE C ,
*  age TYPE I ,
*  weight   TYPE p DECIMALS 2,
*  land(5)  TYPE C,
*END OF LINE.
*
**TYPES: BEGIN OF LINE,   " LOCAL STRS
**  name(20) TYPE C ,
**  age TYPE I,
**  weight   TYPE p DECIMALS 2,
**  land(5)  TYPE C ,
**END OF LINE.
*
*DATA itab LIKE SORTED TABLE OF LINE  WITH NON-UNIQUE KEY name age weight land.
**DATA itab LIKE STANDARD TABLE OF LINE  WITH NON-UNIQUE KEY name age weight land.
*
*LINE-name   = 'JOHAN'.
*LINE-age  = 35.
*LINE-weight = '80.00'.
*LINE-land = 'IND'.
*INSERT LINE INTO TABLE itab.
*
*
*LINE-name   = 'PETER'.
*LINE-age  = 35.
*LINE-weight = '45.00'.
*LINE-land = 'USA'.
*INSERT LINE INTO TABLE itab.
*
*LINE-name   = 'DAVID'.
*LINE-age  = 40.
*LINE-weight = '95.00'.
*LINE-land = 'DE'.
*INSERT LINE INTO TABLE itab.
*
**sort itab by name .
*
*
*LOOP AT itab INTO LINE.  " itab to fld
*  WRITE: / LINE-name, LINE-age, LINE-weight, LINE-land.
*ENDLOOP.

* #3 INSERT LINE

*DATA : BEGIN OF LINE,  " fld strng
*  col_1 TYPE I,
*  col_2 TYPE I,
*END OF LINE.
*
*DATA itab LIKE TABLE OF LINE.
*
*
*DO 2 TIMES.
*  LINE-col_1 = sy-INDEX.
*  LINE-col_2 = sy-INDEX ** 2.
*  APPEND LINE TO itab.
*ENDDO.
*
*LOOP  AT itab INTO LINE.
*  LINE-col_1 = 3 * sy-tabix.
*  LINE-col_2 = 5 * sy-tabix.
*  INSERT LINE INTO itab.
*ENDLOOP.
*LOOP AT itab INTO LINE.
*  WRITE: / sy-tabix, LINE-col_1, LINE-col_2.
*ENDLOOP.


*Modify

*DATA: BEGIN OF LINE,
*  col1 TYPE I,
*  col2 TYPE I,
*END OF LINE.
*
*DATA itab LIKE TABLE OF LINE.
*
*DO 3 TIMES.
*  LINE-col1 = sy-INDEX.
*  LINE-col2 = sy-INDEX ** 2.
*  APPEND LINE TO itab.
*ENDDO.
*
*LOOP AT itab INTO LINE.
*  IF sy-tabix = 2.
*    LINE-col1 = sy-tabix  *  10.
*    LINE-col2 = ( sy-tabix  * 10 ) ** 2.
*    MODIFY itab FROM LINE.
*  ENDIF.
*ENDLOOP.
*LOOP AT itab INTO LINE.
*  WRITE: / sy-tabix, LINE-col1, LINE-col2.
*ENDLOOP.
*

*DELETE
*
*DATA: BEGIN OF LINE,
*  col1 TYPE I,
*  col2 TYPE I,
*END OF LINE.
*DATA itab LIKE HASHED TABLE OF LINE WITH UNIQUE key col1.
*
*DO 4 TIMES.
*  LINE-col1 = sy-INDEX.
*  LINE-col2 = sy-INDEX ** 2.
*  INSERT LINE INTO TABLE itab.
*ENDDO.
*LINE-col1 = 1.
*DELETE TABLE itab: FROM LINE,
*WITH TABLE KEY col1 = 3.
*
*LOOP AT itab INTO LINE.
*  WRITE: / LINE-col1, LINE-col2.
*ENDLOOP.

*
*COLLECT
*
*DATA: BEGIN OF LINE,
*  col_1(3) TYPE C,
*  col_2(2) TYPE n,
*  col_3    TYPE I,
*END OF LINE.
*
*DATA itab LIKE SORTED TABLE OF LINE
*      WITH NON-UNIQUE KEY col_1  col_2.
*
*LINE-col_1 = 'UST'.
*LINE-col_2 = '12'.
*LINE-col_3 = 3.
*
*COLLECT LINE INTO itab.
*WRITE / sy-tabix.
*
*
*LINE-col_1 = 'TECH'.
*LINE-col_2 = '34'.
*LINE-col_3 = 5.
*COLLECT LINE INTO itab.
*WRITE / sy-tabix.
*
*
*LINE-col_1 = 'UST'.
*LINE-col_2 = '22'.
*LINE-col_3 = 7.
*COLLECT LINE INTO itab.
*
*WRITE / sy-tabix.
*LOOP AT itab INTO LINE.
*  WRITE: / LINE-col_1, LINE-col_2, LINE-col_3.
*ENDLOOP.

*Data Types

**--------------------------------------------------------------*
*TYPES: BEGIN OF ty_student,
*  ID(5)    TYPE n,
*  name(10) TYPE C,
*END OF ty_student.
*
*
**READ + INDEX + KEY
**--------------------------------------------------------------*
**Data Declaration
**--------------------------------------------------------------*
*DATA: gwa_student TYPE ty_student.
*DATA: it TYPE TABLE OF ty_student.
*
*gwa_student-ID    = 1.
*gwa_student-name  = 'JOHN'.
*APPEND gwa_student TO it.
*
*gwa_student-ID    = 2.
*gwa_student-name  = 'JIM'.
*APPEND gwa_student TO it.
*
*gwa_student-ID    = 3.
*gwa_student-name  = 'JACK'.
*APPEND gwa_student TO it.
*
*SORT IT BY ID.
*** # 1
**READ TABLE it INTO gwa_student INDEX 1.
**
**IF sy-subrc = 0.
**  WRITE: gwa_student-ID, gwa_student-name.
**ELSE.
**  WRITE 'No Record Found'.
**ENDIF.
*
*
*
******* # 2
*READ TABLE it INTO gwa_student WITH KEY name = 'JACK'.
*IF sy-subrc = 0.
*  WRITE: gwa_student-ID, gwa_student-name.
*ELSE.
*  WRITE 'No Record Found'.
*ENDIF.


***FIELD-SYMBOLS  &C

********* # 1
*DATA : F1(20) TYPE C.
*
*FIELD-SYMBOLS <FS_UST>.
*
*F1 = 'UST TECH'.
*
*ASSIGN F1 TO <FS_UST>.
*
*WRITE : <FS_UST>.

*----------------------------------
* # 2
*----------------------------------
data: begin of line,  " field string
        col_1 type i,
        col_2 type i,
      end of line.

data itab like sorted table of line with unique key col_1.

field-symbols <fs> like line of itab.


do 10 times.
  line-col_1   =   sy-index.
  line-col_2   =   2   *   sy-index.
  append line to itab.
enddo.

LOOP AT itab INTO LINE  .  " itab to fld
  WRITE: / LINE-col_1, LINE-col_2.  " LINE-weight, LINE-land.
ENDLOOP.
*
****READ TABLE
*
read table itab assigning <fs> index 5.
CLEAR <fs>.
write:   sy-subrc, sy-tabix.
write: / <fs>-col_1, <fs>-col_2.