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
      push [num1]
      push [num2]
      call coprimeProc
}