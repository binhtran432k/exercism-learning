       IDENTIFICATION DIVISION.
       PROGRAM-ID. LEAP.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-YEAR PIC 9(4).
       01 WS-RESULT PIC 9.
       PROCEDURE DIVISION.
       ACCEPT WS-YEAR.
       LEAP.
       IF function mod(WS-YEAR, 4) IS EQUAL 0
              AND (function mod(WS-YEAR, 100) IS NOT EQUAL 0
              OR function mod(WS-YEAR, 400) IS EQUAL 0) THEN
           MOVE 1 TO WS-RESULT
       ELSE
           MOVE 0 TO WS-RESULT
       END-IF.
       LEAP-EXIT.
           EXIT.
