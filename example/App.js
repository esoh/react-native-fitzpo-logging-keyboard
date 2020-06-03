import React, { useState, useEffect, useRef } from 'react';
import { View, TextInput, StyleSheet } from 'react-native';
import { TextInputWithLogger } from 'fitzpo-logging-keyboard';

const App: () => React$Node = () => {

  const [text0, setText0] = useState('')
  const [text1, setText1] = useState('')
  const [text2, setText2] = useState('')
  const [text3, setText3] = useState('')

  const ref0 = useRef();
  const ref1 = useRef();
  const ref2 = useRef();

  useEffect(() => {
    console.log('1', text1)
    console.log('2', text2)
    console.log('3', text3)
  })

  /* only supports value, onChangeText */

  return (
    <View style={styles.container}>
      <TextInputWithLogger
        ref={ref0}
        style={styles.input}
        value={text0}
        onChangeText={setText0}
        onRightButtonPress={() => ref1.current?.focus()}
        onLeftButtonPress={() => console.log('RAAT')}
      />
      <TextInputWithLogger
        ref={ref1}
        style={styles.input}
        value={text3}
        onLeftButtonPress={() => ref0.current?.focus()}
        onRightButtonPress={() => ref2.current?.focus()}
      />
      <TextInput
        ref={ref2}
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
