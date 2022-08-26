import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/repository/auth/auth_repository_impl.dart';

final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(ref.read));