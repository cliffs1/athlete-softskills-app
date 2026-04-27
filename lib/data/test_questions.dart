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

  const SoftSkillQuestion({
    required this.question,
    required this.options,
    this.sportSpecificQuestions = const {},
  });

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
    title: 'Lyderyste',
    dbSkillName: 'lyderyste',
    questions: [
      SoftSkillQuestion(
        question: 'Kaip elgiates, kai komandoje kyla konfliktas tarp nariu?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Ignoruojate konflikta, tikedamasis, kad jis issispres savaime',
            weight: 3,
          ),
          QuestionOption(
            id: 'b',
            text: 'Pasirenku viena puse ir ja palaikau',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Isitraukiate, isklausote abi puses ir padedate rasti kompromisa',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Perduodate situacija vadovui',
            weight: 5,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiates, kai rungtyniu metu reikia greitai priimti sprendima sudetingoje situacijoje?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Vengiate sprendimo, kol kas nors kitas ji priims',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text: 'Priimate sprendima impulsyviai, daug neanalizuodamas',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Surenkate informacija, ivertinate rizikas ir priimate atsakomybe uz sprendima',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate nurodymu is kitu',
            weight: 2,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Kaip elgiates, kai komanda pradeda pralaimineti arba krenta motyvacija?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Susitelkiate tik i savo zaidima',
            weight: 3,
          ),
          QuestionOption(
            id: 'b',
            text: 'Isreiskiate nepasitenkinima komandos draugais',
            weight: 0,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Palaikote komandos draugus, skatinate, primenate tiksla ir padedate islaikyti komandine dvasia',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text: 'Laukiate, kol treneris pakels komandos motyvacija',
            weight: 4,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'emociju_reguliavimas',
    title: 'Emociju reguliavimas',
    dbSkillName: 'emociju valdymas',
    questions: [
      SoftSkillQuestion(
        question:
            'Varzybu metu padarote apmaudzia klaida, del kurios komanda praranda pranasuma. Kokia jusu reakcija?',
        options: [
          QuestionOption(
            id: 'a',
            text:
                'Iskart supykstu ant saves ir visa likusi laika galvoju apie ta klaida, prarasdamas susikaupima.',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text:
                'Garsiai isreiskiu nepasitenkinima ir ieskau pasiteisinimu arba kaltinu isorines aplinkybes (teiseja, iranga).',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Giliai ikvepiu, mintyse pripazistu klaida, bet samoningai nukreipiu demesi i tolimesne zaidimo eiga, neleidziu klaidai manes blaskyti.',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Nuleidziu rankas ir nustoju stengtis, nes jauciuosi viska sugadines.',
            weight: 0,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Treneris jums prie visu pasako griezta, bet teisinga pastaba del jusu veiksmu. Kaip su tuo susitvarkote?',
        options: [
          QuestionOption(
            id: 'a',
            text:
                'Iskart pradedu teisintis ir gincytis, nes jauciuosi asmeniskai puolamas.',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text:
                'Isklausau pastaba, stengiuosi atskirti savo emocijas nuo faktu ir po visko ramiai apgalvoju, ka galiu pagerinti.',
            weight: 10,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Tyliu, bet viduje jauciu dideli pykti ar geda, kas smarkiai numusa mano motyvacija dirbti toliau.',
            weight: 3,
          ),
          QuestionOption(
            id: 'd',
            text: 'Visiskai ignoruoju pastaba ir toliau darau viska taip pat.',
            weight: 0,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Likus kelioms minutems iki labai svarbaus pasirodymo ar rungtyniu pradzios jauciate dideli jauduli, sirdis plaka greiciau. Kokiu veiksmu imates?',
        options: [
          QuestionOption(
            id: 'a',
            text:
                'Pasiduodu panikai ir pradedu isivaizduoti blogiausius imanomus scenarijus.',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text:
                'Bandau uzgniauzti jausmus ir apsimesti, kad nieko nejauciu, nors kunas islieka labai isitempes.',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Pradedu blaskytis ir skustis kitiems, kaip smarkiai jaudinuosi, taip perkeldamas itampa ir aplinkiniams.',
            weight: 2,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Pripazistu savo jauduli kaip naturalia reakcija ir atlieku samoningo kvepavimo pratimus, kad susikaupciau.',
            weight: 10,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'streso_valdymas',
    title: 'Streso valdymas',
    dbSkillName: 'streso valdymas',
    questions: [],
  ),
  SoftSkillQuestionCategory(
    id: 'komandinis_darbas',
    title: 'Komandinis darbas',
    dbSkillName: 'komandinis darbas',
    questions: [],
  ),
  SoftSkillQuestionCategory(
    id: 'komunikacija',
    title: 'Komunikacija',
    dbSkillName: 'komunikacija',
    questions: [
      SoftSkillQuestion(
        question:
            'Varzybu metu jusu komanda vis daro ta pacia klaida, taciau treneris nieko del to nedaro. Kokia jusu reakcija?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Pasiskusite savo komandos draugui pertraukos metu',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text: 'Lauksite, kol treneris sureaguos ir imsis veiksmu',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Is karto garsiai visai komandai pasakysite, kokia tai klaida ir kaip ja pataisyti',
            weight: 6,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Ramiai ir naturaliai pertraukos metu aptariate tai su komandos nariais',
            weight: 10,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
            'Ką darysite, kai komandos draugas A ruosiasi svarbiam veiksmui, o komandos draugas B ruosiasi kitam lemiamam epizodui?',
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
                'Garsiai raginsite ir palaikysite komandos drauga A; komandos draugui B duosite ramu technini patarima',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Komandos draugui A duosite ramu technini patarima; garsiai raginsite ir palaikysite komandos drauga B',
            weight: 8,
          ),
        ],
      ),
      SoftSkillQuestion(
        question: 'Kaip reaguojate, kai padarote kritine klaida gynyboje?',
        options: [
          QuestionOption(
            id: 'a',
            text: 'Ranku gestais i virsu parodote savo nusivylima',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text:
                'Nuleidziate galva ir griztate atgal i savo pozicija, kad neatkreipti daug demesio i sia klaida ir daugiau apie ja negalvoti',
            weight: 3,
          ),
          QuestionOption(
            id: 'c',
            text:
                'Is karto ziurite i treneri, laukiate is jo paskatinimo',
            weight: 4,
          ),
          QuestionOption(
            id: 'd',
            text:
                'Laikote galva aukstai, susizvalgote su komandos nariais ir einate i savo pozicija tolimesniam zaidimui',
            weight: 10,
          ),
        ],
      ),
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'pasitikejimas_savimi',
    title: 'Pasitikejimas savimi',
    dbSkillName: 'pasitikejimas savimi',
    questions: [],
  ),
  SoftSkillQuestionCategory(
    id: 'koncentracija',
    title: 'Koncentracija',
    dbSkillName: 'koncentracija',
    questions: [],
  ),
  SoftSkillQuestionCategory(
    id: 'motyvacija',
    title: 'Motyvacija',
    dbSkillName: 'motyvacija',
    questions: [],
  ),
  SoftSkillQuestionCategory(
    id: 'atsakomybe',
    title: 'Atsakomybe',
    dbSkillName: 'atsakomybe',
    questions: [],
  ),
  SoftSkillQuestionCategory(
    id: 'sprendimu_priemimas_stresinese_situacijose',
    title: 'Sprendimu priemimas stresinese situacijose',
    dbSkillName: 'sprendimu priemimas stresinese situacijose',
    questions: [],
  ),
];
