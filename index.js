import React, { forwardRef, useState } from 'react'
import { requireNativeComponent, Platform, TextInput } from 'react-native'
const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLogger')

const TextInputWithLogger = forwardRef(({ onChangeText, ...attr }, ref) => {
  const [latestEventTimeStamp, setLatestEventTimeStamp] = useState(0);
  const _onChangeText = (event) => {
    if (!onChangeText || event.timeStamp < latestEventTimeStamp) return;
    onChangeText(event.nativeEvent.text);
    setLatestEventTimeStamp(event.timeStamp);
  }
  if(Platform.OS === 'ios') {
    return (
      <FTZTextInputWithLogger
        ref={ref}
        onChangeText={_onChangeText}
        leftButtonEnabled={!!attr.onLeftButtonPress}
        rightButtonEnabled={!!attr.onRightButtonPress}
        {...attr}
      />
    )
  } else {
    //android is not implemented yet
    return <TextInput ref={ref} onChangeText={onChangeText} {...attr}/>
  }
});

export { TextInputWithLogger }
