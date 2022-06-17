import 'package:flutter/material.dart';
class Ingredient {
  String image, name;
  Ingredient({
    required this.image,
    required this.name,
});
}
class IngredientsContainer extends StatelessWidget {
  final List<Ingredient> ingredientList=[
    Ingredient(
      name: "Bun",image: "bun"
    ),
    Ingredient(
        name: "Cheese",image: "cheese"
    ),
    Ingredient(
        name: "Egg",image: "egg"
    ),
    Ingredient(
        name: "Kale",image: "kale"
    ),
    Ingredient(
        name: "Onion",image: "onion"
    ),
    Ingredient(
        name: "Patties",image: "patties"
    ),
  ];
  IngredientsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Ingredients",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for(Ingredient value in ingredientList)
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                                "Photo/"+value.image+".png",
                            ),
                          ),
                        ),
                        Text(value.name),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}