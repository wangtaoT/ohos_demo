import { FlutterEntryIndex } from '@ohos/library_flutter/Index';

@Entry
@Component
export struct Three {
  @State currentTabIndex: number = 1
  private tabsController: TabsController = new TabsController();
  private map = new Map<string, string>();

  aboutToAppear(): void {
    this.map.set("a", "111111")
    this.map.set("b", "23232323")
  }

  build() {
    Column() {
      FlutterEntryIndex({ entryPoint: "page", params: this.map })
    }
  }
}