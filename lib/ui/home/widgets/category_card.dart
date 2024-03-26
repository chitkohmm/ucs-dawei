import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:libms_flutter/data/models/book_categories/book_categories.dart';
import 'package:libms_flutter/domain/constants.dart';
import 'package:libms_flutter/ui/books_by_category/books_by_category.dart';

class BookCategoryCard extends StatelessWidget {
  const BookCategoryCard({super.key, required this.bookCategoryData});

  final BookCategoryData bookCategoryData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BooksByCategory(
                categoryName: '${bookCategoryData.category}',
                id: bookCategoryData.id!.toInt(),
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: kDeviceHeight(context) / 5,
              width: kDeviceWidth(context) / 3.5,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: bookCategoryData.image != null
                      ? "${bookCategoryData.image!.originalUrl}"
                      : "",
                  fit: BoxFit.fitHeight,
                  errorWidget: (context, _, dynamic) {
                    return Container(
                      color: Colors.grey.shade400,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${bookCategoryData.category}',
              style: const TextStyle(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
