import React, {useState, useRef} from 'react';
import {StyleSheet, View, Button} from 'react-native';
import TextInputWithLogger from 'react-native-fitzpo-logging-keyboard';

export default function App() {
  const [text, setText] = useState('test');

  const [isRightButtonDisabled, setIsRightButtonDisabled] = useState(false);

  const inputRef = useRef<TextInput>();
  const inputRef2 = useRef<TextInput>();

  console.log(text);
  console.log(isRightButtonDisabled);

  return (
    <View style={styles.container}>
      <Button
        title="toggle right enable"
        onPress={() => setIsRightButtonDisabled(val => !val)}
      />
      <Button title="focus" onPress={() => inputRef.current?.focus()} />
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
      <TextInputWithLogger
        ref={inputRef2}
        style={{width: 120, backgroundColor: 'gray'}}
        onChangeText={text => setText(text)}
        value={text}
        stepValue={2.5}
        onFocus={() => console.log('focus')}
        suggestLabel="Target"
        unitLabel="lbs"
        onLeftButtonPress={() => inputRef.current?.focus()}
        suggestValue={15}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
