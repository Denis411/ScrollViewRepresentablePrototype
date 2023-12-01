//
//  ContentView.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 30.11.23.
//

import SwiftUI

final class ViewModel: ObservableObject {

    @Published var chosenFilterType: BrokersFilterType = .all

    func setChosenFilter(filterType: BrokersFilterType) {
        chosenFilterType = filterType
        print(chosenFilterType)
    }

}


struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("hi")
            BrokerFilterBubbleScrollView(
                chosenFilterType: viewModel.chosenFilterType,
                chooseFilterAction: viewModel.setChosenFilter(filterType:)
            )
                .frame(maxHeight: 50)
        }
        .padding()
    }
}

struct BrokerFilterBubbleScrollView: UIViewRepresentable {

    private let chosenFilterType: BrokersFilterType
    private let chooseFilterAction: (BrokersFilterType) -> Void

    init(
        chosenFilterType: BrokersFilterType,
        chooseFilterAction: @escaping (BrokersFilterType) -> Void
    ) {
        self.chosenFilterType = chosenFilterType
        self.chooseFilterAction = chooseFilterAction
    }

    private let scrollView = UIScrollView()
    private let horizontalStackView = UIStackView()

    func makeUIView(context: Context) -> some UIView {
        return BrokerFilterScrollView(
            chosenFilterType: chosenFilterType,
            chooseFilterAction: chooseFilterAction
        )
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        (uiView as? BrokerFilterScrollView)?.updateChosenFilterType(chosenFilterType)
    }

}

final class BrokerFilterScrollView: UIScrollView {

    private let horizontalStackView = UIStackView()

    private let filterTypes: [BrokersFilterType] = BrokersFilterType.allCases
    private var chosenFilterType: BrokersFilterType
    private let chooseFilterAction: (BrokersFilterType) -> Void

    init(
        chosenFilterType: BrokersFilterType,
        chooseFilterAction: @escaping (BrokersFilterType) -> Void
    ) {
        self.chosenFilterType = chosenFilterType
        self.chooseFilterAction = chooseFilterAction
        super.init(frame: .zero)
        setUpSelf()
        setStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateChosenFilterType(_ newChosenFilterType: BrokersFilterType) {
        chosenFilterType = newChosenFilterType

        for orrangedView in horizontalStackView.arrangedSubviews {
            (orrangedView as? BrokerFilterBubbleCellView)?.setChosenFilterType(chosenFilterType)
        }
    }

    private func setUpSelf() {
        self.showsHorizontalScrollIndicator = false
        self.bounces = true
        self.backgroundColor = .green
    }

    private func setStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .leading
        horizontalStackView.distribution = .fill

        self.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        createBubbleViews()
    }

    private func createBubbleViews() {

        for type in filterTypes {
            let bubbleView = BrokerFilterBubbleCellView(filterType: type)
            bubbleView.setOnTapAction(chooseFilterAction)
            bubbleView.setChosenFilterType(chosenFilterType)
            horizontalStackView.addArrangedSubview(bubbleView)
        }

    }
}


final class BrokerFilterBubbleCellView: UILabel {

    private var onTapAction: ((BrokersFilterType) -> Void)?
    private let filterType: BrokersFilterType

    init(filterType: BrokersFilterType) {
        self.filterType = filterType
        super.init(frame: .zero)
        setGestureRecognizer()
        setUpSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }

    public func setChosenFilterType(_ chosenFilterType: BrokersFilterType) {
        if chosenFilterType == filterType {
            self.layer.backgroundColor = UIColor.yellow.cgColor
        } else {
            self.layer.backgroundColor = UIColor.orange.cgColor
        }
    }

    private func setUpSelf() {
        self.text = filterType.title
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
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }

    public func setOnTapAction(_ onTapAction: @escaping (BrokersFilterType) -> Void) {
        self.onTapAction = onTapAction
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        onTapAction?(filterType)
    }

}

// MARK: - Constants
extension BrokerFilterBubbleCellView {

    enum Constants {

        static let insets = UIEdgeInsets(top: 7, left: 12, bottom: 7, right: 12)

    }

}
