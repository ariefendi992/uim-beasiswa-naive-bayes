import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomFieldProfil extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final FocusNode focusNode;
  final Function() onPressed;

  const CustomFieldProfil(
      {required this.controller,
      required this.label,
      required this.readOnly,
      required this.focusNode,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 6),
            Flexible(
              child: TextFormField(
                cursorColor: kBlackColor,
                // showCursor: true,
                focusNode: focusNode,
                readOnly: readOnly,
                // initialValue: '${state.user.nama}',
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  labelText: label  ,
                  labelStyle:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                  focusColor: kBlueColor,
                  hoverColor: kGreyColor,
                  border: InputBorder.none,
                ),
                // onSaved: (val) => password = val,
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                'Ganti',
                style: blueTextStyle.copyWith(),
              ),
            )
          ],
        ),
        Divider(
          color: kGreyColor,
          indent: 5,
          endIndent: 14,
          thickness: 1,
        ),
      ],
    );
  }
}
