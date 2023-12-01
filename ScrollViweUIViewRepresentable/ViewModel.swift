//
//  ViewModel.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 01.12.23.
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
