class FavoriteMovieModel{

  int? id;
  int? movieKey;
  String? titulo;
  String? image;
  

  FavoriteMovieModel({this.id, this.movieKey, this.titulo, this.image});

  // Map -> Object
  
  factory FavoriteMovieModel.fromMap(Map<String,dynamic> map){
    return FavoriteMovieModel(
      id: map['id'],
      movieKey: map['movieKey'],
      titulo: map['titulo'],
      image: map['image']
    );
  }

  // Object -> map
  Map<String,dynamic> toMap(){
      return{
        'id' : id,
        'movieKey': movieKey,
        'titulo' : titulo,
        'image' : image
      };
  }

}