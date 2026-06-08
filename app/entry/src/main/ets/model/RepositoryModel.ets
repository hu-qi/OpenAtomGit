export class RepositoryModel {
  owner: string = '';
  name: string = '';
  description: string = '';

  constructor(owner: string, name: string, description: string) {
    this.owner = owner;
    this.name = name;
    this.description = description;
  }

  getFullName(): string {
    return this.owner + '/' + this.name;
  }
}
