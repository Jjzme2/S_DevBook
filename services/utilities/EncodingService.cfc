component
	name= "EncodingService"
	hint="A service that allows you to use different encodings."
	singleton
{

		property name = ASCIICodes;

		// The ASCII codes for the keys
		ASCIICodes = {
			'nullchar' = chr(0),
			'startheading' = chr(1),
			'starttext' = chr(2),
			'endtext' = chr(3),
			'endtransmission' = chr(4),
			'enquiry' = chr(5),
			'acknowledge' = chr(6),
			'bell' = chr(7),
			'backspace' = chr(8),
			'horizontaltab' = chr(9),
			'linefeed' = chr(10),
			'verticaltab' = chr(11),
			'formfeed' = chr(12),
			'carriagereturn' = chr(13),
			'shiftout' = chr(14),
			'shiftin' = chr(15),
			'datalinkescape' = chr(16),
			'devicecontrol1' = chr(17),
			'devicecontrol2' = chr(18),
			'devicecontrol3' = chr(19),
			'devicecontrol4' = chr(20),
			'negativeacknowledge' = chr(21),
			'synchronousidle' = chr(22),
			'endtransmissionblock' = chr(23),
			'cancel' = chr(24),
			'endmedium' = chr(25),
			'substitute' = chr(26),
			'escape' = chr(27),
			'fileseparator' = chr(28),
			'groupseparator' = chr(29),
			'recordseparator' = chr(30),
			'unitseparator' = chr(31),
			'space' = chr(32),
			'exclamationmark' = chr(33),
			'quotationmark' = chr(34),
			'numbersign' = chr(35),
			'dollarsign' = chr(36),
			'percentsign' = chr(37),
			'ampersand' = chr(38),
			'apostrophe' = chr(39),
			'leftparenthesis' = chr(40),
			'rightparenthesis' = chr(41),
			'asterisk' = chr(42),
			'plussign' = chr(43),
			'comma' = chr(44),
			'minussign' = chr(45),
			'fullstop' = chr(46),
			'slash' = chr(47),
			'digit0' = chr(48),
			'digit1' = chr(49),
			'digit2' = chr(50),
			'digit3' = chr(51),
			'digit4' = chr(52),
			'digit5' = chr(53),
			'digit6' = chr(54),
			'digit7' = chr(55),
			'digit8' = chr(56),
			'digit9' = chr(57),
			'colon' = chr(58),
			'semicolon' = chr(59),
			'lessthansign' = chr(60),
			'equalsign' = chr(61),
			'greaterthansign' = chr(62),
			'questionmark' = chr(63),
			'atsign' = chr(64),
			'capitala' = chr(65),
			'capitalb' = chr(66),
			'capitalc' = chr(67),
			'capitald' = chr(68),
			'capitale' = chr(69),
			'capitalf' = chr(70),
			'capitalg' = chr(71),
			'capitalh' = chr(72),
			'capitali' = chr(73),
			'capitalj' = chr(74),
			'capitalk' = chr(75),
			'capitall' = chr(76),
			'capitalm' = chr(77),
			'capitaln' = chr(78),
			'capitalo' = chr(79),
			'capitalp' = chr(80),
			'capitalq' = chr(81),
			'capitalr' = chr(82),
			'capitals' = chr(83),
			'capitalt' = chr(84),
			'capitalu' = chr(85),
			'capitalv' = chr(86),
			'capitalw' = chr(87),
			'capitalx' = chr(88),
			'capitaly' = chr(89),
			'capitalz' = chr(90),
			'leftsquarebracket' = chr(91),
			'backslash' = chr(92),
			'rightsquarebracket' = chr(93),
			'caret' = chr(94),
			'underscore' = chr(95),
			'graveaccent' = chr(96),
			'lowercasea' = chr(97),
			'lowercaseb' = chr(98),
			'lowercasec' = chr(99),
			'lowercased' = chr(100),
			'lowercasee' = chr(101),
			'lowercasef' = chr(102),
			'lowercaseg' = chr(103),
			'lowercaseh' = chr(104),
			'lowercasei' = chr(105),
			'lowercasej' = chr(106),
			'lowercasek' = chr(107),
			'lowercasel' = chr(108),
			'lowercasem' = chr(109),
			'lowercasen' = chr(110),
			'lowercaseo' = chr(111),
			'lowercasep' = chr(112),
			'lowercaseq' = chr(113),
			'lowercaser' = chr(114),
			'lowercases' = chr(115),
			'lowercaset' = chr(116),
			'lowercaseu' = chr(117),
			'lowercasev' = chr(118),
			'lowercasew' = chr(119),
			'lowercasex' = chr(120),
			'lowercasey' = chr(121),
			'lowercasez' = chr(122),
			'leftcurlybracket' = chr(123),
			'verticalbar' = chr(124),
			'rightcurlybracket' = chr(125),
			'tilde' = chr(126),
			'delete' = chr(127)
		};

		public array function getASCIIKeys() {

			// Get the keys from the ASCIICodes struct
			var asciiKeys = StructKeyArray(ASCIICodes);
			return asciiKeys;
		}


	public function getASCIIEncoding(string keyToEncode) {

		// Validate the input
		if (keyToEncode EQ nullValue() || len(keyToEncode) EQ 0) {
			throw (message="The key to encode cannot be null or empty.", detail="EncodingService.getASCIIEncoding", type="EncodingService")
		}

		// If keyToEncode is not a valid key, return an empty string
		if(!ASCIICodes.keyExists(keyToEncode)) {
			throw (message="The key to encode (#keyToEncode#) is not a valid key.", detail="Valid Keys: #arrayToList(getASCIIKeys())#", type="EncodingService");
		}

		keyToEncode = Trim( lCase ( keyToEncode ) );
		// Get the ASCII code for the key
		var asciiCode = ASCIICodes[keyToEncode];
		return asciiCode;
	}
}