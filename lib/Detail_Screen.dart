import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:wallpaper_app/const/app_color.dart';

class Details extends StatelessWidget {
  String imgUrl;
  Details(this.imgUrl);

  setWallpaperHomeScreen(url) async {
    try {
      int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      Fluttertoast.showToast(msg: 'Set Successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }

  setWallpaperLockScreen(url) async {
    try {
      int location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      Fluttertoast.showToast(msg: 'Set Successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }

  downloadWallpaper(url) async {
    try {
      var imageId =
          await ImageDownloader.downloadImage(url).catchError((error) {
        if (error is PlatformException) {
          var path = "";
          if (error.code == "404") {
            Fluttertoast.showToast(msg: 'Not Found Error');
          } else if (error.code == "unsupported_file") {
            Fluttertoast.showToast(msg: 'Unsupported File Error');
            path = error.details["unsupported_file_path"];
          }
        }
      });
      if (imageId == null) {
        return;
      } else {
        var path = await ImageDownloader.findPath(imageId);
        Fluttertoast.showToast(msg: 'image saved to: $path');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }

  shareImage(url) async {
    Share.share(url);
  }

  @override
  Widget build(BuildContext context) {
    print(imgUrl);
    return Scaffold(
      floatingActionButton: SpeedDial(
        labelsBackgroundColor: AppColor.vividYellow,
        labelsStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        speedDialChildren: [
          SpeedDialChild(
              child: const Icon(
                Icons.wallpaper,
                size: 18,
              ),
              label: 'Set Homescreen',
              onPressed: () => setWallpaperHomeScreen(imgUrl)),
          SpeedDialChild(
              child: const Icon(
                Icons.wallpaper,
                size: 18,
              ),
              label: 'Set Lockscreen',
              onPressed: () => setWallpaperHomeScreen(imgUrl)),
          SpeedDialChild(
              child: const Icon(
                Icons.wallpaper,
                size: 18,
              ),
              label: 'Download',
              onPressed: () => downloadWallpaper(imgUrl)),
          SpeedDialChild(
              child: const Icon(
                Icons.share,
                size: 18,
              ),
              label: 'Share',
              onPressed: () => shareImage(imgUrl)),
        ],
        child: const Icon(Icons.add_circle_outline_outlined),
      ),
      body: Hero(
        tag: imgUrl,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
