extends Node

var names = ['Adara', 'Adena', 'Adrianne', 'Alarice', 'Alvita', 'Amara', 'Ambika', 'Antonia', 'Araceli', 'Balandria', 'Basha',
'Beryl', 'Bryn', 'Callia', 'Caryssa', 'Cassandra', 'Casondrah', 'Chatha', 'Ciara', 'Cynara', 'Cytheria', 'Dabria', 'Darcei',
'Deandra', 'Deirdre', 'Delores', 'Desdomna', 'Devi', 'Dominique', 'Drucilla', 'Duvessa', 'Ebony', 'Ezzuh', 'Eohda', 'Fantine', 
'Fuscienne', 'Farsha', 'Gabi', 'Gallia', 'Grokk', 'Hanna', 'Hedda', 'Jerica', 'Jetta', 'Joby', 'Kacila', 'Kagami', 'Kala', 'Kallie', 
'Keelia', 'Kerry', 'Kimberly', 'Killian', 'Kory', 'Lilith', 'Lucretia', 'Lysha', 'Mercedes', 'Mia', 'Maura', 'Perdita', 'Quella',
'Riona', 'Safiya', 'Salina', 'Severin', 'Sidonia', 'Sirena', 'Solita', 'Tempest', 'Thea', 'Treva', 'Trista', 'Vala', 'Winta', 'Xarka',
'Xena', 'Yuzz', 'Yara', 'Zakarr']

var alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

var markov = {}

func loadNames(markov, names):
	for name in names:
		var currName = name
		for i in range(currName.length()):
			var currLetter = currName[i].to_lower()
			var letterToAdd;
			if i == (currName.length() - 1):
				letterToAdd = "."
			else:
				letterToAdd = currName[i+1]
			var tempList = []
			if markov.has(currLetter):
				tempList = markov[currLetter]
			tempList.append(letterToAdd)
			markov[currLetter] = tempList

func getName (firstChar, minLength, maxLength):
	var count = 1
	var name = ""
	if firstChar:
		name += firstChar
	else:
		var random_letter = alphabet[roll(0, alphabet.size()-1)]
		name += random_letter
	while count < maxLength:
		var new_last = name.length()-1
		var nextLetter = getNextLetter(name[new_last])
		if str(nextLetter) == ".":
			if count > minLength:
				return name
		else:
			name += str(nextLetter)
			count+=1
	return name

func getNextLetter(letter):
	var thisList = markov[letter]
	return thisList[roll(0, thisList.size()-1)]

# Random number generator
func roll(l,h):
	return int(round(rand_range(l,h)))

func _ready():
	randomize()
	loadNames(markov, names)
	var populated_list = ""
	var new_name = ""
	for i in range(20):
		var random_letter = alphabet[roll(0, alphabet.size()-1)]
		new_name = getName(random_letter, 4, 7)
		new_name = new_name.capitalize()
		populated_list += new_name+"\n"
	print(populated_list)