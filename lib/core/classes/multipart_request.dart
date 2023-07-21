import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(
    String method,
    Uri url, {
    required this.onProgress,
  }) : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = this.contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}

request({
  required String url,
  method = "POST",
  required void Function(int, int) onProgress,
  required void Function(StreamedResponse) onDone,
  Map<String, dynamic>? body,
  File? uploadImage,
  String imageName = "defult.png",
}) async {
  try {
    final request = MultipartRequest(
      method,
      Uri.parse(url),
      onProgress: onProgress,
    );

    if (body != null) {
      body.keys.forEach((element) {
        request.fields[element] = body[element];
      });
    }

    if (uploadImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          uploadImage.path,
          filename: imageName,
        ),
      );
    }

    // done
    await request.send().then((value) async {
      onDone(value);
    });
  } catch (e) {}
}
