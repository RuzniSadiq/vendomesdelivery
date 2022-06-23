class Hotels{

  String? name;

  Hotels({required this.name});

  Hotels.fromJson(Map<String, dynamic> json)
  {
   name = json['name'];
  }
}