# react-native-fitzpo-logging-keyboard

Don't run `yarn install` in the root project!! It prevents the example app from
running correctly.

## Getting started

`$ npm install react-native-fitzpo-logging-keyboard --save`

### Mostly automatic installation

`$ react-native link react-native-fitzpo-logging-keyboard`

## Usage
```javascript
import FTZTextInputWithLoggingKeyboard from 'react-native-fitzpo-logging-keyboard';

export default class App extends Component<{}> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          ☆FTZTextInputWithLoggingKeyboard example☆
        </Text>
        <FTZTextInputWithLoggingKeyboard />
      </View>
    );
  }
}
```
