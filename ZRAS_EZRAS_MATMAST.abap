*&---------------------------------------------------------------------*
*& Report ZRAS_EZRAS_MATMAST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRAS_EZRAS_MATMAST.

PARAMETERS P_MATNR TYPE MATNR.

CALL FUNCTION 'ENQUEUE_EZRAS_MATMAST'
EXPORTING
MODE_MARA            = 'E'
  MANDT                = SY-MANDT
  MATNR                = P_MATNR
*   X_MATNR              = ' '
*   _SCOPE               = '2'
*   _WAIT                = ' '
*   _COLLECT             = ' '
* EXCEPTIONS
*   FOREIGN_LOCK         = 1
*   SYSTEM_FAILURE       = 2
*   OTHERS               = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

BREAK-POINT.

CALL FUNCTION 'DEQUEUE_EZRAS_MATMAST'
EXPORTING
MODE_MARA       = 'E'
MANDT           = SY-MANDT
MATNR           = P_MATNR
*   X_MATNR         = ' '
*   _SCOPE          = '3'
*   _SYNCHRON       = ' '
*   _COLLECT        = ' '
          .