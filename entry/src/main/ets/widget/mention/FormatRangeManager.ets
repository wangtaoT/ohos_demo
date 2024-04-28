import { FormatData } from './bean/FormatData';
import { FormatItemResult } from './bean/FormatItemResult';
import { FormatRange } from './bean/FormatRange';
import { FormatResult } from './bean/FormatResult';
import { MentionTopic } from './bean/MentionTopic';
import { Range } from './bean/Range';
import { RangeManager } from './RangeManager';

export class FormatRangeManager extends RangeManager {
  public getFormatCharSequence(text: string): string {
    if (this.isEmpty()) {
      return text;
    }

    let lastRangeTo = 0;
    let ranges = this.get();
    // Collections.sort(ranges);
    ranges = ranges.sort((a: Range, b: Range) => a.getFrom() - b.getFrom());

    let result: string = ''
    let newChar: string;
    for (let range of ranges) {
      if (range instanceof FormatRange) {
        let formatRange = range;
        let convert = formatRange.getConvert();
        newChar = convert?.formatCharSequence();
        result = result + text.substring(lastRangeTo, range.getFrom())
        result = result + newChar;
        lastRangeTo = range.getTo();
      }
    }
    result = result + text.substring(lastRangeTo)
    return result;
  }

  public getFormatResult(text: string): FormatResult {
    let result = new FormatResult();
    result.setText(text);
    if (this.isEmpty()) {
      return result;
    }

    let ranges: Range[] = this.get();
    // Collections.sort(ranges);
    ranges = ranges.sort((a: Range, b: Range) => a.getFrom() - b.getFrom());

    let userResultList: FormatItemResult[] = [];
    let topicResultList: FormatItemResult[] = [];
    let hintResultList: FormatItemResult[] = [];
    for (let range of ranges) {
      if (range instanceof FormatRange) {
        let formatRange: FormatRange = range;
        let convert: FormatData = formatRange.getConvert();
        // if (formatRange.getInsertData() instanceof MentionUser) {
        //   FormatItemResult userResult =  convert.formatResult();
        //   userResult.setFromIndex(range.getFrom());
        //   userResult.setLength(range.getTo() - range.getFrom());
        //   userResultList.add(userResult);
        // } else
        if (formatRange.getInsertData() instanceof MentionTopic) {
          let topicResult: FormatItemResult = convert.formatResult();
          topicResult.setFromIndex(range.getFrom());
          topicResult.setLength(range.getTo() - range.getFrom());
          topicResultList.push(topicResult);
        }
        //   else if(formatRange.getInsertData() instanceof MentionHint){
        //   FormatItemResult hintResult = convert.formatResult();
        //   hintResult.setFromIndex(range.getFrom());
        //   hintResult.setLength(range.getTo() - range.getFrom());
        //   hintResultList.add(hintResult);
        // }
      }
    }
    result.setUserList(userResultList);
    result.setTopicList(topicResultList);
    result.setUserHint(hintResultList);
    return result;
  }
}