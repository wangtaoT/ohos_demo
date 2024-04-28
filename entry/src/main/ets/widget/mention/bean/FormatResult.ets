import { FormatItemResult } from './FormatItemResult';

export class FormatResult {
  private text: string = '';
  private userList: FormatItemResult[] = [];
  private topicList: FormatItemResult[] = [];
  private userHint: FormatItemResult[] = [];

  public FormatResult() {
  }


  public getText(): string {
    return this.text;
  }

  public setText(text: string): void {
    this.text = text;
  }

  public getUserList(): FormatItemResult[] {
    return this.userList;
  }

  public setUserList(userList: FormatItemResult[]): void {
    this.userList = userList;
  }

  public getTopicList(): FormatItemResult[] {
    return this.topicList;
  }

  public setTopicList(topicList: FormatItemResult[]): void {
    this.topicList = topicList;
  }

  public getUserHint(): FormatItemResult[] {
    return this.userHint;
  }

  public setUserHint(userHint: FormatItemResult[]): void {
    this.userHint = userHint;
  }
}
