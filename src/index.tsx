import React, { MutableRefObject, LegacyRef, useState, forwardRef, useRef, useEffect } from 'react';
import { TextInputChangeEventData, NativeSyntheticEvent, ColorValue, requireNativeComponent, Platform, TextInput, processColor, TextInputProps } from 'react-native';

interface TextInputWithLoggingKeyboardProps extends TextInputProps {
  value: string;
  onChangeText: (text: string) => void;

  onLeftButtonPress?: () => void;
  onRightButtonPress?: () => void;
  isLeftButtonDisabled?: boolean;
  isRightButtonDisabled?: boolean;

  stepValue?: number;

  onFocus?: () => void;
  onBlur?: () => void;

  suggestLabel?: string;
  suggestValue?: number;
  unitLabel?: string;

  primaryColor?: ColorValue;
  topBarBackgroundColor?: ColorValue;
  keyboardBackgroundColor?: ColorValue;
  textColor?: ColorValue;
  textMutedColor?: ColorValue;

  shouldDisplayAsTime?: boolean;
}

interface TextInputWithLoggingKeyboardData extends TextInputChangeEventData {
  text: string;
  eventCount: number;
}

export interface TextInputWithLoggingKeyboardHandle extends TextInput {}

interface FTZTextInputWithLoggerProps extends TextInputProps {
  value: string;
  onChange: (e: NativeSyntheticEvent<TextInputWithLoggingKeyboardData>) => void;

  onLeftButtonPress?: () => void;
  onRightButtonPress?: () => void;
  isLeftButtonDisabled?: boolean;
  isRightButtonDisabled?: boolean;

  stepValue?: number;

  onFocus?: () => void;
  onBlur?: () => void;

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

/** @param text - any number with colons in it */
const formatAsTime = (text: string) => {
  if (!text) {
    return text;
  }

  /**
   * Our goal is to take cleanedText
   * and add in colons as appropriate.
   * (we add in extra 0s up to the minute mark)
   *
   * 1        => 0:01
   * 10       => 0:10
   * .        => 0:00.
   * .7       => 0:00.7
   * 999.07   => 9:99.07
   * 0335.07  => 3:35.07
   *
   * Note: We know that 9:99.07 is not a valid time.
   * We'll correct this during the onBlur function.
   */
  const cleanedText = text.replaceAll(':', '');
  const partsOfNumber = cleanedText.split('.');
  const decimalPart = partsOfNumber[1] !== undefined ? '.' + partsOfNumber[1] : '';
  let integerPart = partsOfNumber[0] !== undefined ? partsOfNumber[0] : '';
  integerPart = isNaN(parseInt(integerPart, 10)) ? integerPart : parseInt(integerPart, 10).toString();
  integerPart = integerPart.padStart(3, '0');
  integerPart = integerPart.slice(0, integerPart.length - 2) + ':' + integerPart.slice(integerPart.length - 2);
  // yxx:xx => y:xx:xx
  if (integerPart.length >= 6) {
    integerPart = integerPart.slice(0, integerPart.length - 5) + ':' + integerPart.slice(integerPart.length - 5);
  }
  return integerPart + decimalPart;
};

const normalizeTime = (text: string) => {
  if (text === '') {
    return '';
  }

  let hours = 0;
  let minutes = 0;
  let seconds = 0;

  const decimalSplits = text.split('.');
  const decimalPartString = decimalSplits[1] === undefined ? '' : '.' + decimalSplits[1];

  if (decimalSplits[0] === undefined || decimalSplits[0] === '') {
    return '0:00' + decimalPartString;
  }

  const timeParts = decimalSplits[0].split(':');
  if (timeParts.length === 1) {
    seconds += parseInt(timeParts[0], 10);
  } else if (timeParts.length === 2) {
    minutes += parseInt(timeParts[0], 10)
    seconds += parseInt(timeParts[1], 10)
  } else if (timeParts.length === 3) {
    hours += parseInt(timeParts[0], 10);
    minutes += parseInt(timeParts[1], 10)
    seconds += parseInt(timeParts[2], 10)
  }

  if (seconds > 60) {
    minutes += Math.trunc(seconds / 60);
    seconds %= 60;
  }

  if (minutes > 60) {
    hours += Math.trunc(minutes / 60);
    minutes %= 60;
  }

  if (hours > 0) {
    return `${hours}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}${decimalPartString}`;
  }
  return `${minutes}:${seconds.toString().padStart(2, '0')}${decimalPartString}`;
};

const convertSecondsToTimeDisplayString = (numSeconds: number) => {
  let curr = numSeconds;

  let seconds = 0;
  let minutes = 0;

  seconds += curr % 60;
  curr = Math.trunc(curr / 60);

  minutes += curr % 60;
  curr = Math.trunc(curr / 60);

  const hours = curr;

  if (hours > 0) {
    return `${hours}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }
  return `${minutes}:${seconds.toString().padStart(2, '0')}`;
};

const convertTimeDisplayStringToSecondsString = (timeString: string) => {
  if (!timeString.includes(':')) {
    return '';
  }

  let seconds = 0;

  const timeParts = timeString.split(':');
  if (timeParts.length === 1) {
    seconds += parseInt(timeParts[0], 10);
    return seconds.toString();
  } else if (timeParts.length === 2) {
    seconds += parseInt(timeParts[0], 10) * 60;
    seconds += parseInt(timeParts[1], 10);
    return seconds.toString();
  } else if (timeParts.length === 3) {
    seconds += parseInt(timeParts[0], 10) * 60 * 60;
    seconds += parseInt(timeParts[1], 10) * 60;
    seconds += parseInt(timeParts[2], 10);
    return seconds.toString();
  }

  return '';
};

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
  shouldDisplayAsTime,

  primaryColor,
  topBarBackgroundColor,
  keyboardBackgroundColor,
  textColor,
  textMutedColor,
  ...props
}, ref) => {
  const [mostRecentEventCount, setMostRecentEventCount] = useState<number>(0);

  const handleChange = (e: NativeSyntheticEvent<TextInputWithLoggingKeyboardData>) => {
    const text = e.nativeEvent.text;
    const formattedText = shouldDisplayAsTime ? formatAsTime(text) : text;
    onChangeText(formattedText);
    setMostRecentEventCount(e.nativeEvent.eventCount);
  };

  const innerRef = useRef(null)
  const combinedRef = useCombinedRef(innerRef, ref)

  const valueRef = useRef<typeof value>(value);
  useEffect(() => {
    valueRef.current = value;
  }, [value]);

  useEffect(() => {
    if (valueRef.current === '') {
      return;
    }

    if (shouldDisplayAsTime && !valueRef.current.includes(':')) {
      const v = parseFloat(valueRef.current);
      if (!isNaN(v)) {
        const newVal = convertSecondsToTimeDisplayString(Math.trunc(v * 60));
        onChangeText(newVal);
      } else {
        onChangeText('');
      }
    } else if (!shouldDisplayAsTime && valueRef.current.includes(':')) {
      const seconds = parseInt(convertTimeDisplayStringToSecondsString(valueRef.current), 10);
      if (!isNaN(seconds)) {
        const newVal = parseFloat((seconds / 60).toFixed(2));
        onChangeText(newVal.toString());
      } else {
        onChangeText('');
      }
    }
  }, [shouldDisplayAsTime]);

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
        if (shouldDisplayAsTime) {
          onChangeText(normalizeTime(value));
        }
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
