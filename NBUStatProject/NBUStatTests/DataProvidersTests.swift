//
//  DataProviders.swift
//  FinStat UkraineTests
//
//  Created by Aleksey Tyurenkov on 2/18/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import XCTest
@testable import FinStat_Ukraine


class DataProvidersTests: XCTestCase {
    
    let dataProviders = ModuleProvider()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCount(){
        XCTAssert(dataProviders.count > 0, "DataProviders List isn't fllled")
    }
    
    func testTitleAtIndex() {
        XCTAssert(!dataProviders.title(at:0).isEmpty, "Title At index 0 should exist")
        XCTAssert(!dataProviders.title(at:1).isEmpty, "Title At index 1 should exist")
        XCTAssert(dataProviders.title(at: dataProviders.count).isEmpty,"Out of range should return empty string")
        XCTAssert(dataProviders.title(at: -1).isEmpty,"Negative index should return empty string")
    }
    
    
    
}
