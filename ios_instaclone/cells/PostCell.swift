import SDWebImageSwiftUI
import SwiftUI

struct PostCell: View {
    
    var uid: String
    var viewModel: FeedViewModel
   
    @State private var showingAlert = false
    @State var post: Post
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                VStack{
                    Image("im_person").resizable().clipShape(Circle())
                        .frame(width: 46, height: 46)
                        .padding(.all, 2)
                }
                VStack(alignment: .leading,spacing: 3){
                    Text("")
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                    
                    Text("")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }.padding(.leading, 15)
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "ellipsis").foregroundColor(.black).font(.system(size: 15))
                })
            }
            .padding(.trailing, 15).padding(.leading, 15).padding(.top, 15)
            
            WebImage(url: URL(string: ""))
                .resizable().scaledToFit()
                .padding(.top, 15)
            
            HStack(spacing: 0){
                Button(action: {
                    
                }, label: {
                    Image(systemName: "heart").resizable().frame(width: 23, height: 23)
                        .foregroundColor(.black)
                }).padding(.trailing, 10)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperplane").resizable().frame(width: 23, height: 23)
                        .foregroundColor(.black)
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "bookmark").resizable().frame(width: 23, height: 23)
                        .foregroundColor(.black)
                })
            }
            .padding(.trailing, 15).padding(.leading, 15).padding(.top, 15)
            
            HStack{
                Text("Make a symbolic breakpiont at UIView, category on UIView listed in").foregroundColor(.black)
                    .font(.system(size: 16))
            }.padding(.all, 10)
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(uid: "uid", viewModel: FeedViewModel(), post: Post(caption: "symbolic", imgPost: Utils.image1))
    }
}
