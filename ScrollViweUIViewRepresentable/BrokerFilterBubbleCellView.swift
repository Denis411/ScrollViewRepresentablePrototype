//
//  BrokerFilterBubbleCellView.swift
//  ScrollViweUIViewRepresentable
//
//  Created by dulianov on 01.12.23.
//

import UIKit

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
