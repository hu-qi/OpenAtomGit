export class HistoryDao {
  static buildHistoryKey(type: string, id: string): string {
    return type + ':' + id;
  }
}
