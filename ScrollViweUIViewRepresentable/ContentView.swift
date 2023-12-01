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
        guard chosenFilterType != filterType else {
            return
        }
        
        chosenFilterType = filterType
        print(chosenFilterType)
    }

}

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
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
