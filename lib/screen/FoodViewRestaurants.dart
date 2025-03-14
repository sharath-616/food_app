import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app_prokit/model/FoodModel.dart';
import 'package:food_app_prokit/utils/FlutterSlider.dart';
import 'package:food_app_prokit/utils/FoodColors.dart';
import 'package:food_app_prokit/utils/FoodDataGenerator.dart';
import 'package:food_app_prokit/utils/FoodString.dart';
import 'package:food_app_prokit/utils/FoodWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import 'FoodBookDetail.dart';
import 'FoodRestaurantsDescription.dart';

class FoodViewRestaurants extends StatefulWidget {
  static String tag = '/FoodViewRestaurants';

  @override
  FoodViewRestaurantsState createState() => FoodViewRestaurantsState();
}

class FoodViewRestaurantsState extends State<FoodViewRestaurants> {
  List<DataFilter> list = getAllData();
  List<DataFilter> list1 = getFilterData();

  List<ViewRestaurants> mList = [];
  List<images> mList1 = [];
  List<Filter> mList2 = [];
  List<String> mPeopleList = [];
  List<String> mCuisine = [];
  List<String> mFilterList = [];
  var mTime = 0;

  @override
  // ignore: must_call_super
  void initState() {
    mList = addViewRestaurantsData();
    mList1 = addViewImagesData();
    mPeopleList = ["1", "2", "3", "4", "5"];
    mFilterList = [
      "Pure Veg Places",
      "Express Delivery",
      "Great Offer",
    ];
    mCuisine = [
      "South Indian",
      "American",
      "BBQ",
      "Bakery",
      "Biryani",
      "Burger",
      "Cafe",
      "Charcoal Chicken",
      "Chiness",
      "Fast Food",
      "Juice",
      "Gujarati",
      "Salad",
    ];
  }

  final List<String> content = [
    'Apple',
    'Banana',
    'Orange',
    'Pomme',
    'Carambola',
    'Cherries',
    'Date Fruit',
    'A Fruit with a really long name',
    'Durian',
    'Grapefruit'
  ];

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(food_app_background);

    mFilter() {
      return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: IntrinsicHeight(
                child: Container(
                
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24), bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 24),
                        Text(food_lbl_by_price, style: primaryTextStyle()),
                        FlutterSlider(
                          values: [30, 420],
                          rangeSlider: true,
                          max: 500,
                          min: 0,
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            lowerValue = lowerValue;
                            upperValue = upperValue;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 16),
                        Text(food_lbl_cuisine, style: primaryTextStyle(color: Colors.black,weight: FontWeight.bold)),
                        SizedBox(height: 16),
                        Wrap(
                          children: list
                              .asMap()
                              .map(
                                (i, e) => MapEntry(
                                  i,
                                  Tooltip(
                                    textStyle: TextStyle(fontSize: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: food_colorPrimary,
                                        boxShadow: defaultBoxShadow()),
                                    padding: EdgeInsets.all(8),
                                    message: e.name!,
                                    child: InkWell(
                                      onTap: () {
                                        e.isCheck = !e.isCheck;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: e.isCheck ? food_colorPrimary : food_view_color),
                                        margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(8),
                                        child: Text(e.name!,
                                            style: secondaryTextStyle(color: e.isCheck ? white : black),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        ),
                        SizedBox(height: 16),
                        Text(food_lbl_rating, style: primaryTextStyle()),
                        SizedBox(height: 16),
                        GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: mPeopleList.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  mTime = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: mTime == index ? food_colorPrimary : food_view_color),
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Text(
                                  mPeopleList[index],
                                  style: primaryTextStyle(color: mTime == index ? food_white : food_textColorPrimary),
                                ).center(),
                              ),
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 2.0),
                        ),
                        SizedBox(height: 16),
                        Text(food_lbl_more_filter, style: primaryTextStyle()),
                        SizedBox(height: 16),
                        Wrap(
                          children: list1
                              .asMap()
                              .map((i, e) => MapEntry(
                                    i,
                                    Tooltip(
                                      textStyle: TextStyle(fontSize: 16),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: food_colorPrimary,
                                          boxShadow: defaultBoxShadow()),
                                      padding: EdgeInsets.all(8),
                                      message: e.title!,
                                      child: InkWell(
                                        onTap: () {
                                          e.isCheck = !e.isCheck;
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: e.isCheck ? food_colorPrimary : food_view_color),
                                          margin: EdgeInsets.all(4),
                                          padding: EdgeInsets.all(8),
                                          child: Text(e.title!,
                                              style: secondaryTextStyle(color: e.isCheck ? white : black),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                  ))
                              .values
                              .toList(),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  finish(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: food_textColorPrimary),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(food_lbl_cancel, style: primaryTextStyle()).center(),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  finish(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  decoration:
                                      BoxDecoration(   gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(158, 228, 87, 90),
                                  food_colorPrimary,
                                ], // Change colors as needed
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ), borderRadius: BorderRadius.circular(50)),
                                  child: Text(food_lbl_filter, style: primaryTextStyle(color: food_white)).center(),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: appBarWidget(
        '',
       
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: appStore.isDarkModeOn ? white : food_colorPrimary),
            onPressed: () {
              mFilter();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: defaultBoxShadow(),
                        color: appStore.isDarkModeOn ? scaffoldDarkColor : food_colorPrimaryDark,
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(food_lbl_lunch_in_delhi_ncr, style: boldTextStyle(size: 20,color: appStore.isDarkModeOn ?  Colors.white: food_colorPrimary,weight: FontWeight.bold ),),
                          SizedBox(height: 16),
                          mAddress(context),
                          SizedBox(height: 16),
                          search(context),
                        ],
                      ),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: mList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RestaurantsInfo(mList[index], mList1[index], index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RestaurantsInfo extends StatelessWidget {
  ViewRestaurants? model;
  images? model1;
  int? pos;

  RestaurantsInfo(this.model, this.model1, this.pos);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FoodRestaurantsDescription().launch(context);
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: food_colorPrimaryDark),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
              imageUrl: model1!.image,
              width: width,
              height: 250,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model!.name, style: primaryTextStyle(size: 18,color: food_colorPrimary,weight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(children: <Widget>[
                    mRating(model!.rating),
                    SizedBox(width: 4),
                    Text(model!.review, style: primaryTextStyle(color: food_black,size: 15,weight: FontWeight.w600)),
                  ]),
                  SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      Text(model!.rs, style: primaryTextStyle(color:food_black,size: 15,weight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: food_colorPrimary),
                          width: 8,
                          height: 8),
                      SizedBox(width: 4),
                      Text(model!.sector, style: primaryTextStyle(color: food_black,size: 15,weight: FontWeight.w600)),
                      SizedBox(width: 4),
                      Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: food_colorPrimary),
                          width: 8,
                          height: 8),
                      SizedBox(width: 4),
                      Text(model!.kms, style: primaryTextStyle(color: food_black,size: 15,weight: FontWeight.w600)),
                    ],
                  ),
                  Container(margin: EdgeInsets.only(top: 16), height: 0.5, color: food_colorPrimary, width: width),
                ],
              ),
            ),
            mViewAll(context, food_lbl_book_a_table, onTap: () {
              FoodBookDetail().launch(context);
            }),
          ],
        ),
      ),
    );
  }
}
