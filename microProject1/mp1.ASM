; task : разработать программу, решающую, €вл€ютс€ ли 4 введенных числа простыми

format PE console

entry start

include 'win32a.inc'
include 'macro.inc'


section '.data' data readable writable

        strEnterPrompt  db 'Enter num #%d: ', 0
        digitIn         db '%d', 0

        firstNum        dd ?
        secondNum       dd ?
        thirdNum        dd ?
        fourthNum       dd ?
        NULL = 0


section '.code' code readable executable
        start:
                enterNum 1, firstNum
                enterNum 2, secondNum
                enterNum 3, thirdNum
                enterNum 4, fourthNum

                call [getch]
                push NULL
                call [ExitProcess]


section 'idata' import data readable
        library kernel, 'kernel32.dll', \
                msvcrt, 'msvcrt.dll'
        import kernel, \
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf', \
               scanf, 'scanf', \
               getch, '_getch'
