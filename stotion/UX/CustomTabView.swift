//
//  CustomTabView.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var currentTab: String
    @Binding var showMenu: Bool
    
    var body: some View {
        
        VStack{
            HStack{
                Button {
                    withAnimation(.spring()){
                        showMenu = true
                    }
                } label: {
                    
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .opacity(showMenu ? 0 : 1)
                
                Spacer()
                
                Button {
                    
                } label: {
                    
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .cornerRadius(5)
                }


            }
            .overlay(
            
                Text(currentTab)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .opacity(showMenu ? 0 : 1)
            )
            .padding([.horizontal,.top])
            .padding(.bottom,8)
            .padding(.top,getSafeArea().top)
            
            TabView(selection: $currentTab) {
                
                Home()
                    .tag("Home")
                
                quickLook()
                    .tag("Quick View")
                
                Text("Devices")
                    .tag("Devices")
                
                Text("Profile")
                    .tag("Profile")
            }
        }
        .disabled(showMenu)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
        
            Button {
                withAnimation(.spring()){
                    showMenu = false
                }
            } label: {
                
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .opacity(showMenu ? 1 : 0)
            .padding()
            .padding(.top)
            
            ,alignment: .topLeading
        )
        .background(
        
            Color.black
        )
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
