// ignore_for_file: file_names, prefer_final_fields

part of '../services.dart';

class BaseUrl {
  static const String _baseURL = 'https://demo.treblle.com/api/v1/';
  static const String _loginServicePath = _baseURL + 'auth/';
  static String login = _loginServicePath + 'login';

  static String fetchArticles = _baseURL + 'articles';
}
