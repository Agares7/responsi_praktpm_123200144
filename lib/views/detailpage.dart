import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class FoodDetailPage extends StatefulWidget {
  final String foodId;

  const FoodDetailPage({required this.foodId});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  Map<String, dynamic> food = {};

  @override
  void initState() {
    super.initState();
    fetchFoodDetail();
  }

  Future<void> fetchFoodDetail() async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.foodId}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        food = data['meals'][0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Detail'),
      ),
      body: food.isNotEmpty
          ? ListView(
              children: [
                Image.network(
                  food['strMealThumb'],
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food['strMeal'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Category : ${food['strCategory']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Area : ${food['strArea']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Instructions:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        food['strInstructions'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            launch(food['strYoutube']);
                          },
                          child: Text('Watch Video on Youtube'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
