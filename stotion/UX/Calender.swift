//
//  ContentView.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//


import SwiftUI

struct Calender: View {
    var body: some View {
        HomeC()
        .background(Color.init(red: 1, green: 1, blue: 0.94))
        let detectDirectionalDrags = DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                
                if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                    print("left swipe")
                }
                else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                    print("right swipe")
                }
                else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                    print("up swipe")
                }
                else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                    print("down swipe")
                }
                else {
                    print("no clue")
                }
            }
    }
}

struct Calender_Previews: PreviewProvider {
    static var previews: some View {
        Calender()
    }
}
