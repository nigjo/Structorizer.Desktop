<?php
// program ELIZA (generated by Structorizer 3.32-01) 

// Copyright (C) 2018-05-14 ??? 
// License: GPLv3-link 
// GNU General Public License (V 3) 
// https://www.gnu.org/licenses/gpl.html 
// http://www.gnu.de/documents/gpl.de.html 

// BEGIN initialization for "KeyMapEntry" 
// type KeyMapEntry = record{ keyword: string; index: int } 
// END initialization for "KeyMapEntry" 

// function adjustSpelling 
// Cares for correct letter case among others 
function adjustSpelling($sentence)
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	$result = $sentence;
	$position = 1;
	while (($position <= length($sentence)) && (copy($sentence, $position, 1) == " ")) 
	{
		$position = $position + 1;
	}
	if ($position <= length($sentence))
	{
		$start = copy($sentence, 1, $position);
		delete($result, 1, $position);
		insert(uppercase($start), $result, 1);
	}
	foreach (array(" i ", " i\'") as $word)
	{
		$position = pos($word, $result);
		while ($position > 0) 
		{
			delete($result, $position+1, 1);
			insert("I", $result, $position+1);
			$position = pos($word, $result);
		}
	}

	return $result;
}

// function checkGoodBye 
// Checks whether the given text contains some kind of 
// good-bye phrase inducing the end of the conversation 
// and if so writes a correspding good-bye message and 
// returns true, otherwise false 
function checkGoodBye($text, $phrases)
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	foreach ($phrases as $pair)
	{
		if (pos($pair[0], $text) > 0)
		{
			$saidBye = true;
			echo $pair[1];
			return true;
		}
	}
	return false;
}

// function checkRepetition 
// Checks whether newInput has occurred among the last 
// length(history) - 1 input strings and updates the history 
function checkRepetition($history, $newInput)
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	$hasOccurred = false;
	if (length($newInput) > 4)
	{
		$currentIndex = $history[0];;
		for ($i = 1; $i <= length($history)-1; $i += (1))
		{
			if ($newInput == $history[$i])
			{
				$hasOccurred = true;
			}
		}
		$history[$history[0]+1] = $newInput;
		$history[0] = ($history[0] + 1) % (length($history) - 1);
	}
	return $hasOccurred;
}

// function conjugateStrings 
function conjugateStrings($sentence, $key, $keyPos, $flexions)
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	$result = " " + copy($sentence, $keyPos + length($key), length($sentence)) + " ";
	foreach ($flexions as $pair)
	{
		$left = "";
		$right = $result;
		$position = pos($pair[0], $right);
		while ($position > 0) 
		{
			$left = $left + copy($right, 1, $position-1) + $pair[1];
			$right = copy($right, $position + length($pair[0]), length($right));
			$position = pos($pair[0], $right);
		}
		$result = $left + $right;
	}
	// Eliminate multiple spaces 
	$position = pos("  ", $result);
	while ($position > 0) 
	{
		$result = copy($result, 1, $position-1) + copy($result, $position+1, length($result));
		$position = pos("  ", $result);
	}

	return $result;
}

// function findKeyword 
// Looks for the occurrence of the first of the strings 
// contained in keywords within the given sentence (in 
// array order). 
// Returns an array of 
// 0: the index of the first identified keyword (if any, otherwise -1), 
// 1: the position inside sentence (0 if not found) 
function findKeyword($keyMap, $sentence)
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	// Contains the index of the keyword and its position in sentence 
	$result = array(-1,0);
	$i = 0;
	while (($result[0] < 0) && ($i < length($keyMap))) 
	{
		$entry = $keyMap[$i];
		$position = pos($entry['keyword'], $sentence);
		if ($position > 0)
		{
			$result[0] = $i;
			$result[1] = $position;
		}
		$i = $i+1;
	}

	return $result;
}

