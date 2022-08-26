import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/dio/app_dio.dart';
import 'package:retrofit/retrofit.dart';

part 'zip_data_source.g.dart';

final zipDataSourceProvider = Provider((ref) => ZipDataSource(ref.read));

@RestApi()
abstract class ZipDataSource {
  factory ZipDataSource(Reader reader) => _ZipDataSource(reader(zipDioProvider));

  @GET("/api/search?zipcode={zipNum}")
  Future<dynamic> getZipSearch(
    @Path("zipNum") String zipNum,
  );

  @POST("/api/search")
  Future<dynamic> postZipSearch(
    @Header("Content-Type") String contentType,
    @Header("LLT_API_SECRETTOKEN") String lltApiSecretToken,
    @Body() Map<String, dynamic> body,
  );
}
