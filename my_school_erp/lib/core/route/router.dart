

import 'package:auto_route/auto_route_annotations.dart';
import '../../ui/views/home/home_view.dart';
    
@MaterialAutoRouter(
routes: <AutoRoute>[ 
    //MaterialRoute(page: HomeView, ),
     // initial route is named "/"
     MaterialRoute(page: HomeView, initial: true)
   ],
)
class $MyRouter {}
        
    