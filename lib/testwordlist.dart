import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import './Word.dart';
import './Variant.dart';
import 'dart:convert';

void main() async {
  final response = await http.Client().get(Uri.parse('https://ananari.neocities.org/aword.html'), headers: {"charset": "utf-16"});
  List words = [];
  if(response.statusCode == 200){
    String respBody = utf8.decode(response.bodyBytes);
    var document = parse(respBody);
    var children = document.children[0].children[1].children;
    for(int i = 0; i < children.length; i++) {
      if(children[i].attributes['class'] != "letHead"){
        List<Word> stagedWords = makeWords(children[i]);
        words = [...words, ...stagedWords];
      }
    }
  }
  print(words);
}

List<Word> makeWords(Element el){
  var word;
  if(el.attributes["class"] == "minorentryvariant" || el.attributes["class"] == "minorentrycomplex"){
    word = new Variant();
  }
  else{
    word = new Word();
  }
  List<Word> stagedWords = [];
  List<Map> stagedVariants = [];
  word.flexId = el.attributes["id"];
  for(int i = 0; i < el.children.length; i++){
    switch(el.children[i].attributes["class"]){
      case "mainheadword":
      case "headword": {
        word.ipaLexeme = el.children[i].text;
        word.flexId = el.children[i].children[0].children[0].attributes["href"] == null
            ? el.children[i].children[0].children[0].children[0].attributes["href"]
            : el.children[i].children[0].children[0].attributes["href"];
      }
      break;
      case "variantformentrybackrefs": {
        for(int j = 0; j < el.children[i].children.length; j++){
          if(el.children[i].children[j].attributes["class"] == "variantformentrybackref"){
            Map variantMap = {"ipaLexeme": el.children[i].children[j].text,
              "flexId": el.children[i].children[j].children[0].children[0].children[0].attributes["href"].substring(1)};
            stagedVariants.add(variantMap);
          }
        }
      }
      break;
      case "senses": {
        word.pos = el.children[i].children[0].text;
        word.definition = el.children[i].children[1].children[0].children[0].text;
        if(el.children[i].children[1].children[0].children.length > 1) {
          for(int j = 0; j < el.children[i].children[1].children[0].children[1].children[0].children[1].children.length; j++){
            stagedWords = [...stagedWords, ...makeWords(el.children[i].children[1].children[0].children[1].children[0].children[1].children[j])];
          }
        }
      }
      break;
      case "nontrivialentryroots":
      case "complexformsnotsubentries": {
        for(int j = 0; j < el.children[i].children.length ; j++) {
          if(el.children[i].children[j].attributes["class"] != "complexformtypes") {
            stagedWords = [...stagedWords, ...makeWords(el.children[i].children[j])];
          }
        }
      }
      break;
      case "subentries mainentrysubentries": {
        for(int j = 0; j < el.children[i].children.length; j++) {
          stagedWords = [...stagedWords, ...makeWords(el.children[i].children[j])];
        }
      }
    }
  }
  stagedWords.add(word);
  for(int i = 0; i < stagedVariants.length; i++){
    Variant variant = word.makeVariant(ipaLexeme: stagedVariants[i]["ipaLexeme"], flexId: stagedVariants[i]["flexId"]);
    stagedWords.add(variant);
  }
  return stagedWords;
}