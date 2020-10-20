// Generated by Structorizer 3.30-11 

// Copyright (C) 2018-05-14 Kay Gürtzig 
// License: GPLv3-link 
// GNU General Public License (V 3) 
// https://www.gnu.org/licenses/gpl.html 
// http://www.gnu.de/documents/gpl.de.html 

using System;

/// <summary>
/// Concept and lisp implementation published by Joseph Weizenbaum (MIT):
/// "ELIZA - A Computer Program For the Study of Natural Language Communication Between Man and Machine" - In:
/// Computational Linguistis 1(1966)9, pp. 36-45
/// Revision history:
/// 2016-10-06 Initial version
/// 2017-03-29 Two diagrams updated (comments translated to English)
/// 2017-03-29 More keywords and replies added
/// 2019-03-14 Replies and mapping reorganised for easier maintenance
/// 2019-03-15 key map joined from keyword array and index map
/// 2019-03-28 Keyword "bot" inserted (same reply ring as "computer")
/// 2019-11-28 New global type "History" (to ensure a homogenous array)
/// </summary>
public class ELIZA {

	private static boolean initDone_History = false;
	// histArray contains the most recent user replies as ring buffer; 
	// histIndex is the index where the next reply is to be stored (= index of the oldest 
	// cached user reply). 
	// Note: The depth of the history is to be specified by initializing a variable of this type, 
	// e.g. for a history of depth 5: 
	// myhistory <- History{{"", "", "", "", ""}, 0} 
	public struct History{
		public string[]	histArray;
		public int	histIndex;
		public History(string[] p_histArray, int p_histIndex)
		{
			histArray = p_histArray;
			histIndex = p_histIndex;
		}
	};

	private static boolean initDone_KeyMapEntry = false;
	// Associates a key word in the text with an index in the reply ring array 
	public struct KeyMapEntry{
		public string	keyword;
		public int	index;
		public KeyMapEntry(string p_keyword, int p_index)
		{
			keyword = p_keyword;
			index = p_index;
		}
	};

	/// <param name="args"> array of command line arguments </param>
	public static void Main(string[] args) {

		initialize_History();
		initialize_KeyMapEntry();
		
		// TODO: Check and accomplish variable declarations: 
		string varPart;
		// Converts the input to lowercase, cuts out interpunctation 
		// and pads the string 
		string userInput;
		string reply;
		int posAster;
		int[] offsets;
		bool isRepeated;
		bool isGone;
		int[] findInfo;

		// TODO: You may have to modify input instructions, 
		//       possibly by enclosing Console.ReadLine() calls with 
		//       Parse methods according to the variable type, e.g.: 
		//          i = int.Parse(Console.ReadLine()); 

		// Title information 
		Console.WriteLine("************* ELIZA **************");
		Console.WriteLine("* Original design by J. Weizenbaum");
		Console.WriteLine("**********************************");
		Console.WriteLine("* Adapted for Basic on IBM PC by");
		Console.WriteLine("* - Patricia Danielson");
		Console.WriteLine("* - Paul Hashfield");
		Console.WriteLine("**********************************");
		Console.WriteLine("* Adapted for Structorizer by");
		Console.WriteLine("* - Kay Gürtzig / FH Erfurt 2016");
		Console.WriteLine("* Version: 2.3 (2020-02-24)");
		Console.WriteLine("* (Requires at least Structorizer 3.30-03 to run)");
		Console.WriteLine("**********************************");
		// Stores the last five inputs of the user in a ring buffer, 
		// the second component is the rolling (over-)write index. 
		History history = new History(new string[]{"", "", "", "", ""}, 0);
		const string[,] replies = setupReplies();
		const string[,] reflexions = setupReflexions();
		const string[,] byePhrases = setupGoodByePhrases();
		const KeyMapEntry[] keyMap = setupKeywords();
		offsets[length(keyMap)-1] = 0;
		isGone = false;
		// Starter 
		Console.WriteLine("Hi! I\'m your new therapist. My name is Eliza. What\'s your problem?");
		do {
			userInput = Console.ReadLine();
			// Converts the input to lowercase, cuts out interpunctation 
			// and pads the string 
			// Converts the input to lowercase, cuts out interpunctation 
			// and pads the string 
			userInput = normalizeInput(userInput);
			isGone = checkGoodBye(userInput, byePhrases);
			if (! isGone) {
				reply = "Please don\'t repeat yourself!";
				isRepeated = checkRepetition(history, userInput);
				if (! isRepeated) {
					findInfo = findKeyword(keyMap, userInput);
					??? keyIndex = findInfo[0];
					if (keyIndex < 0) {
						// Should never happen... 
						keyIndex = length(keyMap)-1;
					}
					KeyMapEntry entry = keyMap[keyIndex];
					// Variable part of the reply 
					varPart = "";
					if (length(entry.keyword) > 0) {
						varPart = conjugateStrings(userInput, entry.keyword, findInfo[1], reflexions);
					}
					??? replyRing = replies[entry.index];
					reply = replyRing[offsets[keyIndex]];
					offsets[keyIndex] = (offsets[keyIndex] + 1) % length(replyRing);
					posAster = pos("*", reply);
					if (posAster > 0) {
						if (varPart == " ") {
							reply = "You will have to elaborate more for me to help you.";
						}
						else {
							delete(reply, posAster, 1);
							insert(varPart, reply, posAster);
						}
					}
					reply = adjustSpelling(reply);
				}
				Console.WriteLine(reply);
			}
		} while (! (isGone));
	}

