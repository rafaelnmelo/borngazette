//
//  ViewCodeProtocol.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import Foundation

protocol ViewCodeProtocol {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewCodeProtocol {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
}
