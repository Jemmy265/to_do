import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/Database/Model/Task.dart';
import 'package:to_do/Database/Model/user.dart';

class MyDatabase {

  static CollectionReference<User> getUserCollections(){
    return FirebaseFirestore
        .instance
        .collection(User.collectionName)
      .withConverter<User>(
      fromFirestore: (snapshot, options){
        return User.FromFireStore(snapshot.data());
      },
      toFirestore: (user, options){
        return user.toFireStore();
      }
  );
}

  static CollectionReference<Task> getTasksCollections(String uid){
    return getUserCollections()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: (snapshot, options){
          return Task.FromFireStore(snapshot.data());
        },
        toFirestore: (task, options){
          return task.toFireStore();
        }
    );
  }

  static Future<void >addUser(User user){
    var collection = getUserCollections();
    return collection.doc(user.id).set(user);
  }

  static Future<User?> readUser(String id) async {
    var collection = getUserCollections();
    var docSnapShot = await collection.doc(id).get();
    return docSnapShot.data();
}
}