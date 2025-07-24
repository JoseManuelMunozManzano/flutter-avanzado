import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

// Tenemos que analizar como nos va a responder el backend la información del usuario.
// Nuestro backend regresa un objeto usuario con los siguientes campos:
// - uid: String
// - nombre: String
// - email: String
// - online: bool
// Este usuario tiene que tener la información del usuario actualmente logeado.
class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners(); // Notifica a los widgets que están escuchando esta propiedad para que se redibuje.
  }

  // Métodos estáticos para obtener el token y eliminarlo.
  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  // Regresa un Future<bool> que indica si el login fue exitoso o no.
  Future<bool> login(String email, String password) async {
    autenticando = true;

    // payload que espera al backend.
    final data = {"email": email, "password": password};

    // Petición y respuesta del backend.
    final url = Uri.http(Environment.apiUrl, 'api/login');
    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    // print(resp.body);
    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      // Aquí ya tenemos cual es el usuario autenticado.
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true; // Login exitoso.
    } else {
      return false; // Login fallido.
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;

    // payload que espera al backend.
    final data = {"nombre": nombre, "email": email, "password": password};

    // Petición y respuesta del backend.
    final url = Uri.http(Environment.apiUrl, 'api/login/new');
    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    // print(resp.body);
    autenticando = false;

    if (resp.statusCode == 200) {
      final registerResponse = loginResponseFromJson(resp.body);
      usuario = registerResponse.usuario;
      await _guardarToken(registerResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final url = Uri.http(Environment.apiUrl, 'api/login/renew');
    final resp = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'x-token': token ?? ''},
    );

    // print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      // Guardamos el nuevo token, reemplazando el anterior.
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      // Si el token no es válido, lo eliminamos.
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
