//
//  ReadLaterViewControllerTests.swift
//  BornGazetteTests
//
//  Created by Rafael Melo on 14/05/24.
//

import XCTest
@testable import BornGazette

class ReadLaterViewControllerTests: XCTestCase {
    
    var sut: ReadLaterViewController?
    
    override func setUpWithError() throws {
        let sb = UIStoryboard(name: "ReadLaterViewController", bundle: nil)
        sut = sb.instantiateViewController(identifier: "ReadLaterViewController!") as? ReadLaterViewController
        sut?.loadView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
}
