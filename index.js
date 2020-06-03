import React, { forwardRef } from 'react'
import { requireNativeComponent } from 'react-native'
const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLogger')

const TextInputWithLogger = forwardRef(({ onChangeText, ...attr }, ref) => {
  const _onChangeText = (event) => {
    if (!onChangeText) return;
    onChangeText(event.nativeEvent.text);
  }
  return (
    <FTZTextInputWithLogger
      ref={ref}
      onChangeText={_onChangeText}
      leftButtonEnabled={!!attr.onLeftButtonPress}
      rightButtonEnabled={!!attr.onRightButtonPress}
      {...attr}
    />
  )
});

export { TextInputWithLogger }
