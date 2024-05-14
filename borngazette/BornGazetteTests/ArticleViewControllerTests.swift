//
//  ArticleViewControllerTests.swift
//  BornGazetteTests
//
//  Created by Rafael Melo on 14/05/24.
//

import XCTest
@testable import BornGazette

class ArticleViewControllerTests: XCTestCase {
    
    var sut: ArticleViewController?
    
    override func setUpWithError() throws {
        let sb = UIStoryboard(name: "ArticleViewController", bundle: nil)
        sut = sb.instantiateViewController(identifier: "ArticleViewController!") as? ArticleViewController
        sut?.loadView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
}
