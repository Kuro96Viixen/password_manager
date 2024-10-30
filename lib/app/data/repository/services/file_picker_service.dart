import 'dart:typed_data';

abstract class FilePickerService {
  Future<String?> pickFile();

  Future<String?> saveFile(Uint8List dataToSave);
}
