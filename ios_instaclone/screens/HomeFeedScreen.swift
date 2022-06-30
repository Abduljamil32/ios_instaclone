//
//  HomeFeedScrenn.swift


import SwiftUI

struct HomeFeedScreen: View {
    
    @Binding var tabSelection: Int
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.items, id:\.self) { item in
                        if let uid = session.session?.uid! {
                            PostCell(uid:uid, viewModel: viewModel, post: item)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
    
            .navigationBarItems(trailing:
                                    Button(action: {
                self.tabSelection = 2
            }, label: {
                Image(systemName: "camera").font(.system(size:20))
            })
            )
            .navigationBarTitle("Instagram", displayMode: .inline)
        }.onAppear{
            viewModel.apiPostList {
                print(viewModel.items.count)
            }
        }
    }
}

struct HomeFeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedScreen(tabSelection: .constant(0))
    }
}
