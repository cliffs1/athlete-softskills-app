class SkillTip {
  final String title;
  final String description;

  const SkillTip({
    required this.title,
    required this.description,
  });
}

String normalizeSkillName(String value) {
  const replacements = {
    'ą': 'a',
    'č': 'c',
    'ę': 'e',
    'ė': 'e',
    'į': 'i',
    'š': 's',
    'ų': 'u',
    'ū': 'u',
    'ž': 'z',
    'Ą': 'a',
    'Č': 'c',
    'Ę': 'e',
    'Ė': 'e',
    'Į': 'i',
    'Š': 's',
    'Ų': 'u',
    'Ū': 'u',
    'Ž': 'z',
  };

  var normalized = value.toLowerCase().trim();
  replacements.forEach((from, to) {
    normalized = normalized.replaceAll(from, to);
  });

  normalized = normalized.replaceAll(RegExp(r'[^a-z0-9]+'), ' ');
  return normalized.trim();
}

const List<SkillTip> generalSkillTips = [
  SkillTip(
    title: 'Bendravimas',
    description:
        'Treniruotėje sąmoningai išklausyk vieną komandos draugą iki galo ir atsakyk be pertraukimo.',
  ),
  SkillTip(
    title: 'Susikaupimas',
    description:
        'Prieš pratimą pasirink vieną aiškų fokusą ir grįžk prie jo po kiekvienos klaidos.',
  ),
  SkillTip(
    title: 'Pasitikėjimas',
    description:
        'Po treniruotės užrašyk vieną sprendimą, kurį priėmei drąsiai, net jei jis nepavyko idealiai.',
  ),
];

final Map<String, List<SkillTip>> skillTipsBySkill = {
  normalizeSkillName('lyderystė'): const [
    SkillTip(
      title: 'Lyderystė',
      description:
          'Per artimiausią treniruotę bent vieną kartą aiškiai padrąsink komandą po klaidos arba sunkesnio momento.',
    ),
  ],
  normalizeSkillName('komandinis darbas'): const [
    SkillTip(
      title: 'Komandinis darbas',
      description:
          'Pasirink vieną komandos draugą ir treniruotės metu aktyviai padėk jam situacijoje, kurioje paprastai susitelktum tik į save.',
    ),
  ],
  normalizeSkillName('komunikacija'): const [
    SkillTip(
      title: 'Komunikacija',
      description:
          'Treniruotėje garsiai įvardink bent tris naudingus veiksmus: kur esi, ką matai arba kokios pagalbos reikia komandai.',
    ),
  ],
  normalizeSkillName('emocijų valdymas'): const [
    SkillTip(
      title: 'Emocijų valdymas',
      description:
          'Kai pajusi nusivylimą, sustok vienam giliam įkvėpimui ir tik tada rinkis kitą veiksmą ar žodžius.',
    ),
  ],
  normalizeSkillName('streso valdymas'): const [
    SkillTip(
      title: 'Streso valdymas',
      description:
          'Prieš įtemptą epizodą susikurk trumpą rutiną: įkvėpimas, vienas konkretus tikslas, veiksmas.',
    ),
  ],
  normalizeSkillName('pasitikėjimas savimi'): const [
    SkillTip(
      title: 'Pasitikėjimas savimi',
      description:
          'Po klaidos sąmoningai atlik kitą paprastą veiksmą užtikrintai, kad greičiau grįžtum į ritmą.',
    ),
  ],
  normalizeSkillName('atsakomybė'): const [
    SkillTip(
      title: 'Atsakomybė',
      description:
          'Po treniruotės įvardink vieną savo veiksmą, kurį gali pagerinti, ir suplanuok konkretų žingsnį kitai treniruotei.',
    ),
  ],
  normalizeSkillName('koncentracija'): const [
    SkillTip(
      title: 'Koncentracija',
      description:
          'Kiekvieno pratimo pradžioje pasirink vieną techninį ar taktininį akcentą ir vertink tik jo laikymąsi.',
    ),
  ],
  normalizeSkillName('motyvacija'): const [
    SkillTip(
      title: 'Motyvacija',
      description:
          'Prieš treniruotę užsirašyk vieną mažą tikslą, kuris priklauso nuo tavo pastangų, o ne nuo rezultato.',
    ),
  ],
  normalizeSkillName('sprendimų priėmimas'): const [
    SkillTip(
      title: 'Sprendimų priėmimas',
      description:
          'Po vienos žaidybinės situacijos trumpai įvertink: ką matei, kokį variantą pasirinkai ir ką kitą kartą spręstum greičiau.',
    ),
  ],
};
