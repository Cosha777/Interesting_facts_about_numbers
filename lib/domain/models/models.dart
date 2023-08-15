class Info {
  final String text;
  final int number;

  Info.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        number = json['number'];

  Map<String, dynamic> toJson() => {
        'text': text,
        'number': number,
      };

  Info({
    required this.text,
    required this.number,
  });
}

class ListInfo {
  final List<Info> list;

  const ListInfo({
    required this.list,
  });

  ListInfo copyWith({
    List<Info>? list,
  }) {
    return ListInfo(
      list: list ?? this.list,
    );
  }
}
