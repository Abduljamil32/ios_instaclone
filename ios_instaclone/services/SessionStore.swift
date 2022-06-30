
import Firebase
import FirebaseAuth
import Foundation
import Combine

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user)")
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
            } else {
                self.session = nil
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
    
//    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
//        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
//    }
//
//    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
//        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
//    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if err != nil{
                completion(false, (err?.localizedDescription)!)
                return
            }
            completion(true, (res?.user.email)!)
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if err != nil{
                completion(false, (err?.localizedDescription)!)
                return
            }
            completion(true, (res?.user.email)!)
        }
    }
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
}
