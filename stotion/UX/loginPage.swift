//
//  ContentView.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//

import SwiftUI

struct loginPage: View {
    var body: some View {

        HomeLI()
            .background(Color.init(red: 1, green: 1, blue: 0.94))
            //.preferredColorScheme(.dark)
    }
}

struct loginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}
