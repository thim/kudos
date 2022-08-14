import 'package:flutter/material.dart';

import 'create/create_page.dart';
import 'gallery/gallery_page.dart';

Map<String, WidgetBuilder> routes() => {
      '/': (context) => const CreatePage(),
      '/cards': (context) => const GalleryPage(),
    };
