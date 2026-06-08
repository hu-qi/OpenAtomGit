export class RepositoryDao {
  static getCacheKey(owner: string, name: string): string {
    return owner + '/' + name;
  }
}
