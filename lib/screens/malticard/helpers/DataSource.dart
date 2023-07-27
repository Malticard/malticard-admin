import 'package:malticard/widgets/FutureImage.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../models/StudentModel.dart';
import '/exports/exports.dart';

class SchoolDataSource extends DataTableSource {
  SchoolDataSource(
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
  StudentsDataSource({required this.data, required this.guardianId,required this.context});
  List<StudentModel> data;
  BuildContext context;
  final String guardianId;
  
// Replace with your actual data source

  @override
  DataRow? getRow(int index) {
     List<GlobalKey> keys = List.generate(data.length, (index) => GlobalKey());
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          FutureBuilder<Uint8List?>(
              future: fetchAndDisplayImage(rowData.studentProfilePic),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            Image.memory(snapshot.data!, width: 50, height: 50),
                      )
                    : CircularProgressIndicator.adaptive();
              }),
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
        DataCell(
          OutlinedButton.icon(
            onPressed: () {
              print("download");
              saveQRCode(context,
                  keys[index], rowData.studentFname + "_" + rowData.studentLname);
            },
            icon: Icon(
                Icons.download),
            label: Text("Download"),
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
