import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ÑAÑA POINT\'S',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Color principal de la aplicación
      ),
      home: LoginPage(), // Pantalla inicial de la app
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Para validar el formulario
  bool _isUserTypeSelected =
      false; // Controla si se ha seleccionado tipo de usuario
  bool _isLoginScreen = true; // Controla si se muestra el login o el registro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  'https://static-cse.canva.com/blob/951768/1650logotiposqueteinspiraran.png', // Reemplaza con la ruta de tu logo
                  height: 100,
                ),
                SizedBox(height: 30),
                Text(
                  'ÑAÑA POINT\'S',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                if (!_isUserTypeSelected) ...[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isUserTypeSelected = true;
                        _isLoginScreen = true;
                      });
                    },
                    child: Text('USUARIO'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isUserTypeSelected = true;
                        _isLoginScreen = false;
                      });
                    },
                    child: Text('EMPRESA'),
                  ),
                ] else ...[
                  if (_isLoginScreen) ...[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Usuario'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su usuario';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Acción para recuperar contraseña
                      },
                      child: Text('Olvidé mi contraseña'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Acción para iniciar sesión
                        }
                      },
                      child: Text('INGRESAR'),
                    ),
                  ] else ...[
                    // Campos del formulario para registrar una empresa
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nombres'),
                    ),
                    // ... otros campos
                  ],
                  SizedBox(height: 20),
                  if (_isLoginScreen) ...[
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLoginScreen = false;
                        });
                      },
                      child: Text('Eres nuevo? Regístrate'),
                    ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () {
                        // Acción para registrar empresa
                      },
                      child: Text('REGISTRARME'),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
