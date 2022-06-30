

import Foundation
import SwiftUI


class Utils{
    static var color1 = Color(red: 252/255, green: 175/255, blue: 69/255)
    static var color2 = Color(red: 245/255, green: 96/255, blue: 64/255)
    
    static var image2 = "https://lh4.googleusercontent.com/-JhFi4fb_Pqw/URquuX-QXbI/AAAAAAAAAbs/IXpYUxuweYM/s1024/Horseshoe%252520Bend.jpg"
    static var image1 = "https://lh6.googleusercontent.com/-9lzOk_OWZH0/URquoo4xYoI/AAAAAAAAAbs/AwgzHtNVCwU/s1024/Frantic.jpg"
    static var image3 = "https://firebasestorage.googleapis.com/v0/b/ios-myinsta-41800.appspot.com/o/posts%2FBGz3SfPDGdcZWsByz6mC8RIILag12022-06-26T19%3A36%3A49Z.jpg?alt=media&token=414170ee-85e8-49c2-829f-3a6ed23ac4fd"
    
    static func currentDate() -> String{
          let date = Date()
          let df = DateFormatter()
          df.dateFormat = "yyyy-MM-dd HH:mm"
          let dateString = df.string(from: date)
          return dateString
      }
}

extension UIScreen{
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let size = UIScreen.main.bounds.size
}

    //Valid Email
    extension String {
        var isValidEmail: Bool {
            NSPredicate(format: "SELF MATCHES %@", "^[A-Z0-9a-z][a-zA-Z0-9_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
    }

    //Valid Password
    extension String {
        var isValidPassword: Bool {
            NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}").evaluate(with: self)
        }
    }

