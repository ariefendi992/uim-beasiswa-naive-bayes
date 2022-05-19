import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:ft_uim_naive_bayes/utils/extensions.dart';

class HasilPage extends StatefulWidget {
  const HasilPage({Key? key}) : super(key: key);

  @override
  _HasilPageState createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  String? readProdi, readSemester, readStatusMhs;
  @override
  void initState() {
    super.initState();
    getAtribut();
  }

  void getAtribut() async {
    var prodi = await SecureStorages().readStorage('prodi');
    var semester = await SecureStorages().readStorage('semester');
    var statusMhs = await SecureStorages().readStorage('statusMhs');

    setState(() {
      readProdi = prodi;
      readSemester = semester;
      readStatusMhs = statusMhs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget titlePage() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hasil Keputusan',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: kBlueColor,
              ),
              children: [
                Text(
                  'Atribut',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Value',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Layak',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tidak Layak',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Prodi',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '$readProdi',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Layak',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tidak Layak',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Semester',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '$readSemester',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Layak',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tidak Layak',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Status Mhs',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  readStatusMhs.toString().toCapitalized(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Layak',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tidak Layak',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Terima KIP',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '$readProdi',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Layak',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tidak Layak',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'P. Ortu',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '$readProdi',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Layak',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tidak Layak',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Terima PKH',
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '$readProdi',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Layak',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tidak Layak',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          titlePage(),
          body(),
        ],
      ),
    );
  }
}
