import { FormatItemResult } from './FormatItemResult';

export interface FormatData {

  formatCharSequence(): string;

  formatResult(): FormatItemResult;
}