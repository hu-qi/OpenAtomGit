export interface IssueCommentUserDto {
  login?: string;
  name?: string;
}

export interface IssueCommentDto {
  id?: number;
  body?: string;
  user?: IssueCommentUserDto;
  created_at?: string;
  updated_at?: string;
}
