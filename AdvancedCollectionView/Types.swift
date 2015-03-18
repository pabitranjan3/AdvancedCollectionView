//
//  Types.swift
//  AdvancedCollectionView
//
//  Created by Zachary Waldowski on 1/2/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

import Foundation

public enum Section {
    
    case Index(Int)
    case Global
    
}

public func ==(lhs: Section, rhs: Section) -> Bool {
    switch (lhs, rhs) {
    case (.Index(let a), .Index(let b)):
        return a == b
    case (.Global, .Global):
        return true
    default:
        return false
    }
}

extension Section: Hashable {
    
    public var hashValue: Int {
        switch self {
        case .Index(let a):
            return a
        default:
            return -1
        }
    }
    
}

public func <(lhs: Section, rhs: Section) -> Bool {
    switch (lhs, rhs) {
    case (.Index(let a), .Index(let b)):
        return a < b
    case (.Index, .Global):
        return true
    default:
        return false
    }
}

extension Section: Comparable {}

extension Section {
    
    public static func all(#numberOfSections: Int) -> GeneratorOf<Section> {
        var includedGlobal = false
        var base = map(lazy(0..<numberOfSections), {
            Section.Index($0)
        }).generate()
        
        return GeneratorOf {
            if !includedGlobal {
                includedGlobal = true
                return .Global
            }
            return base.next()
        }
    }
    
}

func ~=(lhs: Section, rhs: NSIndexSet) -> Bool {
    switch lhs {
    case .Global:
        return false
    case .Index(let idx):
        return rhs.containsIndex(idx)
    }
}

// MARK: -

public enum ElementLength: Equatable {
    
    case Static(CGFloat)
    case Estimate(CGFloat)
    case Remainder
    
    public static var Default: ElementLength {
        return .Static(44)
    }
    
    var lengthValue: CGFloat {
        switch self {
        case .Static(let x): return x
        case .Estimate(let x): return x
        case .Remainder: return 0
        }
    }
    
}

public func ==(lhs: ElementLength, rhs: ElementLength) -> Bool {
    switch (lhs, rhs) {
    case (.Static(let x), .Static(let y)):
        return x ~== y
    case (.Estimate(let x), .Estimate(let y)):
        return x ~== y
    case (.Remainder, .Remainder):
        return true
    default:
        return false
    }
}

// MARK: -

public enum SupplementKind: String {
    
    case Header = "header"
    case Footer = "footer"
//    case SectionGap = "sectionGap"
//    case AtopHeaders = "atopHeaders"
//    case AtopItems = "atopItems"
    case Placeholder = "placeholder"
    
}
