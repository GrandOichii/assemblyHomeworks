; task : разработать программу, решающую, €вл€ютс€ ли 4 введенных числа простыми

format PE console

entry start

include 'win32a.inc'
include 'macro.inc'


section '.data' data readable writable

        strEnterPrompt  db 'Enter num #%d: ', 0
        positiveResStr  db 'The four numbers are prime to each other I think', 10, 0
        negativeResStr  db 'The four numbers are not prime to each other I think', 10, 0
        digitIn         db '%d', 0

        firstNum        dd ?
        secondNum       dd ?
        thirdNum        dd ?
        fourthNum       dd ?
        result          dd 0
        NULL = 0


section '.code' code readable executable
        start:
                enterNum 1, firstNum
                enterNum 2, secondNum
                enterNum 3, thirdNum
                enterNum 4, fourthNum

                primeCompare firstNum, secondNum ; 1 & 2
                add [result], ebx
                primeCompare firstNum, thirdNum ; 1 & 3
                add [result], ebx
                primeCompare firstNum, fourthNum ; 1 & 4
                add [result], ebx
                primeCompare secondNum, thirdNum ; 2 & 3
                add [result], ebx
                primeCompare secondNum, fourthNum ; 2 & 4
                add [result], ebx
                primeCompare thirdNum, fourthNum ; 3 & 4
                add [result], ebx

                cmp ebx, 0
                je resultPositive
                jmp resultNegative

                resultPositive:
                        push positiveResStr
                        call [printf]
                        jmp endProg

                resultNegative:
                        push negativeResStr
                        call [printf]
                        jmp endProg


                endProg:
                        push [result]
                        push digitIn
                        call [printf]

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
