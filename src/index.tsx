import React, { useState } from 'react';
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
  const [mostRecentEventCount, setMostRecentEventCount] = useState<number>(0);

  const handleChange = (e) => {
    onChangeText && onChangeText(e.nativeEvent.text);
    setMostRecentEventCount(e.nativeEvent.eventCount);
  };

  return (
    <FTZTextInputWithLogger
      onChange={e => handleChange(e)}
      text={value}
      mostRecentEventCount={mostRecentEventCount}
      {...props}
    />
  );
};

export default TextInputWithLogger;
