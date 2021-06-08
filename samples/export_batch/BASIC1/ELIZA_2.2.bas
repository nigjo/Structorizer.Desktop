Rem Concept and lisp implementation published by Joseph Weizenbaum (MIT): 
Rem "ELIZA - A Computer Program For the Study of Natural Language Communication Between Man and Machine" - In: 
Rem Computational Linguistis 1(1966)9, pp. 36-45 
Rem Revision history: 
Rem 2016-10-06 Initial version 
Rem 2017-03-29 Two diagrams updated (comments translated to English) 
Rem 2017-03-29 More keywords and replies added 
Rem 2019-03-14 Replies and mapping reorganised for easier maintenance 
Rem 2019-03-15 key map joined from keyword array and index map 
Rem 2019-03-28 Keyword "bot" inserted (same reply ring as "computer") 
Rem Generated by Structorizer 3.31-04 

Rem Copyright (C) 2018-05-14 ??? 
Rem License: GPLv3-link 
Rem GNU General Public License (V 3) 
Rem https://www.gnu.org/licenses/gpl.html 
Rem http://www.gnu.de/documents/gpl.de.html 

Rem  
Rem program ELIZA
Rem TODO: Check and accomplish your variable declarations here: 
Dim varPart As String
Dim userInput As String
Dim replyRing() As String
Dim reply As String
Dim replies()() As String
Dim reflexions()() As String
Dim posAster As Integer
Dim offsets() As Integer
Dim keyMap() As KeyMapEntry
Dim keyIndex As Integer
Dim isRepeated As boolean
Dim isGone As boolean
Dim history() As ???
Dim findInfo() As integer
Dim entry As KeyMapEntry
Dim byePhrases()() As String
Rem  
Rem Title information 
PRINT "************* ELIZA **************"
PRINT "* Original design by J. Weizenbaum"
PRINT "**********************************"
PRINT "* Adapted for Basic on IBM PC by"
PRINT "* - Patricia Danielson"
PRINT "* - Paul Hashfield"
PRINT "**********************************"
PRINT "* Adapted for Structorizer by"
PRINT "* - Kay Gürtzig / FH Erfurt 2016"
PRINT "* Version: 2.2 (2019-03-28)"
PRINT "**********************************"
Rem Stores the last five inputs of the user in a ring buffer, 
Rem the first element is the current insertion index 
Let history = Array(0, "", "", "", "", "")
const replies = setupReplies()
const reflexions = setupReflexions()
const byePhrases = setupGoodByePhrases()
const keyMap = setupKeywords()
offsets(length(keyMap)-1) = 0
isGone = false
Rem Starter 
PRINT "Hi! I\'m your new therapist. My name is Eliza. What\'s your problem?"
Do
  INPUT userInput
  Rem Converts the input to lowercase, cuts out interpunctation 
  Rem and pads the string 
  userInput = normalizeInput(userInput)
  isGone = checkGoodBye(userInput, byePhrases)
  If NOT isGone Then
    reply = "Please don\'t repeat yourself!"
    isRepeated = checkRepetition(history, userInput)
    If NOT isRepeated Then
      findInfo = findKeyword(keyMap, userInput)
      keyIndex = findInfo(0)
      If keyIndex < 0 Then
        Rem Should never happen... 
        keyIndex = length(keyMap)-1
      End If
      var entry: KeyMapEntry = keyMap(keyIndex)
      Rem Variable part of the reply 
      varPart = ""
      If length(entry.keyword) > 0 Then
        varPart = conjugateStrings(userInput, entry.keyword, findInfo(1), reflexions)
      End If
      replyRing = replies(entry.index)
      reply = replyRing(offsets(keyIndex))
      offsets(keyIndex) = (offsets(keyIndex) + 1) % length(replyRing)
      posAster = pos("*", reply)
      If posAster > 0 Then
        If varPart = " " Then
          reply = "You will have to elaborate more for me to help you."
        Else
          delete(reply, posAster, 1)
          insert(varPart, reply, posAster)
        End If
      End If
      reply = adjustSpelling(reply)
    End If
    PRINT reply
  End If
Loop Until isGone
End
Rem  
Rem Cares for correct letter case among others 
Rem TODO: Check (and specify if needed) the argument and result types! 
Function adjustSpelling(sentence AS String) As String
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim word As String
  Dim start As String
  Dim result As String
  Dim position As Integer
  Rem  
  result = sentence
  position = 1
  Do While (position <= length(sentence)) AND (copy(sentence, position, 1) = " ")
    position = position + 1
  Loop
  If position <= length(sentence) Then
    start = copy(sentence, 1, position)
    delete(result, 1, position)
    insert(uppercase(start), result, 1)
  End If
  Dim arrayb060476a() As String = {" i ", " i\'"}
  For Each word In arrayb060476a
    position = pos(word, result)
    Do While position > 0
      delete(result, position+1, 1)
      insert("I", result, position+1)
      position = pos(word, result)
    Loop
  Next word
  Return result
