import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/repository/auth/auth_data_source_impl.dart';

final authDataSourceProvider = Provider((ref) => AuthDataSourceImpl(ref.read));