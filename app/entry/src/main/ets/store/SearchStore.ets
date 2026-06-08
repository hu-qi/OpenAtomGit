export class SearchStore {
  keyword: string = '';
  activeType: string = 'repository';

  setKeyword(value: string): void {
    this.keyword = value;
  }

  setActiveType(value: string): void {
    this.activeType = value;
  }
}
