import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:password_manager/app/data/repository/services/file_picker_service.dart';

class FilePickerServiceImpl implements FilePickerService {
  final _filePicker = FilePicker.platform;

  @override
  Future<String?> pickFile() async {
    final filePicked = await _filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    return filePicked?.files.single.path;
  }

  @override
  Future<String?> saveFile(Uint8List dataToSave) async {
    final today = DateFormat('yyyyMMddHHmm').format(DateTime.now());

    final savedFilePath = await _filePicker.saveFile(
      fileName: 'backup_$today.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
      bytes: dataToSave,
    );

    return savedFilePath;
  }
}
