export class RepositoryModel {
  owner: string = '';
  name: string = '';
  description: string = '';
  stars: number = 0;
  forks: number = 0;
  watchers: number = 0;
  defaultBranch: string = '';

  constructor(owner: string, name: string, description: string, stars: number = 0, forks: number = 0, watchers: number = 0, defaultBranch: string = '') {
    this.owner = owner;
    this.name = name;
    this.description = description;
    this.stars = stars;
    this.forks = forks;
    this.watchers = watchers;
    this.defaultBranch = defaultBranch;
  }

  getFullName(): string {
    return this.owner + '/' + this.name;
  }
}
