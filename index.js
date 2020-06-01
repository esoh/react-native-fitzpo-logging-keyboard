import React, {
  forwardRef,
  useImperativeHandle,
  useRef,
  useEffect,
} from 'react'
import {
  NativeModules,
  findNodeHandle,
  TextInput,
  AppRegistry,
  View,
  requireNativeComponent,
} from 'react-native'

const { LoggingKeyboard: { hijackInput } } = NativeModules;

const ExerciseSetInput = forwardRef((props, ref) => {

  const inputRef = useRef(null)

  useImperativeHandle(ref, () => ({
    focus: () => inputRef.current.focus(),
    blur: () => inputRef.current.blur(),
    onFocus: () => inputRef.current.onFocus(),
    onBlur: () => inputRef.current.onBlur(),
  }))

  useEffect(() => {
    if(inputRef.current) hijackInput(
      findNodeHandle(inputRef.current),
      msg => console.log('installMsg', msg))
  }, [inputRef?.current])

  return (
    <TextInput
      ref={inputRef}
      {...props}
    />
  )
})

const TextInputWithLogger = requireNativeComponent('TextInputWithLogger')

export {
  ExerciseSetInput,
  TextInputWithLogger,
};
