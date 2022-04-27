class SentenceModel {
  final String id;
  final List<String> sentence;

  SentenceModel(this.id, this.sentence);

  SentenceModel.split(String param)
      : id = param,
        sentence = param.split('  ');
}
