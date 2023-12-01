//
//  BrokerFilterBubbleScrollView.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 01.12.23.
//

import SwiftUI

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
