
Map inflect(Map word) {
  String stem;

  // describing verbal inflection
  if(word["pos"] == "v") {
    String verbalNoun = word["ipa"];
    String infinitive, pastParticiple, conditional;
    List pastParticipleForms, simplePresent, presentContinuous, simplePast, pastContinuous, perfect, pluperfect, future, imperative;
    // inflecting normal verbs
    if(word["ipa"].endsWith("a")) {
      // checking if stem is of the form consonant-vowel-consonant
      RegExp cvc = new RegExp(r"t?[kxgŋszʈɖtdnpfɸbmrlʃhɽ][aiueoɔáíúéó́][kxgŋszʈɖtdnpfɸbmrlʃhɽ]\b");
      if(cvc.firstMatch(word["ipa"].substring(0, word["ipa"].length - 1)) != null) {
        stem = word["ipa"].substring(0, word["ipa"].length - 1);
        // impersonal forms
        infinitive = stem + "te";
        pastParticiple = stem + "ia";
        pastParticipleForms = [pastParticiple, stem.substring(0, stem.length - 1) + "i" + stem[stem.length-1] + "a"];
        conditional = stem + "le";

        /* all personal forms are of the order:
          1st person
          2nd person super informal
          2nd person medial
          2nd person formal
          3rd person
           */

        simplePresent = [stem + "i", stem + "os", stem + "o", stem + "oin", stem + "e"];
        presentContinuous = [[stem + "iar", stem + "i ram", stem + "it ram"], stem + "re", stem + "rae", stem + "ra", stem + "er"];
        simplePast = [stem + "lam", stem + "le", stem + "lae", stem + "la", stem + "lo"];
        pastContinuous = [stem + "at aslam", stem + "at asle", stem + "at aslae", stem + "at asla", stem + "at asil"];
        perfect = [stem + "si", stem + "sos", stem + "so", stem + "soin", stem + "se"];
        pluperfect = [stem + "slam", stem + "sle", stem + "slae", stem + "sla", stem + "sil"];
        future = [[stem + "mu", stem + "um"], stem + "be", stem + "bae", stem + "ba", stem + "bo"];
        // no 1st person imperative
        imperative = ["", stem, stem + "o", stem + "oukka", stem + "uk"];

      }

    }
    // inflecting causative-type verbs
    else if(word["ipa"].endsWith("ni")) {
      stem = word["ipa"].substring(0, word["ipa"].length - 2);
    }
    else {
      return {"error": "no verbal inflection defined"};
    }
    return {
      "verbal noun": verbalNoun,
      "infinitive": infinitive,
      "past participle": pastParticipleForms.length > 1 ? pastParticipleForms : pastParticiple,
      "conditional": conditional,
      "simple present": simplePresent,
      "present continuous": presentContinuous,
      "simple past": simplePast,
      "past continuous": pastContinuous,
      "perfect": perfect,
      "pluperfect": pluperfect,
      "future": future,
      "imperative": imperative
    };
  }
  return {"error": "no inflection defined"};
}