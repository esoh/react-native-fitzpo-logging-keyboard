// @ts-nocheck
import React, { useState, forwardRef, useRef, useEffect } from 'react';
import { requireNativeComponent } from 'react-native';

type TextInputWithLoggerProps = {
  value?: string;
  onChangeText?: (text: string) => void;
};

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

export default TextInputWithLogger;
