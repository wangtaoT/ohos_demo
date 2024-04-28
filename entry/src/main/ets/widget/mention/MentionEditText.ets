import Logger from '@ohos/commons/src/main/ets/utils/Logger';
import { FormatItemResult } from './bean/FormatItemResult';
import { FormatRange } from './bean/FormatRange';
import { FormatResult } from './bean/FormatResult';
import { InsertData } from './bean/InsertData';
import { MentionTopic } from './bean/MentionTopic';
import { FormatRangeManager } from './FormatRangeManager';

@Component
export struct MentionEditText {
  //默认文字颜色
  normalFontColor: number | string = Color.Black
  private TOPIC_TAG: string = '#'
  mentionEditTextController?: MentionEditTextController
  private controller: RichEditorController = new RichEditorController();
  protected declare mRangeManager: FormatRangeManager;
  /**
   * at符号搜索
   *
   * @param str    内容
   * @param start  开始下标
   * @param length 长度
   */
  onAtUserName?: (str: string, startIndex: number, length: number) => void
  /**
   * #号
   *
   * @param start 开始下标
   */
  onTopicName?: (startIndex: number) => void
  /**
   * 关闭搜索框
   */
  onCloseSearchView?: () => void

  aboutToAppear(): void {
    this.mRangeManager = new FormatRangeManager();
    if (this.mentionEditTextController) {
      this.mentionEditTextController.setItem(this)
    }
    if (this.normalFontColor) {
      this.controller.setTypingStyle({ fontColor: this.normalFontColor })
    }
  }

  build() {
    Row() {
      RichEditor({ controller: this.controller })
        .width("100%")
        .height('100%')
        .defaultFocus(true)
        .backgroundColor(Color.Gray)
        .onIMEInputComplete((result) => {
          this.checkTopicName(result)
          this.checkAtUserName()
        })
        .onDeleteComplete(() => {
          this.checkAtUserName()
        })
        .aboutToIMEInput((value) => {
          //输入法输入内容前

          let start = value.insertOffset
          let end = start + value.insertValue.length
          this.mRangeManager.get().forEach((item) => {
            if (item.getFrom() >= end) {
              item.setOffset(value.insertValue.length)
            }
          })

          return true;
        })
        .aboutToDelete((value) => {
          //输入法删除内容前
          if (value.richEditorDeleteSpans.length <= 0) {
            return
          }
          let end = value.offset + 1
          let start = end - value.length
          // this.controller.deleteSpans({ start: start, end: end })

          let rangeList = this.mRangeManager.get()
          //清理arraylist中上面已经清理掉的range
          rangeList = rangeList.filter((item) =>!item.isWrapped(start, end))
          //将end之后的span挪offset个位置
          rangeList.forEach((item) => {
            if (item.getFrom() >= end) {
              item.setOffset(start - end)
            }
          })
          this.mRangeManager.set(rangeList)

          return true;
        })
    }
    .width('100%')
    .height(200)
    .padding({ top: AppStorage.get<number>('statusBarHeight') })
  }

  private getText(): string {
    let content = ''
    this.controller.getSpans().forEach(item => {
      if (typeof (item as RichEditorTextSpanResult)['symbolSpanStyle'] != 'undefined') {
        content += (item as RichEditorTextSpanResult).symbolSpanStyle?.fontSize;
      } else {
        content += (item as RichEditorTextSpanResult).value;
      }
    })

    return content;
  }

  //判断 # 话题标识
  private checkTopicName(result: RichEditorTextSpanResult) {
    let content = this.getText();
    let mentionChar = result.value.substring(result.offsetInSpan[0], result.offsetInSpan[1])

    if (mentionChar.length == 1 && content) {
      if (mentionChar == this.TOPIC_TAG) {
        //话题
        let index = content.lastIndexOf(this.TOPIC_TAG)
        this.onTopicName?.(index)
      } else if (mentionChar == ' ') {
        //关闭
        this.onCloseSearchView?.()
      }
    }
  }

