import { MethodCall } from '@ohos/flutter_ohos';
import { MethodCallHandler, MethodResult } from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import { promptAction } from '@kit.ArkUI';

export default class CppMainChannelHandler implements MethodCallHandler {
  onMethodCall(call: MethodCall, result: MethodResult): void {
    switch (call.method) {
      case 'showInfo':
        let msg = call.argument('msg') as string
        promptAction.showToast({
          message: msg,
          duration: 2000
        });
        result.notImplemented
        break;
    }
  }
}