import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../controller/controller.dart';
import '../models/meals.dart';
import 'detailpage.dart';

class MealsView extends StatefulWidget {
  final String text;

  const MealsView({Key? key, required this.text}) : super(key: key);

  @override
  _MealsViewState createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  // late String strMealThumb;
  // late String strMeal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals"),
      ),
      body: Container(
        // FutureBuilder() membentuk hasil Future dari request API
        child: FutureBuilder(
          future: MealSource.instance.loadMeal(widget.text),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError || widget.text.isEmpty) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Makanan maem = Makanan.fromJson(snapshot.data);
              return _buildSuccessSection(maem);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  // Jika API sedang dipanggil
  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSection() {
    if (widget.text.isEmpty) {
      return const Text("");
    } else {
      return const Text("Error");
    }
  }

  // Jika data ada
  Widget _buildSuccessSection(Makanan data) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemCount: data.meals?.length,
      itemBuilder: (BuildContext context, int index) {
        final maem = data.meals![index];
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(foodId: maem.idMeal!),
                ),
              );
            },
            child: Container(
                height: 100,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(maem.strMealThumb as String),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(maem.strMeal as String)),
                      ),
                    ],
                  ),
                )));
      },
    );
  }
}