  //判断 @ 艾特标识
  private checkAtUserName() {
    let content = this.getText();
    this.controller.getSpans().forEach(item => {
      if (typeof (item as RichEditorTextSpanResult)['symbolSpanStyle'] != 'undefined') {
        content += (item as RichEditorTextSpanResult).symbolSpanStyle?.fontSize;
      } else {
        content += (item as RichEditorTextSpanResult).value;
      }
    })
    let selectionStart: number = this.controller.getCaretOffset()
    let mentionString = content.substring(0, selectionStart)
    let list: string[] = mentionString.split('@')

    if (mentionString.endsWith('@')) {
      this.onAtUserName?.('', selectionStart - 1, 1)
    } else if (mentionString.indexOf('@') < 0
      || (list.length == 1 && !list[0])
      || (list[list.length - 1].indexOf(" ") >= 0 || list[list.length - 1].indexOf("\n") >= 0 || list[list.length - 1].indexOf("#") >= 0)) {
      //1、无@符号 关闭
      //2、只有一个空字符 关闭
      //3、最后一个是 空、换行、# 关闭
      this.onCloseSearchView?.()
    } else {
      let keyword = list[list.length - 1];
      let index = mentionString.lastIndexOf(keyword) - 1;
      this.onAtUserName?.(keyword, index, keyword.length + 1)
    }
  }

  /**
   * 光标位置插入高亮
   */
  insert(insertData: InsertData): void {
    if (insertData == null) {
      return;
    }

    let charSequence = insertData.charSequence();
    if (!this.getText()) {
      return;
    }

    let start = this.controller.getSelection().selection[0]
    let oldEnd = this.controller.getSelection().selection[1]
    let end = start + charSequence.length

    // 如果是选中状态
    // if (start != oldEnd) {
    // replaceSelection(insertData);
    // return;
    // }

    let mentionChar = this.getText().substring(0, start);

    //删除
    if (insertData instanceof MentionTopic) {
      //#话题
      if (mentionChar.endsWith(this.TOPIC_TAG)) {
        start = start - 1;
        end = start + charSequence.length;
        this.controller.deleteSpans({ start: start, end: start + 1 })
      }
    }
    // else if (insertData instanceof MentionUser) {
    //   //@用户
    //   String[] atList = mentionChar.split("@");
    //   if (mentionChar.endsWith("@")) {
    //     //最后一位是@
    //     start = start - 1;
    //     end = start + charSequence.length();
    //     editable.delete(start, start + 1);
    //   } else if (!atList[atList.length - 1].contains(" ") && !atList[atList.length - 1].contains("\n") && !atList[atList.length - 1].contains("#")) {
    //     //最后一位 不是空、换行、#
    //     start = mentionChar.lastIndexOf(atList[atList.length - 1]) - 1;
    //     end = start + charSequence.length();
    //     editable.delete(start, start + atList[atList.length - 1].length() + 1);
    //   }
    // }

    //插入
    // this.controller.addTextSpan(charSequence, { offset: start, style: { fontColor: insertData.color() } })
    // this.controller.setTypingStyle({ fontColor: this.normalFontColor })
    this.controller.addTextSpan(charSequence, { offset: start })
    this.controller.updateSpanStyle({
      start: start,
      end: end,
      textStyle: { fontColor: insertData.color() }
    })

    //光标到插入内容之后
    this.controller.setCaretOffset(start + insertData.charSequence().length)

    //存储到列表
    let format = insertData.formatData();
    let range = new FormatRange(start, end);
    range.setInsertData(insertData);
    range.setConvert(format);
    range.setRangeCharSequence(charSequence);
    this.mRangeManager.add(range);
  }

  public getFormatResult(): FormatResult {
    let text: string = this.getText().toString();
    return this.mRangeManager.getFormatResult(text);
  }

  test() {
    this.controller.setTypingStyle({ fontColor: this.normalFontColor })
  }
}

/**
 * 控制器
 */
export class MentionEditTextController {
  item?: MentionEditText;

  setItem(item: MentionEditText) {
    this.item = item;
  }

  /**
   * 光标位置插入高亮
   */
  insert(insertData: InsertData) {
    this.item?.insert(insertData)
  }

  /**
   * 获取 #话题 列表
   * @returns
   */
  getTopicList(): FormatItemResult[] {
    return this.item?.getFormatResult().getTopicList() ?? []
  }

  test() {
    this.item?.test()
  }
}