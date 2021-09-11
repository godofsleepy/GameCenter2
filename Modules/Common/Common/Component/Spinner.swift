//
//  Spinner.swift
//  Common
//
//  Created by Rumah Coding on 11/09/21.
//

import SwiftUI

public struct Spinner: UIViewRepresentable {
    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.color = UIColor(red: 247 / 255, green: 164 / 255, blue: 10 / 255, alpha: 1.0)
        return spinner
    }

   public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

