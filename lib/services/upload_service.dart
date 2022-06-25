import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:http/http.dart' as http;

class UploadService {
  Future<void> uploadImage({
    String? idUser,
    String? fieldName,
    imageFile,
  }) async {
    final url = baseUrl + '/upload/user-profil/$idUser';

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile(
        fieldName!, imageFile!.readAsBytes().asStream(), imageFile.lengthSync(),
        filename: imageFile.path.split('/').last));

    final response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
