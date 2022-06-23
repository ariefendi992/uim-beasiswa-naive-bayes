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
  String? readProdi,
      readSemester,
      readStatusMhs,
      readKip,
      readPenghasilan,
      readPkh;

  String? readProdiLayak,
      readProdiTidakLayak,
      readSemesterLayak,
      readSemesterTidakLayak,
      readStatusMahasiswaLayak,
      readStatusMahasiswaTidakLayak,
      readKipLayak,
      readKipTidakLayak,
      readPenghasilanLayak,
      readPenghasilanTidakLayak,
      readPkhLayak,
      readPkhTidakLayak,
      readHasil;

  @override
  void initState() {
    super.initState();
    getAtribut();
    SecureStorages().readAll();
  }

  void getAtribut() async {
    var prodi = await SecureStorages().readStorage('prodi');
    var semester = await SecureStorages().readStorage('semester');
    var statusMhs = await SecureStorages().readStorage('statusMhs');
    var kip = await SecureStorages().readStorage('kip');
    var penghasilan = await SecureStorages().readStorage('penghasilan');
    var pkh = await SecureStorages().readStorage('pkh');

    var prodiLayak = await SecureStorages().readStorage('prodiLayak');
    var prodiTidakLayak = await SecureStorages().readStorage('prodiTidakLayak');
    var semesterLayak = await SecureStorages().readStorage('semesterLayak');
    var semesterTidakLayak =
        await SecureStorages().readStorage('semesterTidakLayak');
    var statusMahasiswaLayak =
        await SecureStorages().readStorage('statusMahasiswaLayak');
    var statusMahasiswaTidakLayak =
        await SecureStorages().readStorage('statusMahasiswaTidakLayak');
    var kipLayak = await SecureStorages().readStorage('kipLayak');
    var kipTidakLayak = await SecureStorages().readStorage('kipTidakLayak');
    var penghasilanLayak =
        await SecureStorages().readStorage('penghasilanLayak');
    var penghasilanTidakLayak =
        await SecureStorages().readStorage('penghasilanTidakLayak');
    var pkhLayak = await SecureStorages().readStorage('pkhLayak');
    var pkhTidakLayak = await SecureStorages().readStorage('pkhTidakLayak');
    var hasil = await SecureStorages().readStorage('hasil');

    setState(() {
      readProdi = prodi;
      readSemester = semester;
      readStatusMhs = statusMhs;
      readKip = kip;
      readPenghasilan = penghasilan;
      readPkh = pkh;
      readProdiLayak = prodiLayak;
      readProdiTidakLayak = prodiTidakLayak;
      readSemesterLayak = semesterLayak;
      readSemesterTidakLayak = semesterTidakLayak;
      readStatusMahasiswaLayak = statusMahasiswaLayak;
      readStatusMahasiswaTidakLayak = statusMahasiswaTidakLayak;
      readKipLayak = kipLayak;
      readKipTidakLayak = kipTidakLayak;
      readPenghasilanLayak = penghasilanLayak;
      readPenghasilanTidakLayak = penghasilanTidakLayak;
      readPkhLayak = pkhLayak;
      readPkhTidakLayak = pkhTidakLayak;
      readHasil = hasil;
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
              '..:: Hasil Uji Data ::..'.toUpperCase(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
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
                      '${readProdi ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readProdiLayak ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readProdiTidakLayak ?? "-"}',
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
                      '${readSemester ?? '-'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readSemesterLayak ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readSemesterTidakLayak ?? "-"}',
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
                      '${readStatusMhs == null ? '-' : readStatusMhs.toString().toCapitalized()}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readStatusMahasiswaLayak ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readStatusMahasiswaTidakLayak ?? "-"}',
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
                      readKip == null
                          ? '-'
                          : readKip.toString().toCapitalized(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readKipLayak ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readKipTidakLayak ?? "-"}',
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
                      '${readPenghasilan ?? '-'}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readPenghasilanLayak ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readPenghasilanTidakLayak ?? "-"}',
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
                      readPkh != null
                          ? readPkh.toString().toCapitalized()
                          : '-',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readPkhLayak ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${readPkhTidakLayak ?? "-"}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Berdasarkan hasil perhitungan, dapat disimpulkan bahwa data uji tersebut ',
                  ),
                  TextSpan(
                    text: readHasil.toString().toUpperCase(),
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        decoration: TextDecoration.underline),
                  ),
                  TextSpan(
                    text: ' untuk menerima beasiswa.',
                  ),
                ],
                style: blackTextStyle.copyWith(fontSize: 16),
              ),
            ),
            // Text(
            //     'Berdasarkan hasil perhitungan, dapat disimpulkan bahwa data uji tersebut'),
            // Text(
            //   '${readHasil.toString().toUpperCase()}',
            //   style: blackTextStyle.copyWith(fontWeight: semiBold),
            // ),
            // Text('untuk mendapatkan beasiswa'),
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
