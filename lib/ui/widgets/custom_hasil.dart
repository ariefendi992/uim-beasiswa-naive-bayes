import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/models/hasil_ukt_model.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class HasilUjiCustom extends StatelessWidget {
  final HasilUktModel hasilUkt;
  const HasilUjiCustom(this.hasilUkt, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hasil Keputusan',
              style: blueTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 6),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: kWhiteColor,
                        size: 15,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Program Studi',
                    style: blackTextStyle.copyWith(),
                  ),
                  Spacer(),
                  Text('${hasilUkt.prodi}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
