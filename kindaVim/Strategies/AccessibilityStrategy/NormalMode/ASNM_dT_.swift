extension AccessibilityStrategyNormalMode {
    
    func dT(to character: Character, on element: AccessibilityTextElement?) -> AccessibilityTextElement? {
        guard var element = element else { return nil }
        
        if let elementFound = T(to: character, on: element), elementFound.caretLocation != element.caretLocation {
            element.selectedLength = element.caretLocation - elementFound.caretLocation
            element.caretLocation = elementFound.caretLocation
            element.selectedText = ""
            
            return element
        }
        
        element.selectedLength = 1
        element.selectedText = nil
        
        return element
    }
    
}
