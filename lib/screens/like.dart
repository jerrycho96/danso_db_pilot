import 'package:danso_db_pilot/controller/like_song_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LikeSongController likeSongController = Get.put(LikeSongController());
    var likeList = likeSongController.likeSongList;
    return Scaffold(
      appBar: AppBar(
        title: Text('관심곡'),
      ),
      body: Obx(() => ListView.builder(
            itemCount: likeList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${likeList[index].songTitle}'),
                    IconButton(
                        icon: Icon(Icons.star),
                        onPressed: () {
                          // var b = item.songLike == 'true';
                          likeSongController.updateLikeSongList(
                              songId: likeList[index].songId,
                              songLike: likeList[index].songLike);
                        }),
                  ],
                ),
              );
            },
          )),
    );
  }
}
