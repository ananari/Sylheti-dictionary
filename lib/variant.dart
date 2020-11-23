import './word.dart';

class Variant extends Word {
  String relation;
  int wordId;
  Variant({String ipaLexeme, String pos, String etymology, String definition, int id, String relation = "unspecified", int wordId}):
        super(ipaLexeme: ipaLexeme, pos: pos, etymology: etymology, id: id, definition: definition);
}