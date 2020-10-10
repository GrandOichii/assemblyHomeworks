macro enterNum numberNum, number{
      push numberNum
      push strEnterPrompt
      call [printf]

      push number
      push digitIn
      call [scanf]
}
;---------------------------------------------------------------
macro primeCompare num1, num2{

      mov eax, [num1]
      mov ebx, [num2]

      ;mov [temp1], 128
      ;mov [temp2], 88



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

        ; eax -- num1
        ; ebx -- num2

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

}