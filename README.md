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
    onLeftButtonPress={() => console.log('do stuff')}
    onRightButtonPress={() => console.log('do stuff')}
    autocompleteTitle='testing'
    autocompleteValue={15}
    stepValue={1}
  />
}
```

### Important things to note
Changing react-native value prop will update the native value, which will then trigger the onChangeText.

Any change you make in the text field will trigger onChangeText as well.

It is expected that onChangeText will modify the value that is being passed in by the value prop.
