import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/data/test_questions.dart';

void main() {
  group('test questions data', () {
    test('has unique category ids and database skill names', () {
      expect(softSkillQuestionCategories, isNotEmpty);

      final categoryIds = softSkillQuestionCategories.map((c) => c.id).toList();
      expect(categoryIds.toSet(), hasLength(categoryIds.length));

      for (final category in softSkillQuestionCategories) {
        expect(category.id.trim(), isNotEmpty);
        expect(category.title.trim(), isNotEmpty);
        expect(category.dbSkillName.trim(), isNotEmpty);
        expect(category.questions, isNotEmpty);
      }
    });

    test('every question has valid answer options and weights', () {
      for (final category in softSkillQuestionCategories) {
        for (final question in category.questions) {
          expect(question.question.trim(), isNotEmpty);
          expect(question.options, hasLength(4));
          expect(question.options.map((o) => o.id), ['a', 'b', 'c', 'd']);

          for (final option in question.options) {
            expect(option.text.trim(), isNotEmpty);
            expect(option.weight, inInclusiveRange(0, 10));
          }
        }
      }
    });

    test('contains questions for all supported sports', () {
      final allQuestions = softSkillQuestionCategories
          .expand((category) => category.questions)
          .toList();

      expect(
        allQuestions.any((question) => question.isForSport(SportType.krepsinis)),
        isTrue,
      );
      expect(
        allQuestions.any((question) => question.isForSport(SportType.tinklinis)),
        isTrue,
      );
      expect(
        allQuestions.any((question) => question.isForSport(SportType.futbolas)),
        isTrue,
      );
    });

    test('sport-specific filtering keeps shared questions available', () {
      const sharedQuestion = SoftSkillQuestion(
        question: 'Kaip reaguojate i itampa komandoje?',
        options: [],
      );
      const basketballOnlyQuestion = SoftSkillQuestion(
        question: 'Kaip priimate sprendima aiksteje?',
        options: [],
        sportTypes: [SportType.krepsinis],
      );

      expect(sharedQuestion.isForSport(SportType.futbolas), isTrue);
      expect(basketballOnlyQuestion.isForSport(SportType.krepsinis), isTrue);
      expect(basketballOnlyQuestion.isForSport(SportType.futbolas), isFalse);
      expect(basketballOnlyQuestion.isForSport(), isFalse);
    });

    test('explicit Lithuanian sport question variants preserve diacritics', () {
      const question = SoftSkillQuestion(
        question: 'Bendras klausimas',
        options: [],
        sportSpecificQuestions: {
          SportType.krepsinis: 'Kaip elgiatės krepšinio aikštelėje?',
          SportType.tinklinis: 'Kaip elgiatės tinklinio aikštelėje?',
          SportType.futbolas: 'Kaip elgiatės futbolo aikštėje?',
        },
      );

      expect(
        question.getQuestionText(SportType.krepsinis),
        'Kaip elgiatės krepšinio aikštelėje?',
      );
      expect(
        question.getQuestionText(SportType.tinklinis),
        'Kaip elgiatės tinklinio aikštelėje?',
      );
      expect(
        question.getQuestionText(SportType.futbolas),
        'Kaip elgiatės futbolo aikštėje?',
      );
    });

    test('option text selects sport marker variants without changing Lithuanian text', () {
      const option = QuestionOption(
        id: 'd',
        text:
            'Pasirinksite veiksmą pagal situaciją (K metimas / T kėlimas / F perdavimas)',
        weight: 10,
      );

      expect(
        option.getText(SportType.krepsinis),
        'Pasirinksite veiksmą pagal situaciją metimas',
      );
      expect(
        option.getText(SportType.tinklinis),
        'Pasirinksite veiksmą pagal situaciją kėlimas',
      );
      expect(
        option.getText(SportType.futbolas),
        'Pasirinksite veiksmą pagal situaciją perdavimas',
      );
    });
  });
}
