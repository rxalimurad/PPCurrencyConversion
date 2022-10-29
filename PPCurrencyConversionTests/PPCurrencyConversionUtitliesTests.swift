//
//  PPCurrencyConversionUtitliesTests.swift
//  PPCurrencyConversionTests
//
//  Created by murad on 29/10/2022.
//


import XCTest
import Combine
@testable import PPCurrencyConversion

class PPCurrencyConversionUtitliesTests: XCTestCase {
    
    
    override func setUpWithError() throws  {
        
    }
  
    func testArraySorting() {
        XCTAssert([1,2,3,4,5].isSorted)
        XCTAssertFalse([1,2,3,5,1].isSorted)
        XCTAssertFalse([5,2,3,5,1].isSorted)
        XCTAssert([0,2,3,40,500].isSorted)
    }



}
