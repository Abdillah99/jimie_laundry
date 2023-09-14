import 'package:dartz/dartz.dart';
import 'package:jimie_laundry/config/app_constants.dart';
import 'package:jimie_laundry/config/app_request.dart';
import 'package:jimie_laundry/config/app_response.dart';
import 'package:jimie_laundry/config/failure.dart';
import 'package:http/http.dart' as http;

class UserDatasource {
  static Future<Either<Failure, Map>> register(
    String username,
    String email,
    String password,
  ) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/register');
    try {
      final response = await http.post(
        url,
        headers: AppRequest.header(),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(FetchFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map>> Login(
    String email,
    String password,
  ) async {
    Uri url = Uri.parse('${AppConstants.baseURL}/login');
    try {
      final response = await http.post(
        url,
        headers: AppRequest.header(),
        body: {
          'email': email,
          'password': password,
        },
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(FetchFailure(e.toString()));
    }
  }
}
