//
//  ContentView.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 30.11.23.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.layoutDirection) private var layoutDirection

    var body: some View {
        VStack {
            Text("hi")
            BrokerFilterBubbleScrollView(bubbleNames: ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth"])
                .frame(maxHeight: 50)
        }
        .padding()
        .environment(\.layoutDirection, .rightToLeft)
    }
}

#Preview {
    ContentView()
}

struct BrokerFilterBubbleScrollView: UIViewRepresentable {

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

extension BrokerFilterBubbleScrollView {

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
            let bubbleView = BrokerFilterBubbleCellView()
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


final class BrokerFilterBubbleCellView: UILabel {

    private var onTapAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override var intrinsicContentSize: CGSize {
        let extraWidth = Constants.insets.left + Constants.insets.right
        let extraHeight = Constants.insets.bottom + Constants.insets.top

        return CGSize(
            width: super.intrinsicContentSize.width + extraWidth,
            height: super.intrinsicContentSize.height + extraHeight
        )
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: Constants.insets))
        setUpSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpSelf() {
        setGestureRecognizer()
        self.numberOfLines = 1
        self.layer.cornerRadius = 12
        self.textColor = .blue
        self.layer.backgroundColor = UIColor.orange.cgColor
    }

}

// MARK: - On tap actions
extension BrokerFilterBubbleCellView {

    @inline(__always)
    private func setGestureRecognizer() {
        isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(performOnTapAction))
        self.addGestureRecognizer(gestureRecognizer)
    }

    public func setOnTapAction(_ onTapAction: @escaping () -> Void) {
        self.onTapAction = onTapAction
    }

    @objc func performOnTapAction() {
        onTapAction?()
    }

}

// MARK: - Constants
extension BrokerFilterBubbleCellView {

    enum Constants {

        static let insets = UIEdgeInsets(top: 7, left: 12, bottom: 7, right: 12)

    }

}
