import router from '@ohos.router'

@Entry
@Component
struct MallGoodsDetailPage {
  build() {
    Column() {
      Stack() {
        List() {
          ListItem() {
            Swiper() {

            }.aspectRatio(1 / 1)
            .width('100%')
            .backgroundColor(Color.White)
          }

          ListItem() {
            Column() {
              Text() {
                Span('¥').fontSize('15fp').fontColor('#FFFE2442')
                Span('100.50').fontSize('24fp').fontColor('#FFFE2442')
                  .fontWeight(FontWeight.Bold)
              }
            }.width('100%').alignItems(HorizontalAlign.Start)
          }

          ListItem() {
            Text() {
              ImageSpan($r('app.media.icon_mall')).width(41).aspectRatio(41 / 18)
              Span('Go! Solutions猫粮进口无谷九种肉全猫粮美Go! Solutions猫粮进口无谷九种肉全猫粮美')
                .fontSize('16fp')
                .fontColor('#FF252525')
            }
          }

        }.width('100%').height('100%').backgroundColor('#ff58b87c')

        Row() {
          Text('返回').backgroundColor(Color.Red)
            .onClick(() => {
              router.back()
            })
          Text('分享').backgroundColor(Color.Red)
        }.width('100%').height(50).backgroundColor('#ffc3f6aa').justifyContent(FlexAlign.SpaceBetween)
      }
      .layoutWeight(1)
      .alignContent(Alignment.TopStart)

      Row() {
        Text('aaaaa')
      }
      .width('100%')
      .height('40')
      .backgroundColor(Color.Red)
    }
    .height('100%')
    .width('100%')
  }
}