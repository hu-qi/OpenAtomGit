export class RepositoryStore {
  owner: string = '';
  name: string = '';

  setRepository(owner: string, name: string): void {
    this.owner = owner;
    this.name = name;
  }

  getFullName(): string {
    if (this.owner.length === 0 || this.name.length === 0) {
      return '';
    }
    return this.owner + '/' + this.name;
  }
}
