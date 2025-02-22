import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app_prokit/main.dart';
import 'package:food_app_prokit/model/FoodModel.dart';
import 'package:food_app_prokit/utils/FoodColors.dart';
import 'package:food_app_prokit/utils/FoodDataGenerator.dart';
import 'package:food_app_prokit/utils/FoodImages.dart';
import 'package:food_app_prokit/utils/FoodString.dart';
import 'package:food_app_prokit/utils/FoodWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'FoodBookCart.dart';

class FoodDescription extends StatefulWidget {
  static String tag = '/FoodDescription';

  @override
  FoodDescriptionState createState() => FoodDescriptionState();
}

class FoodDescriptionState extends State<FoodDescription> {
  late List<FoodDish> mList1;
  late List<FoodDish> mList2;

  @override
  void initState() {
    super.initState();
    mList1 = addFoodDishData();
    mList2 = orderData();
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    double expandHeight = MediaQuery.of(context).size.height * 0.33;
    var width = MediaQuery.of(context).size.width;

    Widget mHeading(var value) {
      return Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            value.toString().toUpperCase(),
            style: primaryTextStyle(),
          ));
    }

    Widget mVegOption(var value, var iconColor) {
      return Row(
        children: <Widget>[
          Image.asset(food_c_type, color: iconColor, width: 18, height: 18),
          SizedBox(width: 8),
          Text(value, style: primaryTextStyle()),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: expandHeight,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                titleSpacing: 0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: innerBoxIsScrolled
                            ? appStore.isDarkModeOn
                                ? white
                                : blackColor
                            : white),
                    onPressed: () {
                      finish(context);
                    }),
                backgroundColor: innerBoxIsScrolled
                    ? appStore.isDarkModeOn
                        ? blackColor
                        : food_white
                    : blackColor,
                actionsIconTheme: IconThemeData(opacity: 0.0),
                title: Container(
                  height: 60,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[],
                        ),
                        IconButton(
                          icon: Icon(Icons.search,
                              color: innerBoxIsScrolled
                                  ? appStore.isDarkModeOn
                                      ? white
                                      : blackColor
                                  : white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    height: expandHeight,
                    child: CachedNetworkImage(
                      placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                      imageUrl: food_ic_popular3,
                      height: expandHeight,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(boxShadow: defaultBoxShadow(),color: const Color.fromARGB(92, 252, 186, 101),),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(food_lbl_burger, style: primaryTextStyle(size: 18,weight: FontWeight.bold)),
                          SizedBox(
                            height: 15,
                          ),
                          totalRatting(food_lbl_order_rating),
                          SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: gradientBoxDecoration(
                                    gradientColor1: food_colorPrimary,
                              gradientColor2: const Color.fromARGB(255, 126, 3, 50)),
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                margin: EdgeInsets.only(right: 10),
                                child: Text(food_lbl_offer, style: primaryTextStyle(size: 14, color: white)),
                              ),
                              Text(food_lbl_save_14_on_each_night,
                                  style: primaryTextStyle(color: appStore.isDarkModeOn? Colors.white : food_textColorSecondary,size: 15, ), )
                            ],
                          ),
                          SizedBox(height: 12),
                          Divider(height: 0.5, color: Color.fromARGB(255, 233, 140, 1),),
                          SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              Expanded(child: mVegOption(food_lbl_veg_only, food_view_color), flex: 1),
                              Expanded(child: mVegOption(food_lbl_non_veg_only, food_colorPrimary), flex: 2),
                            ],
                          )
                        ],
                      ),
                    ),
                     Padding(
                       padding: const EdgeInsets.only(left: 20,right: 20),
                       child: Divider(height: 0.5, color: Color.fromARGB(255, 233, 140, 1),),
                     ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        
                        margin: EdgeInsets.only(top: 0),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(boxShadow: defaultBoxShadow(),     color: const Color.fromARGB(92, 252, 186, 101),),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(food_ic_comass,
                                // ignore: deprecated_member_use
                                color: food_colorPrimary, width: width * 0.08, height: width * 0.08),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(food_lbl_delivery_by_yumfood_with_online_tracking, style: boldTextStyle(color: appStore.isDarkModeOn? Colors.white : Colors.black, size: 15,weight: FontWeight.bold)),
                                  Text(food_lbl_est_food_delivery_time, style: primaryTextStyle(color: appStore.isDarkModeOn? Colors.white : Colors.black,size: 15,weight: FontWeight.w400)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    Container(
                      decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: const Color.fromARGB(92, 252, 186, 101), ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          mHeading(food_lbl_what_people_love_here),
                          SizedBox(height: 16),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, crossAxisSpacing: 16, childAspectRatio: 0.72, mainAxisSpacing: 16),
                              itemCount: mList1.length,
                              padding: EdgeInsets.only(bottom: 16),
                              itemBuilder: (context, index) {
                                return ItemGrid(mList1[index], index);
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: boxDecorationDefault(
                        boxShadow: defaultBoxShadow(),
                        color: appStore.isDarkModeOn ? blackColor : food_white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          mHeading(food_lbl_what_people_love_here),
                          SizedBox(height: 16),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: mList2.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ItemList(mList2[index], index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  //height: width * 0.38,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialog(),
                          );
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.171),
                                blurRadius: 15,
                                spreadRadius: 0,
                                offset: Offset(
                                  0,
                                  5,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(50),
                            color: appStore.isDarkModeOn ? const Color.fromARGB(255, 255, 255, 255) : food_colorPrimary,
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(food_lbl_view_menu,
                                style: primaryTextStyle(
                                    color: appStore.isDarkModeOn ? food_colorPrimary : Colors.white,
                                    weight: FontWeight.bold,
                                    size: 15)),
                          )),
                        ),
                      ),
                      bottomBillDetail(
                        context,      food_colorPrimary,
                                  const Color.fromARGB(158, 228, 87, 90),
                           food_lbl_order_now,
                          onTap: () {
                        FoodBookCart().launch(context);
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  late FoodDish model;

  ItemList(FoodDish model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
              imageUrl: model.image,
              width: width * 0.2,
              height: width * 0.2,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Image.asset(food_c_type, color: food_colorAccent, width: 16, height: 16))),
                      TextSpan(
                          text: model.name,
                          style:
                              primaryTextStyle(size: 16, color: appStore.isDarkModeOn ? white : food_textColorPrimary)),
                    ],
                  ),
                ),
                Text(model.price, style: primaryTextStyle()),
              ],
            ),
          ),
          Quantitybtn()
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemGrid extends StatelessWidget {
  late FoodDish model;

  ItemGrid(FoodDish model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: boxDecorationDefault(
        color: appStore.isDarkModeOn ? blackColor : food_white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
              imageUrl: model.image,
              width: width,
              height: width * 0.3,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.name, style: primaryTextStyle(), maxLines: 1),
                Text(model.type, style: primaryTextStyle(color: food_textColorSecondary, size: 14)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(model.price, style: primaryTextStyle()),
                    Quantitybtn(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        color: appStore.isDarkModeOn ? Colors.black : Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          )
        ],
      ),
      padding: EdgeInsets.all(24),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Snakes", style: primaryTextStyle()),
                Text("10/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Pizza & Pasta", style: primaryTextStyle()),
                Text("40/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Burger/-", style: primaryTextStyle()),
                Text("20/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Fast Food", style: primaryTextStyle()),
                Text("12/-", style: primaryTextStyle()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Italian", style: primaryTextStyle()),
                Text("60/-", style: primaryTextStyle()),
              ],
            )
          ],
        ),
      ));
}
