//价格组件
@Component
export struct PriceView {
  @Prop fontSize: string = '20fp'
  @Prop secondFontSize: string = '15fp'
  @Prop fontColor: string = '#FFFFFFFF'
  @Prop secondFontColor: string = '#FFFFFFFF'
  //价格
  @Prop price: string = '0'
  //显示¥符号
  @Prop showMoneySymbol: boolean = true

  build() {
    Row() {
      Text('¥')
        .fontSize(this.secondFontSize)
        .fontColor(this.secondFontColor)
        .visibility(this.showMoneySymbol ? Visibility.Visible : Visibility.None)
      Text(this.price).fontSize(this.fontSize).fontColor(this.fontColor)
    }
    .alignItems(VerticalAlign.Bottom)
  }
}