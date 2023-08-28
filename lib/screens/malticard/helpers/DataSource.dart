import 'package:malticard/widgets/FutureImage.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/StudentModel.dart';
import '../UpdateSchool.dart';
import '/exports/exports.dart';

class SchoolDataSource extends DataTableSource {
  SchoolDataSource(this.context,
      {this.data = const [],
      this.paginatorController,
      required this.currentPage,
      this.totalDocuments = 0,
      this.onTap});
  final PaginatorController? paginatorController;
  final List<Result> data;
  final int totalDocuments;
  final int currentPage;
  final ValueChanged<String>? onTap;
  final BuildContext context;
// Replace with your actual data source
  String _schoolId = "";

  @override
  DataRow? getRow(int index) {
    final int pageIndex = currentPage ~/ paginatorController!.rowsPerPage;
    final int dataIndex = index % paginatorController!.rowsPerPage;
    final int dataLength = data.length;

    if (pageIndex * paginatorController!.rowsPerPage + dataIndex >=
        dataLength) {
      return null;
    }

    final rowData =
        data[pageIndex * paginatorController!.rowsPerPage + dataIndex];

    return DataRow2.byIndex(
      onSelectChanged: (value) {
        if (value == null) {
          return;
        } else {
          onTap!(rowData.id);
        }
      },
      index: index,
      cells: [
        // DataCell(Text((index + 1).toString())),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(5.0),
            child:
                FutureImage(future: fetchAndDisplayImage(rowData.schoolBadge)),
          ),
        ),
        DataCell(
          Text(
            rowData.schoolName,
          ),
        ),
        DataCell(
          Text(
            rowData.schoolEmail,
          ),
        ),
        DataCell(buildActionButtons(context, () {
          showDialog(
              context: context,
              builder: (context) {
                return UpdateSchool(schoolModel: rowData);
              });
        }, () {
          showDialog(
            context: context,
            builder: (context) {
              return CommonDelete(
                  title: '${rowData.schoolName}',
                  url: AppUrls.deleteSchool + rowData.id);
            },
          );
        })),
        // Add more DataCells for each column in your data
      ],
    );
  }

  String get schoolId => _schoolId;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalDocuments;

  @override
  int get selectedRowCount => 0;
}

class GuardiansDataSource extends DataTableSource {
  GuardiansDataSource({
    this.paginatorController,
    required this.totalDocuments,
    required this.currentPage,
    required this.data,
    required this.onTap,
  });
  final PaginatorController? paginatorController;
  final int totalDocuments;
  final int currentPage;
  List<GuardianModel> data;
  final ValueChanged<String> onTap;

// Replace with your actual data source

  @override
  DataRow? getRow(int index) {
    final int pageIndex = currentPage ~/ paginatorController!.rowsPerPage;
    final int dataIndex = index % paginatorController!.rowsPerPage;
    final int dataLength = data.length;

    if (pageIndex * paginatorController!.rowsPerPage + dataIndex >=
        dataLength) {
      return null;
    }
    int row = pageIndex * paginatorController!.rowsPerPage + dataIndex;
    final rowData = data[row];
    return DataRow.byIndex(
      onSelectChanged: (value) {
        if (value == null) {
          return;
        } else {
          onTap(rowData.id);
        }
      },
      index: index,
      cells: [
        DataCell(
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: FutureImage(
                future: fetchAndDisplayImage(rowData.guardianProfilePic),
              )),
        ),
        DataCell(
          Text(
            rowData.guardianFname + " " + rowData.guardianLname,
          ),
        ),
        DataCell(
          Text(
            rowData.guardianEmail,
          ),
        ),
        // Add more DataCells for each column in your data
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalDocuments;

  @override
  int get selectedRowCount => 0;
}

class StudentsDataSource extends DataTableSource {
  StudentsDataSource(
      {required this.data, required this.guardianId, required this.context});
  List<StudentModel> data;
  BuildContext context;
  final String guardianId;

// Replace with your actual data source

  @override
  DataRow? getRow(int index) {
    List<GlobalKey> keys = List.generate(
      data.length,
      (index) => GlobalKey(),
    );
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          FutureImage(
            future: fetchAndDisplayImage(rowData.studentProfilePic),
          ),
        ),
        DataCell(
          Text(
            rowData.studentFname + " " + rowData.studentLname,
          ),
        ),
        DataCell(
          Text(
            rowData.studentModelClass.className,
          ),
        ),
        DataCell(
          RepaintBoundary(
            key: keys[index],
            child: QrImageView(
              data: "$guardianId,${rowData.id}",
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
        ),
        DataCell(OutlinedButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(
                  text: "$guardianId,${rowData.id}",
                ),
              ).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Copied to Clipboard"),
                ));
              });
            },
            child: Icon(Icons.copy))),
        DataCell(
          IconButton(
            onPressed: () {
              saveQRCode(context, keys[index],
                  rowData.studentFname + "_" + rowData.studentLname);
            },
            icon: Icon(Icons.download),
          ),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
