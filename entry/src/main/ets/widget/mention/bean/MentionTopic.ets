/**
 * 话题
 */
import { FormatData } from './FormatData';
import { FormatItemResult } from './FormatItemResult';
import { InsertData } from './InsertData';

export class MentionTopic implements InsertData {
  private topicName: string = '';
  private topicId: string = '';

  constructor(topicId: string, topicName: string) {
    this.topicId = topicId;
    this.topicName = topicName;
  }

  formatData(): FormatData {
    return new TopicConvert(this);
  }

  public getTopicName(): string {
    return this.topicName;
  }

  public getTopicId(): string {
    return this.topicId;
  }

  charSequence(): string {
    return "#" + this.topicName + " "
  }

  color(): number {
    return 0xFF14D0B4
  }
}

export class TopicConvert implements FormatData {
  TAG_FORMAT: string = "&nbsp;<tag id='%s' name='%s'>%s</tag>&nbsp;";
  private tag?: MentionTopic;

  constructor(tag: MentionTopic) {
    this.tag = tag;
  }

  formatCharSequence(): string {
    return "&nbsp;<tag id=" + this.tag?.getTopicId() + " name='" + this.tag?.getTopicName() + "'>" + "#" + this.tag?.getTopicName() + "#" + "</tag>&nbsp;"
  }

  formatResult(): FormatItemResult {
    let userResult: FormatItemResult = new FormatItemResult();
    userResult.setId(this.tag?.getTopicId()?.toString() ?? '');
    userResult.setName(this.tag?.getTopicName()?.toString() ?? '');
    return userResult;
  }
}