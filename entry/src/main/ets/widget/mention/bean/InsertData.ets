import { FormatData } from './FormatData';

export interface InsertData {

  charSequence(): string;

  color(): number;

  formatData(): FormatData;
}
