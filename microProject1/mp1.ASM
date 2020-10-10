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
        temp1           dd ?
        temp2           dd ?
        tmpStack        dd ?
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

                cmp [result], 0
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
                        call [getch]
                        push NULL
                        call [ExitProcess]

;--------------------------------------------------
coprimeProc:
        mov [tmpStack], esp
        pop ebx
        pop eax
        primeLoop:
        ; the loop itself
        ;
        ; while (num1 >= num2)
        ; num1 -= num2;
        ; if (num1 == 0)
        ; return num2 == 1;
        ;
        ; while (num2 >= num1)
        ; num2 -= num1;
        ; if (num2 == 0)
        ; return num1 == 1;


        modLoop1:
                cmp eax, ebx
                jl endModLoop1
                sub eax, ebx
                jmp modLoop1

        endModLoop1:
                cmp eax, 0
                je endPrimeLoop1

        modLoop2:
                cmp ebx, eax
                jl endModLoop2
                sub ebx, eax
                jmp modLoop2

        endModLoop2:
                cmp ebx, 0
                je endPrimeLoop2


        jmp primeLoop

      endPrimeLoop1:
        cmp ebx, 1
        je endPrimeLoopNo
        jmp endPrimeLoopYes

      endPrimeLoop2:
        cmp eax, 1
        je endPrimeLoopNo
        jmp endPrimeLoopYes

      endPrimeLoopYes:
        mov ebx, 0
        jmp endPrime
      endPrimeLoopNo:
        mov ebx, 1
        jmp endPrime
      endPrime:
        mov esp, [tmpStack]
        ret


section 'idata' import data readable
        library kernel, 'kernel32.dll', \
                msvcrt, 'msvcrt.dll'
        import kernel, \
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf', \
               scanf, 'scanf', \
               getch, '_getch'
