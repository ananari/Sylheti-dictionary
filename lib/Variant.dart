import './Word.dart';

class Variant extends Word {
  String ipaLexeme, pos, etymology, definition, relation, wordId, flexId, bengEq, semDomain;
  int id;
  Variant({this.ipaLexeme, this.pos, this.etymology, this.definition, this.id, this.relation = "unspecified", this.wordId, this.flexId, this.bengEq, this.semDomain}):
        super(ipaLexeme: ipaLexeme, pos: pos, etymology: etymology, id: id, definition: definition, flexId: flexId, semDomain: semDomain);

  String toString() {
    String str = "ipaLexeme: $ipaLexeme, pos: $pos, etymology: $etymology, definition: $definition, relation: $relation, wordId: $wordId, flexId: $flexId, bengEq: $bengEq, semDomain: $semDomain, id: $id\n";
    return str;
  }
}