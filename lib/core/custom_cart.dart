import 'package:flutter/material.dart';

import '../sqflite/cubit/cubit.dart';

class CustomCart extends StatelessWidget {
  const CustomCart({
    super.key,
    required this.model,
  });
  final Map model;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        ToDoCubit.get(context).deleteData(
          id: model['id'],
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    ToDoCubit.get(context)
                        .updateData(status: 'archived', id: model['id']);
                  },
                  icon: const Icon(
                    Icons.archive_outlined,
                    color: Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ToDoCubit.get(context).updateData(
                      status: 'done',
                      id: model['id'],
                    );
                  },
                  icon: const Icon(
                    Icons.check_box,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
