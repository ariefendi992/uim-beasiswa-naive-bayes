import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class ListFilePage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const ListFilePage({
    Key? key,
    required this.files,
    required this.onOpenedFile,
  }) : super(key: key);

  @override
  _ListFilePageState createState() => _ListFilePageState();
}

class _ListFilePageState extends State<ListFilePage> {
  @override
  Widget build(BuildContext context) {
    Widget buildFile(PlatformFile file) {
      final kb = file.size / 1024;
      final mb = kb / 1024;
      final fileSize = mb >= 2
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      final extension = file.extension ?? 'none';
      // final color =;

      return InkWell(
        onTap: () {
          widget.onOpenedFile(file);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kGreenClor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '.$extension',
                    style: whiteTextStyle.copyWith(
                      fontSize: 28,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                file.name,
                style: blackTextStyle.copyWith(fontWeight: medium),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                fileSize,
                style: blackTextStyle.copyWith(fontWeight: medium),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('All Files'),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final file = widget.files[index];

            return buildFile(file);
          },
        ),
      ),
    );
  }
}
