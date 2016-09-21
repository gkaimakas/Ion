//
//  Form.swift
//  Pods
//
//  Created by George Kaimakas on 11/18/15.
//
//

open class Form {
    open let id: Int64
    open let name: String
    
    fileprivate var dirty = false
    fileprivate var submitted = false
    fileprivate var currentState = false
    fileprivate var previousState = false
    
    fileprivate var sections = [Section]()
    fileprivate var formListeners = [FormListener]()
    
    //MARK: - Computed Properties
    
    open var data: [String: Any]{
        return sections.map{
            $0.data
            }.reduce([String:Any]()) { (result:[String: Any], data:[String : Any]) -> [String:Any] in
				var _result = result
                for (key, value) in data{
                    _result[key] = value
                }

                return _result
        }
    }
    
    open var errors:[String]? {
        let errorList = sections.map{
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
    
    open var isSubmitted: Bool{
        return submitted
    }
    
    open var isValid:Bool {
        return validate()
    }
    
    open var numberOfSections:Int {
        return sections.count
    }
    
    //MARK: - Initializers
    public init(name:String){
        self.id = Int64(Date().timeIntervalSince1970 * 1000)
        self.name = name
    }
    
    open func addSection(_ section: Section) -> Form{
        sections.append(section)
        section.addSectionListener(self)
        return self
    }
    
    open func addFormListener(_ listener: FormListener){
        formListeners.append(listener)
    }
    
    open func sectionAtIndex(_ index: Int) -> Section{
        return sections[index]
    }
	
	open func dataAs<T: DictionaryInitProtocol>(_ type: T.Type) -> T? {
		return T(dictionary: self.data)
	}
    
    //MARK: - Notifications
    
    open func notifyIfFormInputValueChange(_ section: Section, input:Input){
        for listener: FormListener in formListeners{
            listener.formIputDidChangeValue(self,section: section, input: input)
        }
    }
    
    open func notifyIfFormStateChange(){
        for listener: FormListener in formListeners{
            listener.formDidChangeState(self)
        }
    }
    
    open func notifyIfFormSubmitted(){
        for listener: FormListener in formListeners{
            listener.formWasSubmitted(self)
        }
    }
    
    open func setCurrentState(_ state:Bool){
        previousState = currentState
        currentState = state
    }
    
    open func submit(){
        for section: Section in sections{
            section.submit()
        }
        submitted = true
        notifyIfFormSubmitted()
    }
    
    open func validate() -> Bool {
        return sections.reduce(true){
            $0 && $1.validate()
        }
    }
}

//MARK: - SectionListener Implementation

extension Form: SectionListener {
    
    public func sectionInputDidChangeValue(_ section: Section, input: Input) {
        dirty = true
        notifyIfFormInputValueChange(section, input: input)
    }
    
    public func sectionDidChangeState(_ section: Section) {
        setCurrentState(validate())
    }
    
    public func sectionWasSubmitted(_ section: Section) {
        
    }
    
    
}
