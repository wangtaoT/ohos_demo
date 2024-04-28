import { Range } from './bean/Range';

export class RangeManager {
  private mRanges: Range[] = [];

  constructor() {
    this.mRanges = [];
  }

  public set(ranges: Range[]) {
    this.mRanges = ranges
  }

  public get() {
    this.ensureListNonNull();
    return this.mRanges;
  }

  public add<T extends Range>(range: T): void {
    this.ensureListNonNull();
    this.mRanges?.push(range);
    // From升序排列
    // Collections.sort(mRanges);
    this.mRanges = this.mRanges.sort((a: Range, b: Range) => a.getFrom() - b.getFrom());
  }

  public clear(): void {
    this.ensureListNonNull();
    this.mRanges = [];
  }

  public isEmpty(): boolean {
    this.ensureListNonNull();
    return this.mRanges?.length == 0;
  }

  // public  iterator() {
  //   this.ensureListNonNull();
  //   return this.mRanges.iterator();
  // }

  private ensureListNonNull(): void {
    if (!this.mRanges) {
      this.mRanges = [];
    }
  }

  public getRangeOfClosestMentionString(selStart: number, selEnd: number): Range | null {
    if (this.mRanges == null) {
      return null;
    }
    for (let item of this.mRanges) {
      if (item.contains(selStart, selEnd)) {
        return item;
      }
    }

    return null;
  }

  public getRangeOfNearbyMentionString(selStart: number, selEnd: number): Range | null {
    if (this.mRanges == null) {
      return null;
    }
    for (let range of this.mRanges) {
      if (range.isWrappedBy(selStart, selEnd)) {
        return range;
      }
    }
    return null;
  }

  ////////////
  private mLastSelectedRange?: Range;

  public isEqual(selStart: number, selEnd: number): boolean {
    return null != this.mLastSelectedRange && this.mLastSelectedRange.isEqual(selStart, selEnd);
  }

  public setLastSelectedRange(lastSelectedRange: Range): void {
    this.mLastSelectedRange = lastSelectedRange;
  }
}
