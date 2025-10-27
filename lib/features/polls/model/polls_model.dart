class PollsModel {
  int? id, totaVotes;
  String? title;
  List? options;

  PollsModel({required this.id, required this.title, required this.totaVotes});

  PollsModel.fromJson({required Map json}) {
    id = json["id"];
    totaVotes = json["total_votes"];
    title = json["name"];
    options = json["options"];
  }
}
