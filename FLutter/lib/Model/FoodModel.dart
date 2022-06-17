

class FoodModel {
  String name, picture, heading, restauranName, cusine,numberOfPlacedOrder,time, foodId;
  int price;
  double rating;
  String? subheading;
  bool isLiked;
  bool fromServer;
  FoodModel({
    this.fromServer=false,
    required this.name,
    required this.picture,
    required this.heading,
    required this.restauranName,
    required this.cusine,
    required this.rating,
    required this.price,
    required this.numberOfPlacedOrder,
    required this.time,
    required this.foodId,
    this.subheading,
     this.isLiked = false,
});
}

class FoodDummyData {
  static List<FoodModel> dummyFoodData=[
    FoodModel(foodId: "1B", name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1bB",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1fB",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1cB",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1sB",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1rB",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1zB",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1wB",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1Bq",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1Bp",name: "Burger", picture: "Photo/background.jpg", heading: "Droolicious Burger In your Area", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
  ];
  static List<FoodModel> spotlightFoodData=[
    FoodModel(foodId: "1", name: "Sugar and Spice", picture: "SpotlightPhotos/Pasta.png", heading: "IN THE SPOTLIGHT", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1", name: "Sugar and Spice", picture: "SpotlightPhotos/hotdog.png", heading: "IN THE SPOTLIGHT", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1", name: "Sugar and Spice", picture: "SpotlightPhotos/Pizza.png", heading: "IN THE SPOTLIGHT", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
  ];
  static List<FoodModel> cafeFoodData=[
    FoodModel(foodId: "1", name: "Sugar and Spice", picture: "Cafephotos/bluberry.JPG", heading: "IN THE SPOTLIGHT", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1", name: "Sugar and Spice", picture: "Cafephotos/Waffles.JPG", heading: "IN THE SPOTLIGHT", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1", name: "Sugar and Spice", picture: "Cafephotos/pastties.JPG", heading: "IN THE SPOTLIGHT", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
    FoodModel(foodId: "1", name: "Sugar and Spice", picture: "Cafephotos/crossstra.JPG", heading: "IN THE SPOTLIGHT", restauranName: "Sugar And Spice", cusine: "Out of the world", rating: 4.5, price: 545, numberOfPlacedOrder: "400+ orders placed from here", time: "10am to 9pm"),
  ];
}

