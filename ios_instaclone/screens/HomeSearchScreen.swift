import SwiftUI

struct HomeSearchScreen: View {
   
   @EnvironmentObject var session: SessionStore
   @ObservedObject var viewModel = SearchViewModel()
   @State var keyword = ""
   
   var body: some View {
       NavigationView{
           ZStack{
               VStack{
                   HStack{
                       Image(systemName: "magnifyingglass")
                           .padding(.leading, 15)
                           .font(.system(size: 20))
                       
                       TextField("Search for user", text: $keyword)
                           .padding(.leading, 5)
                           .frame(height: 45)
                           .font(.system(size: 18))
                   }
                   .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black.opacity(0.5)))
                   .padding(.horizontal, 20)
                   
                   Spacer()
                   
                   ScrollView(showsIndicators: false){
                       ForEach(viewModel.items, id: \.self ){ item in
                           UserCell(user: item)
                               .listRowInsets((EdgeInsets()))
                               .buttonStyle(PlainButtonStyle())
                               
                       }
                   }.listStyle(PlainListStyle())
               }
               
               if viewModel.isLoading {
                   ProgressView()
               }
               
           }.navigationBarTitle("Search", displayMode: .inline)
       }
       .onAppear{
           let uid = (session.session?.uid)!
           
           viewModel.apiUserList(uid: uid, keyword: keyword)
       }
   }
}

struct HomeSearchScreen_Previews: PreviewProvider {
   static var previews: some View {
       HomeSearchScreen()
   }
}
