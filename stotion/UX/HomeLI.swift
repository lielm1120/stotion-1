//
//  HomeLI.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//

import SwiftUI

struct HomeLI: View {
    
    @State var maxCircleHeight: CGFloat = 0
    
    @State var showSignUp = false
    
    var body: some View {
        
        VStack{
            
            GeometryReader{proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    if maxCircleHeight == 0{
                        maxCircleHeight = height
                    }
                }
                
                return AnyView(
                
                    ZStack{
                        
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: getRect().width / 2, y: -height / 1.3)
                        
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: -getRect().width / 2, y: -height / 1.5)
                        
                        Circle()
                            .fill(Color("lightBlue"))
                            .offset(y: -height / 1.3)
                            .rotationEffect(.init(degrees: -5))
                    }
                )
            }
            .frame(maxHeight: getRect().width)
            
            ZStack{
                
                // Trasnitions...
                if showSignUp{
                    SignUp()
                        .transition(.move(edge: .trailing))
                }
                else{
                    Login()
                        .transition(.move(edge: .trailing))
                }
            }
            // removing Unwanted Space....
            .padding(.top,-maxCircleHeight / (getRect().height < 750 ? 1.5 : 1.6))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
        
            HStack{
                
                Text(showSignUp ? "New Member" : "Already Member")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button(action: {
                    withAnimation{
                        showSignUp.toggle()
                    }
                }, label: {
                    Text(showSignUp ? "sign in" : "sign up")
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightBlue"))
                })
            }
            .padding(.bottom,getSafeArea().bottom == 0 ? 15 : 0)
            
            ,alignment: .bottom
        )
        .background(
        
            // Bottom Rings...
            HStack{
                
                Circle()
                    .fill(Color("lightBlue"))
                    .frame(width: 70, height: 70)
                    .offset(x: -30, y: getRect().height < 750 ? 10 : 0)
                
                Spacer(minLength: 0)
                
                Circle()
                    .fill(Color("dark"))
                    .frame(width: 110, height: 110)
                    .offset(x: 40, y: 20)
            }
            .offset(y: getSafeArea().bottom + 30)
            
            ,alignment: .bottom
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct HomeLI_Previews: PreviewProvider {
    static var previews: some View {
        HomeLI()
    }
}

// extedning view to get screen Size...
