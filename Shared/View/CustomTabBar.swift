//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by nyannyan0328 on 2021/09/10.
//

import SwiftUI

struct CustomTabBar: View {
    @State var currentTab : Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    @State var currentXValue : CGFloat = 0
    @Namespace var animation
    var body: some View {
        TabView(selection:$currentTab){
            
            CardView(color: .red, count: 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Home)
            
            Text("Search")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Search)
            
            Text("Notificationd")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Notification)
            
            Text("Account")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Account)
                
            
            
        }
        .overlay(
        
            HStack(spacing:0){
                
                
                
                ForEach(Tab.allCases,id:\.rawValue){tab in
                    
                    
                    TabButton(tab: tab)
                    
                    
                }
                
                
                
            }
                .padding(.vertical)
                .padding(.bottom,getSafeArea().bottom == 0 ? 15 : (getSafeArea().bottom - 10))
                .background(
                
                    BlurView(style: .systemUltraThinMaterial)
                        .clipShape(BottomShape(currentXValue: currentXValue))
                    
                    
                )
                
            ,alignment: .bottom
        
        )
        .ignoresSafeArea(.all, edges: .bottom)
        .preferredColorScheme(.dark)
        
    }
    
    @ViewBuilder
    
    func CardView(color : Color,count : Int)->some View{
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing:20){
                    
                    
                    ForEach(1...6,id:\.self){index in
                        
                       Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 280)
                            .cornerRadius(15)
                        
                        
                    }
                }
                .padding()
                .padding(.bottom,60)
                .padding(.bottom,getSafeArea().bottom == 0 ? 15 : (getSafeArea().bottom))
                
                
            }
            .navigationTitle("Home")
        }
        
    }
    
    @ViewBuilder
    func TabButton(tab : Tab)->some View{
        
        GeometryReader{proxy in
            
            Button {
                withAnimation(.spring()){
                    
                    currentTab = tab
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(currentTab == tab ? 15 : 0)
                    .contentShape(Rectangle())
                    .background(
                    
                        ZStack{
                            
                            if currentTab == tab{
                                
                                
                                BlurView(style: .systemChromeMaterialDark)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                        
                        
                    )
                    .padding(currentTab == tab ? -50 : 0)
                    
                   
            }
            .onAppear {
                
                if tab == Tab.allCases.first && currentXValue == 0{
                    
                    
                    currentXValue = proxy.frame(in: .global).midX
                    
                }
                
            }
        }
        .frame(height: 30)
      

        
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

enum Tab : String,CaseIterable{
    
    case Home = "house.fill"
    case Search = "magnifyingglass"
    case Notification = "bell.fill"
    case Account = "person.fill"
}

extension View{
    
    func getSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            
            return .zero
        }
        
        
        return safeArea
        
        
        
    }
}
