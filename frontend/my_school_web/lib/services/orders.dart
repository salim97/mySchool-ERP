import 'package:my_school_web/helpers/costants.dart';
import 'package:my_school_web/models/orders.dart';

class OrderServices {
  String collection = "orders";

  Future<List<OrderModel>> getAllOrders() async {
    // return firebaseFiretore.collection(collection).get().then((result) {
    //     List<OrderModel> orders = [];
    //     for (DocumentSnapshot order in result.docs) {
    //       orders.add(OrderModel.fromSnapshot(order));
    //     }
    //     return orders;
    //   });
  }
}
