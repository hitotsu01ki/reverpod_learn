import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/platform_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraProvider = Provider<CameraUtils>((ref) {
  final ImagePicker picker = ImagePicker();
  return CameraUtils(ref.read, picker);
});

class CameraUtils {
  CameraUtils(this._reader, this.picker);
  final ImagePicker picker;
  final Reader _reader;
  late final platform = _reader(platformFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);

  File? file;

  Future<bool> camera() async {
    XFile? pickedFile;
    PermissionStatus status = await Permission.camera.status;
    _log.info(status);
    if (status.isDenied || status.isPermanentlyDenied) {
      // 端末の設定画面を開く
      await openAppSettings();
      return false;
    }
    pickedFile = await picker.pickImage(source: ImageSource.camera);
    return fileCheck(pickedFile);
  }

  Future<bool> gallery() async {
    XFile? pickedFile;
    if (await platform.then((value) => value.isIOS())) { // Android9以上は権限不要
      PermissionStatus status = await Permission.photos.status;
      _log.info(status);
      if (status.isDenied || status.isPermanentlyDenied) {
        // 端末の設定画面を開く
        await openAppSettings();
        return false;
      }
    }
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return fileCheck(pickedFile);
  }

  bool fileCheck(XFile? pickedFile) {
    if (pickedFile == null) {
      _log.info('画像選択をキャンセル');
      return false;
    }
    file = File(pickedFile.path);
    return true;
  }

}