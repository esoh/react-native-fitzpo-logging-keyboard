import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import TextInputWithLogger from 'react-native-fitzpo-logging-keyboard';

export default function App() {

  return (
    <TextInputWithLogger style={{ flex: 1 }}/>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
