//
//  GazetteViewControllerTests.swift.swift
//  BornGazetteTests
//
//  Created by Rafael Melo on 11/05/24.
//

import XCTest
@testable import BornGazette

class GazetteViewControllerTests: XCTestCase {
    
    var sut: GazetteViewController?
    
    override func setUpWithError() throws {
        let sb = UIStoryboard(name: "GazetteViewController", bundle: nil)
        sut = sb.instantiateViewController(identifier: "GazetteViewController!") as? GazetteViewController
        sut?.loadView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testEmptyTableView() {
        let isHidden = sut?.tableview.isHidden
        let list = sut?.presenter?.numberOfNewsRows()
        if list == 0 {
            XCTAssertEqual(isHidden, true)
        } else {
            XCTAssertEqual(isHidden, false)
        }
    }
}
