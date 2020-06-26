//
//  ContentView.swift
//  Dicee-SwiftUI
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var diceLeft = 1
    @State var diceRight = 1

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(n: diceLeft)
                    DiceView(n: diceRight)
                }
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    self.diceLeft = Int.random(in: 1...6)
                    self.diceRight = Int.random(in: 1...6)
                }) {
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
            }
        }
    }
}

struct DiceView: View {
    let n: Int

    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
