import React, { useState, useEffect, useRef } from 'react';
import { View, TextInput, StyleSheet } from 'react-native';
import { TextInputWithLogger } from 'fitzpo-logging-keyboard';

const App: () => React$Node = () => {

  const [text0, setText0] = useState('200')
  const [text1, setText1] = useState('')
  const [text2, setText2] = useState('')
  const [text3, setText3] = useState('')

  const ref0 = useRef();
  const ref1 = useRef();
  const ref2 = useRef();

  useEffect(() => {
    console.log('0', text0)
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
        autocompleteLabel='Previous Set 3 Target'
        autocompleteValue={115.25}
        unit='lbs'
      />
      <TextInputWithLogger
        ref={ref1}
        style={styles.input}
        value={text3}
        onLeftButtonPress={() => ref0.current?.focus()}
      />
      <TextInput
        ref={ref2}
        style={styles.input}
        value={'I AM A REGULAR TEXT INPUT'}
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
