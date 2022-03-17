import React, { MutableRefObject, LegacyRef, useState, forwardRef, useRef, useEffect } from 'react';
import { requireNativeComponent, Platform, TextInput } from 'react-native';

const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLoggingKeyboard');

function useCombinedRef<T>(
  ...refs: Array<LegacyRef<T> | MutableRefObject<T>>
) {
  const combinedRef = useRef<T>(null);

  useEffect(() => {
    refs.forEach(ref => {
      if (!ref) {
        return;
      }

      if (typeof ref === 'function') {
        ref(combinedRef.current);
      } else {
        (ref as MutableRefObject<T | null>).current = combinedRef.current;
      }
    });
  }, [refs]);

  return combinedRef;
}


const TextInputWithLogger = forwardRef<any, any>(({
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
  const [mostRecentEventCount, setMostRecentEventCount] = useState<number>(0);

  const handleChange = (e) => {
    onChangeText && onChangeText(e.nativeEvent.text);
    setMostRecentEventCount(e.nativeEvent.eventCount);
  };

  const innerRef = useRef(null)
  const combinedRef = useCombinedRef(innerRef, ref)

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
