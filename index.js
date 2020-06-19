import React, { forwardRef, useState, useEffect, useRef } from 'react'
import { requireNativeComponent, Platform, TextInput } from 'react-native'
const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLogger')

const useCombinedRef = (...refs) => {
  const combinedRef = useRef();

  useEffect(() => {
    refs.forEach(ref => {
      if (!ref) return

      if (typeof ref === 'function') {
        ref(combinedRef.current)
      } else {
        ref.current = combinedRef.current
      }
    })
  }, [refs])

  return combinedRef
}

const TextInputWithLogger = forwardRef(({
  onChangeText,
  value,
  onFocus,
  ...attr
}, ref) => {

  const innerRef = useRef(null)
  const combinedRef = useCombinedRef(innerRef, ref)

  const [latestEventTimeStamp, setLatestEventTimeStamp] = useState(0);
  const [innerValue, setInnerValue] = useState('');
  const _onChangeText = (event) => {
    if (!onChangeText || event.timeStamp < latestEventTimeStamp) return;
    onChangeText(event.nativeEvent.text);
    setLatestEventTimeStamp(event.timeStamp);
  }

  useEffect(() => {
    setTimeout(() => setInnerValue(value), 50);
  }, [value]);

  if(Platform.OS === 'ios') {
    return (
      <FTZTextInputWithLogger
        ref={combinedRef}
        onChangeText={_onChangeText}
        leftButtonEnabled={!!attr.onLeftButtonPress}
        rightButtonEnabled={!!attr.onRightButtonPress}
        value={innerValue}
        onFocus={() => {
          combinedRef.current?.focus();
          if(!!onFocus) onFocus();
        }}
        {...attr}
      />
    )
  } else {
    //android is not implemented yet
    return (
      <TextInput
        ref={ref}
        onChangeText={onChangeText}
        onFocus={onFocus}
        value={value}
        {...attr}
      />
    )
  }
});

export { TextInputWithLogger }
