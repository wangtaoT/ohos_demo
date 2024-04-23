import FlutterEntry from '@ohos/flutter_ohos/src/main/ets/embedding/ohos/FlutterEntry';
import FlutterEngine from '@ohos/flutter_ohos/src/main/ets/embedding/engine/FlutterEngine';
import MethodChannel, {
  MethodCallHandler,
  MethodResult
} from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import CppMainChannelHandler from './CppMainChannelHandler';

export default class BaseFlutterEntry extends FlutterEntry {
  private methodChannel: MethodChannel | null = null;
  entryPoint: string = ''
  routeParams: Map<string, string> = new Map<string, string>();

  constructor(context: Context, entryPoint: string, routeParams: Map<string, string>) {
    super(context);
    this.entryPoint = entryPoint
    this.routeParams = routeParams
  }

  //传递参数
  getDartEntrypointArgs(): string[] {
    let map = new Map<string, string>()
    map.set('', this.mapToString(this.routeParams))
    return new Array(this.mapToString(map));
  }

  //flutter 页面路由
  getDartEntrypointFunctionName(): string {
    return this.entryPoint
  }

  mapToString(map: Map<string, string>): string {
    if (map.size === 0) {
      return '';
    }
    let obj: object = new Object;
    map.forEach((value, key) => {
      obj[key] = value;
    })
    return JSON.stringify(obj);
  }

  configureFlutterEngine(flutterEngine: FlutterEngine): void {
    this.methodChannel = new MethodChannel(flutterEngine.dartExecutor.getBinaryMessenger(), 'com.cpp_flutter.channel');
    this.methodChannel?.setMethodCallHandler(new CppMainChannelHandler());
    // NativeNetApi.setup(flutterEngine.dartExecutor, new NativeNetApiImp())
  }

  // aboutToDisappear(): void {
  //   super.aboutToDisappear()
  //   this.methodChannel?.setMethodCallHandler(null)
  // }
}