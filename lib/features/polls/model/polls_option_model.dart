class PollsOptionModel {
  int? id;
  String? text;

  PollsOptionModel({required this.id, required this.text});

  PollsOptionModel.fromJson({required Map json}) {
    id = json["id"];
    text = json["option_text"];
  }
}
