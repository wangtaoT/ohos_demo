// Index.ets
import { router } from '@kit.ArkUI';
import { HashMap } from '@kit.ArkTS';

@Component
struct Page01 {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Row() {
          Text('返回')
            .onClick(() => {
              this.pageInfos.pop()
            })
        }
        .backgroundColor('#FFFE2442')
        .width("100%")
        .height('44')

        Row() {
          Image($r('app.media.icon_1'))
            .width('20vp')
            .aspectRatio(1)
          Row() {
            Text('湖畔居茶楼绿城丽江绿地旭辉旭辉城湖畔居茶楼绿城丽江绿地旭辉旭辉城')
              .maxLines(1)
              .fontSize('15fp')
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Image($r('app.media.icon_3'))
              .width('10vp')
              .aspectRatio(1)
          }
          .layoutWeight(1)
          .margin({ right: 10 })

          Image($r('app.media.icon_2'))
            .width('24vp')
            .aspectRatio(1)
        }
        .width('100%')
      }
    }
    .title('Page01')
    .hideTitleBar(true)
    .padding({ top: AppStorage.get<number>('statusBarHeight') })
  }
}

@Component
struct Dialog01 {
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    NavDestination() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(Color.Gray)
          .opacity(0.1)
          .onClick(() => {
            this.pageInfos.pop();
          })
        // Add controls for business processing
        Column() {
          Text('Dialog01')
            .fontSize(30)
            .fontWeight(2)
          Button('push Page01')
            .width('80%')
            .onClick(() => {
              this.pageInfos.pushPathByName('Page01', '');
            })
            .margin({ top: 10, bottom: 10 })
          Button('push Dialog01')
            .width('80%')
            .onClick(() => {
              this.pageInfos.pushPathByName('Dialog01', '');
            })
            .margin({ top: 10, bottom: 10 })
          Button('pop')
            .width('80%')
            .onClick(() => {
              this.pageInfos.pop();
            })
            .margin({ top: 10, bottom: 10 })
        }
        .padding(10)
        .width(250)
        .backgroundColor(Color.White)
        .borderRadius(10)
      }
    }
    .hideTitleBar(true)
    // Set the mode property of this NavDestination to DIALOG
    .mode(NavDestinationMode.DIALOG)
  }
}

@Entry
@Component
struct Index {
  @Provide('NavPathStack') pageInfos: NavPathStack = new NavPathStack()
  isLogin: boolean = false;

  @Builder
  PagesMap(name: string) {
    if (name == 'Page01') {
      Page01()
    } else if (name == 'Dialog01') {
      Dialog01()
    }
  }

  build() {
    Navigation(this.pageInfos) {
      Column() {
        Button('push Page01')
          .width('80%')
          .onClick(() => {
            this.pageInfos.pushPathByName('Page01', '');
          })
        Button('push flutter')
          .width('80%')
          .onClick(() => {
            // router.pushUrl({ url: 'pages/Three' })
            router.pushNamedRoute({
              name: 'FlutterEntryIndex', params: {
                entryPoint: 'page',
                params: { "a": "1", "b": "2" },
              }
            });
          })
        Button('商品详情')
          .width('80%')
          .onClick(() => {
            router.pushUrl({ url: 'pages/MallGoodsDetailPage' })
          })
        Button('发布动态')
          .width('80%')
          .onClick(() => {
            router.pushUrl({ url: 'pages/PublishDynamicPage' })
          })
      }
      .padding({ top: AppStorage.get<number>('statusBarHeight') })
    }
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
    .title('主页')
    .hideTitleBar(true)
    .navDestination(this.PagesMap)
  }
}

