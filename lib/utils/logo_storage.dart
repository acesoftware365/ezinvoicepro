import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogoStorage {
  static Future<String> saveLogoFile(File source) async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/ez_invoice');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final ext = source.path.split('.').last.toLowerCase();
    final safeExt = (ext.isEmpty || ext.length > 5) ? 'png' : ext;
    final target = File('${folder.path}/business_logo.$safeExt');

    // Reemplaza si existe
    if (await target.exists()) {
      await target.delete();
    }
    return (await source.copy(target.path)).path;
  }

  static Future<void> deleteLogoIfExists(String? path) async {
    if (path == null || path.isEmpty) return;
    final f = File(path);
    if (await f.exists()) {
      await f.delete();
    }
  }
}
