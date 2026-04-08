class ArticleLink {
  const ArticleLink({
    required this.title,
    required this.description,
    required this.url,
  });

  final String title;
  final String description;
  final String url;
}

const List<ArticleLink> articleLinks = [
  ArticleLink(
    title: 'Minkštųjų įgūdžių svarba',
    description:
        'Straipsnis aiškina, kad minkštieji įgūdžiai (pvz., komunikacija, komandinis darbas ir problemų sprendimas) yra būtini sportininkams ne tik sporte, bet ir jų ateities karjeroje bei kasdieniame gyvenime.',
    url: 'https://tptischool.com/en/the-importance-of-soft-skills-for-athletes-preparing-for-the-future-on-and-off-the-field/',
  ),
  ArticleLink(
    title: 'Kur galima pritaikyti minkštuosius įgūdžius',
    description:
        'olimpinių sportininkų minkštieji įgūdžiai (pvz., gebėjimas valdyti stresą, siekti tobulumo ir dirbti komandoje) gali būti pritaikomi versle siekiant geresnių rezultatų.',
    url: 'https://www.centraltest.com/blog/olympic-games-2024-how-athletes-soft-skills-can-improve-business-performance',
  ),
  ArticleLink(
    title: 'Sporto nauda',
    description:
        'Straipsnis nagrinėja, kaip sporto praktikavimo trukmė yra susijusi su paauglių kognityviniais gebėjimais (ypač loginio mąstymo) ir minkštaisiais įgūdžiais, tokiais kaip iniciatyvumas, lyderystė ir atkaklumas.',
    url: 'https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2022.857412/full',
  ),
];
