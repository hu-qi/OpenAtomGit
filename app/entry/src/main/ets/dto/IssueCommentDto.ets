export interface IssueCommentDto {
  id?: number;
  body?: string;
  user?: {
    login?: string;
    name?: string;
  };
  created_at?: string;
  updated_at?: string;
}
