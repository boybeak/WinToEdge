// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppKit

public enum EdgePosition {
    case left, top, right, bottom
}

public extension NSWindow {
    
    public func snapToEdge(edges: [EdgePosition], legacy: CGFloat = 48) {
        
        if edges.isEmpty {
            return
        }
        
        if legacy <= 0 {
            fatalError("legacy can not be <= 0")
        }
        
        guard let screenFrame = screen?.visibleFrame else { return }
        
        var newFrame = frame
        
        // 吸附到左边缘
        if edges.contains(.left) {
            if legacy > newFrame.width {
                fatalError("legacy can not be > window's width")
            }
            if newFrame.minX <= screenFrame.minX {
                newFrame.origin.x = screenFrame.minX - newFrame.width + legacy
            }
        }
        
        
        // 吸附到右边缘
        if edges.contains(.right) {
            if legacy > newFrame.width {
                fatalError("legacy can not be > window's width")
            }
            if newFrame.maxX >= screenFrame.maxX {
                newFrame.origin.x = screenFrame.maxX - legacy
            }
        }
        
        // 吸附到上边缘
        if edges.contains(.top) {
            if legacy > newFrame.height {
                fatalError("legacy can not be > window's height")
            }
            if newFrame.maxY >= screenFrame.maxY {
                newFrame.origin.y = screenFrame.maxY - legacy
            }
        }
        
        // 吸附到下边缘
        if edges.contains(.bottom) {
            if legacy > newFrame.height {
                fatalError("legacy can not be > window's height")
            }
            if newFrame.minY <= screenFrame.minY {
                newFrame.origin.y = screenFrame.minY - newFrame.height + legacy
            }
        }
        
        setFrame(newFrame, display: true, animate: true)
    }
    
    public func escapeFromEdge(edges: [EdgePosition]) {
        
        if edges.isEmpty {
            return
        }
        
        guard let screenFrame = screen?.visibleFrame else { return }
        var newFrame = frame
        
        // 从左边缘弹出
        if edges.contains(.left) {
            if newFrame.minX < screenFrame.minX {
                newFrame.origin.x = screenFrame.minX
            }
        }
        
        // 从右边缘弹出
        if edges.contains(.right) {
            if newFrame.maxX > screenFrame.maxX {
                newFrame.origin.x = screenFrame.maxX - newFrame.width
            }
        }
        
        // 从顶部弹出
        if edges.contains(.top) {
            if screenFrame.maxY > newFrame.maxY {
                newFrame.origin.y = screenFrame.maxY - newFrame.height
            }
        }
        
        // 从底部弹出
        if edges.contains(.bottom) {
            if newFrame.minY < screenFrame.minY {
                newFrame.origin.y = screenFrame.minY
            }
        }
        
        setFrame(newFrame, display: true, animate: true)
    }
    
}
