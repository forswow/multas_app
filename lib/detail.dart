import 'package:flutter/material.dart';
import 'package:multas_app/core/styles/textstyle.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Detail(this.fio, this.place, this.date, this.img, this.descr, {super.key});
  String fio;
  String place;
  String date;
  String img;
  String descr;

  @override
  State<Detail> createState() => _DetailState(fio, place, date, img, descr);
}

class _DetailState extends State<Detail> {
  _DetailState(this.fio, this.place, this.date, this.img, this.descr);
  String fio;
  String place;
  String date;
  String img;
  String descr;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromRGBO(114, 124, 245, 1),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: MediaQuery.of(context).size.height / 1.2,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  fio,
                  style: ThemeText.sliverTextHeader,
                ),
                centerTitle: true,
                background: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          color: Colors.white,
                        ),
                        Text(
                          place,
                          style: ThemeText.sliverText,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        Text(
                          date,
                          style: ThemeText.sliverText,
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      descr,
                      style: ThemeText.sliverText,
                    ),
                  ],
                ),
              ),
            ]),),
          ],
        ),
      );
}
