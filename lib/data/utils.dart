import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future uploadImage(File image) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference reference = FirebaseStorage.instance.ref().child(fileName);
  UploadTask uploadTask = reference.putFile(image);
  TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  return await taskSnapshot.ref.getDownloadURL();
}