// function normalizeInput 
// Converts the sentence to lowercase, eliminates all 
// interpunction (i.e. ',', '.', ';'), and pads the 
// sentence among blanks 
function normalizeInput($sentence)
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	$sentence = lowercase($sentence);
	foreach (array('.', ',', ';', '!', '?') as $symbol)
	{
		$position = pos($symbol, $sentence);
		while ($position > 0) 
		{
			$sentence = copy($sentence, 1, $position-1) + copy($sentence, $position+1, length($sentence));
			$position = pos($symbol, $sentence);
		}
	}
	$result = " " + $sentence + " ";

	return $result;
}

// function setupGoodByePhrases 
function setupGoodByePhrases()
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	$phrases[0] = array(" shut","Okay. If you feel that way I\'ll shut up. ... Your choice.");
	$phrases[1] = array("bye","Well, let\'s end our talk for now. See you later. Bye.");
	return $phrases;
}

// function setupKeywords 
// The lower the index the higher the rank of the keyword (search is sequential). 
// The index of the first keyword found in a user sentence maps to a respective 
// reply ring as defined in `setupReplies()´. 
function setupKeywords()
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	// The empty key string (last entry) is the default clause - will always be found 
	$keywords[39] = array("keyword" => "","index" => 29);
	$keywords[0] = array("keyword" => "can you ","index" => 0);
	$keywords[1] = array("keyword" => "can i ","index" => 1);
	$keywords[2] = array("keyword" => "you are ","index" => 2);
	$keywords[3] = array("keyword" => "you\'re ","index" => 2);
	$keywords[4] = array("keyword" => "i don't ","index" => 3);
	$keywords[5] = array("keyword" => "i feel ","index" => 4);
	$keywords[6] = array("keyword" => "why don\'t you ","index" => 5);
	$keywords[7] = array("keyword" => "why can\'t i ","index" => 6);
	$keywords[8] = array("keyword" => "are you ","index" => 7);
	$keywords[9] = array("keyword" => "i can\'t ","index" => 8);
	$keywords[10] = array("keyword" => "i am ","index" => 9);
	$keywords[11] = array("keyword" => "i\'m ","index" => 9);
	$keywords[12] = array("keyword" => "you ","index" => 10);
	$keywords[13] = array("keyword" => "i want ","index" => 11);
	$keywords[14] = array("keyword" => "what ","index" => 12);
	$keywords[15] = array("keyword" => "how ","index" => 12);
	$keywords[16] = array("keyword" => "who ","index" => 12);
	$keywords[17] = array("keyword" => "where ","index" => 12);
	$keywords[18] = array("keyword" => "when ","index" => 12);
	$keywords[19] = array("keyword" => "why ","index" => 12);
	$keywords[20] = array("keyword" => "name ","index" => 13);
	$keywords[21] = array("keyword" => "cause ","index" => 14);
	$keywords[22] = array("keyword" => "sorry ","index" => 15);
	$keywords[23] = array("keyword" => "dream ","index" => 16);
	$keywords[24] = array("keyword" => "hello ","index" => 17);
	$keywords[25] = array("keyword" => "hi ","index" => 17);
	$keywords[26] = array("keyword" => "maybe ","index" => 18);
	$keywords[27] = array("keyword" => " no","index" => 19);
	$keywords[28] = array("keyword" => "your ","index" => 20);
	$keywords[29] = array("keyword" => "always ","index" => 21);
	$keywords[30] = array("keyword" => "think ","index" => 22);
	$keywords[31] = array("keyword" => "alike ","index" => 23);
	$keywords[32] = array("keyword" => "yes ","index" => 24);
	$keywords[33] = array("keyword" => "friend ","index" => 25);
	$keywords[34] = array("keyword" => "computer","index" => 26);
	$keywords[35] = array("keyword" => "bot ","index" => 26);
	$keywords[36] = array("keyword" => "smartphone","index" => 27);
	$keywords[37] = array("keyword" => "father ","index" => 28);
	$keywords[38] = array("keyword" => "mother ","index" => 28);
	return $keywords;
}

