import router from '@ohos.router'
import { MallDetailSkuDialog } from '../widget/MallDetailSkuDialog';
import { PriceView } from '../widget/PriceView'

@Entry
@Component
struct MallGoodsDetailPage {
  skuDialog: CustomDialogController = new CustomDialogController({
    builder: MallDetailSkuDialog(),
    alignment: DialogAlignment.Bottom,
    autoCancel: true,
    customStyle: true
  });

  build() {
    Column() {
      Stack() {
        List() {
          ListItem() {
            this.getMallGoodsDetailTopImageWidget()
          }

          //价格区域
          ListItem() {
            Row() {
              Text() {
                Span('¥').fontSize('15fp').fontColor($r('app.color.mall_theme_color'))
                Span('100.50').fontSize('24fp').fontColor($r('app.color.mall_theme_color'))
                  .fontWeight(FontWeight.Bold)
              }

              Row() {
                Text() {
                  Span('预估到手').fontSize('12fp').fontColor(Color.White)
                }.padding({ top: 5, right: 2 })

                PriceView({ price: '999' })
              }
              .backgroundColor($r('app.color.mall_theme_color'))
              .borderRadius(22)
              .padding({ left: 12, right: 12, top: 4, bottom: 4 })
              .margin({ left: 8 })
            }.width('100%').padding({ left: 15 }).margin({ top: 16 })
          }

          //标题区域
          ListItem() {
            Column() {
              Text() {
                ImageSpan($r('app.media.icon_mall')).width(41).aspectRatio(41 / 18).margin({ right: 5 })
                Span('Go! Solutions猫粮进口无谷九种肉全猫粮美Go! Solutions猫粮进口无谷九种肉全猫粮美')
                  .fontSize('16fp')
                  .fontColor('#FF252525')
              }

              Text('24h发货')
                .fontSize('12fp')
                .fontColor($r('app.color.mall_theme_color'))
                .borderWidth('0.5')
                .borderColor('#FFFFCFD8')
                .backgroundColor(Color.White)
                .padding({ left: 4, right: 4, top: 1, bottom: 1 })
                .margin({ top: 6 })

              Text('已售99999').fontColor('#FF666666').fontSize('13fp').margin({ top: 6 })
            }.alignItems(HorizontalAlign.Start).margin({ left: 15, right: 8, top: 18 })
          }

          //选择区域
          ListItem() {
            Column() {
              Row() {
                Text('选择').fontColor('#FF666666').fontSize('13fp')
                Text('xxxxxxxxxxxx').fontColor('#FF333333').layoutWeight(1).margin({ left: 18 })
                Image($r('app.media.icon_arrow_right_FF999999')).width(12).height(12)
              }
              .padding({ top: 13, bottom: 13, left: 12, right: 8 })
              .onClick(() => {
                this.skuDialog.open()
              })

              Divider()
                .height(0.5)
                .color('#FFF8F8F8')
                .margin({ left: 12, right: 12 })
              Row() {
                Text('物流').fontColor('#FF666666').fontSize('13fp')
                Text('xxxxxxxxxxxx').fontColor('#FF333333').layoutWeight(1).margin({ left: 18 })
              }
              .padding({ top: 13, bottom: 13, left: 12, right: 8 })

              Divider()
                .height(0.5)
                .color('#FFF8F8F8')
                .margin({ left: 12, right: 12 })
              Row() {
                Text('参数').fontColor('#FF666666').fontSize('13fp')
                Text('xxxxxxxxxxxx').fontColor('#FF333333').layoutWeight(1).margin({ left: 18 })
                Image($r('app.media.icon_arrow_right_FF999999')).width(12).height(12)
              }
              .padding({ top: 13, bottom: 13, left: 12, right: 8 })
            }
            .layoutWeight(1)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ left: 8, right: 8, top: 13 })
          }

          ListItem() {
            Divider()
              .height(8)
              .width('100%')
          }

          ListItem() {
            Image($r('app.media.ic_goods')).width('100%')
          }

          ListItem() {
            Image($r('app.media.ic_goods')).width('100%')
          }

        }.width('100%').height('100%').backgroundColor('#FFF7F8FC').scrollBar(BarState.Off)


        this.getAppBarWidget()
      }
      .layoutWeight(1)
      .alignContent(Alignment.TopStart)

      this.getBottomBar()
    }
    .height('100%')
    .width('100%')
  }

  //appbar
  @Builder
  getAppBarWidget() {
    Row() {
      Image($r('app.media.icon_mall_detail_back')).width(26).height(26).onClick(() => {
        router.back()
      })
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: AppStorage.get<number>('statusBarHeight') })
    .padding({ left: 15, right: 15 })
  }

  /**
   * 轮播图
   */
  @Builder
  getMallGoodsDetailTopImageWidget() {
    Swiper() {
      Image($r('app.media.ic_goods')).width('100%')
      Image($r('app.media.ic_goods')).width('100%')
    }.aspectRatio(1 / 1)
    .width('100%')
    .backgroundColor(Color.White)
  }

  //底部操作区域
  @Builder
  getBottomBar() {
    Column() {
      Row() {
        Column() {
          Image($r('app.media.customer_service_icon')).width(22).height(22)
          Text('客服').fontColor('#FF666666').fontSize('10fp')
        }

        Column() {
        }.width(16)

        Column() {
          Image($r('app.media.un_collect_icon')).width(22).height(22)
          Text('收藏').fontColor('#FF666666').fontSize('10fp')
        }
        .constraintSize({
          minWidth: 40
        })

        Column() {
        }.width(16)

        Column() {
          Image($r('app.media.goods_detail_cart')).width(22).height(22)
          Text('购物车').fontColor('#FF666666').fontSize('10fp')
        }

        Row() {
          Button("加入购物车", { type: ButtonType.Normal })
            .fontColor($r('app.color.mall_theme_color'))
            .backgroundColor('#FFFFEFEF')
            .borderRadius({ topLeft: 22, bottomLeft: 22 })
            .layoutWeight(1)

          Button("立即购买", { type: ButtonType.Normal })
            .backgroundColor($r('app.color.mall_theme_color'))
            .borderRadius({ topRight: 22, bottomRight: 22 })
            .layoutWeight(1)
        }
        .layoutWeight(1)
        .margin({ left: 30 })
      }
      .height(56)
      .width('100%')
      .padding({ left: 10, right: 10 })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .padding({ bottom: AppStorage.get<number>('naviIndicatorHeight') })
  }
}