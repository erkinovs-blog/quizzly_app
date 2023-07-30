class Language {
  int id;
  String name;
  String flag;
  String languageCode;

  Language({
    required this.id,
    required this.name,
    required this.flag,
    required this.languageCode,
  });
  
  static List<Language> languageList() => [
    Language(id: 0, name: "UZ", flag: "🇺🇿", languageCode: "uz"),
    Language(id: 1, name: "EN", flag: "🇺🇸", languageCode: "en"),
    Language(id: 2, name: "RU", flag: "🇷🇺", languageCode: "ru"),
  ];
}
