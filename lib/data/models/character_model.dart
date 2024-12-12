class CharacterModel{
  final String name;
  final String house;
  final String image;

  CharacterModel({
    required this.name,
    required this.house,
    required this.image
});

  factory CharacterModel.fromJson(Map<String, dynamic> json){
    return CharacterModel(
      name: json['name'],
      house: json['house'] ?? 'Unknown',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'house': house,
      'image': image,
    };
  }

}