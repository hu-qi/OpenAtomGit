export interface IssueDto {
  number?: number;
  title?: string;
  state?: string;
  body?: string;
  user?: {
    login?: string;
    name?: string;
  };
  comments?: number;
  created_at?: string;
  updated_at?: string;
}