	/// <summary>
	/// Automatically created initialization procedure for History
	/// </summary>
	private static void initialize_History() {
		if (! initDone_History) {
			initDone_History = true;
		}
	}

	/// <summary>
	/// Automatically created initialization procedure for KeyMapEntry
	/// </summary>
	private static void initialize_KeyMapEntry() {
		if (! initDone_KeyMapEntry) {
			initDone_KeyMapEntry = true;
		}
	}

	/// <summary>
	/// Cares for correct letter case among others
	/// </summary>
	/// <param name="sentence"> TODO </param>
	/// <return> TODO </return>
	private static string adjustSpelling(string sentence) {
		// TODO: Check and accomplish variable declarations: 
		string word;
		string start;
		string result;
		int position;

		result = sentence;
		position = 1;
		while ((position <= length(sentence)) && (copy(sentence, position, 1) == " ")) {
			position = position + 1;
		}
		if (position <= length(sentence)) {
			start = copy(sentence, 1, position);
			delete(result, 1, position);
			insert(uppercase(start), result, 1);
		}
		foreach (String word in new String[]{" i ", " i\'"}) {
			position = pos(word, result);
			while (position > 0) {
				delete(result, position+1, 1);
				insert("I", result, position+1);
				position = pos(word, result);
			}
		}

		return result;
	}

	/// <summary>
	/// Checks whether the given text contains some kind of
	/// good-bye phrase inducing the end of the conversation
	/// and if so writes a correspding good-bye message and
	/// returns true, otherwise false
	/// </summary>
	/// <param name="text"> TODO </param>
	/// <param name="phrases"> TODO </param>
	/// <return> TODO </return>
	private static bool checkGoodBye(string text, string[,] phrases) {
		// TODO: Check and accomplish variable declarations: 
		string[] pair;

		foreach (@string pair in phrases) {
			if (pos(pair[0], text) > 0) {
				Console.WriteLine(pair[1]);
				return true;
			}
		}
		return false;
	}

	/// <summary>
	/// </summary>
	/// <param name="sentence"> TODO </param>
	/// <param name="key"> TODO </param>
	/// <param name="keyPos"> TODO </param>
	/// <param name="flexions"> TODO </param>
	/// <return> TODO </return>
	private static string conjugateStrings(string sentence, string key, int keyPos, string[,] flexions) {
		// TODO: Check and accomplish variable declarations: 
		string right;
		string result;
		int position;
		string[] pair;
		string left;

		result = " " + copy(sentence, keyPos + length(key), length(sentence)) + " ";
		foreach (@string pair in flexions) {
			left = "";
			right = result;
			position = pos(pair[0], right);
			while (position > 0) {
				left = left + copy(right, 1, position-1) + pair[1];
				right = copy(right, position + length(pair[0]), length(right));
				position = pos(pair[0], right);
			}
			result = left + right;
		}
		// Eliminate multiple spaces 
		position = pos("  ", result);
		while (position > 0) {
			result = copy(result, 1, position-1) + copy(result, position+1, length(result));
			position = pos("  ", result);
		}

		return result;
	}

