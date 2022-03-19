import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget loadMoreButton({Function onTap}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
    child: GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 10.h,
              width: double.infinity,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://media.istockphoto.com/vectors/abstract-colorful-hand-sketched-swirls-seamless-background-pattern-vector-id500677364?k=20&m=500677364&s=612x612&w=0&h=ig3JLm0YdXK5ab2At2MtDX_cLSYQIKXWRPM0clstFTA='),
              ),
            ),
            Container(
              color: Colors.black54,
              height: 10.h,
            ),
            Container(
              child: Text(
                'LOAD MORE...',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
