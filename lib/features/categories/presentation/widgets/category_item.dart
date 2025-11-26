/*import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              height: 410,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(width: 1.4),
            ),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
*/// lib/features/categories/presentation/widgets/category_item.dart

import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: AspectRatio( // 💡 إضافة AspectRatio للتحكم في نسبة العرض إلى الارتفاع
        aspectRatio: 1.0, // 💡 يمكنك تعديل هذه القيمة حسب ما يناسبك، مثلاً 1.5 أو 1.2
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                // 💡 إزالة height: 410 والسماح لها بملء الـ AspectRatio
                fit: BoxFit.cover,
                width: double.infinity, // لضمان ملء العرض المتاح
                height: double.infinity, // لضمان ملء الارتفاع المتاح
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(13),
                // 💡 إزالة Border.all إذا لم ترغب في الحد الأسود الذي يظهر مكرراً
                // border: Border.all(width: 1.4),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center, // 💡 لضمان أن النص يكون في المنتصف تماماً
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall // 💡 ربما يكون headlineSmall أفضل للمساحات الصغيرة
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}