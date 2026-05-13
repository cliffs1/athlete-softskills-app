class SportType {
  static const String krepsinis = 'krepsinis';
  static const String tinklinis = 'tinklinis';
  static const String futbolas = 'futbolas';
}

class QuestionOption {
  final String id;
  final String text;
  final double weight;

  const QuestionOption({
    required this.id,
    required this.text,
    required this.weight,
  });
}

class SoftSkillQuestion {
  final String question;
  final List<QuestionOption> options;
  final Map<String, String> sportSpecificQuestions;
  final List<String> sportTypes;

  const SoftSkillQuestion({
    required this.question,
    required this.options,
    this.sportSpecificQuestions = const {},
    this.sportTypes = const [],
  });

  bool isForSport([String? sportType]) {
    return sportTypes.isEmpty ||
        (sportType != null && sportTypes.contains(sportType));
  }

  String getQuestionText([String? sportType]) {
    if (sportType != null && sportSpecificQuestions.containsKey(sportType)) {
      return sportSpecificQuestions[sportType]!;
    }

    return question;
  }
}

class SoftSkillQuestionCategory {
  final String id;
  final String title;
  final String dbSkillName;
  final List<SoftSkillQuestion> questions;

  const SoftSkillQuestionCategory({
    required this.id,
    required this.title,
    required this.dbSkillName,
    required this.questions,
  });
}