End Function
Rem  
Rem Checks whether the given text contains some kind of 
Rem good-bye phrase inducing the end of the conversation 
Rem and if so writes a correspding good-bye message and 
Rem returns true, otherwise false 
Rem TODO: Check (and specify if needed) the argument and result types! 
Function checkGoodBye(text AS String, phrases AS array of array[0..1] of string) As boolean
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim saidBye As boolean
  Dim pair() As String
  Rem  
  For Each pair In phrases
    If pos(pair(0), text) > 0 Then
      saidBye = true
      PRINT pair(1)
      Return true
    End If
  Next pair
  return false
End Function
Rem  
Rem Checks whether newInput has occurred among the last 
Rem length(history) - 1 input strings and updates the history 
Rem TODO: Check (and specify if needed) the argument and result types! 
Function checkRepetition(history AS array, newInput AS String) As boolean
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim i As Integer
  Dim hasOccurred As boolean
  Dim currentIndex As ???
  Rem  
  hasOccurred = false
  If length(newInput) > 4 Then
    currentIndex = history(0);
    For i = 1 To length(history)-1
      If newInput = history(i) Then
        hasOccurred = true
      End If
    Next i
    history(history(0)+1) = newInput
    history(0) = (history(0) + 1) % (length(history) - 1)
  End If
  return hasOccurred
End Function
Rem  
Rem TODO: Check (and specify if needed) the argument and result types! 
Function conjugateStrings(sentence AS String, key AS String, keyPos AS integer, flexions AS array of array[0..1] of string) As String
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim right As String
  Dim result As String
  Dim position As Integer
  Dim pair() As String
  Dim left As String
  Rem  
  result = " " + copy(sentence, keyPos + length(key), length(sentence)) + " "
  For Each pair In flexions
    left = ""
    right = result
    position = pos(pair(0), right)
    Do While position > 0
      left = left + copy(right, 1, position-1) + pair(1)
      right = copy(right, position + length(pair(0)), length(right))
      position = pos(pair(0), right)
    Loop
    result = left + right
  Next pair
  Rem Eliminate multiple spaces 
  position = pos("  ", result)
  Do While position > 0
    result = copy(result, 1, position-1) + copy(result, position+1, length(result))
    position = pos("  ", result)
  Loop
  Return result
End Function
Rem  
Rem Looks for the occurrence of the first of the strings 
Rem contained in keywords within the given sentence (in 
Rem array order). 
Rem Returns an array of 
Rem 0: the index of the first identified keyword (if any, otherwise -1), 
Rem 1: the position inside sentence (0 if not found) 
Rem TODO: Check (and specify if needed) the argument and result types! 
Function findKeyword(keyMap AS const array of KeyMapEntry, sentence AS String) As array[0..1] of integer
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim result() As Integer
  Dim position As Integer
  Dim i As Integer
  Dim entry As KeyMapEntry
  Rem  
  Rem Contains the index of the keyword and its position in sentence 
  Let result = Array(-1, 0)
  i = 0
  Do While (result(0) < 0) AND (i < length(keyMap))
    var entry: KeyMapEntry = keyMap(i)
    position = pos(entry.keyword, sentence)
    If position > 0 Then
      result(0) = i
      result(1) = position
    End If
    i = i+1
  Loop
  Return result
End Function
Rem  
Rem Converts the sentence to lowercase, eliminates all 
Rem interpunction (i.e. ',', '.', ';'), and pads the 
Rem sentence among blanks 
Rem TODO: Check (and specify if needed) the argument and result types! 
Function normalizeInput(sentence AS String) As String
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim symbol As char
  Dim result As String
  Dim position As Integer
  Rem  
  sentence = lowercase(sentence)
  Rem TODO: Specify an appropriate element type for the array! 
  Dim arraya6106d42() As FIXME_a6106d42 = {'.', ',', ';', '!', '?'}
  For Each symbol In arraya6106d42
    position = pos(symbol, sentence)
    Do While position > 0
      sentence = copy(sentence, 1, position-1) + copy(sentence, position+1, length(sentence))
      position = pos(symbol, sentence)
    Loop
  Next symbol
  result = " " + sentence + " "
  Return result
End Function
Rem  
Rem TODO: Check (and specify if needed) the argument and result types! 
Function setupGoodByePhrases() As array of array[0..1] of string
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim phrases()() As String
  Rem  
  Let phrases(0) = Array(" shut", "Okay. If you feel that way I\'ll shut up. ... Your choice.")
  Let phrases(1) = Array("bye", "Well, let\'s end our talk for now. See you later. Bye.")
  return phrases
