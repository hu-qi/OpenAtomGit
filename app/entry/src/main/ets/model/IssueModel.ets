export class IssueModel {
  number: number = 0;
  title: string = '';
  state: string = '';
  author: string = '';
  createdAt: string = '';
  updatedAt: string = '';

  constructor(number: number, title: string, state: string, author: string, createdAt: string, updatedAt: string) {
    this.number = number;
    this.title = title;
    this.state = state;
    this.author = author;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }
}
