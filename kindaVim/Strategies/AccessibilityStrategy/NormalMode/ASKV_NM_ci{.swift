extension AccessibilityStrategyNormalMode {
    
    func ciLeftBrace(on element: AccessibilityTextElement?) -> AccessibilityTextElement? {
        return ciInnerBrackets(using: "{", on: element)
    }
    
}