	/// <summary>
	/// Converts the sentence to lowercase, eliminates all
	/// interpunction (i.e. ',', '.', ';'), and pads the
	/// sentence among blanks
	/// </summary>
	/// <param name="sentence"> TODO </param>
	/// <return> TODO </return>
	private static string normalizeInput(string sentence) {
		// TODO: Check and accomplish variable declarations: 
		char symbol;
		string result;
		int position;

		sentence = lowercase(sentence);
		foreach (char symbol in new char[]{'.', ',', ';', '!', '?'}) {
			position = pos(symbol, sentence);
			while (position > 0) {
				sentence = copy(sentence, 1, position-1) + copy(sentence, position+1, length(sentence));
				position = pos(symbol, sentence);
			}
		}
		result = " " + sentence + " ";

		return result;
	}

	/// <summary>
	/// </summary>
	/// <return> TODO </return>
	private static string[,] setupGoodByePhrases() {
		// TODO: Check and accomplish variable declarations: 
		string[,] phrases;

		phrases[0] = new string[]{" shut", "Okay. If you feel that way I\'ll shut up. ... Your choice."};
		phrases[1] = new string[]{"bye", "Well, let\'s end our talk for now. See you later. Bye."};
		return phrases;
	}

	/// <summary>
	/// Returns an array of pairs of mutualy substitutable 
	/// </summary>
	/// <return> TODO </return>
	private static string[,] setupReflexions() {
		// TODO: Check and accomplish variable declarations: 
		string[,] reflexions;

		reflexions[0] = new string[]{" are ", " am "};
		reflexions[1] = new string[]{" were ", " was "};
		reflexions[2] = new string[]{" you ", " I "};
		reflexions[3] = new string[]{" your", " my"};
		reflexions[4] = new string[]{" i\'ve ", " you\'ve "};
		reflexions[5] = new string[]{" i\'m ", " you\'re "};
		reflexions[6] = new string[]{" me ", " you "};
		reflexions[7] = new string[]{" my ", " your "};
		reflexions[8] = new string[]{" i ", " you "};
		reflexions[9] = new string[]{" am ", " are "};
		return reflexions;
	}

