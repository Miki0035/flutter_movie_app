import 'package:appwrite/appwrite.dart';
import 'package:flutter_movie_app/core/env/env.dart';

class AppwriteService {
  AppwriteService._internal();

  static final AppwriteService instance = AppwriteService._internal();

  late final Client client;
  late final Account account;
  late final TablesDB tables;

  void init() {
    client = Client()
        .setEndpoint(Env.appwriteEndPoint)
        .setProject(Env.appwriteProjectId);

    account = Account(client);
    tables = TablesDB(client);
  }
}
