@CustomDialog
export struct SelectTopicDialog {
  controller?: CustomDialogController;
  onSelectTopic?: (topic: TopicModel) => void

  build() {
    Column() {
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        this.getTopicItemView(new TopicModel("1", '11111111'))
        this.getTopicItemView(new TopicModel("2", '22222222'))
        this.getTopicItemView(new TopicModel("3", '33333333'))
        this.getTopicItemView(new TopicModel("4", '44444444'))
      }.margin({ top: 12 })
    }
    .backgroundColor('#FFF7F8FC')
    .borderRadius({ topLeft: 16, topRight: 16 })
    .width('100%')
    .height(300)
  }

  @Builder
  getTopicItemView(topic: TopicModel) {
    Button(topic.name)
      .onClick(() => {
        this.onSelectTopic?.(topic)
        this.controller?.close()
      })
  }
}

export class TopicModel {
  id: string = ''
  name: string = ''

  constructor(id: string, name: string) {
    this.id = id;
    this.name = name
  }
}