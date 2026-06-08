export interface IssueDto {
  number?: number;
  title?: string;
  state?: string;
  user?: {
    login?: string;
    name?: string;
  };
  created_at?: string;
  updated_at?: string;
}
