import 'dart:io';

import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/core/helpers/snack_bar_service.dart';
import 'package:ecommerce/src/data/models/product_by_category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareProduct {
  static void onShare(Product product, BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    List<String> imagePaths = product.imagesUrl!;
    try {
      if (imagePaths.isNotEmpty) {
        final dir = await getApplicationDocumentsDirectory();
        final data = await http
            .get(Uri.parse('$BASE_API_URL_IMAGE/${imagePaths.first}'));
        await File('${dir.path}/image.png').writeAsBytes(data.bodyBytes);
        final imageToShare = XFile('${dir.path}/image.png');

        var xx = await Share.shareXFiles([imageToShare],
            text: '''Product Name: ${product.name}\n'''
                '''Protein Content: ${product.description}\n''',
            subject: "liyu",
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
        Logger().d(xx.status);
      } else {
        await Share.share(
            '''Product Name: ${product.name}\n'''
            '''Protein Content: ${product.description}\n''',
            subject: 'liyu,',
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      }
    } catch (e) {
      SnackBarService.showInfoSnackBar(
          content: 'We couldn\'t perform share,please try again');
      Logger().d(e.toString());
    }
  }
}
