import { InsertData } from './InsertData';

export class Range {
  private mFrom: number = 0;
  private mTo: number = 0;
  private insertData?: InsertData;

  constructor(from: number, to: number) {
    this.mFrom = from;
    this.mTo = to;
  }

  public isWrapped(start: number, end: number): boolean {
    return (start <= this.mFrom && this.mTo <= end) || (this.mFrom < start && end < this.mTo);
  }

  public isWrappedBy(start: number, end: number): boolean {
    return (start > this.mFrom && start < this.mTo) || (end > this.mFrom && end < this.mTo);
  }

  public contains(start: number, end: number): boolean { // 光标落在range中
    return this.mFrom <= start && this.mTo >= end;
  }

  public isEqual(start: number, end: number): boolean {
    return (this.mFrom == start && this.mTo == end) || (this.mFrom == end && this.mTo == start);
  }

  public getAnchorPosition(value: number): number {
    if ((value - this.mFrom) - (this.mTo - value) >= 0) {
      return this.mTo;
    } else {
      return this.mFrom;
    }
  }

  public setOffset(offset: number): void {
    this.mFrom += offset;
    this.mTo += offset;
  }

  // @Override
  // public int compareTo(@NonNull Range o) {
  //   return mFrom - o.mFrom;
  // }

  public getFrom(): number {
    return this.mFrom;
  }

  public setFrom(from: number): void {
    this.mFrom = from;
  }

  public getTo(): number {
    return this.mTo;
  }

  public setTo(to: number): void {
    this.mTo = to;
  }

  public getInsertData(): InsertData | undefined {
    return this.insertData;
  }

  public setInsertData(insertData: InsertData): void {
    this.insertData = insertData;
  }
}