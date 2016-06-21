# Features to Implement before going to Version 1.0.0

- [Inputs](#Inputs)
- [Sections](#Sections)
- [Forms](#forms)

## Inputs
- Option to set an input as hidden or as visible. When an input is set as hidden, it should not be accounted for in the inputs to display
- The getValue() function does not make a Swifty API
- Provide getters for value, previousValue and originalValue
- Change the ValidatorProtocol on SwiftValidators: instead of the getValue() function it should rely on the value getter.
- Move the hint variable for the TextInput to the Input class so that it is available to all subclasses.
- Remove the description variable from SelectInput and SwitchInput (it should be replaced with the hint)
- 

## Sections
- Option to set an entire section as hidden or visible. When a section is set as hidden it should be accounted for in the sections to display
- .numberOfInputs should return the number of the visible inputs only
- .inputAtIndex() should return the visible input onlu
- have a way to access hidden inputs

## Forms
- Ability to search for an input or section using its name or ID.
- (Possible) Have a generic implementation of Form, e.g: Form<T>
