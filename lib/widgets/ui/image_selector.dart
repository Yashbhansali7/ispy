import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:rooftop_ispy/widgets/helpers/default_text.dart';

class ImageSelector extends StatefulWidget {
  final ValueChanged<File> outerFile;
  final String title;
  final bool showClose;
  const ImageSelector(
      {Key? key,
      required this.outerFile,
      required this.title,
      required this.showClose})
      : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  Future<XFile?> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return image;
  }

  bool isLoading = false;
  Widget souceSelector(String title, IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Column(
        children: [
          InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                XFile? xFile;
                if (title == 'Camera') {
                  xFile = await getImage(ImageSource.camera);
                } else {
                  xFile = await getImage(ImageSource.gallery);
                }
                if (xFile == null) {
                  Navigator.of(context).pop();
                }
                widget.outerFile(File(xFile!.path));
                setState(() {});
                // dynamic media = campaign.getCampaign.imageUrl;
                // String url = await FirebaseUploadConfigs().uploadProfileImage(
                //     file,
                //     'campaignImages/${FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.phoneNumber}/${file.path.toString().split('/').last}');
                // media = url;
                // campaign.updateCampaignHome(null, null, media);
                // FirebaseFirestore.instance
                //     .collection('campaigns')
                //     .doc(campaign.getCampaign.id)
                //     .update({'imageUrl': media});

                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Center(child: Icon(icon)),
                radius: 30,
              )),
          const SizedBox(height: 14),
          DefaultText(
            text: title,
            weight: FontWeight.w500,
            fontSize: 16,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.showClose
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close,
                            size: 24, color: Colors.black))
                    : const SizedBox(),
                DefaultText(
                    text: widget.title, fontSize: 18, weight: FontWeight.w600),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 100,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: widget.showClose
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 15),
                        souceSelector('Camera', Icons.camera_outlined, context),
                        souceSelector(
                            'Gallery', Icons.photo_album_outlined, context),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
