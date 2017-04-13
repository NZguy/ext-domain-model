//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

// How can I get the tests to show me the actual vs expected?
// Whats a good way to get the number from the enum jobtype?
// Whats the meaning behind a _job and a job?

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String
    
    public var description: String {
        return currency + String(amount)
    }
  
    public func convert(_ to: String) -> Money {
        // Converts self to a universal curency that can be evenly divided into any other currency
        var amt = 0
        if self.currency == "USD"{
            amt = self.amount * 15
        }else if self.currency == "GBP"{
            amt = self.amount * 30
        }else if self.currency == "EUR"{
            amt = self.amount * 10
        }else if self.currency == "CAN"{
            amt = self.amount * 12
        }else{
            // Self is not a recognized currency type
        }
        
        // Divides universal currency into the requested type
        var ret: Money = Money(amount: 0, currency: "")
        if to == "USD"{
            ret = Money(amount: amt / 15, currency: "USD")
        }else if to == "GBP"{
            ret = Money(amount: amt / 30, currency: "GBP")
        }else if to == "EUR"{
            ret = Money(amount: amt / 10, currency: "EUR")
        }else if to == "CAN"{
            ret = Money(amount: amt / 12, currency: "CAN")
        }else{
            // to is not a recognized currency type
        }
        
        return ret
    }
  
    public func add(_ to: Money) -> Money {
        var me = self
        if(me.currency != to.currency){
            me = me.convert(to.currency)
        }
        let ret = Money(amount: me.amount + to.amount, currency: to.currency)
        return ret
    }
    
    public func subtract(_ from: Money) -> Money {
        var other = from
        if(self.currency != other.currency){
            other = other.convert(self.currency)
        }
        let ret = Money(amount: other.amount - self.amount, currency: self.currency)
        return ret
    }
}

////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible{
    fileprivate var title : String
    fileprivate var type : JobType
    
    public var description: String{
        switch self.type{
            case .Hourly(let num): return title + " earning " + String(num) + " per Hour"
            case .Salary(let num): return title + " earning " + String(num) + " per Year"
        }
    }

    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }

    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }

    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type{
        case .Hourly(let num): return Int(num * Double(hours))
        case .Salary(let num): return num
        }
    }

    open func raise(_ amt : Double) {
        switch self.type{
        case .Hourly(let num): self.type = JobType.Hourly(num + amt)
        case .Salary(let num): self.type = JobType.Salary(num + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person : CustomStringConvertible{
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    public var description: String{
        return firstName + " " + lastName + " age " + String(age)
    }

    // Whats the meaning behind a _job and a job?
    fileprivate var _job : Job? = nil
        open var job : Job? {
        get {
            return self._job
        }
        set(value) {
            if self.age >= 16 {
                self._job = value
            }
        }
    }

    fileprivate var _spouse : Person? = nil
        open var spouse : Person? {
        get {
            return self._spouse
        }
        set(value) {
            if self.age >= 18 {
                self._spouse = value
            }
        }
    }

    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    open func toString() -> String {
        var jobString = "nil"
        var spouseString = "nil"
        if self.job != nil{
            jobString = " title:\(self.job!.title) type:\(self.job!.type)"
        }
        if self.spouse != nil{
            spouseString = self.spouse!.toString()// This could potentially become an infinite loop
        }
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(jobString) spouse:\(spouseString)]"
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible{
    fileprivate var members : [Person] = []
    
    public var description: String{
        var str: String = ""
        for i in 0...members.count-1{
            str += String(describing: members[i])
            if i < members.count-1{
                str += ", "
            }
        }
        return str;
    }

    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil{
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            self.members.append(spouse1)
            self.members.append(spouse2)
        }
    }

    open func haveChild(_ child: Person) -> Bool {
        self.members.append(child)
        return true // Whats the point of this return?
        // Can't restrict the child to age 0, unit tests fail
        }

        open func householdIncome() -> Int {
        var ret = 0
        for person in self.members{
            if person.job != nil{
                ret = ret + Int(person.job!.calculateIncome(2000)) // Why does it need to be over 2000 hours?
            }
        }
        return ret
    }
}

// Any way to make the returned class the one it was added on?
protocol Mathematics{
    func add(_: Money) -> Money
    func subtract(_: Money) -> Money
}

extension Double {
    func USD() -> Money{
        return Money(amount: Int(self), currency: "USD")
    }
    func EUR() -> Money{
        return Money(amount: Int(self), currency: "EUR")
    }
    func GBP() -> Money{
        return Money(amount: Int(self), currency: "GBP")
    }
    func CAN() -> Money{
        return Money(amount: Int(self), currency: "CAN")
    }
}









