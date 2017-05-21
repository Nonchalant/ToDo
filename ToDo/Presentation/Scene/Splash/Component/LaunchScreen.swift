//
//  LaunchScreen.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import UIKit

class LaunchScreen: UIView {

    // MARK: - Property

    private var contentView: UIView?

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView?.frame = self.bounds
    }

    // MARK: - Private

    private func commonInit() {
        let nib = UINib(nibName: LaunchScreen.todo.className, bundle: Bundle(for: type(of: self)))
        contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        if let view = contentView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
