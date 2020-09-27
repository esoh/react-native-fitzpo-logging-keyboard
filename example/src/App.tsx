import React, { useState } from 'react';
import { StyleSheet, View, Text } from 'react-native';
import TextInputWithLogger from 'react-native-fitzpo-logging-keyboard';

export default function App() {

  const [text, setText] = useState('test');

  console.log(text);

  return (
    <View style={styles.container}>
      <TextInputWithLogger
        style={{ width: 120, backgroundColor: 'gray' }}
        onChangeText={text => setText(text)}
        value={text}
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
