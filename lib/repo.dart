import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:nxtmate/models/model.dart';

class Repository {
  static String baseurl =
      "https://raw.githubusercontent.com/devshivam207/api_testing/main/student.json";
  final Dio _dio = Dio();

  Future<List<Student>> getlist() async {
    try {
      Response response = await _dio.get(baseurl);
      print(response.data);
      // Convert json string to a list
      List<dynamic> jsonData = json.decode(response.data);
      print(jsonData);
      // Convert jsondata in list of Student object
      List<Student> students =
          jsonData.map((item) => Student.fromJson(item)).toList();
      return students;
    } catch (error) {
      throw Exception("Failed to fetch data");
    }
  }

  Future<List<Student>> getlistByName() async {
    try {
      Response response = await _dio.get(baseurl);
      List<dynamic> jsonData = json.decode(response.data);
      List<Student> studentsByName = jsonData
          .where((item) => item['name'] != null)
          .map((item) => Student.fromJson(item))
          .toList();

      return studentsByName;
    } catch (error) {
      throw Exception("Failed to fetch data by name");
    }
  }

  Future<List<Student>> getlistByClassNumber() async {
    try {
      Response response = await _dio.get(baseurl);
      List<dynamic> jsonData = json.decode(response.data);
      List<Student> studentsByClassNumber = jsonData
          .where((item) => item['className'] != null)
          .map((item) => Student.fromJson(item))
          .toList();

      return studentsByClassNumber;
    } catch (error) {
      throw Exception("Failed to fetch data by class number");
    }
  }
}
