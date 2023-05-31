import '../service/base_network.dart';

//Dengan memanggil method loadBooks(),  mengembalikan nilai dari class
//BaseNetwork dengan method get() diisi dengan parameter “text” dikarenakan ingin
//mengambil list dari buku-buku.

class MealSource {
  static MealSource instance = MealSource();
  Future<Map<String, dynamic>> loadMeal(String text) {
    return BaseNetwork.get(text);
  }
}
