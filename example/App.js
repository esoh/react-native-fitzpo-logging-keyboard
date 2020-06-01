import React, { useState, useEffect } from 'react';
import { View, TextInput, StyleSheet } from 'react-native';
import { TextInputWithLogger } from 'fitzpo-logging-keyboard';

const App: () => React$Node = () => {

  const [text0, setText0] = useState('')
  const [text1, setText1] = useState('')
  const [text2, setText2] = useState('')
  const [text3, setText3] = useState('')

  useEffect(() => {
    console.log('1', text1)
    console.log('2', text2)
    console.log('3', text3)
  })

  /* only supports value, onChangeText */

  return (
    <View style={styles.container}>
      <TextInputWithLogger
        style={styles.input}
        value={text1}
        onChangeText={setText1}
        onCustomCallbackButtonPress={() => console.log('hey')}
      />
      <TextInputWithLogger
        style={styles.input}
        value={text3}
      />
      <TextInput
        style={styles.input}
        value={text3}
        onChangeText={setText3}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  input: {
    width: 200,
    margin: 10,
    borderBottomWidth: 1,
    borderColor: 'black'
  },
});

export default App;