	/// <summary>
	/// This routine sets up the reply rings addressed by the key words defined in
	/// routine `setupKeywords()´ and mapped hitherto by the cross table defined
	/// in `setupMapping()´
	/// </summary>
	/// <return> TODO </return>
	private static string[,] setupReplies() {
		// TODO: Check and accomplish variable declarations: 
		string[,] setupReplies;

		String[,] replies;
		// We start with the highest index for performance reasons 
		// (is to avoid frequent array resizing) 
		replies[29] = new string[]{"Say, do you have any psychological problems?", "What does that suggest to you?", "I see.", "I'm not sure I understand you fully.", "Come come elucidate your thoughts.", "Can you elaborate on that?", "That is quite interesting."};
		replies[0] = new string[]{"Don't you believe that I can*?", "Perhaps you would like to be like me?", "You want me to be able to*?"};
		replies[1] = new string[]{"Perhaps you don't want to*?", "Do you want to be able to*?"};
		replies[2] = new string[]{"What makes you think I am*?", "Does it please you to believe I am*?", "Perhaps you would like to be*?", "Do you sometimes wish you were*?"};
		replies[3] = new string[]{"Don't you really*?", "Why don't you*?", "Do you wish to be able to*?", "Does that trouble you*?"};
		replies[4] = new string[]{"Do you often feel*?", "Are you afraid of feeling*?", "Do you enjoy feeling*?"};
		replies[5] = new string[]{"Do you really believe I don't*?", "Perhaps in good time I will*.", "Do you want me to*?"};
		replies[6] = new string[]{"Do you think you should be able to*?", "Why can't you*?"};
		replies[7] = new string[]{"Why are you interested in whether or not I am*?", "Would you prefer if I were not*?", "Perhaps in your fantasies I am*?"};
		replies[8] = new string[]{"How do you know you can't*?", "Have you tried?", "Perhaps you can now*."};
		replies[9] = new string[]{"Did you come to me because you are*?", "How long have you been*?", "Do you believe it is normal to be*?", "Do you enjoy being*?"};
		replies[10] = new string[]{"We were discussing you--not me.", "Oh, I*.", "You're not really talking about me, are you?"};
		replies[11] = new string[]{"What would it mean to you if you got*?", "Why do you want*?", "Suppose you soon got*...", "What if you never got*?", "I sometimes also want*."};
		replies[12] = new string[]{"Why do you ask?", "Does that question interest you?", "What answer would please you the most?", "What do you think?", "Are such questions on your mind often?", "What is it that you really want to know?", "Have you asked anyone else?", "Have you asked such questions before?", "What else comes to mind when you ask that?"};
		replies[13] = new string[]{"Names don't interest me.", "I don't care about names -- please go on."};
		replies[14] = new string[]{"Is that the real reason?", "Don't any other reasons come to mind?", "Does that reason explain anything else?", "What other reasons might there be?"};
		replies[15] = new string[]{"Please don't apologize!", "Apologies are not necessary.", "What feelings do you have when you apologize?", "Don't be so defensive!"};
		replies[16] = new string[]{"What does that dream suggest to you?", "Do you dream often?", "What persons appear in your dreams?", "Are you disturbed by your dreams?"};
		replies[17] = new string[]{"How do you do ...please state your problem."};
		replies[18] = new string[]{"You don't seem quite certain.", "Why the uncertain tone?", "Can't you be more positive?", "You aren't sure?", "Don't you know?"};
		replies[19] = new string[]{"Are you saying no just to be negative?", "You are being a bit negative.", "Why not?", "Are you sure?", "Why no?"};
		replies[20] = new string[]{"Why are you concerned about my*?", "What about your own*?"};
		replies[21] = new string[]{"Can you think of a specific example?", "When?", "What are you thinking of?", "Really, always?"};
		replies[22] = new string[]{"Do you really think so?", "But you are not sure you*?", "Do you doubt you*?"};
		replies[23] = new string[]{"In what way?", "What resemblance do you see?", "What does the similarity suggest to you?", "What other connections do you see?", "Could there really be some connection?", "How?", "You seem quite positive."};
		replies[24] = new string[]{"Are you sure?", "I see.", "I understand."};
		replies[25] = new string[]{"Why do you bring up the topic of friends?", "Do your friends worry you?", "Do your friends pick on you?", "Are you sure you have any friends?", "Do you impose on your friends?", "Perhaps your love for friends worries you."};
		replies[26] = new string[]{"Do computers worry you?", "Are you talking about me in particular?", "Are you frightened by machines?", "Why do you mention computers?", "What do you think machines have to do with your problem?", "Don't you think computers can help people?", "What is it about machines that worries you?"};
		replies[27] = new string[]{"Do you sometimes feel uneasy without a smartphone?", "Have you had these phantasies before?", "Does the world seem more real for you via apps?"};
		replies[28] = new string[]{"Tell me more about your family.", "Who else in your family*?", "What does family relations mean for you?", "Come on, How old are you?"};
		setupReplies = replies;

		return setupReplies;
	}

	/// <summary>
	/// Checks whether newInput has occurred among the recently cached
	/// input strings in the histArray component of history and updates the history.
	/// </summary>
	/// <param name="history"> TODO </param>
	/// <param name="newInput"> TODO </param>
	/// <return> TODO </return>
	private static bool checkRepetition(History history, string newInput) {
		initialize_History();
		
		// TODO: Check and accomplish variable declarations: 
		int histDepth;
		bool hasOccurred;

		hasOccurred = false;
		if (length(newInput) > 4) {
			histDepth = length(history.histArray);
			for (int i = 0; i <= histDepth-1; i += (1)) {
				if (newInput == history.histArray[i]) {
					hasOccurred = true;
				}
			}
			history.histArray[history.histIndex] = newInput;
			history.histIndex = (history.histIndex + 1) % (histDepth);
		}
		return hasOccurred;
	}

