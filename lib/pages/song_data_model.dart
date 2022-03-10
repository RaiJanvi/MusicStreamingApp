//Data model for songs list

class SongDataModel{
  int? id;
  String? language, title, artist, img;

  SongDataModel({this.id, this.language, this.title, this.img, this.artist});

  SongDataModel.fromJson(Map<String, dynamic> json){
    id= json['id'];
    language= json['language'];
    title= json['title'];
    artist= json['artist'];
    img= json['img'];
  }
}