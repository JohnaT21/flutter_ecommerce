// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:ecommerce/src/config/local_storage.dart';

const BASE_API_URL = "https://api.liyumarket.com/api";
const BASE_SOCKET_API_URL = "https://api.liyumarket.com/api";
const BASE_API_URL_IMAGE = "https://api.liyumarket.com/";
String TOKEN = Storage.getValue("TOKEN") ?? '';
String USERID = Storage.getValue("USERID") ?? '';
