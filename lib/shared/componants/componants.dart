import 'package:conditional_builder/conditional_builder.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
import 'package:news_app/shared/componants/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:skeleton_text/skeleton_text.dart';
// Article item

Widget buildArticleItem(article, context) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);

  String convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    String now = formatDate(todayDate, [
      yyyy,
      '-',
      mm,
      '-',
      dd,
    ]);
    if (formattedDate != now) {
      return formatDate(todayDate, [
        yyyy,
        '/',
        mm,
        '/',
        dd,
      ]);
    } else {
      return formatDate(todayDate, ['Today ', hh, ':', nn, ' ', am]);
    }
  }

  final publishedDate = convertDateFromString(article['publishedAt']);
  return InkWell(
    onTap: () {
      navigateTo(context, WebViewScreen(article['url'], article['title']));
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${article['source']['name']}',
            style: TextStyle(
              color: primaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Text(
            "${article['title']}",
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Text(
            '$publishedDate',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

// Divider component
Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      fallback: (context) => isSearch ? Container() : skeletonLoading(context),
      builder: (context) => RefreshIndicator(
        onRefresh: () async {
          AppCubit.get(context).getMoreData();
        },
        child: ListView.builder(
          controller: AppCubit.get(context).scrollController,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          itemCount: 20,
        ),
      ),
    );

// default text form field
Widget defaultFormField({
  String labelText,
  @required TextEditingController controller,
  @required Function validation,
  TextInputType type,
  IconData prefix,
  IconData suffix,
  String hintText,
  Function onSubmit,
  Function onTape,
  bool secure = false,
  Function onPressed,
  bool isClickable = true,
  Function onChanged,
  TextInputAction actionBtn,
}) =>
    TextFormField(
      validator: validation,
      cursorColor: primaryColor,
      controller: controller,
      style: TextStyle(
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        labelText: labelText,
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(suffix),
        ),
        border: OutlineInputBorder(),
      ),
      keyboardType: type,
      textInputAction: actionBtn,
      onTap: onTape,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      obscureText: secure,
      onChanged: onChanged,
      autofocus: true,
    );

// Navigation method

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// Skeleton Loading effect
Widget skeletonContainer(double width, double height, double radius) =>
    SkeletonAnimation(
      curve: Curves.easeInQuad,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );

Widget skeletonLoading(context) => ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            skeletonContainer(
              double.infinity,
              200,
              10,
            ),
            SizedBox(
              height: 15,
            ),
            skeletonContainer(
              100,
              15,
              20,
            ),
            SizedBox(
              height: 8,
            ),
            skeletonContainer(
              double.infinity,
              15,
              20,
            ),
            SizedBox(
              height: 8,
            ),
            skeletonContainer(
              150,
              15,
              20,
            ),
          ],
        ),
      ),
      itemCount: 3,
    );
// Navigate to Screen and replacement function
void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) => widget
  ),
      (Route<dynamic> route) => false,
);

// Default app button
Widget defaultButton({
  double width = double.infinity,
  double height = 50,
  Color background = Colors.transparent,
  Color border = Colors.transparent,
  @required void Function() onPressed,
  @required String text,
  bool isUpperCase = true,
  Color textColor = Colors.black,
  double fontSize = 15,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            width: 1.5,
            color: border,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          isUpperCase ?
          '$text'.toUpperCase() :
          '$text',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );

// Social app button
Widget socialButton({
  @required String assetName,
  double width = double.infinity,
  double height = 50,
  Color background = Colors.transparent,
  Color border = Colors.transparent,
  @required void Function() onPressed,
  @required String text,
  bool isUpperCase = true,
  Color textColor = Colors.black,
  double fontSize = 15,
  bool isCenter = true,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            width: 1.5,
            color: border,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(assetName,),
            Text(
              isUpperCase ?
              '$text'.toUpperCase() :
              '$text',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            if(isCenter)
              Opacity(
                opacity: 0,
                child: Image.asset(assetName),
              ),
          ],
        ),
      ),
    );


// default text form field

// Default text button
Widget defaultTextButton({
  @required String text,
  @required void Function() onPressed,
  double fontSize,
  FontWeight fontWeight,
  Color textColor,
}) => TextButton(
  onPressed: onPressed,
  child: Text(
    '$text',
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  ),
);

