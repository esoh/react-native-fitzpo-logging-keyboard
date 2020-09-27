import * as React from 'react';
import { requireNativeComponent } from 'react-native';

type TextInputWithLoggerProps = {
  value?: string;
  onChangeText?: (text: string) => void;
};

const FTZTextInputWithLogger = requireNativeComponent('FTZTextInputWithLogger');

const TextInputWithLogger = ({
  value,
  onChangeText,
  ...props
}: TextInputWithLoggerProps) => {
  const handleChange = e => {
    onChangeText && onChangeText(e.nativeEvent.text);
  };

  return (
    <FTZTextInputWithLogger
      onChange={e => handleChange(e)}
      text={value}
      {...props}
    />
  );
};

export default TextInputWithLogger;
