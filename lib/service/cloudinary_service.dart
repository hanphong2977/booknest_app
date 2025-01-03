import 'package:cloudinary/cloudinary.dart';

class CloudinaryService {
  static final Cloudinary _cloudinary = Cloudinary.signedConfig(
    apiKey: '236694893781876',
    apiSecret: 'Z9I0VKG4OK3CGPmJZNoJDzGlbbI',
    cloudName: 'df54g1yhb',
  );

  // Hàm tải ảnh lên
  static Future<String?> uploadImage(String imagePath) async {
    try {
      final response = await _cloudinary.upload(
        file: imagePath,
        resourceType: CloudinaryResourceType.image,
        folder: 'flutter_images',
      );

      if (response.isSuccessful) {
        return response.secureUrl;
      } else {
        return null;
      }
    } catch (e) {
      print('Lỗi khi tải ảnh lên Cloudinary: $e');
      return null;
    }
  }
}
