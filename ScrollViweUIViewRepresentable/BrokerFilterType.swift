//
//  BrokerFilterType.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 01.12.23.
//

import Foundation

enum BrokersFilterType: Identifiable, Comparable, CaseIterable {

    case all
    case stocks
    case crypto
    case forex
    case futures
    case cfd

    var id: Self {
        return self
    }

    var title: String {
        switch self {
        case .all:
            return "All brokers"
        case .stocks:
            return "Stocks"
        case .crypto:
            return "Crypto"
        case .forex:
            return "Forex"
        case .futures:
            return "Futures"
        case .cfd:
            return "CFDs"
        }
    }

}
