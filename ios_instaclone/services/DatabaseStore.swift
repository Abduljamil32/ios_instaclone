

import Foundation
import FirebaseFirestore

class DatabaseStore: ObservableObject{
    var USER_PATH = "users"
    var POST_PATH = "posts"
    
    let store = Firestore.firestore()
    
    func storeUser(user: User){
        let params = ["uid": user.uid, "email": user.email, "displayname": user.displayName, "password": user.password]
        
        store.collection(USER_PATH).document(user.uid!).setData(params)
    }
    
    func loadUser(uid: String, completion: @escaping (User?) -> ()) {
        print(uid)
        store.collection(USER_PATH).document(uid).getDocument(completion: {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                // Do something with doc data
                    
                let uid = docData!["uid"] as? String ?? ""
                let email = docData!["email"] as? String ?? ""
                let displayName = docData!["displayName"] as? String ?? ""
                let imgUser = docData!["imgUser"] as? String ?? ""
                var user = User(email: email, displayName: displayName, imgUser: imgUser)
                user.uid = uid
                completion(user)
            } else {
                print("Document does not exist")
                completion(nil)
            }
        })
    }
    
    func loadUsers(keyword: String,completion: @escaping ([User]?) -> ()) {
        var items: [User] = []
        
        store.collection(USER_PATH)
            .whereField("displayName", isGreaterThanOrEqualTo: keyword)
            .whereField("displayName", isLessThan: keyword + "z")
            .addSnapshotListener{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No users")
                    return
                }
                documents.compactMap{ document in
                    let uid = document["uid"] as? String ?? ""
                    let email = document["email"] as? String ?? ""
                    let displayName = document["displayName"] as? String ?? ""
                    let imgUser = document["imgUser"] as? String ?? ""
                    let user = User(uid: uid, email: email, displayName: displayName, imgUser: imgUser)
                    items.append(user)
                }
                completion(items)
            }
    }
    
    func updateMyImage(uid: String, imgUser: String?) {
         store.collection(USER_PATH).document(uid).updateData(["imgUser": imgUser!])
     }
    
    func storePost(post: Post,completion: @escaping (Bool) -> ()) {
        let postId = store.collection(USER_PATH).document(post.uid!).collection(POST_PATH).document().documentID

        let params = [
            "postId": postId,
            "time": Utils.currentDate(),
            "caption": post.caption,
            "imgPost": post.imgPost,
            "uid": post.uid,
            "displayName": post.displayName,
            "imgUser": post.imgUser]

        if let uid = post.uid{
            do {
                try store.collection(USER_PATH).document(uid).collection(POST_PATH).document(postId).setData(params)
//                try store.collection(USER_PATH).document(uid).collection(FEED_PATH).document(postId).setData(params)
                completion(true)
            }catch {
                print("There was an error while trying to update a task \(error.localizedDescription).")
                completion(false)
            }
        }
    }
}
