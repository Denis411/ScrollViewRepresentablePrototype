//
//  ContentView.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 30.11.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("hi")
            ScrollViewRepresentable(bubbleNames: ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth"])
                .frame(maxHeight: 50)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ScrollViewRepresentable: UIViewRepresentable {

    private let bubbleNames: [String]

    private let scrollView = UIScrollView()
    private let horizontalStackView = UIStackView()

    init(bubbleNames: [String]) {
        self.bubbleNames = bubbleNames
        setStackView()
        setScrollView()
    }

    func makeUIView(context: Context) -> some UIView {
        scrollView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

}

extension ScrollViewRepresentable {

    private func setStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .leading
        horizontalStackView.distribution = .fill

        scrollView.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        createBubbleViews()
    }

    private func createBubbleViews() {

        for name in bubbleNames {
            let bubbleView = UILabel()
            bubbleView.text = name
            horizontalStackView.addArrangedSubview(bubbleView)
        }

    }

    private func setScrollView() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        scrollView.backgroundColor = .green
    }

}