// function setupReflexions 
// Returns an array of pairs of mutualy substitutable  
function setupReflexions()
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	$reflexions[0] = array(" are "," am ");
	$reflexions[1] = array(" were "," was ");
	$reflexions[2] = array(" you "," I ");
	$reflexions[3] = array(" your"," my");
	$reflexions[4] = array(" i\'ve "," you\'ve ");
	$reflexions[5] = array(" i\'m "," you\'re ");
	$reflexions[6] = array(" me "," you ");
	$reflexions[7] = array(" my "," your ");
	$reflexions[8] = array(" i "," you ");
	$reflexions[9] = array(" am "," are ");
	return $reflexions;
}

// function setupReplies 
// This routine sets up the reply rings addressed by the key words defined in 
// routine `setupKeywords()´ and mapped hitherto by the cross table defined 
// in `setupMapping()´ 
function setupReplies()
{

	// TODO Establish sensible web formulars to get the $_GET input working. 

	$replies = array();
	// We start with the highest index for performance reasons 
	// (is to avoid frequent array resizing) 
	$replies[29] = array("Say, do you have any psychological problems?","What does that suggest to you?","I see.","I'm not sure I understand you fully.","Come come elucidate your thoughts.","Can you elaborate on that?","That is quite interesting.");
	$replies[0] = array("Don't you believe that I can*?","Perhaps you would like to be like me?","You want me to be able to*?");
	$replies[1] = array("Perhaps you don't want to*?","Do you want to be able to*?");
	$replies[2] = array("What makes you think I am*?","Does it please you to believe I am*?","Perhaps you would like to be*?","Do you sometimes wish you were*?");
	$replies[3] = array("Don't you really*?","Why don't you*?","Do you wish to be able to*?","Does that trouble you*?");
	$replies[4] = array("Do you often feel*?","Are you afraid of feeling*?","Do you enjoy feeling*?");
	$replies[5] = array("Do you really believe I don't*?","Perhaps in good time I will*.","Do you want me to*?");
	$replies[6] = array("Do you think you should be able to*?","Why can't you*?");
	$replies[7] = array("Why are you interested in whether or not I am*?","Would you prefer if I were not*?","Perhaps in your fantasies I am*?");
	$replies[8] = array("How do you know you can't*?","Have you tried?","Perhaps you can now*.");
	$replies[9] = array("Did you come to me because you are*?","How long have you been*?","Do you believe it is normal to be*?","Do you enjoy being*?");
	$replies[10] = array("We were discussing you--not me.","Oh, I*.","You're not really talking about me, are you?");
	$replies[11] = array("What would it mean to you if you got*?","Why do you want*?","Suppose you soon got*...","What if you never got*?","I sometimes also want*.");
	$replies[12] = array("Why do you ask?","Does that question interest you?","What answer would please you the most?","What do you think?","Are such questions on your mind often?","What is it that you really want to know?","Have you asked anyone else?","Have you asked such questions before?","What else comes to mind when you ask that?");
	$replies[13] = array("Names don't interest me.","I don't care about names -- please go on.");
	$replies[14] = array("Is that the real reason?","Don't any other reasons come to mind?","Does that reason explain anything else?","What other reasons might there be?");
	$replies[15] = array("Please don't apologize!","Apologies are not necessary.","What feelings do you have when you apologize?","Don't be so defensive!");
	$replies[16] = array("What does that dream suggest to you?","Do you dream often?","What persons appear in your dreams?","Are you disturbed by your dreams?");
	$replies[17] = array("How do you do ...please state your problem.");
	$replies[18] = array("You don't seem quite certain.","Why the uncertain tone?","Can't you be more positive?","You aren't sure?","Don't you know?");
	$replies[19] = array("Are you saying no just to be negative?","You are being a bit negative.","Why not?","Are you sure?","Why no?");
	$replies[20] = array("Why are you concerned about my*?","What about your own*?");
	$replies[21] = array("Can you think of a specific example?","When?","What are you thinking of?","Really, always?");
	$replies[22] = array("Do you really think so?","But you are not sure you*?","Do you doubt you*?");
	$replies[23] = array("In what way?","What resemblance do you see?","What does the similarity suggest to you?","What other connections do you see?","Could there really be some connection?","How?","You seem quite positive.");
	$replies[24] = array("Are you sure?","I see.","I understand.");
	$replies[25] = array("Why do you bring up the topic of friends?","Do your friends worry you?","Do your friends pick on you?","Are you sure you have any friends?","Do you impose on your friends?","Perhaps your love for friends worries you.");
	$replies[26] = array("Do computers worry you?","Are you talking about me in particular?","Are you frightened by machines?","Why do you mention computers?","What do you think machines have to do with your problem?","Don't you think computers can help people?","What is it about machines that worries you?");
	$replies[27] = array("Do you sometimes feel uneasy without a smartphone?","Have you had these phantasies before?","Does the world seem more real for you via apps?");
	$replies[28] = array("Tell me more about your family.","Who else in your family*?","What does family relations mean for you?","Come on, How old are you?");
	$setupReplies = $replies;

	return $setupReplies;
}
// = = = = 8< = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

