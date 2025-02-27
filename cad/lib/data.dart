import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'target.dart';
import 'recipe.dart';
import 'notifications.dart';

saveTargets(List<Target> targets) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("targets", jsonEncode(targets));
}

Future<List<Target>> loadTargets() async {
  final prefs = await SharedPreferences.getInstance();
  const key = "targets";
  final value = prefs.getString(key);
  if (value == null) {
    return [];
  }
  final List<dynamic> decoded = jsonDecode(value);
  return decoded.map((e) => Target.fromJson(e)).toList();
}

updateTarget(Target target) async {
  final prefs = await SharedPreferences.getInstance();
  final targets = await loadTargets();
  final index = targets.indexWhere((e) => e.title == target.title);
  if (index == -1) {
    return;
  }

  targets[index] = target;
  prefs.setString("targets", jsonEncode(targets));
}

saveRecipes(List<Recipe> recipes) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("recipes", jsonEncode(recipes));
}

Future<List<Recipe>> loadRecipes() async {
  final prefs = await SharedPreferences.getInstance();
  const key = "recipes";
  final value = prefs.getString(key);
  if (value == null) {
    return [];
  }
  final List<dynamic> decoded = jsonDecode(value);
  return decoded.map((e) => Recipe.fromJson(e)).toList();
}

updateRecipe(Recipe recipe) async {
  final prefs = await SharedPreferences.getInstance();
  final recipes = await loadRecipes();
  final index = recipes.indexWhere((e) => e.title == recipe.title);
  if (index == -1) {
    return;
  }

  recipes[index] = recipe;
  prefs.setString("recipes", jsonEncode(recipes));
}

saveNotifications(List<AppNotification> notifications) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("notifications", jsonEncode(notifications));
}

Future<List<AppNotification>> loadNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  const key = "notifications";
  final value = prefs.getString(key);
  if (value == null) {
    return [];
  }
  final List<dynamic> decoded = jsonDecode(value);
  return decoded.map((e) => AppNotification.fromJson(e)).toList();
}
