class VoteResponse {
  int id;
  String title;
  int beginning;
  String group;
  VoteType type;

  VoteResponse({this.id, this.title, this.beginning, this.group, this.type});

  factory VoteResponse.fromJson(Map<String, dynamic> json) => new VoteResponse(
      id: json["id"],
      title: json["title"],
      beginning: json["beginning"],
      group: json["group"],
      type: VoteType.fromJson(json["type"]));

  factory VoteResponse.fromJsonNullable(Map<String, dynamic> json) {
    VoteResponse response = VoteResponse();
    if (json.containsKey("id")) {
      response.id = json["id"];
    }
    if (json.containsKey("title")) {
      response.title = json["title"];
    }
    if (json.containsKey("beginning")) {
      response.beginning = json["beginning"];
    }
    if (json.containsKey("group")) {
      response.group = json["group"];
    }
    if (json.containsKey("type")) {
      response.type = VoteType.fromJson(json["type"]);
    }
    return response;
  }
}

class FinishedVoteResponse {
  int id;
  String title;
  int end;
  String group;
  VoteType type;

  FinishedVoteResponse({this.id, this.title, this.end, this.group, this.type});

  factory FinishedVoteResponse.fromJson(Map<String, dynamic> json) =>
      new FinishedVoteResponse(
          id: json["id"],
          title: json["title"],
          end: json["end"],
          group: json["group"],
          type: VoteType.fromJson(json["type"]));

  factory FinishedVoteResponse.fromJsonNullable(Map<String, dynamic> json) {
    FinishedVoteResponse response = FinishedVoteResponse();
    if (json.containsKey("id")) {
      response.id = json["id"];
    }
    if (json.containsKey("title")) {
      response.title = json["title"];
    }
    if (json.containsKey("beginning")) {
      response.end = json["end"];
    }
    if (json.containsKey("group")) {
      response.group = json["group"];
    }
    if (json.containsKey("type")) {
      response.type = VoteType.fromJson(json["type"]);
    }
    return response;
  }
}

class VoteDetailResponse {
  final int id;
  final String title;
  final String description;
  final int beginning;
  final int end;
  final Group group;
  final VoteType type;
  final List<VoteOptions> responses;
  final List<VoteResults> results;

  VoteDetailResponse(
      {this.id,
      this.title,
      this.description,
      this.beginning,
      this.end,
      this.group,
      this.type,
      this.responses,
      this.results});

  factory VoteDetailResponse.fromJson(Map<String, dynamic> json) {
    return new VoteDetailResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        beginning: json["beginning"],
        end: json["end"],
        group: Group.fromJson(json["group"]),
        type: VoteType.fromJson(json["type"]),
        responses: List<VoteOptions>.from(
            json["responses"].map((x) => VoteOptions.fromJson(x))),
        results: List<VoteResults>.from(
            json["results"].map((x) => VoteResults.fromJson(x))));
  }
}

class VoteResults {
  final String title;
  final List<ResultItem> items;

  VoteResults({this.title, this.items});

  factory VoteResults.fromJson(Map<String, dynamic> json) => VoteResults(
      title: json["title"],
      items: List<ResultItem>.from(
          json["items"].map((x) => ResultItem.fromJson(x))));
}

class ResultItem {
  final String label;
  final int value;

  ResultItem({this.label, this.value});

  factory ResultItem.fromJson(Map<String, dynamic> json) =>
      ResultItem(label: json["label"], value: json["value"]);
}

class VoteOptions {
  int id;
  String value;
  String description;

  VoteOptions({this.id, this.value, this.description});

  factory VoteOptions.fromJson(Map<String, dynamic> json) => new VoteOptions(
      id: json["id"], value: json["value"], description: json["description"]);
}

class Group {
  String name;
  int id;

  Group({this.name, this.id});

  factory Group.fromJson(Map<String, dynamic> json) =>
      new Group(name: json["name"], id: json["id"]);
}

//      DateTime.fromMillisecondsSinceEpoch(vote.beginning),
class VoteType {
  final String color;
  final String name;
  final String logo;

  VoteType({this.color, this.name, this.logo});

  factory VoteType.fromJson(Map<String, dynamic> json) => new VoteType(
      color: json["color"], name: json["name"], logo: json["logo"]);
}

class VerifyVoteResopnse {
  String encryptedData;

  VerifyVoteResopnse({this.encryptedData,});

  factory VerifyVoteResopnse.fromJson(Map<String, dynamic> json) =>
      new VerifyVoteResopnse(encryptedData: json["encryptedData"]);
}