import 'package:flutter/material.dart';
import 'package:fruitapp/Dialog/NameFruitDialog.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/models/fruit_model.dart';
import 'package:fruitapp/widgets/appbar.dart';
import 'package:fruitapp/widgets/mlkg.dart';
import 'package:fruitapp/widgets/view_page_item.dart';
import 'package:provider/provider.dart';

class DayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: Consumer<DayModel>(
        builder: (_, data, __) {
          return PageView.builder(
              itemBuilder: (context, index) {
                return Container(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      // color: index % 2 == 0 ? Colors.pink : Colors.cyan,
                      child: Consumer<FruitModel>(
                        builder: (context, fruitData, child) {
                          if (data.currentIndex != index)
                            return Center(
                              child: CircularProgressIndicator(),
                            );

                          return Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: fruitData.apple.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                                      child: ViewPageItemWidget(
                                          fruit: fruitData.apple[index]),
                                    );
                                  }),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: fruitData.pear.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                                      child: ViewPageItemWidget(
                                          fruit: fruitData.pear[index]),
                                    );
                                  }),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: fruitData.watermelon.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                                      child: ViewPageItemWidget(
                                          fruit: fruitData.watermelon[index]),
                                    );
                                  }),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: fruitData.banana.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                                      child: ViewPageItemWidget(
                                          fruit: fruitData.banana[index]),
                                    );
                                  })
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              onPageChanged: (int index) {
                Provider.of<DayModel>(context, listen: false)
                    .pageChanged(index);
                Provider.of<FruitModel>(context, listen: false).refresh(
                    Provider.of<DayModel>(context, listen: false).currentDate);
              },
              controller: PageController(
                  initialPage: data.currentIndex, viewportFraction: 1));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                DateTime currentDate =
                    Provider.of<DayModel>(context).currentDate;

                return NameFruitDialog(
                    "${currentDate.day}/${currentDate.month}/${currentDate.year}");
              });
        },
      ),
    );
  }
}
