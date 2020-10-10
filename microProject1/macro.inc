macro enterNum numberNum, number{
      push numberNum            ; print the user prompt
      push strEnterPrompt
      call [printf]

      push number
      push digitIn
      call [scanf]
}
;---------------------------------------------------------------
macro primeCompare num1, num2{
      push [num1]               ; push the 2 values to the stack, then figures out if they are coprime
      push [num2]
      call coprimeProc
}