// program ELIZA 
// Concept and lisp implementation published by Joseph Weizenbaum (MIT): 
// "ELIZA - A Computer Program For the Study of Natural Language Communication Between Man and Machine" - In: 
// Computational Linguistis 1(1966)9, pp. 36-45 
// Revision history: 
// 2016-10-06 Initial version 
// 2017-03-29 Two diagrams updated (comments translated to English) 
// 2017-03-29 More keywords and replies added 
// 2019-03-14 Replies and mapping reorganised for easier maintenance 
// 2019-03-15 key map joined from keyword array and index map 
// 2019-03-28 Keyword "bot" inserted (same reply ring as "computer") 

// TODO Establish sensible web formulars to get the $_GET input working. 

// Title information 
echo "************* ELIZA **************";
echo "* Original design by J. Weizenbaum";
echo "**********************************";
echo "* Adapted for Basic on IBM PC by";
echo "* - Patricia Danielson";
echo "* - Paul Hashfield";
echo "**********************************";
echo "* Adapted for Structorizer by";
echo "* - Kay Gürtzig / FH Erfurt 2016";
echo "* Version: 2.2 (2019-03-28)";
echo "**********************************";
// Stores the last five inputs of the user in a ring buffer, 
// the first element is the current insertion index 
$history = array(0,"","","","","");
const $replies = setupReplies();
const $reflexions = setupReflexions();
const $byePhrases = setupGoodByePhrases();
const $keyMap = setupKeywords();
$offsets[length($keyMap)-1] = 0;
$isGone = false;
// Starter 
echo "Hi! I\'m your new therapist. My name is Eliza. What\'s your problem?";
do
{
	$userInput = $_REQUEST['userInput'];	// TODO form a sensible input opportunity;
	// Converts the input to lowercase, cuts out interpunctation 
	// and pads the string 
	$userInput = normalizeInput($userInput);
	$isGone = checkGoodBye($userInput, $byePhrases);
	if (! $isGone)
	{
		$reply = "Please don\'t repeat yourself!";
		$isRepeated = checkRepetition($history, $userInput);
		if (! $isRepeated)
		{
			$findInfo = findKeyword($keyMap, $userInput);
			$keyIndex = $findInfo[0];
			if ($keyIndex < 0)
			{
				// Should never happen... 
				$keyIndex = length($keyMap)-1;
			}
			$entry = $keyMap[$keyIndex];
			// Variable part of the reply 
			$varPart = "";
			if (length($entry['keyword']) > 0)
			{
				$varPart = conjugateStrings($userInput, $entry['keyword'], $findInfo[1], $reflexions);
			}
			$replyRing = $replies[$entry['index']];
			$reply = $replyRing[$offsets[$keyIndex]];
			$offsets[$keyIndex] = ($offsets[$keyIndex] + 1) % length($replyRing);
			$posAster = pos("*", $reply);
			if ($posAster > 0)
			{
				if ($varPart == " ")
				{
					$reply = "You will have to elaborate more for me to help you.";
				}
				else
				{
					delete($reply, $posAster, 1);
					insert($varPart, $reply, $posAster);
				}
			}
			$reply = adjustSpelling($reply);
		}
		echo $reply;
	}
} while (!( $isGone ));

?>