const List<SoftSkillQuestionCategory> softSkillQuestionCategories = [
  SoftSkillQuestionCategory(
    id: 'lyderyste',
    title: 'Lyderystė',
    dbSkillName: 'lyderystė',
    questions: [
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aikštėje tarp komandos draugų kyla nesutarimas po nesėkmingos atakos?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nekreipiate dėmesio ir tęsiate žaidimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Palaikote vieną komandos draugą ir kaltinate kitą',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote nuraminti situaciją, išklausote abi puses ir skatinate susitelkti į žaidimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate, kol treneris išspręs situaciją',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai paskutinėmis sekundėmis reikia priimti greitą sprendimą atakoje?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate imtis iniciatyvos',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Metate neįvertinęs situacijos',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Greitai įvertinate komandos draugų pozicijas ir priimate atsakingą sprendimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate komandos draugo nurodymo',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda pradeda pralaiminėti ketvirtajame kėlinyje?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susikoncentruojate tik į savo statistiką',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Rodote nusivylimą komandos draugais',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Motyvuojate komandą, palaikote draugus ir skatinate kovoti iki galo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio motyvacinės kalbos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas nepataiko svarbaus metimo?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Kritikuojate jo sprendimą mesti',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Nekreipiate dėmesio',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandos draugą ir skatinate pasitikėti savimi',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio reakcijos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai gynyboje trūksta komunikacijos?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tylite ir ginatės individualiai',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pykstate dėl kitų klaidų',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai komunikuojate ir organizuojate gynybą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio nurodymų',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda po kelių klaidų praranda koncentraciją?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pats prarandate motyvaciją',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Rodote nepasitenkinimą komandos draugais',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Skatinate komandą susikoncentruoti ir kovoti toliau',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio pertraukėlės',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai į komandą ateina naujas žaidėjas?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bendraujate tik su savo draugais komandoje',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Ignoruojate naują žaidėją',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Padedate jam pritapti prie komandos',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Manote, kad tai trenerio atsakomybė',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia mesti lemiamą metimą?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate atsakomybės',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Abejojate savimi ir delsate',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pasitikite savimi ir prisiimate atsakomybę',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Perduodate kamuolį kitam žaidėjui',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai rūbinėje prieš rungtynes jaučiama įtampa?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsiribojate nuo komandos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prisidedate prie neigiamų emocijų',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote pozityvią atmosferą ir motyvuojate komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio kalbos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas nesilaiko komandos taisyklių?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Ignoruojate situaciją',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Viešai kritikuojate žaidėją',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Ramiai pasikalbate ir primenate komandos atsakomybes',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Iškart pranešate treneriui',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotėje komanda dirba be energijos?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Dirbate tik dėl savęs',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skundžiatės komandos požiūriu',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote motyvuoti komandą ir palaikyti energiją',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nieko nedarote',
            weight: 0,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po skaudaus pralaimėjimo?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate bendravimo su komanda',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate kitus dėl nesėkmės',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandą ir skatinate mokytis iš klaidų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio analizės',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aikštėje tarp žaidėjų kyla konfliktas dėl praleisto įvarčio?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Ignoruojate situaciją',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate vieną žaidėją dėl klaidos',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote suvienyti komandą ir skatinate susitelkti į tolimesnį žaidimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate, kol konfliktą sustabdys treneris ar kapitonas',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia greitai priimti sprendimą kontratakos metu?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate priimti sprendimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimate impulsyvų sprendimą neįvertinęs situacijos',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Greitai įvertinate komandos draugų pozicijas ir pasirenkate geriausią sprendimą komandai',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kitų žaidėjų iniciatyvos',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda praleidžia kelis įvarčius ir praranda pasitikėjimą?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susitelkiate tik į savo žaidimą',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Rodote nepasitenkinimą komandos draugams',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Drąsinate komandą, palaikote žaidėjus ir skatinate nenuleisti rankų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Tikitės, kad situaciją pakeis trenerio sprendimai',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas suklysta gynyboje?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Kritikuojate jo klaidą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Ignoruojate situaciją',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote žaidėją ir skatinate susikoncentruoti',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio reakcijos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aikštėje trūksta komunikacijos?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tylite ir žaidžiate toliau',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Rodote pyktį komandos draugams',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedate aktyviau komunikuoti ir organizuoti komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kapitono iniciatyvos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda po kelių nesėkmių praranda motyvaciją?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pats prarandate pasitikėjimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate kitus žaidėjus',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Motyvuojate komandą ir skatinate kovoti iki galo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio motyvacijos',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai naujas žaidėjas jaučiasi atskirtas rūbinėje?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bendraujate tik su senais komandos draugais',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Ignoruojate naują žaidėją',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Stengiatės įtraukti jį į komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Manote, kad tai trenerio darbas',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia mušti lemiamą baudinį?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate atsakomybės',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Abejojate savo sprendimu',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pasitikite savimi ir prisiimate atsakomybę',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Perduodate galimybę kitam žaidėjui',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai rūbinėje tvyro bloga atmosfera?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsiribojate nuo komandos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prisidedate prie neigiamų emocijų',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote suvienyti komandą ir palaikyti pozityvumą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio kalbos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas nesilaiko disciplinos?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Ignoruojate situaciją',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Viešai kritikuojate žaidėją',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Ramiai pasikalbate ir primenate atsakomybes komandai',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Iškart pranešate treneriui',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotėje komanda dirba vangiai?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Dirbate tik dėl savo rezultatų',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skundžiatės komandos darbu',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote pakelti komandos energiją ir motyvaciją',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nieko nedarote',
            weight: 0,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po skaudaus pralaimėjimo?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate bendravimo su komanda',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate komandos draugus',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandą ir skatinate mokytis iš klaidų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio analizės',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai po nesėkmingo epizodo tarp komandos draugų kyla įtampa?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsiribojate nuo situacijos',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Palaikote vieną žaidėją ir kritikuojate kitą',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote nuraminti komandą ir skatinate susitelkti į kitą tašką',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio įsikišimo',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai svarbiu momentu reikia nuspręsti, kaip užbaigti ataką?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bijote prisiimti atsakomybę',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Veikiate impulsyviai',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Įvertinate situaciją ir priimate komandai naudingiausią sprendimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kitų komandos draugų sprendimo',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda pralaimi kelis taškus iš eilės?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Užsidarote savyje ir susitelkiate tik į save',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedate reikšti nepasitenkinimą komanda',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandos draugus ir skatinate išlaikyti gerą atmosferą aikštėje',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio pertraukėlės motyvacijai pakelti',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas suklysta priimdamas kamuolį?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Parodote nepasitenkinimą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Nekreipiate dėmesio',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote žaidėją ir skatinate susikoncentruoti',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio reakcijos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aikštėje trūksta komunikacijos?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tylite ir koncentruojatės tik į save',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pykstate dėl kitų klaidų',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai komunikuojate ir organizuojate komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kapitono iniciatyvos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda po kelių klaidų praranda motyvaciją?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pats prarandate pasitikėjimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Rodote nepasitenkinimą komanda',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandą ir skatinate kovoti toliau',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio pertraukėlės',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai į komandą ateina naujas žaidėjas?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bendraujate tik su artimiausiais komandos draugais',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Ignoruojate naują žaidėją',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Padedate jam pritapti komandoje',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Manote, kad tai trenerio atsakomybė',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia atlikti svarbų padavimą rungtynių pabaigoje?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate atsakomybės',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Abejojate savimi',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pasitikite savimi ir prisiimate atsakomybę',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Tikitės, kad tai atliks kitas žaidėjas',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai prieš rungtynes komandoje jaučiama įtampa?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsiribojate nuo komandos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prisidedate prie neigiamų emocijų',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote palaikyti gerą atmosferą ir motyvuoti komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio motyvacijos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas nesilaiko komandos taisyklių?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Ignoruojate situaciją',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Viešai kritikuojate žaidėją',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Ramiai pasikalbate ir primenate atsakomybes komandai',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Iškart kreipiatės į trenerį',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotėje komanda dirba pasyviai?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Koncentruojatės tik į savo žaidimą',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skundžiatės komandos darbu',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Motyvuojate komandą ir palaikote gerą atmosferą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nieko nedarote',
            weight: 0,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po skaudaus pralaimėjimo?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsiribojate nuo komandos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate kitus žaidėjus',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandą ir skatinate mokytis iš klaidų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio analizės',
            weight: 4,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'emociju_reguliavimas',
    title: 'Emocijų reguliavimas',
    dbSkillName: 'emocijų valdymas',
    questions: [
      SoftSkillQuestion(
        question:
            'Greitoje atakoje nepataikote visiškai laisvo metimo iš po krepšio (apmaudi klaida). Kokia jūsų reakcija?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Supykstu ant savęs ir visą kitą ataką galvoju apie klaidą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu komandos draugą, kad davė blogą perdavimą',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Greitai ją pamirštu, giliai įkvepiu ir iškart bėgu atidirbti gynyboje',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nuleidžiu rankas ir nustoju stengtis',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treneris minutės pertraukėlės metu prie visos komandos griežtai aprėkia jus dėl pamesto varžovo gynyboje. Kaip su tuo susitvarkote?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu teisintis ir atsikalbinėti',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išklausau, atskiriu emocijas nuo faktų ir žengęs į aikštę pakeičiu savo poziciją',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Tyliu, bet viduje jaučiu stiprų pyktį ir toliau žaidžiu be energijos',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Visiškai ignoruoju pastabą ir darau savo',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Likus kelioms minutėms iki finalinių rungtynių pradžios jaučiate didelį jaudulį, prakaituoja delnai. Kokių veiksmų imatės?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pasiduodu panikai ir galvoju, kad tuoj susimausiu',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Bandau viską užgniaužti ir apsimesti, kad nejaudinu',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Priimu jaudulį kaip natūralų ir atlieku sąmoningo kvėpavimo pratimus',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Skundžiuosi komandos draugams, taip keldamas įtampą ir jiems',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Teisėjas jums skiria pražangą, kurios, esate 100% tikras, nebuvo. Ką darote?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Giliai įkvepiu, pakeliu ranką ir grįžtu į gynybą, neleisdamas tam sugadinti mano žaidimo',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Agresyviai rėkiu ant teisėjo, rizikuodamas gauti techninę pražangą',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Visą kėlinį galvoju apie neteisybę ir prarandu motyvaciją',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Iš pykčio specialiai grubiai prasižengiu kitoje atakoje',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Jus dengiantis varžovas nuolat naudoja nešvarius triukus (žnaibosi, stumdo alkūnėmis) ir provokuoja žodžiais. Kaip reaguojate?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susinervinu ir prarandu savitvardą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Atsakau tuo pačiu ir pradedu žaisti nešvariai',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Išlaikau šaltą protą, ignoruoju žodžius ir nubaudžiu jį pelnydamas taškus',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prašau trenerio mane pakeisti, nes neatlaikau spaudimo',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Rungtynių pabaigoje komandos draugas padaro kvailą klaidą (pvz., išmeta kamuolį į užribį), dėl kurios pralaimite rungtynes. Ką darote?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Garsiai jį aprėkiu aikštelėje',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Nusiviliu ir rūbinėje su juo nešneku',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prieinu, nuraminu jį ir pasakau, kad laimime ir pralaimime kartu kaip komanda',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Rūbinėje trankau spinteles iš pykčio',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Dėl kelių iš eilės padarytų klaidų treneris jus pasodina ant suolo dar pirmajame kėlinyje. Ką jaučiate ir darote?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Įsižeidžiu, nusisuku nuo aikštės ir ignoruoju rungtynes',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Raminu emocijas, stebiu žaidimą nuo suolo ir laukiu šanso ištaisyti klaidas',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedu pyktis su asistentais ar draugais ant suolo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Susitaikau su tuo, kad šiandien esu nenaudingas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Paskutinę sekundę prametatate lemiamą tritaškį, galėjusį išplėšti pergalę. Kokia jūsų reakcija po rungtynių?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Užsidarau savyje, save grauždamas kelias dienas',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu komandos draugą, kad per vėlai atidavė perdavimą',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pripažįstu liūdesį, bet priimu tai kaip pamoką ir kitą dieną einu į salę tobulinti metimo',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nusprendžiu, kad niekada daugiau neimsiu lemiamo metimo',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Grįžtate po čiurnos traumos ir jaučiate baimę veržtis po krepšiu. Kaip valdote šią emociją?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pripažįstu baimę, bet sąmoningai verčiu save atlikti kontaktinius judesius per treniruotes, kol ji dingsta',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Visiškai vengiu kontakto ir žaidžiu tik ties tritaškiu',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Slepiu baimę nuo trenerio ir nuolat žaidžiu įsitempęs (rizikuoju vėl gauti traumą)',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pykstu ant savęs, kad esu toks bailys',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Trečiajame kėlinyje atsiliekate 25 taškų skirtumu, komandai niekas nesiseka. Kaip jaučiatės?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nuleidžiu rankas ir žaidžiu be energijos laukdamas sirenos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu žaisti savanaudiškai, kad bent jau susirenkčiau asmeninę statistiką',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Kaltinu teisėjus dėl prasto rezultato',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sugeneruoju pyktį į sportinį agresyvumą ir stengiuosi laimėti bent jau atskirus mikroepizodus (gynybą, atkovotus kamuolius)',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Turėjote labai blogą dieną (prastas pažymys ar ginčas namuose). Kaip tai veikia atėjus į krepšinio treniruotę?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Būnu irzlus ir lieju pyktį ant komandos draugų',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Treniruojuosi be nuotaikos, viską darydamas „autopilotu“',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Sąmoningai palieku problemas už salės durų ir naudoju krepšinį kaip terapiją emocijoms iškrauti',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Simuliuoju traumą, kad nereikėtų sportuoti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Išvykos rungtynėse varžovų fanai kiekvieną jūsų prisilietimą prie kamuolio palydi švilpimu ir patyčiomis. Kaip reaguojate?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Supykstu ir bandau jiems atkeršyti provokuojančiais gestais',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Susigūžiu ir stengiuosi rečiau gauti kamuolį',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Priimu jų švilpimą kaip komplimentą (vadinasi, manęs bijo) ir paverčiu tai papildoma energija žaidimui',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prarandu savitvardą ir pradedu klysti lygioje vietoje',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Lengvą varžovų padavimą priimate (pasuojate) tiesiai į tribūnas. Kokia jūsų reakcija?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Ilgai keikiuosi ir negaliu susikaupti kitam taškui',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu salės apšvietimą arba kamuolio kokybę',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pripažįstu klaidą, giliai įkvepiu ir iškart ruošiuosi kitam padavimui',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nuleidžiu rankas ir nustoju stengtis',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treneris per minutės pertraukėlę prie visų pasako griežtą pastabą, kad nespėjate į bloką. Kaip su tuo susitvarkote?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu teisintis, kad varžovų kėlėjas per greitas',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išklausau, „nuryju“ emociją ir žengęs į aikštę aktyviau dirbu kojomis',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Tyliu, bet viduje jaučiu didelį pyktį ir toliau blokuoju prastai',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Visiškai ignoruoju pastabą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Likus kelioms minutėms iki lemiamo (penkto) seto, jaučiate stiprų jaudulį, širdis kalatojasi. Kokių veiksmų imatės?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pasiduodu panikai ir bijau priimti kamuolį',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Bandau viską užgniaužti, nors rankos įsitempusios',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Priimu jaudulį, padarau kelis gilius įkvėpimus ir primenu sau techniką',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Skundžiuosi komandos draugams, koks baisus spaudimas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Teisėjas nefiksuoja aiškaus varžovų prisilietimo prie tinklo ir atiduoda jiems lemiamą tašką. Ką darote?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Išlaikau savitvardą, nuraminu komandą ir ruošiuosi atsiimti tašką savo jėgomis',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Agresyviai rėkiu ant teisėjo, rizikuodamas gauti kortelę (baudos tašką)',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Iš pykčio pradedu daužyti kamuolį į žemę',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prarandu motyvaciją ir nuleidžiu rankas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Varžovų puolėjas po sėkmingo smūgio specialiai žiūri į jus per tinklą ir bando išprovokuoti. Kaip reaguojate?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susinervinu ir prarandu savitvardą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu rėkauti jam atgal',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Ignoruoju jį, nusišypsau ir koncentruojuosi, kaip jį užblokuoti kitoje atakoje',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prašau trenerio mane pakeisti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Komandos draugas (kėlėjas) lemiamu metu atiduoda jums labai prastą, per žemą perdavimą, dėl kurio smūgiuojate į tinklą. Ką darote?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Garsiai jį aprėkiu',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prieinu, paliečiu jam per petį ir pasakau „nieko tokio, kitą padarysim geriau“',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nusiviliu ir nebežiūriu į jo pusę',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu rodyti nepasitenkinimo gestus publikai',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Po poros „ace“ (neatremiamų padavimų) į jūsų zoną, treneris jus pakeičia. Ką jaučiate ir darote?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Raminu emocijas, stoviu su atsarginiais, palaikau komandą ir analizuoju padavėjo techniką',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Įsižeidžiu ir atsisėdu suolelio gale ignoruodamas rungtynes',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedu pyktis su treneriu',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Susitaikau su tuo, kad esu bevertis žaidėjas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Paskutinę rungtynių minutę atliekate padavimą ir smūgiuojate tiesiai į tinklą, pralaimėdami mačą. Kokia jūsų reakcija?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Užsidarau savyje ir kelias dienas analizuoju tik tą klaidą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu salės sąlygas',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pripažįstu liūdesį, bet priimu tai kaip pamoką ir kitą treniruotę atlieku 50 papildomų padavimų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nusprendžiu, kad lemiamų padavimų daugiau nebemušiu',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Grįžtate po kelio traumos ir jaučiate baimę šokti maksimaliu aukščiu. Kaip valdote šią emociją?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Visiškai vengiu šokinėti ir tik permušinėju kamuolį',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Slepiu baimę ir šoku ne pilna jėga (galiu vėl susižeisti)',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pripažįstu baimę, kalbuosi su fizioterapeutu ir palaipsniui treniruotėse didinu apkrovą, kol įgaunu pasitikėjimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pykstu ant savęs, kad bijau',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Setą atsiliekate 5:15, niekas nesigauna. Kaip jaučiatės?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nuleidžiu rankas ir žaidžiu be energijos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu kėlėją, kad neduoda gerų kamuolių',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Sutelkiu komandą, pasakau, kad pamirštume rezultatą ir tiesiog žaistume dėl kiekvieno artimiausio taško',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu bet kaip daužyti kamuolį',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Turėjote blogą dieną darbe ar universitete. Kaip tai veikia jūsų tinklinio treniruotę?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Sąmoningai atskiriu problemas, įžengiu į salę švaria galva ir mėgaujuosi žaidimu',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Būnu irzlus ir pykstu ant komandos draugų',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Treniruojuosi be nuotaikos, nestatydamas kojų į priėmimą',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Simuliuoju traumą, kad nereikėtų sportuoti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Išvykoje paduodant kamuolį varžovų fanai pradeda pūsti dūdas tiesiai jums už nugaros. Kaip reaguojate?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Supykstu ir bandau jiems atkeršyti smūgiuodamas kuo stipriau (ir klystu)',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimu tai kaip iššūkį, šypteliu ir paverčiu jų triukšmą motyvacija atlikti tobulą padavimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Susigūžiu ir paduodu lengvą kamuolį',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prarandu savitvardą ir numetu kamuolį',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Savo aikštės pusėje apmaudžiai prarandate kamuolį ir varžovai sukuria pavojingą ataką. Kokia jūsų reakcija?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Supykstu ant savęs ir sustoju vietoje iš apmaudo',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu gynėją, kad jis man nepadėjo',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Iškart bėgu atgal į gynybą bandydamas ištaisyti klaidą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nuleidžiu rankas ir nustoju stengtis',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treneris nuo šoninės linijos prie visų rėkia ant jūsų, kad negrįžtate į gynybą. Kaip su tuo susitvarkote?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu rodyti jam gestus ir atsikalbinėti',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: '„Nuryju“ ego, suprantu pastabos esmę ir padidinu darbo krūvį aikštėje',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Tyliu, bet viduje įsižeidžiu ir toliau bėgioju lėtai',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Visiškai ignoruoju trenerį',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Stovite tunelyje likus kelioms minutėms iki išėjimo į svarbias rungtynes, jaučiate didelį jaudulį. Kokių veiksmų imatės?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pasiduodu panikai ir bijau priimti pirmą perdavimą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimu jaudulį, atlieku kelis gilius įkvėpimus ir vizualizuoju sėkmingus savo veiksmus',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandau viską užgniaužti ir atrodyti kietas',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Skundžiuosi komandos draugams, koks jaučiuosi įsitempęs',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Teisėjas skiria baudinį į jūsų vartus už švarią jūsų pražangą (kurios nebuvo). Ką darote?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Agresyviai bėgu prie teisėjo ir rėkiu jam į veidą (gaunu geltoną kortelę)',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Numalšinu pyktį, atsitraukiu, kad negaučiau kortelės, ir ruošiuosi kovoti toliau',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Iš pykčio spiriu kamuolį į tribūnas',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nuleidžiu rankas ir nusprendžiu, kad rungtynės papirktos',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Jus dengiantis gynėjas nuolat žaidžia nešvariai – gnybia, mina ant kojų, provokuoja žodžiais. Kaip reaguojate?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Neišlaikau ir jam atkeršiju stipriu smūgiu per kojas',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu rėkauti ir skųstis teisėjui kiekviename žingsnyje',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Kontroliuoju pyktį ir nubaudžiu jį sėkmingu žaidimu – apsivarau ir sukuriu progą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu vengti to krašto ir prašau keitimo',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Jūsų komandos vartininkas praleidžia kuriozinį įvartį (išmeta kamuolį iš rankų). Ką darote?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Garsiai jį aprėkiu prie visų žiūrovų',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Susinervinu ir nusisuku',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prieinu prie vartininko, suploju rankomis ir pasakau, kad atlošime šį įvartį',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu gestikuliuoti rodydamas nepasitenkinimą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Po prasto pirmojo kėlinio treneris jus pakeičia per pertrauką. Ką jaučiate ir darote?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Įsižeidęs iškart išeinu į dušą ir negrįžtu ant suolo',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Numalšinu ego, atsisėdu su komanda, palaikau draugus ir padarau išvadas kitai treniruotei',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedu pyktis su treneriu persirengimo kambaryje',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Susitaikau su tuo, kad esu prastas žaidėjas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            '90-tą minutę išeinate vienas prieš vartininką ir nepataikote į tuščius vartus. Kokia jūsų reakcija po rungtynių?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Graužiu save kelias savaites ir prarandu pasitikėjimą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu nelygią aikštės veją',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Priimu emociją, bet kitą treniruotę pasilieku papildomai mušti į vartus',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nusprendžiu daugiau nebesiveržti į puolimą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Grįžtate po raumens plyšimo ir jaučiate baimę eiti į 50/50 mikrodvikovą (kovą dėl kamuolio). Kaip valdote emociją?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pripažįstu baimę, bet palaipsniui pratinu save prie kontakto treniruotėse, kol įgaunu drąsą',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Visiškai vengiu dvikovų ir tik atsimušinėju',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Slepiu baimę ir einu į dvikovas užsimerkęs',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pykstu ant savęs, kad esu toks silpnas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Iki kėlinio pabaigos lieka 10 minučių, atsiliekate 0:4. Kaip jaučiatės?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nuleidžiu rankas ir tiesiog vaikštau po aikštę',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu nešvariai žaisti prieš varžovus iš pykčio',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Kaltinu komandos draugus dėl prastos gynybos',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Surandu savyje sportinio pykčio ir stengiuosi laimėti bent jau antrąjį kėlinį arba įmušti paguodos įvartį',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Atvykstate į rungtynes susinervinęs dėl asmeninių problemų. Kaip tai veikia jūsų žaidimą?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Sąmoningai palieku problemas rūbinėje ir futbolo aikštę naudoju kaip erdvę išvalyti mintims',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Būnu agresyvus ir rėkiu ant komandos draugų',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Žaidžiu be nuotaikos, nesistengdamas atimti kamuolio',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Simuliuoju traumą, kad nereikėtų žaisti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Einate kelti kampinio, o varžovų sirgaliai įžeidinėja jus asmeniškai. Kaip reaguojate?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Parodau jiems nepadorų gestą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Šypteliu, priimu jų pyktį kaip įrodymą, kad esu geras žaidėjas, ir atlieku tobulą perdavimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Susigūžiu ir atiduodu kamuolį kelti kitam žaidėjui',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Supykstu ir per stipriai išspiriu kamuolį į užribį',
            weight: 3,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'streso_valdymas',
    title: 'Streso valdymas',
    dbSkillName: 'streso valdymas',
    questions: [
      SoftSkillQuestion(
        question:
        'Kaip elgiatės, kai rungtynių pabaigoje rezultatas lygus ir turite atlikti lemiamą veiksmą?',
        options: [
          QuestionOption(
            id: 'a',
            text:
            'Vengiate atsakomybės ir stengiatės perduoti ją komandos draugams',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Skubate atlikti veiksmą, norėdamas kuo greičiau atsikratyti įtampos',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Priimate atsakomybę, atsiribojate nuo spaudimo ir susitelkiate į atlikimo techniką',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Panikuojate ir galvojate tik apie tai, kokios bus pasekmės, jei nepavyks',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
        'Kaip reaguojate, kai varžybų metu varžovai stipriai spaudžia, o komandai viskas klostosi ne pagal planą?',
        options: [
          QuestionOption(
            id: 'a',
            text:
            'Pasiduodate stresui ir prarandate motyvaciją toliau kovoti',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Pradedate elgtis chaotiškai arba agresyviai',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Nusiraminate, „nusinulinate“ ir susitelkiate tik į vieną artimiausią užduotį (žingsnis po žingsnio)',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Tikitės, kad sėkmė atsisuks į jūsų pusę pati, nekeisdamas žaidimo plano',
            weight: 7,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
        'Kaip tvarkotės su įtampa dieną prieš labai svarbias varžybas ar turnyrą?',
        options: [
          QuestionOption(
            id: 'a',
            text:
            'Nuolat galvojate apie varžybas, taip dar labiau didindamas savo nerimą',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Stengiatės išsiblaškyti naršant telefone iki išnaktų ir prarandate poilsį',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Naudojate atsipalaidavimo technikas (pvz., kvėpavimo pratimus, vizualizaciją), kad nuramintumėte mintis',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Bandote ignoruoti jaudulį ir apsimetate, kad varžybos visiškai nesvarbios',
            weight: 5,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'komandinis_darbas',
    title: 'Komandinis darbas',
    dbSkillName: 'komandinis darbas',
    questions: [
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda turi greitai priimti sprendimą greitos atakos metu?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Priimate sprendimą vienas, nepasitaręs',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate, kol kiti nuspręs',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bendraujate su komandos draugais ir priimate sprendimą kartu',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sekate tik trenerio nurodymus',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip prisidedate prie bendro komandos tikslo rungtynių metu?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Koncentruojatės tik į savo statistiką',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Dirbate komandai tik tada, kai tai patogu',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prisitaikote prie situacijos ir aktyviai padedate komandai',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atliekate tik savo pagrindinę rolę',
            weight: 6,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip bendraujate su komandos draugais gynyboje?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nebendraujate ir ginatės individualiai',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kalbate tik esant būtinybei',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nuolat komunikuojate ir organizuojate gynybą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Kalbate daug, bet ne visada konstruktyviai',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas yra geresnėje pozicijoje mesti?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Metate pats',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kartais perduodate kamuolį',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Perduodate kamuolį geresnėje pozicijoje esančiam žaidėjui',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Dvejojate ir prarandate progą atakai',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po komandos draugo klaidos?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Rodote nepasitenkinimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Ignoruojate situaciją',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandos draugą ir skatinate tęsti žaidimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio reakcijos',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia padėti komandos draugui gynyboje?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nesikišate į situaciją',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Padedate tik jei labai būtina',
            weight: 5,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai padedate ir komunikuojate',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate, kol kiti sureaguos',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės treniruotėse atliekant komandines užduotis?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Dirbate tik dėl savo progreso',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prisidedate minimaliai',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bendradarbiaujate ir skatinate kitus',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atliekate tik tai, kas liepta',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda pralaimi?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Koncentruojatės tik į savo žaidimą',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate komandos draugus',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote palaikyti komandą ir susitelkti kartu',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio motyvacijos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aikštėje kyla nesusikalbėjimas?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tylite ir tęsiate žaidimą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Rodote pyktį komandos draugams',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote aiškiai komunikuoti ir išspręsti situaciją',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kapitono sprendimo',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia atlikti „juodą darbą“ komandoje?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate tokių užduočių',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Atliekate tik kai būtina',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prisidedate prie komandos darbo be nusiskundimų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atliekate tik savo pagrindines pareigas',
            weight: 6,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai naujas žaidėjas prisijungia prie komandos?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nebendraujate su nauju žaidėju',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Bendraujate minimaliai',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Padedate jam įsilieti į komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Manote, kad tai trenerio darbas',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės svarbiu rungtynių momentu?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bandote viską atlikti vienas',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate kitų iniciatyvos',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bendradarbiaujate su komanda siekdami geriausio sprendimo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sekate tik iš anksto numatytą planą',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda turi greitai priimti sprendimą kontratakos metu?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bandote pats užbaigti ataką',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate, kol kiti nuspręs',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bendraujate su komandos draugais ir kartu pasirenkate geriausią sprendimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sekate tik trenerio nurodymus',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip prisidedate prie bendro komandos tikslo rungtynių metu?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Koncentruojatės tik į savo statistiką ar įvarčius',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Dirbate komandai tik tada, kai tai naudinga jums',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prisitaikote prie situacijos ir padedate komandai tiek puolime, tiek gynyboje',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atliekate tik savo pozicijos funkcijas',
            weight: 6,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip bendraujate su komandos draugais rungtynių metu?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tylite ir susitelkiate tik į savo žaidimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kalbate tik esant būtinybei',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nuolat komunikuojate ir organizuojate komandos veiksmus',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Kalbate daug, bet ne visada konstruktyviai',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas yra geresnėje pozicijoje pelnyti įvartį?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bandote smūgiuoti pats',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Perduodate tik kartais',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Atiduodate perdavimą geresnėje pozicijoje esančiam žaidėjui',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Dvejojate ir prarandate progą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po komandos draugo klaidos gynyboje?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Rodote nepasitenkinimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Ignoruojate situaciją',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandos draugą ir skatinate tęsti žaidimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio reakcijos',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia padėti komandos draugui gynyboje?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Paliekate jį gintis vieną',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Padedate tik jei būtina',
            weight: 5,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai grįžtate į gynybą ir komunikuojate',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kitų reakcijos',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės atliekant komandinį presingą?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Spaudžiate varžovus vienas',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate, kol pradės kiti',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Derinate veiksmus su visa komanda',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sekate tik kapitono nurodymus',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda praleidžia įvartį?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Koncentruojatės tik į savo žaidimą',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate komandos draugus',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandote palaikyti komandą ir išlaikyti susikaupimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio motyvacijos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aikštėje kyla nesusikalbėjimas?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tylite ir tęsiate žaidimą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pykstate ant komandos draugų',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aiškiai komunikuojate ir bandote sutvarkyti situaciją',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kapitono sprendimo',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia atlikti „juodą darbą“ komandoje?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate tokių užduočių',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prisidedate tik tada, kai būtina',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai prisidedate prie komandos darbo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atliekate tik savo pagrindines funkcijas',
            weight: 6,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai į komandą ateina naujas žaidėjas?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nebendraujate su juo',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Bendraujate minimaliai',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Padedate jam įsilieti į komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Manote, kad tai trenerio darbas',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės paskutinėmis rungtynių minutėmis?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bandote vienas pakeisti rungtynių eigą',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate kitų iniciatyvos',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bendradarbiaujate su komanda ieškodami geriausio sprendimo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sekate tik iš anksto numatytą taktiką',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda turi greitai priimti sprendimą dėl kamuolio priėmimo?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Veikiate vienas, neatsižvelgdamas į kitus',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate, kol sureaguos komandos draugai',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Komunikuojate su komanda ir kartu priimate sprendimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio nurodymų',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip prisidedate prie bendro komandos tikslo rungtynių metu?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Koncentruojatės tik į savo statistiką',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prisidedate tik tada, kai tai patogu',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prisitaikote prie situacijos ir aktyviai padedate komandai',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atliekate tik savo pagrindinę rolę',
            weight: 6,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip bendraujate su komandos draugais aikštėje?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nebendraujate ir susitelkiate tik į save',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kalbate tik esant būtinybei',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nuolat komunikuojate, informuojate ir palaikote komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Kalbate daug, bet ne visada konstruktyviai',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komandos draugas yra geresnėje pozicijoje užbaigti ataką?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bandote užbaigti ataką pats',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Perduodate kamuolį tik kartais',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pasirenkate komandos draugą geresnėje pozicijoje',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Dvejojate ir prarandate progą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po komandos draugo klaidos priimant kamuolį?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Rodote nepasitenkinimą',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Ignoruojate situaciją',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandos draugą ir skatinate tęsti žaidimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio reakcijos',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia padėti komandos draugui gynyboje?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nesikišate į situaciją',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Padedate tik jei būtina',
            weight: 5,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai judate ir padedate komandai gintis',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kitų reakcijos',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda nesusikalba dėl kamuolio?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tylite ir laukiate kitų veiksmų',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pykstate dėl nesusikalbėjimo',
            weight: 2,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai komunikuojate ir aiškiai kviečiate kamuolį',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kapitono iniciatyvos',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda pralaimi kelis taškus iš eilės?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Užsidarote savyje',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Rodote nepasitenkinimą komanda',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandą ir skatinate nenuleisti rankų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio pertraukėlės',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai reikia atlikti „juodą darbą“ aikštėje?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate tokių užduočių',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prisidedate tik kai būtina',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aktyviai prisidedate prie komandos darbo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atliekate tik savo pagrindines funkcijas',
            weight: 6,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai į komandą ateina naujas žaidėjas?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nebendraujate su nauju komandos nariu',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Bendraujate minimaliai',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Padedate jam pritapti ir įsilieti į komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Manote, kad tai trenerio atsakomybė',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės svarbiu rungtynių momentu?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bandote vienas išspręsti situaciją',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate kitų iniciatyvos',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bendradarbiaujate su komanda ieškodami geriausio sprendimo',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sekate tik iš anksto numatytą planą',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po skaudaus pralaimėjimo?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsiribojate nuo komandos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinate kitus žaidėjus',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikote komandą ir skatinate mokytis iš klaidų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate trenerio analizės',
            weight: 4,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'komunikacija',
    title: 'Komunikacija',
    dbSkillName: 'komunikacija',
    questions: [
      SoftSkillQuestion(
        question:
            'Varžybų metu jūsų komanda vis daro tą pačią klaidą, tačiau treneris nieko dėl to nedaro. Kokia jūsų reakcija?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pasiskųsite savo komandos draugui pertraukos metu',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Lauksite, kol treneris sureaguos ir imsis veiksmų',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Iš karto garsiai visai komandai pasakysite, kokia tai klaida ir kaip ją pataisyti',
            weight: 6,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Ramiai ir natūraliai pertraukos metu aptariate tai su komandos nariais',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Ką darysite, kai komandos draugas A ruošiasi svarbiam veiksmui, o komandos draugas B ruošiasi kitam lemiamam epizodui?',
        sportSpecificQuestions: {
          SportType.krepsinis:
              'Ką darysite, kai komandos draugas A ruošiasi mesti baudos metimą, kuris galėtų išlyginti rezultatą, o komandos draugas B ruošiasi priimti kamuolį greitos atakos metu ir veržtis prie krepšio?',
          SportType.tinklinis:
              'Ką darysite, kai komandos draugas A ruošiasi serviruoti, o komandos draugas B ruošiasi lemiamos atakos smūgiui?',
          SportType.futbolas:
              'Ką darysite, kai komandos draugas A ruošiasi smūgiuoti iš 11 metrų, o komandos draugas B ruošiasi bėgti į kontratakos sprintą?',
        },
        options: [
          QuestionOption(
            id: 'a',
            text: 'Garsiai raginsite ir palaikysite abu komandos draugus',
            weight: 6,
          ),
          QuestionOption(
            id: 'b',
            text:
                'Abiem komandos draugams duosite ramius, techninius patarimus',
            weight: 5,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Garsiai raginsite ir palaikysite komandos draugą A; komandos draugui B duosite ramų techninį patarimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Komandos draugui A duosite ramų techninį patarimą; garsiai raginsite ir palaikysite komandos draugą B',
            weight: 8,
          ),
        ],
      ),
      SoftSkillQuestion(
        question: 'Kaip reaguojate, kai padarote kritinę klaidą gynyboje?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Rankų gestais į viršų parodote savo nusivylimą',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text:
                'Nuleidžiate galvą ir grįžtate atgal į savo poziciją, kad neatkreiptumėte daug dėmesio į šią klaidą ir daugiau apie ją negalvotumėte',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Iš karto žiūrite į trenerį, laukiate iš jo paskatinimo',
            weight: 4,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Laikote galvą aukštai, susižvalgote su komandos nariais ir einate į savo poziciją tolimesniam žaidimui',
            weight: 10,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'pasitikejimas_savimi',
    title: 'Pasitikėjimas savimi',
    dbSkillName: 'pasitikėjimas savimi',
    questions: [
      SoftSkillQuestion(
        question: 'Kaip elgiatės, kai padarote dvi klaidas iš eilės, bet matote, kad jūsų komandos draugui reikia paskatinimo?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nežiūrite jam į akis, nenorite užvedinėti žmonių, kai pats nepasitikite savo jėgomis',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Prieinate ir pasakote, kad šiuo metu negalite padėti, nes pačiam sunku',
            weight: 7,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Garsiai šaukiate raginimo frazes, bandydamas užslėpti savo nepasitikėjimą ir abejones',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Palinksite ir palaikote akių kontaktą su komandos draugu, taip rodydamas savo pasiruošimą tolesniam žaidimui ir pasiliekate abejones sau',
            weight: 8,
          ),
        ],
      ),
      SoftSkillQuestion(
        question: 'Ką darytumėte, jei staiga atsitiktų situacija aikštėje, kuria reikia aptarti, bet esate naujoje komandoje?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Liekate tylus, nes dar neišsikovojote pagarbos',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Po treniruotės pasikalbat apie tai su treneriu',
            weight: 5,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Tyliai ir trumpai pasikalbate apie tai su šalia esančiu žaidėjo',
            weight: 5,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Garsiai paklausiate visų aplinkui, nes reikia žinoti visų pozicijas ir atsakomybes, kad situacija nepasikartotų',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question: 'Kaip reaguojate, kai treneris kritikuoja jus prieš visą komandą?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nuleidžiate galvą ir laukiat, kol ši situacija praeis',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Sutinkate su treneriu, bet kai jis nusisuka, ieškote palaikymo iš komandos draugų',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Pradedate teisintis, kodėl taip padarėte',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Palinksite galvą, pasiklausinėjate trenerio, jei reikia papildomos informacijos',
            weight: 7,
          ),
        ],
      )
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'koncentracija',
    title: 'Koncentracija',
    dbSkillName: 'koncentracija',
    questions: [
      SoftSkillQuestion(
        question:
            'Metate lemiamus baudos metimus išvykos rungtynėse, o varžovų fanai garsiai šaukia ir mojuoja balionais. Kaip elgiatės?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susinervinu ir prarandu metimo ritmą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Paskubinu metimą, kad kuo greičiau viskas baigtųsi',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Naudoju savo įprastą rutiną (įkvėpimas, kamuolio sumušimas), visą dėmesį nukreipdamas tik į lanką',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Stengiuosi juos ignoruoti, bet vis tiek galvoju apie triukšmą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Žaidimas netikėtai sustabdomas kelioms minutėms dėl teisėjų vaizdo peržiūros (angl. coach challenge). Kaip išlaikote dėmesį?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu bendrauti su žiūrovais ar komandos draugais apie nesusijusius dalykus',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Trumpai atsigeriu vandens ir mintyse pergalvoju artimiausią gynybinį ar puolimo veiksmą',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Tiesiog pasyviai stoviu ir laukiu sprendimo',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu labai nervintis dėl to, koks bus teisėjo sprendimas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Ketvirto kėlinio pabaiga, jaučiate didelį nuovargį, o komandai reikia idealiai atlikti sudėtingą derinį iš užribio. Kur sutelkiate mintis?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Galvoju tik apie tai, kaip stipriai esu pavargęs ir kaip dega plaučiai',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Primenu sau vieną „raktinį žodį“ (pvz., „gera užtvara“), kad išlaikyčiau fokusą į savo užduotį derinyje',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Žaidžiu iš inercijos, pernelyg nesusitelkdamas į detales',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Stengiuosi pasislėpti aikštelėje, kad nereikėtų priimti kamuolio',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Pabėgote į greitą ataką ir apmaudžiai nepataikėte visiškai laisvo metimo iš po krepšio. Kokia jūsų reakcija bėgant į gynybą?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Mintyse analizuoju, kodėl nepataikiau, ir nespėju grįžti į gynybą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Žiūriu į teisėją prašydamas pražangos, kurios nebuvo',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Garsiai keikiuosi ir nuleidžiu galvą',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Susitaikau su tuo ir iškart perjungiu dėmesį į savo dengiamą žmogų',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Teisėjas jums skiria pražangą, kurios, jūsų nuomone, tikrai nebuvo. Ką darote?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Priimu tai kaip faktą ir ruošiuosi atsikovoti kamuolį po varžovo metimų',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu agresyviai ginčytis su teisėju rizikuodamas gauti techninę',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Visą kitą ataką galvoju apie neteisybę ir prarandu koncentraciją',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Specialiai prasižengiu dar kartą iš pykčio',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Varžovas jus aktyviai gina ir nuolat naudoja „trash talk“ (provokuoja žodžiais). Kaip reaguojate?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsakau tuo pačiu ir pradedu su juo pyktis',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Prarandu kantrybę ir pradedu žaisti ne pagal komandos derinį',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Susitelkiu tik į krepšinio elementus (užtvaras, judėjimą), ignoruodamas jo žodžius',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Skundžiuosi teisėjui ir prašau jį nuraminti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Prieš rungtynes vėlavo autobusas, todėl apšilimo laikas sutrumpėjo perpus. Kaip tai veikia jūsų susikaupimą?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Panikuoju, kad nespėsiu apšilti, ir pradedu bet kaip mėtyti',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pykstu ant organizatorių ir negaliu susikaupti',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Koncentruojuosi į svarbiausius apšilimo elementus ir greičiau įeinu į varžybų ritmą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nusprendžiu, kad šiandien žaisiu prastai, nes nebuvo tinkamo apšilimo',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treneris jus pakelia nuo suolelio likus minutei iki kėlinio pabaigos su užduotimi tik apsiginti. Kaip greitai įsitraukiate?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Žengiu į aikštę žinodamas, ką dengiu ir kokia mūsų gynybos sistema',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išeinu šaltas ir tikiuosi, kad kamuolys nepapuls pas mano žaidėją',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bandau iškart perimti kamuolį rizikuodamas, nes noriu pasižymėti',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Dėmesį blaško tai, kad gavau mažai laiko žaisti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Trečiajame kėlinyje jūsų komanda pirmauja 20 taškų skirtumu. Koks jūsų dėmesio lygis?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu žaisti savanaudiškai ir daryti nereikalingus triukus',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išlaikau aukštą koncentraciją gynyboje ir žaidžiu taip, lyg rezultatas būtų 0:0',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Visiškai atsipalaiduoju ir leidžiu varžovams laisvai mesti',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu juoktis iš varžovų ir nesiklausau trenerio',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treniruotės metu atliekate monotonišką metimų pratimą, o mintyse kirba artėjantis egzaminas ar asmeninės problemos. Kaip išlaikote fokusą?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Darau pratimą automatiškai, bet galvoju apie savo problemas',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pastebėjęs nuklydusias mintis, nukreipiu dėmesį į kamuolio rotaciją ar metimo trajektoriją',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Sustoju ir einu pasikalbėti su komandos draugu',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Metu bet kaip, nes vis tiek negaliu susikaupti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Pastebite, kad vienoje aikštelės pusėje grindys yra labai slidžios. Kaip tai veikia jūsų žaidimą?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Dėmesį skiriu tam, kaip pritaikyti savo stabdymą toje zonoje, nekeičiant žaidimo agresyvumo',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skundžiuosi ir atsisakau aktyviai gintis toje vietoje',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pamirštu tai po minutės ir vis tiek paslystu',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nuolat galvoju apie galimą traumą ir bijau veržtis',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Vedatės kamuolį prieš spaudimą, ir tuo pat metu treneris nuo suolo garsiai rėkia komandos derinio numerį. Ką darote?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Sutrinku, sustabdau kamuolį ir pažiūriu į trenerį (rizikuoju jį prarasti)',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Negirdžiu trenerio, nes esu per daug susinervinęs',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Skenuoju aikštę, apsaugau kamuolį ir tik tada sukomanduoju derinį komandai',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Metu kamuolį bet kam, kad tik atiduočiau atsakomybę',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Lemiamas seto taškas, ruošiatės atlikti padavimą, o varžovų sirgaliai pradeda švilpti ir šaukti. Kaip elgiatės?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Sutelkiu visą dėmesį į kamuolio išmetimą ir numatytą padavimo zoną, ignoruodamas triukšmą',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Susinervinu ir paduodu kamuolį ne ten, kur liepė treneris',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Paskubinu padavimą, nes jaučiu įtampą',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Stengiuosi juos ignoruoti, bet rankos vis tiek dreba',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Žaidimas sustabdomas, nes aikštės darbuotojai turi išvalyti šlapias grindis po žaidėjo kritimo. Kaip išlaikote dėmesį šios pauzės metu?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu juokauti su komandos draugais ir prarandu žaidimo ritmą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Lengvai judinu kojas ir mintyse vizualizuoju, kaip priimsiu varžovų padavimą po pauzės',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nervinuosi, kad pauzė numuš mano gerą formą',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Tiesiog pasyviai laukiu žiūrėdamas į valytojus',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Penkto seto vidurys, jaučiatės išsekęs, bet turite tiksliai atlikti greitą ataką (pvz., „metrą“ ar „kryžių“). Kur sutelkiate mintis?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Naudoju trumpą komandą sau (pvz., „greitas išėjimas“), kad sutelkčiau dėmesį į atakos tempą',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Galvoju apie tai, kaip pavargau šokinėti',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Šoku be energijos, tikėdamasis, kad varžovų blokas suklys',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Tikiuosi, kad kėlėjas duos kamuolį ne man',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Stipriai smūgiavote kamuolį ir pataikėte tiesiai į anteną ar varžovų bloką (be apsaugos). Kaip reaguojate artėjant kitam taškui?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nuleidžiu rankas ir kitą ataką bijau smūgiuoti stipriai (tik permušu)',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pykstu ant savęs ir negaliu susikaupti priėmimui',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Kaltinu kėlėją, kad davė prastą kamuolį',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Įsivertinu varžovų bloko padėtį ir susitelkiu į kitą veiksmą',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Jūs matėte, kad smūgiuodamas varžovas palietė jūsų komandos bloką (buvo „blokautas“), bet teisėjas to nepastebėjo ir atidavė tašką varžovams. Ką darote?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Iškart atsistoju į savo poziciją ir laukiu kito padavimo, paleisdamas šią situaciją',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu rėkti ant teisėjo per tinklą',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Supykstu ir visą kitą setą galvoju apie prarastą tašką',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Po truputį nustoju stengtis, nes teisėjai „tempia“ varžovus',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Žaidžiant prie tinklo, varžovų puolėjas po sėkmingos atakos nuolat žiūri į jus ir bando išprovokuoti. Kaip reaguojate?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsakau piktais žvilgsniais ir prarandu koncentraciją savo užduotims',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Provokuoju jį atgal',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Žiūriu tik į kamuolį ir ignoruoju jo emocijas, ruošdamasis kitam blokui',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu vengti to žaidėjo prie tinklo',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Prieš varžybas apšilimo laikas tinkle buvo sutrumpintas, ir jūs spėjote atlikti tik porą smūgių. Kaip tai veikia jūsų žaidimą?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nusprendžiu, kad žaisiu prastai',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Koncentruojuos į gerą įsibėgėjimo ir atsispyrimo techniką pačių varžybų metu, adaptuodamasis eigoje',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pykstu ant organizatorių ir žaidžiu įsitempęs',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prašau trenerio manęs neleisti į aikštę, kol neapšilsiu',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treneris išleidžia jus į aikštelę seto pabaigoje tik vienam konkrečiam tikslui – atlikti sudėtingą taktinį padavimą. Kaip susikaupiate?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bandau paduoti kuo stipriau, negalvodamas apie kryptį',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Tiesiog permušu kamuolį per tinklą, kad nepadaryčiau klaidos',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Aiškiai nusistatau taikinį varžovų aikštelės pusėje ir pasikliauju savo metimo rutina',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nervinuosi, kad nuo vieno padavimo priklauso seto baigtis',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Jūsų komanda dominuoja ir laimi setą rezultatu 20:12. Koks jūsų dėmesio lygis?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Visiškai atsipalaiduoju ir leidžiu sau daryti rizikingas, neapgalvotas klaidas',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu juokauti aikštelėje',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Išlaikau koncentraciją ties kiekvienu prisilietimu ir siekiu užbaigti setą be asmeninių klaidų',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nebesidengiu gynyboje, nes laimėjimas garantuotas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treniruotėje darote rutininius priėmimo pratimus, bet mintys krypsta prie asmeninių reikalų. Kaip elgiatės?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Darau pratimą „autopilotu“, nelenkdamas kojų',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Sąmoningai grąžinu dėmesį prie kamuolio trajektorijos ir savo rankų platformos',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedu plepėti su šalia stovinčiu žaidėju',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prašau trenerio trumpam išeiti iš salės',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Žaidžiant jums tiesiai į akis šviečia saulė (arba ryški salės lempa), trukdanti matyti iškeltą kamuolį. Kaip adaptuojatės?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nuolat skundžiuosi ir nuleidžiu rankas puolime',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Sutelkiu dėmesį į greitesnį kamuolio sekimą ir pozicijos prisitaikymą išvengiant tiesioginės šviesos',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nustoju šokinėti į ataką',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Smūgiuoju aklai ir tikiuosi pataikyti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Vykstant ilgam taško žaidimui (raliui), treneris staiga sušunka pakeisti bloko schemą. Ką darote?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pasimetu ir nešoku į bloką visai',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Sustoju vietoje bandydamas suprasti, ką jis sakė',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nespėjęs išgirsti, toliau seku kamuolį, o po taško pasitikslinu trenerio nurodymą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Garsiai per visą salę klausiu, ką daryti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Esate paskirtas mušti 11 metrų baudinį varžovų tvirtovėje, o už vartų sirgaliai rėkia ir šviečia lazeriais. Kaip elgiatės?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Paskubinu smūgį, kad greičiau pabėgčiau nuo įtampos',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Susinervinu ir mintyse pykstu ant sirgalių',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Sutelkiu dėmesį tik į kamuolį ir pasirinktą smūgio kampą, tarsi stadione būtų tuščia',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Žiūriu į sirgalius bandydamas jiems kažką įrodyti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Teisėjas sustabdo žaidimą, kad VAR peržiūrėtų situaciją dėl galimos raudonos kortelės jūsų varžovui. Kaip išlaikote dėmesį?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Aktyviai spaudžiu teisėją ir rėkiu, kad duotų kortelę',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išlaikau raumenų tonusą ir apgalvoju, kaip keisis mūsų taktika, jei varžovų liks dešimt',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Atsisėdu ant žolės ir atsijungiu nuo žaidimo',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu kalbėtis su žiūrovais',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            '85-oji rungtynių minutė, kojos sunkios kaip švinas, o komanda ruošiasi atlikti sudėtingą standartinę situaciją (kampinį). Kur jūsų mintys?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Galvoju, kaip greičiau sulaukti finalinio švilpuko',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Koncentruojuosi į konkrečią savo bėgimo trajektoriją ir zonos uždarymą',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Bėgu į baudos aikštelę be plano ir tikiuosi, kad kamuolys mane suras',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Specialiai lieku gynybos linijoje, kad nereikėtų bėgti pirmyn',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Darant perdavimą savo aikštės pusėje apmaudžiai klystate, prarandate kamuolį ir vos nepraleidžiate įvarčio. Kokia reakcija po to?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Iškart po epizodo padarau išvadą ir visą dėmesį nukreipiu į kitą atakos kūrimą',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Visas likusias rungtynes bijau liesti kamuolį ir atiduodu jį kitiems',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Kaltinu komandos draugą, kad jis neatsidarė perdavimui',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Ilgai analizuoju klaidą ir dėl to pramiegu kitą varžovo kirtimą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Prieš jus akivaizdžiai prasižengė, bet teisėjas švilpuko neduoda ir žaidimas tęsiasi. Ką darote?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Guliu ant žemės, mojuoju rankomis ir rėkiu ant teisėjo',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Stabdau žaidimą ir bandau atkeršyti varžovui',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Iškart šoku ant kojų ir tęsiu gynybą ar kovą dėl kamuolio',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nuleidžiu rankas ir leidžiu varžovams pabėgti į ataką',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Dengiant varžovą kampinio metu, jis nuolat jus stumdo, gnybia arba mina ant kojų, bandydamas išprovokuoti. Kaip reaguojate?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu muštis ir gaunu geltoną kortelę',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skundžiuosi teisėjui užuot žiūrėjęs į kamuolį',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Koncentruojuosi tik į kamuolio skrydį ir savo poziciją, ignoruodamas varžovo provokacijas',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pasitraukiu nuo jo ir leidžiu jam laisvai smūgiuoti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Prieš rungtynes per apšilimą pastebite, kad veja yra labai nelygi ir klampi. Kaip tai keičia jūsų požiūrį?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Visas rungtynes galvoju apie tai, kokia prasta aikštė',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Nusprendžiu, kad šiandien nepavyks sužaisti gerai',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Susitelkiu į stipresnius ir paprastesnius perdavimus, priimdamas aikštės sąlygas kaip faktą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Bandau žaisti sudėtingą futbolą ir nuolat klystu',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treneris išleidžia jus į aikštę po keitimo šaltu ir lietingu oru. Kaip greitai adaptuojatės žaidimo ritme?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Žengiu žinodamas savo pozicines užduotis ir iškart aktyviai prašau kamuolio',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pirmas penkias minutes vengiu kontakto, kol sušilsiu',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Darau neapgalvotas pražangas, nes nesu „įėjęs“ į žaidimą',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Galvoju apie tai, kaip man šalta',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Jūsų komanda dominavo visą kėlinį ir pirmauja rezultatu 3:0. Kaip išlaikote fokusą antrajame kėlinyje?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Žaidžiu disciplinuotai ir vertinu kiekvieną perdavimą, tarsi rezultatas būtų lygus',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedu perdėtai varytis kamuolį ir ignoruoju laisvus komandos draugus',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nustoju bėgti į gynybą, nes pergalė jau kišenėje',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Atsipalaiduoju ir leidžiu varžovams laimėti mikrodvikovas',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Per treniruotę atliekate rutininius perdavimus kvadratu (angl. rondo), bet jūsų mintys sukasi apie mokslus ar darbus. Kaip elgiatės?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atidavinėju kamuolį netiksliai ir gadinu pratimą komandai',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Sustabdau mintis ir grąžinu dėmesį į kamuolio greitį bei savo kūno poziciją',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Laukiu, kol pratimas greičiau pasibaigs',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Būnant viduryje nustoju bėgioti ir bandyti atimti kamuolį',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Rungtynių metu prasideda stiprus vėjas, kuris smarkiai keičia ilgų perdavimų skrydžio trajektoriją. Kaip adaptuojatės?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Dėmesį skiriu greitesniam trajektorijos įvertinimui ir kamuolio priėmimui žemu profiliu',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skundžiuosi oru ir atsisakau mušti kamuolį į priekį',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Vis tiek darau ilgus perdavimus ir pykstu, kad jie nepasiekia tikslo',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Bijau atlikti bet kokį sudėtingesnį perdavimą',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Bėgate su kamuoliu krašte link varžovų baudos aikštelės, o treneris nuo šoninės linijos kažką jums garsiai rėkia. Ką darote?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Sustoju pažiūrėti į trenerį ir prarandu kamuolį',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išlaikau akis į aikštę, priimu geriausią žaidybinį sprendimą, o taktiką pasitikslinu per pauzę',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Išsigąstu ir išspiru kamuolį į užribį',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu rėkti jam atgal',
            weight: 3,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'motyvacija',
    title: 'Motyvacija',
    dbSkillName: 'motyvacija',
    questions: [
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotės tampa monotoniškos (pvz., vien gynybinis judėjimas ar nuolatinis tų pačių metimų kartojimas) ir neduoda greitų rezultatų?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pradedu simuliuoti, dirbu puse jėgos, kol treneris nemato',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Darau tik minimumą, be jokio papildomo noro',
            weight: 5,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nuolat skundžiuosi komandos draugams, kaip viskas nuobodu',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Primenu sau ilgalaikius tikslus ir ieškau detalių, kaip galiu patobulinti savo judesių techniką',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai kelias rungtynes iš eilės gaunate mažai minučių aikštelėje ir tenka sėdėti ant suolelio?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pykstu ant trenerio ir nustoju stengtis treniruočių metu',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Palaikau komandą ir dar sunkiau dirbu treniruotėse, kad įrodyčiau galintis žaisti daugiau',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prarandu pasitikėjimą savimi ir susitaikau su atsarginio vaidmeniu',
            weight: 4,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu galvoti apie komandos keitimą, užuot bandęs tobulėti',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda patiria nesėkmių ruožą ir ilgą laiką nepavyksta laimėti rungtynių?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Prarandu viltį, žaidžiu be energijos ir laukiu sezono pabaigos',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Susitelkiu tik į savo asmeninę pelnytų taškų statistiką ir ignoruoju komandos rezultatą',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text: 'Kaltinu kitus komandos narius ar trenerius dėl prastos gynybos',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Priimu tai kaip iššūkį, stengiuosi įkvėpti komandą ir ieškau, kur galime pagerinti komandinį žaidimą',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės pasibaigus treniruotei, jei jaučiate, kad jums vis dar nesiseka pataikyti baudos metimų ar atlikti specifinio klaidinančio judesio?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pasiliekate salėje po treniruotės, kad išmestumėte papildomų metimų ir atidirbtumėte judesį',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Iškart einate į rūbinę, nes treniruotės laikas baigėsi',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nusiviliate savimi ir nusprendžiate, kad šis elementas jums niekad nepavyks',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kitos treniruotės ir tikitės, kad tada „pakris“ geriau',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai dėl nedidelės traumos (pvz., čiurnos patempimo) negalite sportuoti kelias savaites?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Visiškai atsiribojate nuo krepšinio, kol pasveiksite',
            weight: 3,
          ),
          QuestionOption(
            id: 'b',
            text: 'Grįžtate per anksti, rizikuodamas atnaujinti traumą, nes neturite kantrybės',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Skiriate laiką varžovų taktikos analizei, darote leistinus reabilitacijos pratimus ir palaikote komandą',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Puolate į neviltį ir prarandate norą išvis grįžti į krepšinį',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės sužinoję, kad kitose rungtynėse teks žaisti prieš turnyro lyderius, kurie dominuoja po krepšiu ir yra aiškūs favoritai?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Iš anksto susitaikote su pralaimėjimu ir per daug nesistengiate',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimate tai kaip puikią progą pasitikrinti jėgas, pasisemti patirties ir atiduodate viską',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Jaučiate baimę ir varžybų metu stengiatės kuo greičiau atsikratyti kamuolio',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Ieškote pasiteisinimų, kad nereikėtų žaisti šiose rungtynėse',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės prieš prasidedant naujam krepšinio sezonui?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tiesiog pradedate lankyti treniruotes negalvodamas apie jokius lūkesčius',
            weight: 4,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išsikeliate aiškius asmeninius (pvz., pagerinti tritaškių procentą) bei komandinius tikslus',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Keliate sau nerealius tikslus, o po pirmų nesėkmių greitai nusiviliate',
            weight: 2,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate, kol treneris pasakys, ko iš jūsų tikisi',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kokia jūsų rutina tarpsezoniu, kai nevyksta oficialios krepšinio treniruotės?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Visiškai apleidžiate kamuolį iki kito sezono',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Sudarote asmeninį planą ir dirbate su fiziniu pasirengimu ar metimo technika',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Žaidžiate krepšinį tik tada, kai draugai pakviečia į lauko aikštelę',
            weight: 5,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedate ruoštis tik likus savaitei iki pirmosios stovyklos',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po rungtynių, kuriose pelnėte daugiausiai taškų ir buvote išrinktas MVP (naudingiausiu)?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Visiškai atsipalaiduojate ir manote, kad treniruotėse dirbti nebereikia',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedate žiūrėti į komandos draugus iš aukšto',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pasidžiaugiate, tačiau greitai susitelkiate į kitas rungtynes ir toliau nuosekliai dirbate',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Sumažinate pastangas, nes manote, kad jau pasiekėte savo lygio viršūnę',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai treneris atkreipia dėmesį, kad jūsų fizinė forma (greitis ar ištvermė) aikštelėje pastaruoju metu krito?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Priimate tai kaip impulsą išanalizuoti klaidas ir padvigubinti pastangas sporto salėje',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimate tai kaip asmeninį įžeidimą ir pradedate ginčytis',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Ignoruojate pastabas ir manote, kad treneris prie jūsų kabinėjasi',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Jaučiatės įskaudintas ir prarandate norą žaisti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotėje paskiriama labai sunki fizinio pasirengimo užduotis?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bėgate greitai tik tada, kai treneris į jus žiūri',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Raskite pasiteisinimą (pvz., atrištas batelis), kad pailsėtumėte',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Atliekate užduotį maksimaliai susikaupęs, nes žinote, kad tai būtina ketvirtam kėliniui',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Garsiai skundžiatės, gadindamas nuotaiką kitiems žaidėjams',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aplinkiniai abejoja jūsų galimybėmis prasimušti į pagrindinę komandą ar žaisti aukštesnėje lygoje?',
        sportTypes: [SportType.krepsinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Patikite jais ir nuleidžiate kartelę savo tikslams',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Susinervinate ir pradedate pyktis su aplinkiniais',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nustojate stengtis, nes manote, kad vis tiek niekas jumis netiki',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Panaudojate šias abejones kaip motyvaciją sunkiau dirbti aikštelėje ir įrodyti, kad jie klysta',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotės tampa monotoniškos (pvz., nuolatinis padavimų priėmimo atidirbimas) ir neduoda greitų rezultatų?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Dirbu puse jėgos, nelenkdamas kojų priėmime',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Primenu sau ilgalaikius tikslus ir koncentruojuosi į idealią kūno platformą kiekviename prisilietime',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Skundžiuosi komandos draugams, kaip viskas nuobodu',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Darau tik minimumą, kurio reikalauja treneris',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai kelis mačus iš eilės tenka likti atsarginių zonoje ir jus išleidžia atlikti tik pavienius padavimus?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Prarandu pasitikėjimą savimi ir susitaikau su atsarginio vaidmeniu',
            weight: 4,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pykstu ant trenerio ir atsainiai atlieku apšilimą',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Palaikau aikštelėje esančius draugus, džiaugiuosi kiekvienu tašku ir treniruotėse dirbu dar sunkiau',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedu ieškoti kitos komandos, kur iškart gaučiau pagrindinio žaidėjo vietą',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda patiria nesėkmių ruožą ir ilgą laiką nepavyksta laimėti nė vieno seto?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susitelkiu tik į savo asmeninę puolimo statistiką ir ignoruoju bendrą rezultatą',
            weight: 4,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu kėlėją ar priimančius žaidėjus dėl prasto žaidimo',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Priimu tai kaip iššūkį, skatinu komandos dvasią po kiekvieno taško ir ieškau, kaip pagerinti savo indėlį',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prarandu viltį, žaidžiu be energijos ir laukiu, kol viskas baigsis',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės pasibaigus treniruotei, jei jaučiate, kad jums vis dar nesiseka stabiliai atlikti šuolinio padavimo (ar tikslaus perdavimo)?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Iškart einate į persirengimo kambarį',
            weight: 3,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pasiliekate salėje papildomam laikui, pasiimate kamuolių krepšį ir atidirbate techniką',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nusiviliate savimi ir nusprendžiate per varžybas padavinėti tik paprastai',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate kitos treniruotės ir tikitės, kad tada judesys pavyks pats',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai dėl traumos (pvz., peties ar piršto) negalite sportuoti kelias savaites?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Puolate į neviltį ir atsiribojate nuo tinklinio',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skiriate laiką varžovų blokų / puolimo analizei, dirbate ties reabilitacija ir stebite varžybas',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Grįžtate per anksti, rizikuodamas pabloginti traumą',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Visiškai pamirštate komandą, kol neduodamas leidimas žaisti',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės sužinoję, kad kitame mače teks žaisti prieš komandą su ypač aukštu bloku ir galingu puolimu?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Priimate tai kaip progą pasitikrinti jėgas, išbandyti gudresnius smūgius (pvz., blokautus) ir atiduodate viską',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Iš anksto nuleidžiate rankas, nes varžovai fiziškai stipresni',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Jaučiate baimę ir vengiate imtis atsakomybės lemiamų atakų metu',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Bandote rasti pasiteisinimą nelipti į aikštelę',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės prieš prasidedant naujam tinklinio sezonui?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Išsikeliate aiškius tikslus (pvz., pagerinti priėmimo stabilumą) ir susidarote pasiruošimo planą',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Laukiate, kol treneris pasakys, ko iš jūsų tikisi',
            weight: 5,
          ),
          QuestionOption(
            id: 'c',
            text: 'Tiesiog lankote treniruotes be aiškios krypties',
            weight: 4,
          ),
          QuestionOption(
            id: 'd',
            text: 'Susikuriate lūkesčius tapti geriausiu lygoje, bet susidūręs su sunkumais iškart pasiduodate',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kokia jūsų rutina tarpsezoniu, kai nevyksta tinklinio treniruotės salėje?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Sportuojate tik tada, kai draugai pakviečia pažaisti paplūdimyje dėl pramogos',
            weight: 5,
          ),
          QuestionOption(
            id: 'b',
            text: 'Visiškai apleidžiate sportą',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Dirbate sporto klube ar individualiai, kad padidintumėte šuolį ir fizinę ištvermę',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedate judėti tik gavęs pranešimą apie artėjančią stovyklą',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai varžybose atliekate daugiausiai „ace“ (neatremiamų padavimų) ar sėkmingų blokų?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Visiškai atsipalaiduojate ir praleidžiate kelias treniruotes',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pasidžiaugiate asmeniniu pasiekimu, bet toliau sunkiai dirbate, kad šį lygį išlaikytumėte',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedate ignoruoti trenerio taktiką, nes manote, kad viską žinote geriau',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nustojate stipriai stengtis, manydamas, kad forma jau pasiekta',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai treneris pasako, kad jūsų reakcijos greitis ar šuolio aukštis pastaruoju metu suprastėjo?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Jaučiatės įskaudintas ir pradedate galvoti apie sporto metimą',
            weight: 3,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimate tai kaip impulsą keisti mitybą/poilsį ir padvigubinti pastangas fizinio pasirengimo treniruotėse',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedate ginčytis ir teisintis nuovargiu',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Ignoruojate pastabą, tikėdami, kad treneris klysta',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotėje paskiriama alinanti užduotis (pvz., nepertraukiamas kritimų ir šuoliukų ciklas)?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atliekate ją tiksliai ir atiduodate visas jėgas, suprasdamas, kad tai grūdina ištvermę ilgiems setams',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Bandote išvengti kelių šuolių, kai treneris nusisuka',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Garsiai skundžiatės, kad užduotis per sunki',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Suvaidinate skausmą, kad nereikėtų tęsti',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai aplinkiniai abejoja jūsų galimybėmis tapti pagrindiniu komandos žaidėju ar žaisti aukštoje lygoje?',
        sportTypes: [SportType.tinklinis],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Patikite jais ir tenkinatės mėgėjų lygiu',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Panaudojate tai kaip papildomą kurą sunkiau dirbti treniruotėse ir įrodyti, kad esate vertas daugiau',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedate vengti tų žmonių ir atsisakote iššūkių',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Susinervinate ir bandote įrodinėti savo tiesą žodžiais, bet ne darbais aikštelėje',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treniruotės tampa monotoninės (pvz., nuolatinis ilgų perdavimų atidirbimas)?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Simuliuojate ir atliekate judesius tik iš inercijos, be kokybės',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Skundžiatės, kad geriau iškart žaisti „į vartus“',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Primenate sau, kad būtent šie baziniai įgūdžiai nulemia sėkmę rungtynėse, ir koncentruojatės į kamuolio kontrolę',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Darote tik tiek, kiek užtenka, kad negautumėte pastabos',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai kelias rungtynes nepatenkate į startinį vienuoliktuką ir tenka šalti ant atsarginių suolelio?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Prarandu motyvaciją ir per treniruotes nustoju kovoti dėl kamuolio',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išlaikau pozityvumą, studijuoju žaidimą nuo suolo ir treniruotėse ardau aikštę, kad atkreipčiau trenerio dėmesį',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedu ieškoti kaltų arba galvoju apie išėjimą į prastesnę komandą',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Susitaikau su tuo ir net nesitikiu žengti į aikštę',
            weight: 3,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai komanda išgyvena krizę – neįmuša įvarčių ir pralaimi kelias rungtynes iš eilės?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susitelkiu tik į tai, kaip pačiam nepadaryti klaidų, o komandos rezultatas man tampa nebesvarbus',
            weight: 4,
          ),
          QuestionOption(
            id: 'b',
            text: 'Kaltinu gynėjus (arba puolėjus) dėl prasto žaidimo',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Prarandu entuziazmą žaisti ir laukiu sezono galo',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prisiimu atsakomybę, palaikau rūbinės mikroklimatą ir stengiuosi aikštėje atiduoti 110 % jėgų',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, jei jaučiate, kad jums niekaip nesiseka atlikti gero baudos smūgio arba tiksliai priimti aukštą kamuolį?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Po treniruotės pasiliekate su vartininku ir smūgiuojate/priiminėjate kamuolius papildomai',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Numojate ranka, nes vis tiek per varžybas baudų nemušate',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Einate namo ir tikitės, kad kitą kartą pasiseks geriau',
            weight: 4,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nusiviliate savimi ir pradedate vengti šio technikos elemento',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai dėl raumenų patempimo ar kitos traumos negalite žaisti kelias savaites?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsiribojate nuo komandos ir futbolo, kol pasveiksite',
            weight: 3,
          ),
          QuestionOption(
            id: 'b',
            text: 'Grįžtate į aikštę per anksti, nors gydytojai neleidžia, nes nenorite prarasti vietos sudėtyje',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Nuosekliai darote fizioterapiją, palaikote formą baseine ar dviračiu ir vykstate su komanda į rungtynes',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Prarandate bet kokią motyvaciją ir priaugate svorio',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės prieš taurės rungtynes su aukštesnės lygos klubu, kuris puikiai valdo kamuolį ir yra aiškus favoritas?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Iš anksto susitaikote su pralaimėjimu ir planuojate tiesiog atsimušinėti',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Jaučiate baimę, todėl gavęs kamuolį stengiatės jį kuo greičiau išspirti',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text: 'Ieškote pasiteisinimo (pvz., mikrotraumos), kad nereikėtų rungtyniauti',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Matote tai kaip puikų šansą išbandyti savo greitį ir ištvermę prieš geriausius, kovodamas dėl kiekvieno aikštės metro',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės prieš prasidedant sunkiam futbolo pasirengimo sezonui?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Tiesiog pradedate treniruotis be jokio plano',
            weight: 4,
          ),
          QuestionOption(
            id: 'b',
            text: 'Išsikeliate individualius tikslus (pvz., pagerinti 30 m sprinto laiką) ir nusiteikiate sunkiam darbui',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Tikitės, kad pasiruošimas nebus per sunkus, o prasidėjus krosams – skundžiatės',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate, kol treneris pats nuspręs, kokia jūsų rolė',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kokia jūsų rutina po sezono (žiemą ar vasaros pertraukos metu)?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pilnai apleidžiate sportą ir nustojate bėgioti',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Dirbate pagal asmeninį bėgimo ir ištvermės planą, kad į pirmą stovyklą atvyktumėte geros formos',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedate krutėti tik likus savaitei iki komandinių treniruočių',
            weight: 2,
          ),
          QuestionOption(
            id: 'd',
            text: 'Žaidžiate tik salės futbolą su draugais dėl pramogos',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės po rungtynių, kuriose pelnėte pergalingą įvartį (arba išlaikėte „sausus“ vartus)?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Atsipalaiduojate ir manote, kad vietą pagrindinėje sudėtyje jau užsitikrinote ilgam',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pradedate puikuotis prieš komandos draugus',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pasidžiaugiate atliktu darbu, bet treniruotėse vėl dirbate maksimaliai, ruošdamasis kitam varžovui',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Nustojate sunkiai bėgioti gynyboje, manydamas, kad savo jau padarėte',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip reaguojate, kai treneris pasako, kad po 70-os minutės jūs lėtėjate ir prarandate poziciją aikštėje?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Įsižeidžiate ir galvojate, kad treneris nesupranta futbolo',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimate tai kaip iššūkį pagerinti savo „kardio“ ir savarankiškai didinate krūvius',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text: 'Pradedate teisintis, kad varžovai buvo greitesni arba aikštė prasta',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Ignoruojate pastabą ir nieko nekeičiate',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai treneris paskiria ypač sunkią treniruotę be kamuolių (pvz., ilgi krosai ar sprinto intervalai)?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Bėgate iš paskutiniųjų ir bandote tempti komandos draugus, suprasdamas, kad tai leis laimėti mikrodvikovas 90-tą minutę',
            weight: 10,
          ),
          QuestionOption(
            id: 'b',
            text: 'Bėgate lėčiau už grupę ir „taupote“ jėgas',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Skundžiatės, kad futbolininkams reikia žaisti su kamuoliu, o ne bėgioti maratonus',
            weight: 1,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pasiimate „laisvadienį“ dėl neva skaudančio kelio',
            weight: 1,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiatės, kai kiti žaidėjai ar žiūrovai abejoja jūsų talentu tapti profesionaliu futbolininku?',
        sportTypes: [SportType.futbolas],
        options: [
          QuestionOption(
            id: 'a',
            text: 'Nuleidžiate rankas ir nusprendžiate likti mėgėjų lygoje',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text: 'Paverčiate šią kritiką pykčiu ir kerštingu žaidimu aikštėje (gaunate korteles)',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text: 'Atkreipiate į tai dėmesį, bet paverčiate tai savo motyvaciniu varikliu treniruotis dvigubai sunkiau',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Pradedate vengti sudėtingų rungtynių, kad nepadarytumėte klaidos ir nebūtumėte kritikuojamas',
            weight: 1,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'atsakomybe',
    title: 'Atsakomybė',
    dbSkillName: 'atsakomybė',
    questions: [
      SoftSkillQuestion(
          question: 'Kaip elgiatės, kai matote, kad komandos draugas trenerio užduoto pratimo iki galo nepadaro, pavyzdžiui vietoje 10 pakartojimų daro tik 6-7?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Nieko nesakote, esate susikaupęs į savo užduotis, laukiate, kol treneris pamatys',
                weight: 3
            ),
            QuestionOption(
                id: 'b',
                text: 'Garsiai atkreipiate visos komandos dėmesį, kad visi matytų, kaip komandos draugas sukčiauja',
                weight: 5
            ),
            QuestionOption(
                id: 'c',
                text: 'Po treniruotės paskundžiate komandos draugą treneriui, kad kitą kartą pastebėtų',
                weight: 7
            ),
            QuestionOption(
                id: 'd',
                text: 'Po treniruotės pasikalbate apie tai su komandos draugu',
                weight: 10
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Šiandien turėjote dvi treniruotes, ryt anksti ryte laukia dar viena. Jau 21 valanda vakaro, komandos draugai kviečia pavakarieniauti ir pabūti mieste iki paryčių, ką darysite?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Eisite su komandos draugais į miestą, šiandien reikia atsipalaiduoti',
                weight: 3
            ),
            QuestionOption(
                id: 'b',
                text: 'Eisite su komandos draugais į miestą, bet vengsite alkoholio, svarbu turėti gerą ryšį su komanda už aikštelės ribų',
                weight: 5
            ),
            QuestionOption(
                id: 'c',
                text: 'Eisite su komandos draugais į miestą, tačiau nusistatysite laiką kada turite jau būti namie, kad dar spėtumėte išsimiegoti',
                weight: 9
            ),
            QuestionOption(
                id: 'd',
                text: 'Neisite su komandos draugais į miestą, grįšite namo pavalgysite ir iš karto eisite miegoti',
                weight: 10
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Ką darytumėte, jei pas jus būtų kamuolys ir nuo jūsų priklauso, kas komandai darys paskutinį tašką, esant lygiosioms? Treneris liepė pasuoti vienam žmogui, tačiau matote, kad kitas labiau pasiruošęs.',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Sudvejojate ir nepavyksta nei trenerio nei naujas planas',
                weight: 1
            ),
            QuestionOption(
                id: 'b',
                text: 'Darote taip, kaip liepė treneris',
                weight: 5
            ),
            QuestionOption(
                id: 'c',
                text: 'Vykdote savo planą, tačiau nespėjate garsiai pasakyti visiems',
                weight: 6
            ),
            QuestionOption(
                id: 'd',
                text: 'Garsiai pasakote komandai, kam pasuosite, kad visi būtų pasiruošę',
                weight: 10
            )
          ]
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'sprendimu_priemimas_stresinese_situacijose',
    title: 'Sprendimų priėmimas stresinėse situacijose',
    dbSkillName: 'sprendimų priėmimas',
    questions: [
      SoftSkillQuestion(
          question: 'Ką darote, kai turite pasuoti kamuolį lemiamu varžybų momentu ir du komandos nariai, kurie yra skirtingose pusėse, prašo kamuolio?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Momentiškai sustingstate, kol dvejojate, kam pasuoti kamuolį',
                weight: 1
            ),
            QuestionOption(
                id: 'b',
                text: 'Reaguojate į komandos narį, kuris šaukia labiausiai ir garsiausiai',
                weight: 3
            ),
            QuestionOption(
                id: 'c',
                text: 'Nekreipiate dėmesio į tai, kuris garsiau šaukia, priimate sprendimą kuris jums atrodo logiškiausias, tačiau nespėjate jo įgarsinti komandai',
                weight: 6
            ),
            QuestionOption(
                id: 'd',
                text: 'Priimate sprendimą greitai ir spėjate garsiai pranešti apie jį komandai',
                weight: 10
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Kaip elgiatės, kai esate fiziškai pavargęs varžybų paskutinėmis minutėmis, tačiau reikia sudėlioti komandos draugus gynybai?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Tylite ir laukiate, kol visi sustos, kaip buvo įprasta varžybų metu – reikia taupyti energija tolesniam žaidimui',
                weight: 1
            ),
            QuestionOption(
                id: 'b',
                text: 'Palaukiate ir bėgate į likusią tuščią poziciją, tolimesnio žaidimo metu bandote fiziškai kompensuoti paliktas „skyles“ gynyboje',
                weight: 3
            ),
            QuestionOption(
                id: 'c',
                text: 'Rankų mostais parodote, kur kiekvienam žaidėjui stovėti',
                weight: 6
            ),
            QuestionOption(
                id: 'd',
                text: 'Greitai pasakote žaidėjams ką daryti ir toliau koncentruojatės į varžybas',
                weight: 10
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Vėl gaunate kamuolį, po kelių intensyvių gynybinių momentų abiejose aikštės pusėse, matote, kad varžovai negrįžo į savo pozicijas, ką darysite toliau?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Pažiūrėsite į trenerį, kad jis pasakytų, ką toliau daryti',
                weight: 1
            ),
            QuestionOption(
                id: 'b',
                text: 'Sulėtinsite žaidimą, kad jūsų komanda būtų pasiruošusi puolimui',
                weight: 3
            ),
            QuestionOption(
                id: 'c',
                text: 'Greitinate žaidimą iš karto, nes komanda turi greitai pulti',
                weight: 6
            ),
            QuestionOption(
                id: 'd',
                text: 'Garsiai pasakote, ką darysite ir greitinate žaidimą, kad spėtumėte užpulti priešininkus',
                weight: 10
            )
          ]
      )
    ],
  ),
];
