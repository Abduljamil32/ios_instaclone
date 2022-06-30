import FirebaseFirestore
import Foundation
import Firebase

class SignUpViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    
    func apiSignUp(email: String, password: String, completion: @escaping (Bool) -> ()){
        isLoading = true
        SessionStore().signUp(email: email, password: password, completion: {(res,err) in
            self.isLoading = false
            if err != nil {
                print("Check email or password")
                completion(false)
            }else{
                print("User signed up")
                completion(true)
            }
        })
    }
    
    func apiStoreUser(user: User){
        DatabaseStore().storeUser(user: user)
    }
    
}
