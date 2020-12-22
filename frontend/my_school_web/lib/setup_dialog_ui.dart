import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';


enum DialogType {
  Basic,
  Form,
}


void setupDialogUi() {
  var dialogService = locator<DialogService>();

  var builders = {
    DialogType.Basic: (context, dialogRequest, completer) => Dialog(
          child: _BasicCustomDialog(
            dialogRequest: dialogRequest,
            onDialogTap: completer,
          ),
        ),
    // DialogType.Form: (context, dialogRequest, completer) => Dialog(
    //       child: _FormCustomDialog(
    //         dialogRequest: dialogRequest,
    //         onDialogTap: completer,
    //       ),
    //     )
  };

  dialogService.registerCustomDialogBuilders(builders);

  // dialogService.registerCustomDialogUi((context, dialogRequest, Completer()) => Dialog(
  //       backgroundColor: Colors.transparent,
  //       child: Container(
  //         padding: const EdgeInsets.all(2),
  //         height: MediaQuery.of(context).size.height * 0.8,
  //         // width: MediaQuery.of(context).size.width,
  //         decoration: BoxDecoration(color: Colors.white.withOpacity(0.90), borderRadius: BorderRadius.all(Radius.circular(36)), boxShadow: [
  //           BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 36),
  //         ]),
  //         child: dialogRequest.customData as Widget,
  //       ),
  //     ));
}


Widget _customDialogUi(
  DialogRequest dialogRequest,
  Function(DialogResponse) onDialogTap,
) {
  var dialogType = dialogRequest.customData as DialogType;
  switch (dialogType) {
    // case DialogType.Form:
    //   return _FormCustomDialog(
    //     dialogRequest: dialogRequest,
    //     onDialogTap: onDialogTap,
    //   );
    case DialogType.Basic:
    default:
      return _BasicCustomDialog(
        dialogRequest: dialogRequest,
        onDialogTap: onDialogTap,
      );
  }
}

class _BasicCustomDialog extends StatelessWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;
  const _BasicCustomDialog({Key key, this.dialogRequest, this.onDialogTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            dialogRequest.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            dialogRequest.description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => onDialogTap(DialogResponse(confirmed: true)),
            child: Container(
              child: dialogRequest.showIconInMainButton
                  ? Icon(Icons.check_circle)
                  : Text(dialogRequest.mainButtonTitle),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class _FormCustomDialog extends HookWidget {
//   final DialogRequest dialogRequest;
//   final Function(DialogResponse) onDialogTap;
//   const _FormCustomDialog({Key key, this.dialogRequest, this.onDialogTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var controller = useTextEditingController();
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Text(
//             dialogRequest.title,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           TextField(
//             controller: controller,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           GestureDetector(
//             onTap: () =>
//                 onDialogTap(DialogResponse(responseData: [controller.text])),
//             child: Container(
//               child: dialogRequest.showIconInMainButton
//                   ? Icon(Icons.check_circle)
//                   : Text(dialogRequest.mainButtonTitle),
//               alignment: Alignment.center,
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.redAccent,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
