import React, { useState } from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import TextInputWithLogger from 'react-native-fitzpo-logging-keyboard';

export default function App() {

  const [text, setText] = useState('test');

  const [isRightButtonDisabled, setIsRightButtonDisabled] = useState(false);

  console.log(text);
  console.log(isRightButtonDisabled);

  return (
    <View style={styles.container}>
      <Button title='toggle right enable' onPress={() =>
        setIsRightButtonDisabled(val => !val)}/>
      <TextInputWithLogger
        style={{ width: 120, backgroundColor: 'gray' }}
        onChangeText={text => setText(text)}
        value={text}
        isRightButtonDisabled={isRightButtonDisabled}
        onRightButtonPress={() => console.log('right', isRightButtonDisabled)}
        stepValue={2.5}
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
