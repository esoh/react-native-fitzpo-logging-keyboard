import React, { MutableRefObject, LegacyRef, useState, forwardRef, useRef, useEffect } from 'react';
import { TextInputChangeEventData, NativeSyntheticEvent, ColorValue, requireNativeComponent, Platform, TextInput, processColor, TextInputProps } from 'react-native';

interface TextInputWithLoggingKeyboardProps extends TextInputProps {
  value: string;
  onChangeText: (text: string) => void;

  onLeftButtonPress: () => void;
  onRightButtonPress: () => void;
  isLeftButtonDisabled?: boolean;
  isRightButtonDisabled?: boolean;

  stepValue?: number;

  onFocus: () => void;
  onBlur: () => void;

  suggestLabel?: string;
  suggestValue?: number;
  unitLabel?: string;

  primaryColor?: ColorValue;
  topBarBackgroundColor?: ColorValue;
  keyboardBackgroundColor?: ColorValue;
  textColor?: ColorValue;
  textMutedColor?: ColorValue;
}

interface TextInputWithLoggingKeyboardData extends TextInputChangeEventData {
  text: string;
  eventCount: number;
}

export interface TextInputWithLoggingKeyboardHandle extends TextInput {}

interface FTZTextInputWithLoggerProps extends TextInputProps {
  value: string;
  onChange: (e: NativeSyntheticEvent<TextInputWithLoggingKeyboardData>) => void;

  onLeftButtonPress: () => void;
  onRightButtonPress: () => void;
  isLeftButtonDisabled?: boolean;
  isRightButtonDisabled?: boolean;

  stepValue?: number;

  onFocus: () => void;
  onBlur: () => void;

  suggestLabel?: string;
  suggestValue?: number;
  unitLabel?: string;

  primaryColor?: number;
  topBarBackgroundColor?: number;
  keyboardBackgroundColor?: number;
  textColor?: number;
  textMutedColor?: number;
}

const FTZTextInputWithLogger = requireNativeComponent<FTZTextInputWithLoggerProps>('FTZTextInputWithLoggingKeyboard');

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

const normalizeColor = (color: ColorValue | undefined) => {
  if (!color) return undefined;
  const processed = processColor(color);
  if (typeof processed === 'number') {
    return ((processed << 8) | (processed >>> 24)) >>> 0;
  }
  return undefined;
}

const TextInputWithLoggingKeyboard = forwardRef<TextInputWithLoggingKeyboardHandle, TextInputWithLoggingKeyboardProps>(({
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

  primaryColor,
  topBarBackgroundColor,
  keyboardBackgroundColor,
  textColor,
  textMutedColor,
  ...props
}, ref) => {
  const [mostRecentEventCount, setMostRecentEventCount] = useState<number>(0);

  const handleChange = (e: NativeSyntheticEvent<TextInputWithLoggingKeyboardData>) => {
    onChangeText && onChangeText(e.nativeEvent.text);
    setMostRecentEventCount(e.nativeEvent.eventCount);
  };

  const innerRef = useRef(null)
  const combinedRef = useCombinedRef(innerRef, ref)

  return (
    <FTZTextInputWithLogger
      // @ts-ignore
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

      primaryColor={normalizeColor(primaryColor)}
      topBarBackgroundColor={normalizeColor(topBarBackgroundColor)}
      keyboardBackgroundColor={normalizeColor(keyboardBackgroundColor)}
      textColor={normalizeColor(textColor)}
      textMutedColor={normalizeColor(textMutedColor)}
      {...props}
    />
  );
});

export default Platform.OS === 'ios' ? TextInputWithLoggingKeyboard : TextInput
