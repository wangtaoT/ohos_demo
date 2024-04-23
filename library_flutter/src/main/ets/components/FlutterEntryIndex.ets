import Log from '@ohos/flutter_ohos/src/main/ets/util/Log';
import { FlutterView } from '@ohos/flutter_ohos/src/main/ets/view/FlutterView';
import { FlutterPage } from '@ohos/flutter_ohos';
import BaseFlutterEntry from './BaseFlutterEntry';
import { router } from '@kit.ArkUI';

@Entry({ routeName: 'FlutterEntryIndex' })
@Component
export struct FlutterEntryIndex {
  private flutterEntry: BaseFlutterEntry | null = null;
  private flutterView?: FlutterView
  entryPoint: string = ''
  params: Map<string, string> = new Map<string, string>()

  aboutToAppear() {
    if (router.getParams() != null) {
      let data = router.getParams() as Record<string, Object>

      let entryPoint: string = data?.['entryPoint'] as string
      let params = new Map<string, string>(Object.entries(data?.['params']))
      if (entryPoint) {
        this.entryPoint = entryPoint
      }
      if (params && params.size > 0) {
        this.params = params
      }
    }

    this.flutterEntry = new BaseFlutterEntry(getContext(this), this.entryPoint, this.params)
    this.flutterEntry.aboutToAppear()
    this.flutterView = this.flutterEntry.getFlutterView()
    Log.d("Flutter", "Index aboutToAppear===");
  }

  aboutToDisappear() {
    Log.d("Flutter", "Index aboutToDisappear===");
    this.flutterEntry?.aboutToDisappear()
  }

  onPageShow() {
    Log.d("Flutter", "Index onPageShow===");
    this.flutterEntry?.onPageShow()
  }

  onPageHide() {
    Log.d("Flutter", "Index onPageHide===");
    this.flutterEntry?.onPageHide()
  }

  build() {
    Column() {
      FlutterPage({ viewId: this.flutterView?.getId() })
    }
    .backgroundColor(Color.White)
  }
}