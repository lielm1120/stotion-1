//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 08/01/22.
//

import SwiftUI

struct quickLook: View {
    var body: some View {
        HomeQL()
            .background(Color.init(red: 1, green: 1, blue: 0.94))
    }
}

struct quickLook_Previews: PreviewProvider {
    static var previews: some View {
        quickLook()
    }
}
