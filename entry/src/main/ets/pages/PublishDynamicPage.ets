import Logger from '@ohos/commons/src/main/ets/utils/Logger'
import { MentionTopic } from '../widget/mention/bean/MentionTopic';
import { MentionEditText, MentionEditTextController } from '../widget/mention/MentionEditText'
import { SelectTopicDialog } from '../widget/SelectTopicDialog';

@Entry
@Component
struct PublishDynamicPage {
  private mentionEditTextController = new MentionEditTextController();
  selectTopicDialog: CustomDialogController = new CustomDialogController({
    builder: SelectTopicDialog({
      onSelectTopic: (topic) => {
        this.mentionEditTextController?.insert(new MentionTopic(
          topic.id,
          topic.name
        ))
      }
    }),
    alignment: DialogAlignment.Bottom,
    autoCancel: true,
    customStyle: true,
  });

  build() {
    Column() {
      MentionEditText({
        onTopicName: (startIndex) => {
          Logger.debug('TAG', '----#----' + startIndex)
          this.selectTopicDialog.open()
        },
        onCloseSearchView: () => {

        },
        onAtUserName: (str, startIndex, length) => {
          Logger.debug('TAG', '----@----' + str)
        },
        mentionEditTextController: this.mentionEditTextController
      }).height(200)
      Button('获取 #话题 数据').onClick(() => {
        let topicList = this.mentionEditTextController.getTopicList()
        Logger.debug("TAG", "-")
      }).width('100%')
      Button('获取 @用户 数据').onClick(() => {

      }).width('100%')

      Button('测试').onClick(() => {
        this.mentionEditTextController.test()
      }).width('100%')
    }
  }
}