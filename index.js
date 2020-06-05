import React, { forwardRef, useState, useEffect } from 'react'
import { requireNativeComponent, Platform, TextInput } from 'react-native'
const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLogger')

const TextInputWithLogger = forwardRef(({ onChangeText, value, ...attr }, ref) => {
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
        ref={ref}
        onChangeText={_onChangeText}
        leftButtonEnabled={!!attr.onLeftButtonPress}
        rightButtonEnabled={!!attr.onRightButtonPress}
        value={innerValue}
        {...attr}
      />
    )
  } else {
    //android is not implemented yet
    return <TextInput ref={ref} onChangeText={onChangeText} value={value} {...attr}/>
  }
});

export { TextInputWithLogger }
