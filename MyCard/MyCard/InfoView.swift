//
//  InfoView.swift
//  MyCard
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    let imageName: String
    let text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                Text(text)
            })
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(imageName: "person.circle", text: "omrobbie")
            .previewLayout(.sizeThatFits)
    }
}
