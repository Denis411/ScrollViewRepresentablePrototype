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
