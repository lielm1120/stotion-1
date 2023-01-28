//
//  accountViewController.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//


import SwiftUI

struct HomePage: View {
    var body: some View {
        Home()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(red: 1, green: 1, blue: 0.96)
                            .edgesIgnoringSafeArea(.all)
            HomePage()
        }
    }
}

struct Home : View {
    
    @State var index = 0
    @State var db = DataBase()
    var body: some View{
        
        VStack(spacing: 0){
            
            HStack{
                
                Button(action: {
                    let newPage = Calender()
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: newPage)
                }) {
                    
                    Image(systemName: "circle.grid.2x2")
                        .font(.title)
                        .foregroundColor(Color.init(red: 1, green: 1, blue: 0.96))
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            .padding(.top,(UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
            .padding(.bottom, 80)
            .background(Color.init(red: 0.2, green: 0.2, blue: 0.4))
            .clipShape(Corners(corner: [.bottomRight], size: CGSize(width: 55, height: 55)))
            
            HStack{
                
                VStack{
                    
                    // image...
                    HStack{
                        
                        Spacer()
                        
                        Image("pic")
                        .resizable()
                        .frame(width: 170, height: 130)
                    }
                    // moving bottom view slightly up...
                    .padding(.bottom, -35)
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Welcome")
                                .font(.title)
                            
                            Text("Liel")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.leading, 30)
                }
                // setting custom width...
                .padding(.bottom, 35)
                .frame(width: UIScreen.main.bounds.width - 100)
                .background(Color("select"))
                .clipShape(Corners(corner: [.topLeft,.topRight,.bottomRight], size: CGSize(width: 70, height: 70)))
                
                Spacer()
            }
            // moving view up...
            // giving only space 10 between...
            .padding(.top, -70)
            
            // now were going to create simple bottomleft outline corner radius...
            // follow me...
            
            // first filling the same color in background...

            ZStack{
                
                Color("select")
                
                ScrollView(.vertical, showsIndicators: false){
                    
                    HStack{
                        
                        Text("Event Categories")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            
                            Image(systemName: "ellipsis")
                                .font(.title)
                            
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.leading, 35)
                    .padding(.top, 50)
                    .padding(.trailing)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        CardView()
                    }
                    .padding(.top, 25)
                    
                    HStack{
                        
                        Text("Upcoming Events")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            
                            Image(systemName: "ellipsis")
                                .font(.title)
                            
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.leading, 25)
                    .padding(.top, 25)
                    .padding(.trailing)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 25){
                            ForEach(DataStructure.tasks) { task in
                                
                                VStack {
                                    HStack{
                                        Spacer()
                                        Image("pic")
                                        .resizable()
                                        .frame(width: 100, height: 70)
                                    }
                                    
                                    HStack{
                                        
                                        VStack(alignment: .leading, spacing: 15){
                                            
                                            Text(task.taskName.components(separatedBy: " ")[0])
                                                .font(.title)
                                                .foregroundColor(.black)
                                            if(task.taskName.components(separatedBy: " ").count > 1){
                                                Text(task.taskName.components(separatedBy: " ")[1])
                                                    .font(.title)
                                                    .foregroundColor(.black)
                                            }
                                            else{
                                                Text(" ")
                                                    .font(.title)
                                                    .foregroundColor(.black)
                                            }
                                            Text(dateToString(date: task.dateAdded))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 25)
                                }
                                    .padding(.bottom, 20)
                                    .frame(width: UIScreen.main.bounds.width / 2)
                                    .background(self.index == DataStructure.counetr ? Color("select") : Color.black.opacity(0.06))
                                    .cornerRadius(35)
                                    .onTapGesture {
                                            
                                        self.index = DataStructure.counetr
                                    }
                                }
                            VStack(spacing: 10){
                                
                                HStack{
                                    
                                    Spacer()
                                    
                                    Image("pic")
                                    .resizable()
                                    .frame(width: 100, height: 70)
                                }
                                
                                HStack{
                                    
                                    VStack(alignment: .leading, spacing: 15){
                                        
                                        Text("Mia's")
                                            .font(.title)
                                            .foregroundColor(.black)
                                        
                                        Text("Birthday")
                                            .font(.title)
                                            .foregroundColor(.black)
                                        
                                        Text("02 Feb")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.leading, 25)
                            }
                            // setting custom width..
                            .padding(.bottom, 20)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .background(self.index == DataStructure.counetr + 1 ? Color("select") : Color.black.opacity(0.06))
                            .cornerRadius(35)
                            .onTapGesture {
                                    
                                self.index = DataStructure.counetr + 1
                            }
                            
                            VStack(spacing: 10){
                                
                                HStack{
                                    
                                    Spacer()
                                    
                                    Image("pic")
                                    .resizable()
                                    .frame(width: 100, height: 70)
                                }
                                
                                HStack{
                                    
                                    VStack(alignment: .leading, spacing: 15){
                                        
                                        Text("iOS")
                                            .font(.title)
                                            .foregroundColor(.black)
                                        
                                        Text("App")
                                            .font(.title)
                                            .foregroundColor(.black)
                                        
                                        Text("15 Feb")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.leading, 25)
                            }
                            // setting custom width..
                            .padding(.bottom, 20)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .background(self.index == DataStructure.counetr + 2 ? Color("select") : Color.black.opacity(0.06))
                            .cornerRadius(35)
                            .onTapGesture {
                                    
                                self.index = DataStructure.counetr + 2
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .padding(.top, 25)
                    .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 10)
                    
                    
                }
                .background(Color.init(red: 1, green: 1, blue: 0.96))
                // now going to apply corner radius only to topleft so that we can acheive outline corner radius...
                .clipShape(Corners(corner: [.topLeft], size: CGSize(width: 70, height: 70)))
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
}

struct CardView : View {
    
    @State var index = 0
    
    var body: some View{
        
        HStack(spacing: 25){
            
            VStack(spacing: 12){
                
                Image(systemName: "desktopcomputer")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                
                Text("Work")
                    .foregroundColor(self.index == 0 ? .white : .black)
            }
            .padding(.horizontal, 5)
            .padding(.vertical,30)
            .background(self.index == 0 ? Color.init(red: 0.2, green: 0.2, blue: 0.4) : Color.black.opacity(0.06))
            .clipShape(Capsule())
            .onTapGesture {
                
                self.index = 0
            }
            
            VStack(spacing: 12){
                
                Image(systemName: "quote.bubble.fill")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                
                Text("Studies")
                    .foregroundColor(self.index == 1 ? .white : .black)
            }
            .padding(.horizontal, 10)
            .padding(.vertical,30)
            .background(self.index == 1 ? Color.init(red: 0.2, green: 0.2, blue: 0.4) : Color.black.opacity(0.06))
            .clipShape(Capsule())
            .onTapGesture {
                
                self.index = 1
            }
            
            VStack(spacing: 12){
                
                Image(systemName: "photo.on.rectangle")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                
                Text("General")
                    .foregroundColor(self.index == 2 ? .white : .black)
            }
            .padding(.horizontal, 10)
            .padding(.vertical,30)
            .background(self.index == 2 ? Color.init(red: 0.2, green: 0.2, blue: 0.4) : Color.black.opacity(0.06))
            .clipShape(Capsule())
            .onTapGesture {
                
                self.index = 2
            }
            
            VStack(spacing: 12){
                
                Image(systemName: "scissors")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                
                Text("Beauty")
                    .foregroundColor(self.index == 3 ? .white : .black)
            }
            .padding(.horizontal, 10)
            .padding(.vertical,30)
            .background(self.index == 3 ? Color.init(red: 0.2, green: 0.2, blue: 0.4) : Color.black.opacity(0.06))
            .clipShape(Capsule())
            .onTapGesture {
                
                self.index = 3
            }
        }
        .padding(.horizontal, 25)
    }
       
}

struct Corners : Shape {
    
    var corner : UIRectCorner
    var size : CGSize
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: size)
        
        return Path(path.cgPath)
    }
}

