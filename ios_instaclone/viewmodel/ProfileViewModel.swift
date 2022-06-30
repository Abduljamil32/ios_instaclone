import Foundation
import Firebase
import FirebaseFirestore
import UIKit

class ProfileViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [Post] = []
    
    @Published var email = ""
    @Published var displayName = ""
    @Published var imgUser = ""
    
    func apiPostList(completion: @escaping () -> ()){
        isLoading = true
        items.removeAll()

//        self.items.append(Post(title: "", content: "", imageURL: Utils.image3))
//        self.items.append(Post(title: "", content: "", imageURL: Utils.image3))


        isLoading = false
        completion()
    }

    func apiSignOut(){
        SessionStore().signOut()
    }
    
    // Loading User info
    func apiLoadUser(uid: String){
        DatabaseStore().loadUser(uid: uid, completion: { user in
            self.email = (user?.email)!
            self.displayName = (user?.displayName)!
            self.imgUser = (user?.imgUser)!
            print(self.imgUser)
        })
    }
  
    func apiUploadMyImage(uid: String, image: UIImage){
          isLoading = true
          StorageStore().uploadUserImage(uid: uid, image, completion: { downloadUrl in
              self.apiUpdateMyImage(uid: uid, imgUser: downloadUrl)
              self.apiLoadUser(uid: uid)
          })
      }
    
    func apiUpdateMyImage(uid: String, imgUser: String?){
           DatabaseStore().updateMyImage(uid: uid, imgUser: imgUser)
       }
}