End Function
Rem  
Rem The lower the index the higher the rank of the keyword (search is sequential). 
Rem The index of the first keyword found in a user sentence maps to a respective 
Rem reply ring as defined in `setupReplies()´. 
Rem TODO: Check (and specify if needed) the argument and result types! 
Function setupKeywords() As array of KeyMapEntry
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim keywords() As KeyMapEntry
  Rem  
  Rem The empty key string (last entry) is the default clause - will always be found 
  Let keywords(39).keyword = ""
  Let keywords(39).index = 29
  Let keywords(0).keyword = "can you "
  Let keywords(0).index = 0
  Let keywords(1).keyword = "can i "
  Let keywords(1).index = 1
  Let keywords(2).keyword = "you are "
  Let keywords(2).index = 2
  Let keywords(3).keyword = "you\'re "
  Let keywords(3).index = 2
  Let keywords(4).keyword = "i don't "
  Let keywords(4).index = 3
  Let keywords(5).keyword = "i feel "
  Let keywords(5).index = 4
  Let keywords(6).keyword = "why don\'t you "
  Let keywords(6).index = 5
  Let keywords(7).keyword = "why can\'t i "
  Let keywords(7).index = 6
  Let keywords(8).keyword = "are you "
  Let keywords(8).index = 7
  Let keywords(9).keyword = "i can\'t "
  Let keywords(9).index = 8
  Let keywords(10).keyword = "i am "
  Let keywords(10).index = 9
  Let keywords(11).keyword = "i\'m "
  Let keywords(11).index = 9
  Let keywords(12).keyword = "you "
  Let keywords(12).index = 10
  Let keywords(13).keyword = "i want "
  Let keywords(13).index = 11
  Let keywords(14).keyword = "what "
  Let keywords(14).index = 12
  Let keywords(15).keyword = "how "
  Let keywords(15).index = 12
  Let keywords(16).keyword = "who "
  Let keywords(16).index = 12
  Let keywords(17).keyword = "where "
  Let keywords(17).index = 12
  Let keywords(18).keyword = "when "
  Let keywords(18).index = 12
  Let keywords(19).keyword = "why "
  Let keywords(19).index = 12
  Let keywords(20).keyword = "name "
  Let keywords(20).index = 13
  Let keywords(21).keyword = "cause "
  Let keywords(21).index = 14
  Let keywords(22).keyword = "sorry "
  Let keywords(22).index = 15
  Let keywords(23).keyword = "dream "
  Let keywords(23).index = 16
  Let keywords(24).keyword = "hello "
  Let keywords(24).index = 17
  Let keywords(25).keyword = "hi "
  Let keywords(25).index = 17
  Let keywords(26).keyword = "maybe "
  Let keywords(26).index = 18
  Let keywords(27).keyword = " no"
  Let keywords(27).index = 19
  Let keywords(28).keyword = "your "
  Let keywords(28).index = 20
  Let keywords(29).keyword = "always "
  Let keywords(29).index = 21
  Let keywords(30).keyword = "think "
  Let keywords(30).index = 22
  Let keywords(31).keyword = "alike "
  Let keywords(31).index = 23
  Let keywords(32).keyword = "yes "
  Let keywords(32).index = 24
  Let keywords(33).keyword = "friend "
  Let keywords(33).index = 25
  Let keywords(34).keyword = "computer"
  Let keywords(34).index = 26
  Let keywords(35).keyword = "bot "
  Let keywords(35).index = 26
  Let keywords(36).keyword = "smartphone"
  Let keywords(36).index = 27
  Let keywords(37).keyword = "father "
  Let keywords(37).index = 28
  Let keywords(38).keyword = "mother "
  Let keywords(38).index = 28
  return keywords
End Function
Rem  
Rem Returns an array of pairs of mutualy substitutable  
Rem TODO: Check (and specify if needed) the argument and result types! 
Function setupReflexions() As array of array[0..1] of string
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim reflexions()() As String
  Rem  
  Let reflexions(0) = Array(" are ", " am ")
  Let reflexions(1) = Array(" were ", " was ")
  Let reflexions(2) = Array(" you ", " I ")
  Let reflexions(3) = Array(" your", " my")
  Let reflexions(4) = Array(" i\'ve ", " you\'ve ")
  Let reflexions(5) = Array(" i\'m ", " you\'re ")
  Let reflexions(6) = Array(" me ", " you ")
  Let reflexions(7) = Array(" my ", " your ")
  Let reflexions(8) = Array(" i ", " you ")
  Let reflexions(9) = Array(" am ", " are ")
  return reflexions
End Function
Rem  
Rem This routine sets up the reply rings addressed by the key words defined in 
Rem routine `setupKeywords()´ and mapped hitherto by the cross table defined 
Rem in `setupMapping()´ 
Rem TODO: Check (and specify if needed) the argument and result types! 
Function setupReplies() As array of array of string
  Rem TODO: Check and accomplish your variable declarations here: 
  Dim setupReplies()() As String
  Dim replies()() As String
  Rem  
  var replies: array of array of String
  Rem We start with the highest index for performance reasons 
  Rem (is to avoid frequent array resizing) 
  Let replies(29) = Array( "Say, do you have any psychological problems?", "What does that suggest to you?", "I see.", "I'm not sure I understand you fully.", "Come come elucidate your thoughts.", "Can you elaborate on that?", "That is quite interesting.")
  Let replies(0) = Array( "Don't you believe that I can*?", "Perhaps you would like to be like me?", "You want me to be able to*?")
  Let replies(1) = Array( "Perhaps you don't want to*?", "Do you want to be able to*?")
  Let replies(2) = Array( "What makes you think I am*?", "Does it please you to believe I am*?", "Perhaps you would like to be*?", "Do you sometimes wish you were*?")
  Let replies(3) = Array( "Don't you really*?", "Why don't you*?", "Do you wish to be able to*?", "Does that trouble you*?")
  Let replies(4) = Array( "Do you often feel*?", "Are you afraid of feeling*?", "Do you enjoy feeling*?")
  Let replies(5) = Array( "Do you really believe I don't*?", "Perhaps in good time I will*.", "Do you want me to*?")
  Let replies(6) = Array( "Do you think you should be able to*?", "Why can't you*?")
  Let replies(7) = Array( "Why are you interested in whether or not I am*?", "Would you prefer if I were not*?", "Perhaps in your fantasies I am*?")
  Let replies(8) = Array( "How do you know you can't*?", "Have you tried?","Perhaps you can now*.")
  Let replies(9) = Array( "Did you come to me because you are*?", "How long have you been*?", "Do you believe it is normal to be*?", "Do you enjoy being*?")
  Let replies(10) = Array( "We were discussing you--not me.", "Oh, I*.", "You're not really talking about me, are you?")
  Let replies(11) = Array( "What would it mean to you if you got*?", "Why do you want*?", "Suppose you soon got*...", "What if you never got*?", "I sometimes also want*.")
  Let replies(12) = Array( "Why do you ask?", "Does that question interest you?", "What answer would please you the most?", "What do you think?", "Are such questions on your mind often?", "What is it that you really want to know?", "Have you asked anyone else?", "Have you asked such questions before?", "What else comes to mind when you ask that?")
  Let replies(13) = Array( "Names don't interest me.", "I don't care about names -- please go on.")
  Let replies(14) = Array( "Is that the real reason?", "Don't any other reasons come to mind?", "Does that reason explain anything else?", "What other reasons might there be?")
  Let replies(15) = Array( "Please don't apologize!", "Apologies are not necessary.", "What feelings do you have when you apologize?", "Don't be so defensive!")
  Let replies(16) = Array( "What does that dream suggest to you?", "Do you dream often?", "What persons appear in your dreams?", "Are you disturbed by your dreams?")
  Let replies(17) = Array( "How do you do ...please state your problem.")
  Let replies(18) = Array( "You don't seem quite certain.", "Why the uncertain tone?", "Can't you be more positive?", "You aren't sure?", "Don't you know?")
  Let replies(19) = Array( "Are you saying no just to be negative?", "You are being a bit negative.", "Why not?", "Are you sure?", "Why no?")
  Let replies(20) = Array( "Why are you concerned about my*?", "What about your own*?")
  Let replies(21) = Array( "Can you think of a specific example?", "When?", "What are you thinking of?", "Really, always?")
  Let replies(22) = Array( "Do you really think so?", "But you are not sure you*?", "Do you doubt you*?")
  Let replies(23) = Array( "In what way?", "What resemblance do you see?", "What does the similarity suggest to you?", "What other connections do you see?", "Could there really be some connection?", "How?", "You seem quite positive.")
  Let replies(24) = Array( "Are you sure?", "I see.", "I understand.")
  Let replies(25) = Array( "Why do you bring up the topic of friends?", "Do your friends worry you?", "Do your friends pick on you?", "Are you sure you have any friends?", "Do you impose on your friends?", "Perhaps your love for friends worries you.")
  Let replies(26) = Array( "Do computers worry you?", "Are you talking about me in particular?", "Are you frightened by machines?", "Why do you mention computers?", "What do you think machines have to do with your problem?", "Don't you think computers can help people?", "What is it about machines that worries you?")
  Let replies(27) = Array( "Do you sometimes feel uneasy without a smartphone?", "Have you had these phantasies before?", "Does the world seem more real for you via apps?")
  Let replies(28) = Array( "Tell me more about your family.", "Who else in your family*?", "What does family relations mean for you?", "Come on, How old are you?")
  setupReplies = replies
  Return setupReplies
End Function

Rem = = = = 8< = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

