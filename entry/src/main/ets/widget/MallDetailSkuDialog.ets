@CustomDialog
export struct MallDetailSkuDialog {
  controller?: CustomDialogController;

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_goods')).height(60).width(60).borderRadius(5)
        Blank()
        Text('关闭')
          .onClick(() => {
            this.controller?.close()
          })
      }
      .width('100%')
      .padding({ left: 13, right: 13 })

      //规格
      List() {
        ListItem() {
          Column() {
            Text('规格').fontSize('13fp').fontColor('#FF1F1F1F')
            Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
              this.getSkuItemView()
              this.getSkuItemView()
              this.getSkuItemView()
            }.margin({ top: 12 })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(8)
          .alignItems(HorizontalAlign.Start)
          .padding({ top: 15, bottom: 15, left: 12, right: 12 })
          .margin({ left: 8, right: 8, top: 13 })
        }
      }.constraintSize({ minHeight: 200, maxHeight: 600 })

      Row() {
        Button('立即购买', { type: ButtonType.Normal })
          .fontColor(Color.White)
          .fontSize('16fp')
          .margin({ top: 12, bottom: 12 })
          .backgroundColor($r('app.color.mall_theme_color'))
          .width('100%')
          .borderRadius(22)
      }
      .backgroundColor(Color.White)
      .width('100%')
      .margin({ top: 10 })
      .padding({ bottom: AppStorage.get<number>('naviIndicatorHeight'), left: 20, right: 20 })
    }
    .backgroundColor('#FFF7F8FC')
    .borderRadius({ topLeft: 16, topRight: 16 })
  }

  @Builder
  getSkuItemView() {
    Text('1fgfgfgfg1fgfgfgfg1fgfgfgfg')
      .padding({ top: 8, bottom: 8, left: 13, right: 13 })
      .backgroundColor('#FFFFF2F0')
      .fontColor('#FFFE2442')
      .borderWidth(0.5)
      .borderColor('#FFFE2442')
      .borderRadius(5)
      .margin({ right: 8, bottom: 8 })
  }
}