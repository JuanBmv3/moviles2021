class ProfileModel{

  int? id;
  String? nombre;
  String? a_paterno;
  String? a_materno;
  String? num_tel;
  String? correo;
  String? image;


  ProfileModel({this.id, this.nombre, this.a_paterno, this.a_materno, this.num_tel, this.correo, this.image});

  // Map -> Object
  
  factory ProfileModel.fromMap(Map<String,dynamic> map){
    return ProfileModel(
      id: map['id'],
      nombre: map['nombre'],
      a_paterno: map['a_paterno'],
      a_materno: map['a_materno'],
      num_tel: map['num_telf'],
      correo: map['correo'],
      image: map['image'],
    );
  }

  // Object -> map
  Map<String,dynamic> toMap(){
      return{
        'id' : id,
        'nombre': nombre,
        'a_paterno': a_paterno,
        'a_materno': a_materno,
        'num_telf': num_tel,
        'correo': correo,
        'image': image,
       };
  }

}