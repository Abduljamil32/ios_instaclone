
import SDWebImageSwiftUI
import SwiftUI


struct MyPostCell: View {
    var uid: String
    var viewModel: ProfileViewModel
    @State private var showingAlert = false
    var post: Post
    var length: CGFloat
    
    var body: some View {
        VStack{
            WebImage(url: URL(string: post.imgPost!))
                .resizable()
                .frame(width: length, height: length)
                .scaledToFit()
            
            Text(post.caption!)
                .foregroundColor(.black)
                .font(.system(size: 16))
                .padding(.top, 10)
                .padding(.bottom, 10)
                .frame(width: length)
        }
    }
}

struct MyPostCell_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        MyPostCell(uid: "uid", viewModel: ProfileViewModel(),post: Post(caption: "khurshid88", imgPost: Utils.image2),length: UIScreen.width)
    }
}
