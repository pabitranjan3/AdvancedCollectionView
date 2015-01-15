//
//  GridLayoutAttributes.swift
//  AdvancedCollectionView
//
//  Created by Zachary Waldowski on 12/15/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

import UIKit

public final class GridLayoutAttributes: UICollectionViewLayoutAttributes {
    
    /// The background color for the view
    public var backgroundColor: UIColor? = nil
    /// The background color when selected
    public var selectedBackgroundColor: UIColor? = nil
    /// The background color for the view
    public var tintColor: UIColor? = nil
    /// The background color when selected
    public var selectedTintColor: UIColor? = nil
    /// Used by supplementary items
    public var padding = UIEdgeInsetsZero
    
    /// If this is a header, is it pinned to the top of the collection view?
    /// If this is pinned, where is our minY when we unpin it?
    var pinning: (isPinned: Bool, isHiddenNormally: Bool, unpinnedY: CGFloat?) = (false, false, nil)
    /// What is the column index for this item?
    var columnIndex = 0
    
    public override var hash: Int {
        var hash = SimpleHash(super.hash)
        hash.append(backgroundColor?.hashValue)
        hash.append(selectedBackgroundColor?.hashValue)
        hash.append(tintColor?.hashValue)
        hash.append(selectedTintColor?.hashValue)
        hash.append(padding.top.hashValue)
        hash.append(padding.left.hashValue)
        hash.append(padding.bottom.hashValue)
        hash.append(padding.right.hashValue)
        hash.append(pinning.isPinned.hashValue)
        hash.append(pinning.isHiddenNormally.hashValue)
        hash.append(pinning.unpinnedY?.hashValue)
        hash.append(columnIndex.hashValue)
        return hash.result
    }
    
    public override func isEqual(object: AnyObject?) -> Bool {
        if !super.isEqual(object) { return false }
        if let other = object as? GridLayoutAttributes {
            if backgroundColor != other.backgroundColor { return false }
            if selectedBackgroundColor != other.selectedBackgroundColor { return false }
            if tintColor != other.tintColor { return false }
            if selectedTintColor != other.selectedTintColor { return false }
            if padding != other.padding { return false }
            if pinning.isPinned != other.pinning.isPinned { return false }
            if pinning.isHiddenNormally != other.pinning.isHiddenNormally { return false }
            if pinning.unpinnedY != other.pinning.unpinnedY { return false }
            if columnIndex != other.columnIndex { return false }
            return true
        } else {
            return false
        }
    }
    
    public override func copyWithZone(zone: NSZone) -> AnyObject {
        var attributes = super.copyWithZone(zone) as GridLayoutAttributes
        attributes.backgroundColor = backgroundColor
        attributes.selectedBackgroundColor = selectedBackgroundColor
        attributes.tintColor = tintColor
        attributes.selectedTintColor = selectedTintColor
        attributes.padding = padding
        attributes.pinning = pinning
        attributes.columnIndex = columnIndex
        return attributes
    }
    
}

public class GridLayoutInvalidationContext: UICollectionViewLayoutInvalidationContext {

    public var invalidateLayoutMetrics = true
    public var invalidateLayoutOrigin = false
    
}
