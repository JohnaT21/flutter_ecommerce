import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/core/network/network_info.dart';
import 'package:logger/logger.dart';

import '../../domain/repositories/chat_repo.dart';
import '../data_sources/chat_data_source.dart';

class ChatRepositoryImpl implements ChatRepo {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, dynamic>> getChatList() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getChatLists();
        return Right(res);
      } catch (e) {
        Logger().d(e.toString());
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }
}
