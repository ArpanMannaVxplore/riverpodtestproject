import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view model/first_screen_view_model.dart';

class FirstScreen extends ConsumerWidget {
  const FirstScreen({Key? key}) : super(key: key);

  onAdd(WidgetRef ref) {
    ref.read(homePageControllerProvider).addEntry(DateTime.now().toString());
  }

  onRemove(WidgetRef ref, String entry) {
    ref.read(homePageControllerProvider).removeEntry(entry);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entries Management page 1'),
        actions: [
          IconButton(onPressed: (){
            onFirstScreenNavClicked();
          }, icon:const Icon( Icons.next_plan, color: Colors.black,),)
        ],
      ),
      body: ref.watch(entriesProvider).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, trace) => Center(child: Text(error.toString())),
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text(item),
              onTap: () => onRemove(ref, item),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onAdd(ref),
      ),
    );
  }
}