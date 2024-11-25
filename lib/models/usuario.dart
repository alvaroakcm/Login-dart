class UsuarioDTO {
  int userId;
  String userName;
  String apellido;
  String correo;
  String telefono;
  String password;
  String tipoUsuario;
  String? nombreEmpresa;
  String? dni;
  String? direccion;

  UsuarioDTO({
    required this.userId,
    required this.userName,
    required this.apellido,
    required this.correo,
    required this.telefono,
    required this.password,
    required this.tipoUsuario,
    this.nombreEmpresa,
    this.dni,
    this.direccion,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'apellido': apellido,
      'correo': correo,
      'telefono': telefono,
      'password': password,
      'tipoUsuario': tipoUsuario,
      'nombreEmpresa': nombreEmpresa,
      'dni': dni,
      'direccion': direccion,
    };
  }
}
