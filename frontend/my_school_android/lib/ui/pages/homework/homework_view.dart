// import 'package:common/common.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
// import 'package:stacked/stacked.dart';

// import 'homework_row.dart';
// import 'homework_view_model.dart';

// class HomeWorkView extends StatefulWidget {
//   @override
//   _HomeWorkViewState createState() => _HomeWorkViewState();
// }

// class _HomeWorkViewState extends State<HomeWorkView> {
//     List<HomeworkModel> listHomeWorks = [
//       HomeworkModel(
//         subjectName: "General Maths",
//         status: "I",
//         evaluationDate: "17 Aug 2019",
//         homeworkDate: "17 Aug 2019",
//         submissionDate: "17 Aug 2019",
//         createdBy: "Prof 007",
//         evaluatedBy: "Prof 007",
//       ),
//       HomeworkModel(
//         subjectName: "Science",
//         status: "C",
//         evaluationDate: "17 Aug 2019",
//         homeworkDate: "17 Aug 2019",
//         submissionDate: "17 Aug 2019",
//         createdBy: "Prof 007",
//         evaluatedBy: "Prof 007",
//       ),
//       HomeworkModel(
//         subjectName: "Biology",
//         status: "C",
//         evaluationDate: "17 Aug 2019",
//         homeworkDate: "17 Aug 2019",
//         submissionDate: "17 Aug 2019",
//         createdBy: "Prof 007",
//         evaluatedBy: "Prof 007",
//       ),
//       HomeworkModel(
//         subjectName: "English",
//         status: "I",
//         evaluationDate: "17 Aug 2019",
//         homeworkDate: "17 Aug 2019",
//         submissionDate: "17 Aug 2019",
//         createdBy: "Prof 007",
//         evaluatedBy: "Prof 007",
//       ),
//     ];



//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<HomeWorkViewModel>.reactive(
//       viewModelBuilder: () => HomeWorkViewModel(),
//       builder: (
//         BuildContext context,
//         HomeWorkViewModel model,
//         Widget child,
//       ) {


//         return Scaffold(
//           appBar: AppBarWidget.header(context, 'Homework'),
//           backgroundColor: Colors.white,
//           body: ListView.builder(
//             itemCount: listHomeWorks.length,
//             itemBuilder: (context, index) {
//               return StudentHomeworkRow(listHomeWorks[index]);
//             },
//           ),
//         );
//       },
//     );
//   }
// }



