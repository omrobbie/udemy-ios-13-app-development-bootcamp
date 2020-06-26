//
//  WebView.swift
//  H4X0R-News
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let urlString: String?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}

