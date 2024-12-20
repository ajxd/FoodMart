class CulinaryCreation {
  final String creationId;
  final String visualRepresentation;
  final String title;
  final int costEstimation;
  final double satisfactionIndex;
  final NutritionalProfile nutritionalDetails;
  final String estimatedPreparationTime;
  final String culinaryNarrative;
  final List<String> keyIngredients;
  final DietaryPreferences dietaryPreferences;
  final String nutritionalInfo;

  CulinaryCreation({
    required this.creationId,
    required this.visualRepresentation,
    required this.title,
    required this.costEstimation,
    required this.satisfactionIndex,
    required this.nutritionalDetails,
    required this.estimatedPreparationTime,
    required this.culinaryNarrative,
    required this.keyIngredients,
    required this.dietaryPreferences,
    required this.nutritionalInfo,
  });

  factory CulinaryCreation.fromJson(Map<String, dynamic> data) => CulinaryCreation(
    creationId: data["creationId"],
    visualRepresentation: data["visualRepresentation"],
    title: data["title"],
    costEstimation: data["costEstimation"],
    satisfactionIndex: data["satisfactionIndex"].toDouble(),
    nutritionalDetails: NutritionalProfile.fromJson(data["nutritionalDetails"]),
    estimatedPreparationTime: data["estimatedPreparationTime"],
    culinaryNarrative: data["culinaryNarrative"],
    keyIngredients: List<String>.from(data["keyIngredients"]),
    dietaryPreferences: DietaryPreferences.fromJson(data["dietaryPreferences"]),
    nutritionalInfo: data["nutritionalInfo"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "creationId": creationId,
    "visualRepresentation": visualRepresentation,
    "title": title,
    "costEstimation": costEstimation,
    "satisfactionIndex": satisfactionIndex,
    "nutritionalDetails": nutritionalDetails.toJson(),
    "estimatedPreparationTime": estimatedPreparationTime,
    "culinaryNarrative": culinaryNarrative,
    "keyIngredients": keyIngredients,
    "dietaryPreferences": dietaryPreferences.toJson(),
    "nutritionalInfo": nutritionalInfo,
  };

  bool isSuitableForDiet(DietType diet) {
    return dietaryPreferences.isSuitableFor(diet);
  }

  @override
  String toString() {
    return 'CulinaryCreation: $title - Satisfaction: ${satisfactionIndex.toStringAsFixed(1)}';
  }
}

class NutritionalProfile {
  final String calories;
  final String fats;
  final String carbs;
  final String proteins;

  NutritionalProfile({
    required this.calories,
    required this.fats,
    required this.carbs,
    required this.proteins,
  });

  factory NutritionalProfile.fromJson(Map<String, dynamic> data) => NutritionalProfile(
    calories: data["calories"],
    fats: data["fats"],
    carbs: data["carbs"],
    proteins: data["proteins"],
  );

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "fats": fats,
    "carbs": carbs,
    "proteins": proteins,
  };
}

class DietaryPreferences {
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;

  DietaryPreferences({
    required this.isVegetarian,
    required this.isVegan,
    required this.isGlutenFree,
  });

  factory DietaryPreferences.fromJson(Map<String, dynamic> data) => DietaryPreferences(
    isVegetarian: data["isVegetarian"],
    isVegan: data["isVegan"],
    isGlutenFree: data["isGlutenFree"],
  );

  Map<String, dynamic> toJson() => {
    "isVegetarian": isVegetarian,
    "isVegan": isVegan,
    "isGlutenFree": isGlutenFree,
  };

  bool isSuitableFor(DietType diet) {
    switch (diet) {
      case DietType.Vegetarian:
        return isVegetarian;
      case DietType.Vegan:
        return isVegan;
      case DietType.GlutenFree:
        return isGlutenFree;
      default:
        return false;
    }
  }
}

enum DietType { Vegetarian, Vegan, GlutenFree }
