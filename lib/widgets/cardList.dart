import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/screens/detailsScreen.dart';

class cardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildGestureDetectorCard(context),
            buildGestureDetectorCard(context),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  GestureDetector buildGestureDetectorCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(Details.routeName);
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width / 2.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://m.media-amazon.com/images/M/MV5BMjMyNDkzMzI1OF5BMl5BanBnXkFtZTgwODcxODg5MjI@._V1_.jpg'))),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              height: 100,
              width: MediaQuery.of(context).size.width / 2.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Thor Ragnarok and the hulk",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: 172,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBarIndicator(
                              rating: 2,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.lightBlue,
                              ),
                              itemCount: 5,
                              itemSize: 16.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              "2.4k reviews",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(child: Text("this is it"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
