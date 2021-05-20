SELECT * FROM KI.User_Input A
LEFT JOIN KI.Final_Questionnaire B
ON A.Session = B.Session
LEFT JOIN KI.Consent C
ON C.Session = A.Session;