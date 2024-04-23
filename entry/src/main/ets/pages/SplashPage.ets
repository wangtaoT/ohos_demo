import { router } from '@kit.ArkUI';

@Entry
@Component
struct SplashPage {
  init(): void {
    setTimeout(() => {
      this.jump();
    }, 3000);
  }

  jump(): void {
    router.replaceUrl({
      url: `pages/Index`
    });
  }

  aboutToAppear(): void {
    this.init();
  }

  build() {
    Column() {
      Column() {
        Image($r('app.media.ic_splash'))
          .width('300')
          .aspectRatio(1)
          .objectFit(ImageFit.Contain)
          .transition(TransitionEffect.asymmetric(TransitionEffect.OPACITY.animation({
            duration: 1000,
            curve: Curve.Ease
          }), TransitionEffect.OPACITY.animation({
            duration: 0
          })))
      }
      .width('100%')
      .aspectRatio(2 / 3)
      .backgroundImageSize({
        width: '225%',
        height: '100%'
      })
      .backgroundImage($r('app.media.bg_splash'))
      .backgroundImagePosition(Alignment.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text('HarmonyOS世界')
          .fontFamily('HarmonyHeiTi')
          .fontColor('#FFFFFF')
          .fontSize('24fp')
          .fontWeight(500)

        Text('欢迎来到HarmonyOS开发者世界')
          .fontFamily('HarmonyHeiTi')
          .fontSize('16fp')
          .fontColor('#FFFFFF')
          .opacity(0.7)
          .fontWeight(400)
          .margin({
            top: '5vp'
          })
      }
      .transition(TransitionEffect.asymmetric(TransitionEffect.OPACITY.animation({
        duration: 300,
        curve: Curve.Ease
      }), TransitionEffect.OPACITY.animation({
        duration: 0
      })))
    }
    .padding({ bottom: '17%', top: '24' })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#0A59F7')
    .height('100%')
    .width('100%')
  }
}