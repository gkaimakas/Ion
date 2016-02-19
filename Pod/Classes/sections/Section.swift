//
//  Section.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

public class Section{
    public let id: Int64
    public let name: String
    
    private var dirty = false
    private var previousState = false
    private var currentState = false
    private var submitted = false
    
    private var inputs = [Input]()
    
    private var sectionListeners = [SectionListener]()
    
    //MARK: - Computed Properties
    
    public var data: [String: Any]{
        return inputs.map{
            $0.data
            }.filter(){
                $0 != nil
            }.reduce([String:Any]()) { (var result:[String: Any], data:[String : Any]?) -> [String:Any] in
                if let _data = data {
                    for (key, value) in _data{
                        result[key] = value
                    }
                }
                return result
        }
    }
    
    public var errors:[String]? {
        let errorList = inputs.map{
            $0.errors
            }.filter(){
                $0 != nil
            }.reduce([String]()) { (var result:[String], data: [String]?) -> [String] in
                if let _data = data {
                    result.appendContentsOf(_data)
                }
                return result
        }
        
        if errorList.count != 0{
            return errorList
        }
        
        return nil
    }
    
    public var isDirty: Bool{
        return dirty
    }
    
    public var isValid: Bool {
        return validate()
    }
    
    public var isSubmitted: Bool {
        return submitted
    }
    
    public var numberOfInputs: Int {
        return inputs.count
    }
    
    
    //MARK: - Initializers
    public init(name:String){
        self.id = Int64(NSDate().timeIntervalSince1970 * 1000)
        self.name = name
    }
    
    public func addInput(input:Input) -> Section{
        inputs.append(input)
        input.addInputListener(self)
        
        return self
    }
    
    public func addSectionListener(listener: SectionListener){
        sectionListeners.append(listener)
    }
    
    public func inputAtIndex(index: Int) -> Input {
        return inputs[index]
    }
    
    //Mark: - Notifications
    
    internal func notifyIfSectionInputValueChange(input: Input){
        for listener:SectionListener in sectionListeners{
            listener.sectionInputDidChangeValue(self, input: input)
        }
    }
    
    internal func notifyIfSectionStateChange(){
        if previousState != currentState {
            for listener:SectionListener in sectionListeners{
                listener.sectionDidChangeState(self)
            }
        }
    }
    
    internal func notifyIfSectionSubmitted(){
        if submitted{
            for listener:SectionListener in sectionListeners{
                listener.sectionWasSubmitted(self)
            }
        }
        
    }
    
    public func setCurrentState(state:Bool){
        previousState = currentState
        currentState = state
    }

    public func submit(){
        submitted = true
        for input:Input in inputs{
            input.submit()
        }
    }
    
    public func validate() -> Bool{
        return inputs.reduce(true){
            $0 && $1.validate()
        }
    }
}



//MARK: - InputListener implementation
extension Section: InputListener {
    
    public func inputDidChangeState(input: Input) {
        setCurrentState(validate())
        notifyIfSectionStateChange()
    }
    
    public func inputDidChangeValue(input: Input) {
        dirty = true
        notifyIfSectionInputValueChange(input)
    }
    
    public func inputWasForceValidated(input: Input) {
        
    }
    
    public func inputWasSubmitted(input: Input) {
        
    }
}
