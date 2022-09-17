import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/ukt/training_ukt_cubit.dart';
import 'package:ft_uim_naive_bayes/models/training_ukt.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_app_bar.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/loading_widget.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/srollable_widget.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:ft_uim_naive_bayes/utils/extensions.dart';

class PenerimaPage extends StatefulWidget {
  const PenerimaPage({Key? key}) : super(key: key);

  @override
  _PenerimaPageState createState() => _PenerimaPageState();
}

class _PenerimaPageState extends State<PenerimaPage> {
  late List<TrainingUktModel> trainingUkt;
  int? sortColumnIndex;
  bool isAscending = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<TrainingUktCubit>().fetchUkt();
    Timer(Duration(seconds: 4), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildDataTable(List<TrainingUktModel> uktModel) {
      final columns = ['Nama', 'Prodi', 'Status'];

      List<DataColumn> getColumns(List<String> columns) => columns
          .map(
            (String column) => DataColumn(
              label: Text(column),
              onSort: (columnIndex, ascending) {
                if (isAscending == true) {
                  isAscending = false;
                  uktModel.sort(
                      (value1, value2) => value2.nama!.compareTo(value1.nama!));
                } else {
                  isAscending = true;
                  uktModel.sort(
                      (value1, value2) => value1.nama!.compareTo(value2.nama!));
                }
                setState(() {
                  sortColumnIndex = columnIndex;
                  print('sort == $sortColumnIndex');
                });
              },
            ),
          )
          .toList();

      List<DataCell> getCells(List<dynamic> cells) =>
          cells.map((data) => DataCell(Text('$data'))).toList();

      List<DataRow> getRows(List<TrainingUktModel> uktModel) =>
          uktModel.map((TrainingUktModel ukt) {
            final cells = [
              '${ukt.nama.toString().toTitleCase()}',
              '${ukt.prodi}',
              '${ukt.kelaykan.toString().toTitleCase()}'
            ];
            return DataRow(cells: getCells(cells));
          }).toList();

      return DataTable(
        columns: getColumns(columns),
        rows: getRows(uktModel),
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
      );
    }

    return Scaffold(
      backgroundColor: kBarColor,
      body: BlocConsumer<TrainingUktCubit, TrainingUktState>(
        listener: (context, state) {
          if (state is TrainingUktFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TrainingUktSuccess) {
            return Stack(
              children: [
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                //   child: Text(
                //     '.:: Data Training ::.'.toUpperCase(),
                //     style: blackTextStyle.copyWith(
                //       fontSize: 20,
                //       fontWeight: medium,
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 80),
                  decoration: BoxDecoration(color: kBackgroundColor),
                  child: ListView(
                    children: [
                      ScrollableWidget(
                        child: buildDataTable(state.trainingUktModel),
                      ),
                    ],
                  ),
                ),
                CustomAppBar(
                  title: 'Data Training',
                  onTap: () {
                    context.read<PageCubit>().setPage(1);
                    Navigator.pushNamed(context, '/main');
                  },
                ),
              ],
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
