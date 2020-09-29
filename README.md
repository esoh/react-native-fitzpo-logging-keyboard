# fitzpo-logging-keyboard

## Getting started

`$ npm install fitzpo-logging-keyboard --save`

### Mostly automatic installation

`$ react-native link fitzpo-logging-keyboard`

## Usage
```javascript
import { TextInputWithLogger } from 'fitzpo-logging-keyboard';

const App = () => {
  <TextInputWithLogger
    ref={ref}
    onChangeText={text => setState(text)}
    value={text}
    autocompleteLabel='testing'
    autocompleteValue={15}
    unitLabel='lbs'
    stepValue={1}
    isLeftButtonDisabled
    onLeftButtonPress={() => console.log('do stuff')}
    isRightButtonDisabled
    onRightButtonPress={() => console.log('do stuff')}
    onBlur={() => console.log('blur')}
    onFocus={() => console.log('focus')}
  />
}
```

### Important things to note
Changing react-native value prop will update the native value, which will then trigger the onChangeText.

Any change you make in the text field will trigger onChangeText as well.

It is expected that onChangeText will modify the value that is being passed in by the value prop.
