import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { AbilityConstant, Want } from '@kit.AbilityKit';
import '@ohos/library_flutter/Index';


import FlutterManager from '@ohos/library_flutter/oh_modules/@ohos/flutter_ohos/src/main/ets/embedding/ohos/FlutterManager';
import Logger from '@ohos/commons/src/main/ets/utils/Logger';
import { WindowUtil } from '@ohos/commons/Index';
import { AppConstants } from '../AppConstants';

// import FlutterManager from '@ohos/flutter_ohos/src/main/ets/embedding/ohos/FlutterManager';


let localStorage: LocalStorage = new LocalStorage();

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    FlutterManager.getInstance().pushUIAbility(this)
  }

  onDestroy(): void {
    FlutterManager.getInstance().popUIAbility(this)
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    WindowUtil.requestFullScreen(windowStage, this.context);
    windowStage.loadContent('pages/SplashPage', localStorage);

    FlutterManager.getInstance().pushWindowStage(this, windowStage)
  }

  onWindowStageRestore(windowStage: window.WindowStage): void {
    WindowUtil.requestFullScreen(windowStage, this.context);
  }

  onWindowStageDestroy(): void {
    FlutterManager.getInstance().popWindowStage(this)
  }
}