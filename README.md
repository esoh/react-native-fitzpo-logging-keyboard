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
    suggestLabel='testing'
    suggestValue={15}
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
