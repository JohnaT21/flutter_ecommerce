import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceCard extends StatelessWidget {
const PriceCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 10.h),
    
     child:SizedBox(
      width: 80.w,
    child: const Card(
      elevation: 2,
      child: Center(child:Text("2000 ETB",maxLines: 1,overflow: TextOverflow.ellipsis,)),
    
    )));
  }
}