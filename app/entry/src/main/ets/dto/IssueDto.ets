export interface IssueUserDto {
  login?: string;
  name?: string;
}

export interface IssueDto {
  number?: number;
  title?: string;
  state?: string;
  body?: string;
  user?: IssueUserDto;
  comments?: number;
  created_at?: string;
  updated_at?: string;
}
