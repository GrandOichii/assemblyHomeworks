macro enterNum numberNum, number{
      push numberNum
      push strEnterPrompt
      call [printf]

      push number
      push digitIn
      call [scanf]
}