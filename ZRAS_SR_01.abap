*&---------------------------------------------------------------------*

REPORT ZRAS_SR_01.

**1 CALL BY VALUE
*
*DATA A TYPE I VALUE 30.
*
*PERFORM SUB USING A.
*
*WRITE : / 'SUBROUTINE WITH CALL BY VALUE', A.
**&---------------------------------------------------------------------*
**& Form SUB
**&---------------------------------------------------------------------*
**&---------------------------------------------------------------------*
*FORM SUB USING VALUE(P_A).
*P_A = 50.
*ENDFORM.

*2  CALL BY REFERENCE

*DATA A TYPE I VALUE 20.
*
*PERFORM SUB_1 CHANGING A.
*
*WRITE : / 'SUBROUTINE WITH CALL BY REFERENCE', A.
**&---------------------------------------------------------------------*
**& Form SUB_1
*
**&---------------------------------------------------------------------*
*FORM sub_1 CHANGING p_a.
*P_A = 50.
*ENDFORM.


* 3  CALL BY VALUE AND RETURN

*DATA A TYPE I VALUE 20.
*
*PERFORM SUB_2 CHANGING A.
*
*WRITE : / 'SUBROUTINE WITH CALL BYVALUE AND RETURN', A.
**&---------------------------------------------------------------------*
**& Form SUB_2
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**&      <-- A
**&---------------------------------------------------------------------*
*FORM sub_2  CHANGING p_a.
*P_A = 50.
*ENDFORM.

*4 FOR INCLUDE

Include ZRAS_INCLUDESR_01.