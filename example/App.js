import React, { useState, useEffect } from 'react';
import { View, TextInput, StyleSheet } from 'react-native';
import { ExerciseSetInput } from 'fitzpo-logging-keyboard';

const App: () => React$Node = () => {

  const [text0, setText0] = useState('')
  const [text1, setText1] = useState('')
  const [text2, setText2] = useState('')

  return (
    <View style={styles.container}>
      <ExerciseSetInput
        style={styles.input}
        value={text0}
        onChangeText={setText0}
      />
      <ExerciseSetInput
        style={styles.input}
        value={text1}
        onChangeText={setText1}
      />
      <TextInput
        style={styles.input}
        value={text2}
        onChangeText={setText2}
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
