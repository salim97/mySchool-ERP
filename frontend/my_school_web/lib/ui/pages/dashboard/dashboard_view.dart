import 'package:my_school_web/ui/widgets/cards/cards_list.dart';
import 'package:my_school_web/ui/widgets/custom_text.dart';
import 'package:my_school_web/ui/widgets/page_header.dart';
import 'package:my_school_web/ui/widgets/charts/sales_chart.dart';
import 'package:my_school_web/ui/widgets/top_buyer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        onModelReady: (model) {
          // Do something once your model is initialized
        },
        builder: (context, model, child) {
          return ListView(
            children: [
              PageHeader(
                text: "TABLEAU DE BORD",
              ),
              CardsList(),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 800,
                      width: MediaQuery.of(context).size.width / 1.9,
                      child: SalesChart(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 800,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.grey[300], offset: Offset(0, 3), blurRadius: 16)]),
                      child: Column(
                        
                        children: [
                          CustomText(
                            text: 'EXAMS',
                            size: 30,
                          ),
                          // TopBuyerWidget(),
                          // TopBuyerWidget(),
                          // TopBuyerWidget(),
                          // TopBuyerWidget(),
                          // TopBuyerWidget(),
                          // TopBuyerWidget(),
                          // TopBuyerWidget(),
                          // TopBuyerWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
