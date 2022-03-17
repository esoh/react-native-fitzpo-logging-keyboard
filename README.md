# react-native-fitzpo-logging-keyboard

Don't run `yarn install` in the root project!! It prevents the example app from
running correctly.

## Getting started

`$ npm install react-native-fitzpo-logging-keyboard --save`

### Mostly automatic installation

`$ react-native link react-native-fitzpo-logging-keyboard`

## Usage
```javascript
import TextInputWithLogger from 'react-native-fitzpo-logging-keyboard';

export default class App extends Component<{}> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          ☆FTZTextInputWithLoggingKeyboard example☆
        </Text>
        <TextInputWithLogger
          ref={inputRef}
          style={{width: 120, backgroundColor: 'gray'}}
          onChangeText={text => setText(text)}
          value={text}
          isRightButtonDisabled={isRightButtonDisabled}
          onRightButtonPress={() => inputRef2.current?.focus()}
          stepValue={2.5}
          onFocus={() => console.log('focus')}
          suggestLabel="Target"
          unitLabel="lbs"
          suggestValue={15}
          primaryColor="red"
          topBarBackgroundColor="#00ff0066"
          keyboardBackgroundColor="rgba(0, 0, 255, 1)"
          textColor="rgb(255, 255, 0)"
          textMutedColor="rgb(0, 255, 255)"
        />
      </View>
    );
  }
}
```
