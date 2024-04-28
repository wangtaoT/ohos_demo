import { FormatData } from './FormatData';
import { Range } from './Range';

export class FormatRange extends Range {
  private declare convert: FormatData;

  constructor(from: number, to: number) {
    super(from, to)
  }

  public getConvert(): FormatData {
    return this.convert;
  }

  private rangeCharSequence: string = '';

  public setConvert(convert: FormatData): void {
    this.convert = convert;
  }

  public getRangeCharSequence(): string {
    return this.rangeCharSequence;
  }

  public setRangeCharSequence(rangeCharSequence: string): void {
    this.rangeCharSequence = rangeCharSequence;
  }
}