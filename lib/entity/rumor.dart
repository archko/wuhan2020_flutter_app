class Rumor {
  int id;
  String title;
  String mainSummary;
  String summary;
  String body;
  String sourceUrl;
  int score;
  int rumorType;

  Rumor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mainSummary = json['mainSummary'];
    summary = json['summary'];
    body = json['body'];
    sourceUrl = json['sourceUrl'];
    score = json['score'];
    rumorType = json['rumorType'];
  }

  @override
  String toString() {
    return 'Rumor{id: $id, title: $title, mainSummary: $mainSummary, summary: $summary, body: $body, sourceUrl: $sourceUrl, score: $score, rumorType: $rumorType}';
  }
}
