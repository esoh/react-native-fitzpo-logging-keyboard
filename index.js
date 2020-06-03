import React, { forwardRef } from 'react'
import { requireNativeComponent, Platform } from 'react-native'
const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLogger')

const TextInputWithLogger = forwardRef(({ onChangeText, ...attr }, ref) => {
  const _onChangeText = (event) => {
    if (!onChangeText) return;
    onChangeText(event.nativeEvent.text);
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
