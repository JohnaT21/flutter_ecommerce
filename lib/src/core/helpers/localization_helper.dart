import 'package:ecommerce/src/config/local_storage.dart';
import 'package:ecommerce/src/data/data_sources/localization_service.dart';
import 'package:flutter/material.dart';

String getTranslation(BuildContext context,String key){
  return Localization.of(context).getTranslation(key);
}