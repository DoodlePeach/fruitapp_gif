import 'package:flutter/material.dart';
import 'package:fruitapp/Dialog/NameFruitDialog.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/widgets/appbar.dart';
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
                  padding: EdgeInsets.only(top: 10),
                  color: index % 2 == 0 ? Colors.pink : Colors.cyan,
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              Provider.of<DayModel>(context, listen: false)
                                  .apple
                                  .length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: ViewPageItemWidget(
                                  fruit: Provider.of<DayModel>(context,
                                          listen: false)
                                      .apple[index]),
                            );
                          }),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              Provider.of<DayModel>(context, listen: false)
                                  .pear
                                  .length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: ViewPageItemWidget(
                                  fruit: Provider.of<DayModel>(context,
                                          listen: false)
                                      .pear[index]),
                            );
                          }),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              Provider.of<DayModel>(context, listen: false)
                                  .watermelon
                                  .length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: ViewPageItemWidget(
                                  fruit: Provider.of<DayModel>(context,
                                          listen: false)
                                      .watermelon[index]),
                            );
                          }),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              Provider.of<DayModel>(context, listen: false)
                                  .banana
                                  .length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                              child: ViewPageItemWidget(
                                  fruit: Provider.of<DayModel>(context,
                                          listen: false)
                                      .banana[index]),
                            );
                          })
                    ],
                  ),
                );
              },
              onPageChanged:
                  Provider.of<DayModel>(context, listen: false).pageChanged,
              controller: PageController(initialPage: data.currentIndex));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          // TODO: Implement FAB.
          showDialog(
              context: context,
              builder: (context) {
                return NameFruitDialog(
                    Provider.of<DayModel>(context).currentDate.toString());
              });
        },
      ),
    );
  }
}
