extension AccessibilityStrategyNormalMode {
    
    func dj(on element: AccessibilityTextElement?) -> AccessibilityTextElement? {
        guard var element = element else { return nil }
        
        if element.isEmpty {
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsNotLinefeed {
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsLinefeed {
            return element
        }
        
        
        if let axNextLine = AXEngine.axLineRangeFor(lineNumber: element.currentLine.number! + 1) {
            element.selectedLength = element.currentLine.length! + axNextLine.length
            element.selectedText = ""
            
            _ = AccessibilityTextElementAdaptor.toAXfocusedElement(from: element)
            
            if let updatedElement = AccessibilityTextElementAdaptor.fromAXFocusedElement() {            
                let firstNonBlankWithinLineLimitOfUpdatedElementLocation = textEngine.firstNonBlankWithinLineLimit(in: TextEngineLine(from: updatedElement.currentLine.value))
                
                element.caretLocation += firstNonBlankWithinLineLimitOfUpdatedElementLocation
                element.selectedLength = 0
                element.selectedText = nil
            }
        }        
        
        return element
    }
    
}