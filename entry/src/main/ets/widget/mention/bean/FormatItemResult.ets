export class FormatItemResult {
  private fromIndex: number = 0;
  private length: number = 0;
  private id: string = '';
  private name = '';

  public getFromIndex(): number {
    return this.fromIndex;
  }

  public setFromIndex(fromIndex: number): void {
    this.fromIndex = fromIndex;
  }

  public getLength(): number {
    return this.length;
  }

  public setLength(length: number): void {
    this.length = length;
  }

  public getId(): string {
    return this.id;
  }

  public setId(id: string): void {
    this.id = id;
  }

  public getName(): string {
    return this.name;
  }

  public setName(name: string): void {
    this.name = name;
  }
}