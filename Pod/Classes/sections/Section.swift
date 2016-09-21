//
//  Section.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

open class Section{
    open let id: Int64
    open let name: String
    
    fileprivate var dirty = false
    fileprivate var previousState = false
    fileprivate var currentState = false
    fileprivate var submitted = false
    
    fileprivate var inputs = [Input]()
    
    fileprivate var sectionListeners = [SectionListener]()
    
    //MARK: - Computed Properties
    
    open var data: [String: Any]{
        return inputs.map{
            $0.data
            }.filter(){
                $0 != nil
            }.reduce([String:Any]()) { (result:[String: Any], data:[String : Any]?) -> [String:Any] in
				var _result = result
                if let _data = data {
                    for (key, value) in _data{
                        _result[key] = value
                    }
                }
                return _result
        }
    }
    
    open var errors:[String]? {
        let errorList = inputs.map{
            $0.errors
            }.filter(){
                $0 != nil
            }.reduce([String]()) { (result:[String], data: [String]?) -> [String] in
				var _result = result
                if let _data = data {
                    _result.append(contentsOf: _data)
                }
                return _result
        }
        
        if errorList.count != 0{
            return errorList
        }
        
        return nil
    }
    
    open var isDirty: Bool{
        return dirty
    }
    
    open var isValid: Bool {
        return validate()
    }
    
    open var isSubmitted: Bool {
        return submitted
    }
    
    open var numberOfInputs: Int {
        return inputs.count
    }
    
    
    //MARK: - Initializers
    public init(name:String){
        self.id = Int64(Date().timeIntervalSince1970 * 1000)
        self.name = name
    }
    
    open func addInput(_ input:Input) -> Section{
        inputs.append(input)
        input.addInputListener(self)
        
        return self
    }
    
    open func addSectionListener(_ listener: SectionListener){
        sectionListeners.append(listener)
    }
    
    open func inputAtIndex(_ index: Int) -> Input {
        return inputs[index]
    }
    
    //Mark: - Notifications
    
    internal func notifyIfSectionInputValueChange(_ input: Input){
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
    
    open func setCurrentState(_ state:Bool){
        previousState = currentState
        currentState = state
    }

    open func submit(){
        submitted = true
        for input:Input in inputs{
            input.submit()
        }
    }
    
    open func validate() -> Bool{
        return inputs.reduce(true){
            $0 && $1.validate()
        }
    }
}



//MARK: - InputListener implementation
extension Section: InputListener {
    
    public func inputDidChangeState(_ input: Input) {
        setCurrentState(validate())
        notifyIfSectionStateChange()
    }
    
    public func inputDidChangeValue(_ input: Input) {
        dirty = true
        notifyIfSectionInputValueChange(input)
    }
    
    public func inputWasForceValidated(_ input: Input) {
        
    }
    
    public func inputWasSubmitted(_ input: Input) {
        
    }
}
