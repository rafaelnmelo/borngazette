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
    
    override func setUp(){
        super.setUp()
        sut = GazetteViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testHasATableView() {
        XCTAssertNotNil(sut?.tableview)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut?.tableview.delegate)
    }
    
    func testTableViewConformsToTableViewDelegateProtocol() {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDelegate.self)) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:didSelectRowAt:)))) != nil))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut?.tableview.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDataSource.self)) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:numberOfRowsInSection:)))) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:cellForRowAt:)))) != nil))
    }
}
