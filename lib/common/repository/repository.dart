import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/auth/ui/model/user.dart';

class EcommerceRepository {
  final dio = Dio();

  Future<Either<String, Bool>> login(
      {required String email, required String password}) async {
    try {
      final _ = await dio.post(
          "https://ecommerce-api-3sb4.onrender.com/api/auth/login",
          data: {
            "email": email,
            "password": password,
          });

      Right(true);
    } on DioException catch (e) {
      return Left(e.message ?? "there is might be something wrong");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      final _ = await dio.post(
          "https://ecommerce-api-3sb4.onrender.com/api/auth/register",
          data: {
            "name": name,
            "email": email,
            "password": password,
            "phone": phone,
            "address": address,
          });

      final user = User(
          fullName: name,
          phoneNumber: phone,
          address: address,
          email: email,
          password: password);
      return Right(user);
    } on DioException catch (e) {
      print(e.message);
      return Left(e.message ?? "May be something went wrong");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
/*
{
"name":"",
"email":"",
"password":"",
"phone":"",
"address":""}
*/

/*
try {
      final _ = await dio.post(
          "https://ecommerce-api-3sb4.onrender.com/api/auth/login",
          data: {
            "email": email,
            "password": password,
          });

      Right(true);
    } 
 */