	/// <summary>
	/// Looks for the occurrence of the first of the strings
	/// contained in keywords within the given sentence (in
	/// array order).
	/// Returns an array of
	/// 0: the index of the first identified keyword (if any, otherwise -1),
	/// 1: the position inside sentence (0 if not found)
	/// </summary>
	/// <param name="keyMap"> TODO </param>
	/// <param name="sentence"> TODO </param>
	/// <return> TODO </return>
	private static int[] findKeyword(const array of KeyMapEntry keyMap, string sentence) {
		initialize_KeyMapEntry();
		
		// TODO: Check and accomplish variable declarations: 
		int[] result;
		int position;
		int i;

		// Contains the index of the keyword and its position in sentence 
		result = new int[]{-1, 0};
		i = 0;
		while ((result[0] < 0) && (i < length(keyMap))) {
			KeyMapEntry entry = keyMap[i];
			position = pos(entry.keyword, sentence);
			if (position > 0) {
				result[0] = i;
				result[1] = position;
			}
			i = i+1;
		}

		return result;
	}

	/// <summary>
	/// The lower the index the higher the rank of the keyword (search is sequential).
	/// The index of the first keyword found in a user sentence maps to a respective
	/// reply ring as defined in `setupReplies()´.
	/// </summary>
	/// <return> TODO </return>
	private static KeyMapEntry[] setupKeywords() {
		initialize_KeyMapEntry();
		
		// TODO: Check and accomplish variable declarations: 
		// The empty key string (last entry) is the default clause - will always be found 
		KeyMapEntry[] keywords;

		// The empty key string (last entry) is the default clause - will always be found 
		keywords[39] = new KeyMapEntry("", 29);
		keywords[0] = new KeyMapEntry("can you ", 0);
		keywords[1] = new KeyMapEntry("can i ", 1);
		keywords[2] = new KeyMapEntry("you are ", 2);
		keywords[3] = new KeyMapEntry("you\'re ", 2);
		keywords[4] = new KeyMapEntry("i don't ", 3);
		keywords[5] = new KeyMapEntry("i feel ", 4);
		keywords[6] = new KeyMapEntry("why don\'t you ", 5);
		keywords[7] = new KeyMapEntry("why can\'t i ", 6);
		keywords[8] = new KeyMapEntry("are you ", 7);
		keywords[9] = new KeyMapEntry("i can\'t ", 8);
		keywords[10] = new KeyMapEntry("i am ", 9);
		keywords[11] = new KeyMapEntry("i\'m ", 9);
		keywords[12] = new KeyMapEntry("you ", 10);
		keywords[13] = new KeyMapEntry("i want ", 11);
		keywords[14] = new KeyMapEntry("what ", 12);
		keywords[15] = new KeyMapEntry("how ", 12);
		keywords[16] = new KeyMapEntry("who ", 12);
		keywords[17] = new KeyMapEntry("where ", 12);
		keywords[18] = new KeyMapEntry("when ", 12);
		keywords[19] = new KeyMapEntry("why ", 12);
		keywords[20] = new KeyMapEntry("name ", 13);
		keywords[21] = new KeyMapEntry("cause ", 14);
		keywords[22] = new KeyMapEntry("sorry ", 15);
		keywords[23] = new KeyMapEntry("dream ", 16);
		keywords[24] = new KeyMapEntry("hello ", 17);
		keywords[25] = new KeyMapEntry("hi ", 17);
		keywords[26] = new KeyMapEntry("maybe ", 18);
		keywords[27] = new KeyMapEntry(" no", 19);
		keywords[28] = new KeyMapEntry("your ", 20);
		keywords[29] = new KeyMapEntry("always ", 21);
		keywords[30] = new KeyMapEntry("think ", 22);
		keywords[31] = new KeyMapEntry("alike ", 23);
		keywords[32] = new KeyMapEntry("yes ", 24);
		keywords[33] = new KeyMapEntry("friend ", 25);
		keywords[34] = new KeyMapEntry("computer", 26);
		keywords[35] = new KeyMapEntry("bot ", 26);
		keywords[36] = new KeyMapEntry("smartphone", 27);
		keywords[37] = new KeyMapEntry("father ", 28);
		keywords[38] = new KeyMapEntry("mother ", 28);
		return keywords;
	}

}
