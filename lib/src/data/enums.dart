enum CharacterSpecies { 
  human("Human"), 
  alien("Alien"), 
  empty(""); 
  final String humanText;
  const CharacterSpecies(this.humanText);
  }
enum CharacterStatus { 
  alive("Alive"), 
  unknown("unknown"), 
  dead("Dead"), 
  empty("");
  final String humanText;
  const CharacterStatus(this.humanText);
   }
enum CharacterGender { 
  male("Male"), 
  female("Female"), 
  unknown("unknown"), 
  empty("");
  final String humanText;
  const CharacterGender(this.humanText);
   }
