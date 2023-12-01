//
//  ContentView.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 30.11.23.
//

import SwiftUI

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
