import React, { useState, forwardRef, useRef, useEffect } from 'react';
import { requireNativeComponent, Platform, TextInput } from 'react-native';

const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLogger');

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
  value,
  onChangeText,
  onLeftButtonPress,
  isLeftButtonDisabled,
  onRightButtonPress,
  isRightButtonDisabled,
  stepValue,
  onFocus,
  onBlur,
  suggestLabel,
  suggestValue,
  unitLabel,
  ...props
}, ref) => {
  const [mostRecentEventCount, setMostRecentEventCount] = useState(0);

  const handleChange = (e) => {
    onChangeText && onChangeText(e.nativeEvent.text);
    setMostRecentEventCount(e.nativeEvent.eventCount);
  };

  const innerRef = useRef(null);
  const combinedRef = useCombinedRef(innerRef, ref)

  useEffect(() => {
    // When unmounting we need to blur the input
    return () => combinedRef.current?.blur();
  }, [combinedRef]);

  return (
    <FTZTextInputWithLogger
      ref={combinedRef}
      onChange={e => handleChange(e)}
      text={value}
      stepValue={stepValue}
      onRightButtonPress={onRightButtonPress}
      isRightButtonDisabled={isRightButtonDisabled ?? !onRightButtonPress}
      onLeftButtonPress={onLeftButtonPress}
      isLeftButtonDisabled={isLeftButtonDisabled ?? !onLeftButtonPress}
      suggestLabel={suggestLabel}
      suggestValue={suggestValue}
      unitLabel={unitLabel}
      onFocus={() => {
        combinedRef.current?.focus();
        if(onFocus) onFocus();
      }}
      onBlur={() => {
        combinedRef.current?.blur();
        if(onBlur) onBlur();
      }}
      mostRecentEventCount={mostRecentEventCount}
      {...props}
    />
  );
});

export default Platform.OS === 'ios' ? TextInputWithLogger : TextInput
