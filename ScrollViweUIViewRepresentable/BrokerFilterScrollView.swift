//
//  BrokerFilterScrollView.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 01.12.23.
//

import UIKit

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
