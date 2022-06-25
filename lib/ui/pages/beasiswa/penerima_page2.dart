import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/ukt/training_ukt_cubit.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ft_uim_naive_bayes/models/training_ukt.dart';

// class PenerimaPage extends StatefulWidget {
//   const PenerimaPage({Key? key}) : super(key: key);

//   @override
//   _PenerimaPageState createState() => _PenerimaPageState();
// }

// class _PenerimaPageState extends State<PenerimaPage> {
//   bool isAscending = false;

//   @override
//   void initState() {
//     super.initState();
//     context.read<TrainingUktCubit>().fetchUkt();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<DataColumn> getColumns(List<String> columns) => columns
//         .map((String column) => DataColumn(
//               label: Text(column),
//             ))
//         .toList();

//     List<DataCell> getCell(List<dynamic> cells) =>
//         cells.map((data) => DataCell(Text('$data'))).toList();

//     List<DataRow> getRows(List<UktTraining> uktTraining) =>
//         uktTraining.map((UktTraining ukt) {
//           final cells = [ukt.nama, ukt.prodi, ukt.kelaykan];
//           return DataRow(cells: getCell(cells));
//         }).toList();

//     Widget buildDataTable() {
//       final columns = ['Nama', 'Prodi', 'Kelayakan'];
//       return DataTable(columns: getColumns(columns), rows: getRows(ukt));
//     }

//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       body: ScrollableWidget(
//         child: buildDataTable(),
//       ),
//     );
//   }
// }

class PenerimaPage extends StatefulWidget {
  const PenerimaPage({Key? key}) : super(key: key);

  @override
  _PenerimaPageState createState() => _PenerimaPageState();
}

class _PenerimaPageState extends State<PenerimaPage> {
  @override
  void initState() {
    super.initState();
    context.read<TrainingUktCubit>().fetchUkt();
  }

  @override
  Widget build(BuildContext context) {
    Widget dataUkt(List<TrainingUktModel> trainingUkt) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.only(
            top: 30,
            right: defaultPadding,
            left: defaultRadius,
            bottom: 110,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: trainingUkt.map((TrainingUktModel trainingUktModel) {
                  return Container(
                      child: Row(
                    children: [Text('${trainingUktModel.nama}')],
                  ));
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
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
            return ListView(
              children: [
                dataUkt(state.trainingUktModel),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
