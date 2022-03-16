import {
  requireNativeComponent,
  UIManager,
  Platform,
  ViewStyle,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-fitzpo-logging-keyboard' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type FitzpoLoggingKeyboardProps = {
  color: string;
  style: ViewStyle;
};

const ComponentName = 'FitzpoLoggingKeyboardView';

export const FitzpoLoggingKeyboardView =
  UIManager.getViewManagerConfig(ComponentName) != null
    ? requireNativeComponent<FitzpoLoggingKeyboardProps>(ComponentName)
    : () => {
        throw new Error(LINKING_ERROR);
      };
