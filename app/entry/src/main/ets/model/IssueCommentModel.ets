export class IssueCommentModel {
  id: number = 0;
  body: string = '';
  author: string = '';
  createdAt: string = '';
  updatedAt: string = '';

  constructor(id: number, body: string, author: string, createdAt: string, updatedAt: string) {
    this.id = id;
    this.body = body;
    this.author = author;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }
}
