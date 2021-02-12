// import 'package:html/dom.dart';
// import 'package:html/parser.dart';
// import 'package:http/http.dart' as http;
// import './Word.dart';
// import './Variant.dart';
// import 'dart:convert';
//
// void main() async {
//   final response = await http.Client().get(Uri.parse('https://ananari.neocities.org/testwords.html'));
//   List words = [];
//   if(response.statusCode == 200){
//     String respBody = utf8.decode(response.bodyBytes);
//     var document = parse(respBody);
//     var children = document.children[0].children[1].children;
//     for(int i = 0; i < children.length; i++) {
//       if(children[i].attributes['class'] != "letHead"){
//         List<Word> stagedWords = makeWords(children[i]);
//         words = [...words, ...stagedWords];
//       }
//     }
//   }
//   print(words);
// }
//
// List<Word> makeWords(Element el){
//   var word;
//   if(el.attributes["class"] == "minorentryvariant" || el.attributes["class"] == "minorentrycomplex"){
//     word = new Variant();
//   }
//   else{
//     word = new Word();
//   }
//   List<Word> stagedWords = [];
//   List<Map> stagedVariants = [];
//   word.flexId = el.attributes["id"];
//   for(int i = 0; i < el.children.length; i++){
//     switch(el.children[i].attributes["class"]){
//       case "mainheadword":
//       case "headword": {
//         Map wordInfo = makeHeadword(el.children[i]);
//         word.ipaLexeme = wordInfo["ipaLexeme"];
//         word.flexId = wordInfo["flexId"];
//       }
//       break;
//       case "variantformentrybackrefs": {
//         List newVariants = makeVariantEntries(el.children[i]);
//         stagedVariants = [...stagedVariants, ...newVariants];
//       }
//       break;
//       case "senses": {
//         Map senses = makeSenses(el.children[i]);
//         word.pos = senses["pos"];
//         word.definition = senses["definition"];
//       }
//       break;
//       case "nontrivialentryroots":
//       case "complexformsnotsubentries": {
//         for(int j = 0; j < el.children[i].children.length ; j++) {
//           if(el.children[i].children[j].attributes["class"] != "complexformtypes") {
//             stagedWords = [...stagedWords, ...makeWords(el.children[i].children[j])];
//           }
//         }
//       }
//       break;
//       case "subentries mainentrysubentries": {
//         for(int j = 0; j < el.children[i].children.length; j++) {
//           stagedWords = [...stagedWords, ...makeWords(el.children[i].children[j])];
//         }
//       }
//     }
//   }
//   stagedWords.add(word);
//   for(int i = 0; i < stagedVariants.length; i++){
//     Variant variant = word.makeVariant(ipaLexeme: stagedVariants[i]["ipaLexeme"], flexId: stagedVariants[i]["flexId"]);
//     stagedWords.add(variant);
//   }
//   return stagedWords;
// }
//
// Map makeHeadword(Element el){
//   //mainheadword (or headword) contains ipaLexeme and flexId
//   String ipaLexeme;
//   String flexId;
//   //ipaLexeme is the only text under mainword or headword
//   ipaLexeme = el.text;
//   //the flexId is always an href attribute on an a tag, but the depth of that tag can sometimes vary
//   flexId = el.children[0].children[0].attributes["href"] == null
//       ? el.children[0].children[0].children[0].attributes["href"]
//       : el.children[0].children[0].attributes["href"];
//   return {
//     "ipaLexeme": ipaLexeme,
//     "flexId": flexId
//   };
// }
//
// List makeVariantEntries(Element el){
//   List stagedVariants = [];
//   //looping through all variantformentrybackrefs
//   for(int i = 0; i < el.children.length; i++){
//     if(el.children[i].attributes["class"] == "variantformentrybackref"){
//       //each variantformentrybackref just consists of a headword
//       Map variantMap = makeHeadword(el.children[i].firstChild);
//       stagedVariants.add(variantMap);
//     }
//   }
//   return stagedVariants;
// }
//
// Map makeSenses(Element el){
//   String pos;
//   Map senseContent;
//   for(int i = 0; i < el.children.length; i++){
//     switch(el.children[i].attributes["class"]){
//       case "sharedgrammaticalinfo": {
//         pos = el.children[i].text;
//       }
//       break;
//       case "sensecontent": {
//         senseContent = makeSenseContent(el.children[i].children[0]);
//       }
//     }
//   }
//   return {
//     "pos": pos,
//     "definition": senseContent["definition"],
//     "examples": senseContent["examples"],
//     "semDomains": senseContent["semDomains"],
//     "synonyms": senseContent["synonyms"]
//   };
// }
//
// Map makeSenseContent(Element el){
//   String definition;
//   List examples = [];
//   List synonyms = [];
//   List semDomains = [];
//   for(int i = 0; i < el.children.length; i++){
//     switch(el.children[i].attributes["class"]){
//       case "definitionorgloss": {
//         definition = el.children[i].text;
//       }
//       break;
//       case "examplescontents": {
//         //eventually replace with example class and wordexample link
//         examples = makeExamples(el.children[i]);
//       }
//       break;
//       case "lexsensereferences": {
//         //gotta work our way down to where the configtargets are
//         //also eventually replace these with a synonymity wordlink
//         for(int j = 0; j < el.children[i].children[0].children.length; j++) {
//           switch(el.children[i].children[0].children[j].attributes["class"]){
//             case "configtargets": {
//               synonyms = makeSynonyms(el.children[i].children[0].children[j]);
//             }
//           }
//
//         }
//       }
//       break;
//       case "semanticdomains": {
//         semDomains = makeSemDomains(el.children[i]);
//       }
//     }
//   }
//   return {
//     "definition": definition,
//     "examples": examples,
//     "synonyms": synonyms,
//     "semDomains": semDomains
//   };
// }
//
// List makeExamples(Element el){
//   List examples = [];
//   for(int i = 0; i < el.children.length; i++) {
//     examples.add(makeExample(el.children[i]));
//   }
//   return examples;
// }
//
// Map makeExample(Element el){
//   //body refers to the sylheti text, translation refers to the english text, as visible in the SemDomain class
//   String body;
//   String translation;
//   for(int i = 0; i < el.children.length; i++) {
//     switch(el.children[i].attributes["class"]){
//       case "example": {
//         body = el.children[i].text;
//       }
//       break;
//       case "translationcontents": {
//         translation = el.children[i].text;
//       }
//     }
//   }
//   return {
//     "body": body,
//     "translation": translation
//   };
// }
//
// List makeSemDomains(Element el){
//   List semDomains = [];
//   for(int i = 0; i < el.children.length; i++) {
//     semDomains.add(makeSemDomain(el.children[i]));
//   }
//   return semDomains;
// }
//
// Map makeSemDomain(Element el){
//   String abbreviation, name;
//   for(int i = 0; i < el.children.length; i++) {
//     switch(el.children[i].attributes["class"]){
//       case "abbreviation": {
//         abbreviation = el.children[i].text;
//       }
//       break;
//       case "name": {
//         name = el.children[i].text;
//       }
//     }
//   }
//   return {
//     "abbreviation": abbreviation,
//     "name": name
//   };
// }
//
// List makeSynonyms(Element el){
//   List synonyms = [];
//   for(int i = 0; i < el.children.length; i++) {
//     synonyms.add(makeWords(el.children[i]));
//   }
//   return synonyms;
// }