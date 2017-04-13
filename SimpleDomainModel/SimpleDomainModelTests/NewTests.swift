//
//  NewTests.swift
//  ExtDomainModel
//
//  Created by Duncan Andrew on 4/12/17.
//  Copyright © 2017 Ted Neward. All rights reserved.
//

import XCTest

class NewTests: XCTestCase {

    func testFamily(){
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        let family = Family(spouse1: ted, spouse2: charlotte)
        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)
        XCTAssertEqual(family.description, "Ted Neward age 45, Charlotte Neward age 45, Mike Neward age 22, Matt Neward age 16")
        XCTAssertEqual(ted.description, "Ted Neward age 45")
    }
    
    func testMoney(){
        let tenUSD = Money(amount: 10, currency: "USD")
        let twelveUSD = Money(amount: 12, currency: "USD")
        let fiveGBP = Money(amount: 5, currency: "GBP")
        let fifteenEUR = Money(amount: 15, currency: "EUR")
        let fifteenCAN = Money(amount: 15, currency: "CAN")
        XCTAssertEqual(tenUSD.description, "USD10")
        XCTAssertEqual(twelveUSD.description, "USD12")
        XCTAssertEqual(fiveGBP.description, "GBP5")
        XCTAssertEqual(fifteenEUR.description, "EUR15")
        XCTAssertEqual(fifteenCAN.description, "CAN15")
    }
    
    func testJob(){
        let job1 = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        let job2 = Job(title: "Burger Flopper", type: Job.JobType.Hourly(15.0))
        XCTAssertEqual(job1.description, "Guest Lecturer earning 1000 per Year")
        XCTAssertEqual(job2.description, "Burger Flopper earning 15.0 per Hour")
    }
    
    func testMathematics(){
        let oneUSD = Money(amount: 1, currency: "USD")
        let tenUSD = Money(amount: 10, currency: "USD")
        let twoGBP = Money(amount: 2, currency: "GBP")
        let money1 = oneUSD.add(tenUSD)
        let money2 = oneUSD.subtract(tenUSD)
        let money3 = twoGBP.add(tenUSD)
        XCTAssertEqual(money1.description, "USD11")
        XCTAssertEqual(money2.description, "USD9")
        XCTAssertEqual(money3.description, "USD14")
    }
    
    func testDoubleExtention(){
        let double1: Double = 20.0
        let double2: Double = 3.0
        let money1 = double1.USD()
        let money2 = double2.GBP()
        XCTAssertEqual(money1.description, "USD20")
        XCTAssertEqual(money2.description, "GBP3")
    }
}
