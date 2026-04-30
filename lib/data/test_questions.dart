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
      )
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'komandinis_darbas',
    title: 'Komandinis darbas',
    dbSkillName: 'komandinis darbas',
    questions: [
      SoftSkillQuestion(
        question:
        'Kaip elgiatės, kai komanda turi greitai priimti sprendimą žaidimo metu?',
        options: [
          QuestionOption(
            id: 'a',
            text:
            'Priimate sprendimą vienas, nepasitaręs',
            weight: 2,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Laukiate, kol kiti nuspręs',
            weight: 1,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Bendraujate su komandos draugais ir priimate sprendimą kartu',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Sekate tik trenerio nurodymus, pats nesiorientuojate',
            weight: 4,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
        'Kaip prisidedate prie bendro komandos tikslo rungtynių metu?',
        options: [
          QuestionOption(
            id: 'a',
            text:
            'Koncentruojatės tik į savo rezultatą',
            weight: 1,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Dirbate komandos labui tik tada, kai tai patogu',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Nuolat prisidedate prie komandos žaidimo ir prisitaikote prie situacijos',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Atliekate tik savo pagrindinę rolę, nesikišate daugiau',
            weight: 6,
          ),
        ],
      ),
      SoftSkillQuestion(
        question:
        'Kaip bendraujate su komandos draugais rungtynių metu?',
        options: [
          QuestionOption(
            id: 'a',
            text:
            'Nebendraujate, susitelkiate tik į save',
            weight: 0,
          ),
          QuestionOption(
            id: 'b',
            text:
            'Bendraujate tik esant būtinybei',
            weight: 4,
          ),
          QuestionOption(
            id: 'c',
            text:
            'Nuolat komunikuojate, informuojate ir palaikote komandos draugus',
            weight: 10,
          ),
          QuestionOption(
            id: 'd',
            text:
            'Kalbate daug, bet ne visada konstruktyviai',
            weight: 5,
          ),
        ],
      )
    ],
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
          question: 'Kaip elgiatės, kai atliekant svarbų veiksmą varžovų fanai bando jus išblaškyti?',
          options: [
            QuestionOption(
              id: 'a',
              text: 'Susinervinu ir prarandu susikaupimą',
              weight: 1
            ),
            QuestionOption(
              id: 'b',
              text: 'Stengiuosi ignoruoti, bet dėmesys vis tiek nukrypsta į triukšmą',
              weight: 3
            ),
            QuestionOption(
                id: 'c',
                text: 'Susitelkiu tik į savo rutiną ir atliekamą veiksmą',
                weight: 10
            ),
            QuestionOption(
                id: 'd',
                text: 'Paskubinu veiksmą, kad viskas kuo greičiau baigtųsi',
                weight: 5
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Ką darote, kai žaidimas netikėtai sustabdomas kelioms minutėms?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Visiškai atsipalaiduoju ir pradedu kalbėtis pašalinėmis temomis',
                weight: 5
            ),
            QuestionOption(
                id: 'b',
                text: 'Pradedu nerimauti dėl to, kas bus po pauzės',
                weight: 3
            ),
            QuestionOption(
                id: 'c',
                text: 'Išlaikau fokusą ir mintyse vizualizuoju kitą savo užduotį',
                weight: 10
            ),
            QuestionOption(
                id: 'd',
                text: 'Tiesiog laukiu atsijungęs nuo žaidimo',
                weight: 1
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Kaip išlaikote dėmesį rungtynių pabaigoje, kai jaučiate didelį fizinį nuovargį?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Galvoju tik apie tai, kaip noriu, kad varžybos greičiau baigtųsi',
                weight: 2
            ),
            QuestionOption(
                id: 'b',
                text: 'Žaidžiu iš inercijos, nesusitelkdamas į detales',
                weight: 5
            ),
            QuestionOption(
                id: 'c',
                text: 'Koncentruojuos į atskirus elementus ir primenu sau techniką',
                weight: 10
            ),
            QuestionOption(
                id: 'd',
                text: 'Stengiuosi išvengti aktyvaus dalyvavimo, kad nepadaryčiau klaidos',
                weight: 1
            )
          ]
      )
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'motyvacija',
    title: 'Motyvacija',
    dbSkillName: 'motyvacija',
    questions: [
      SoftSkillQuestion(
          question: 'Kaip elgiatės, kai treniruotės tampa monotoniškos, reikalauja daug jėgų ir neduoda greitų, matomų rezultatų?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Pradedu simuliuoti, dirbu puse jėgos arba praleidinėju treniruotes',
                weight: 1
            ),
            QuestionOption(
                id: 'b',
                text: 'Darau tik minimumą, kurio reikalauja treneris, be jokio papildomo noro',
                weight: 5
            ),
            QuestionOption(
                id: 'c',
                text: 'Primenu sau ilgalaikius tikslus ir ieškau detalių, kurias galiu patobulinti net ir esant rutinai',
                weight: 10
            ),
            QuestionOption(
                id: 'd',
                text: 'Nuolat skundžiuosi komandos draugams, taip mažindamas visų entuziazmą',
                weight: 1
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Kaip reaguojate, kai kelias varžybas iš eilės gaunate mažai žaidybinio laiko arba tenka sėdėti ant atsarginių suolelio?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Pykstu ant trenerio ir nustoju stengtis treniruočių metu',
                weight: 1
            ),
            QuestionOption(
                id: 'b',
                text: 'Prarandu pasitikėjimą savimi ir susitaikau su atsarginio vaidmeniu',
                weight: 4
            ),
            QuestionOption(
                id: 'c',
                text: 'Išlaikau pozityvumą, palaikau komandą ir dar sunkiau dirbu treniruotėse, kad įrodyčiau savo vertę',
                weight: 10
            ),
            QuestionOption(
                id: 'd',
                text: 'Pradedu galvoti apie komandos keitimą, užuot bandęs tobulėti',
                weight: 1
            )
          ]
      ),
      SoftSkillQuestion(
          question: 'Kaip elgiatės, kai komanda patiria nesėkmių ruožą ir ilgą laiką nepavyksta pasiekti pergalės?',
          options: [
            QuestionOption(
                id: 'a',
                text: 'Prarandu viltį, žaidžiu be energijos ir laukiu sezono pabaigos',
                weight: 2
            ),
            QuestionOption(
                id: 'b',
                text: 'Susitelkiu tik į savo asmeninę statistiką ir ignoruoju komandos rezultatus',
                weight: 4
            ),
            QuestionOption(
                id: 'c',
                text: 'Priimu tai kaip iššūkį, stengiuosi įkvėpti komandos draugus ir ieškau būdų, kaip galime žaisti geriau',
                weight: 10
            ),
            QuestionOption(
                id: 'd',
                text: 'Kaltinu kitus komandos narius ar trenerius dėl prastų rezultatų',
                weight: 1
            )
          ]
      )
    ],
  ),
  SoftSkillQuestionCategory(
    id: 'atsakomybe',
    title: 'Atsakomybe',
    dbSkillName: 'atsakomybe',
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
    title: 'Sprendimu priemimas stresinese situacijose',
    dbSkillName: 'sprendimu priemimas stresinese situacijose',
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
