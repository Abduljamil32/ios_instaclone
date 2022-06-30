import SwiftUI

struct HomeLikesScreen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = LikesViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.items, id:\.self) { item in
                        if let uid = session.session?.uid! {
                            LikePostCell(uid:uid, viewModel: viewModel, post: item)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Likes", displayMode: .inline)
        }.onAppear{
            viewModel.apiPostList {
                print(viewModel.items.count)
            }
        }
    }
}

struct HomeLikesScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeLikesScreen()
    }
}
