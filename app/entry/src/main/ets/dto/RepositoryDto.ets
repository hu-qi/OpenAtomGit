export interface RepositoryDto {
  name?: string;
  path?: string;
  full_name?: string;
  description?: string;
  namespace?: string;
  stargazers_count?: number;
  stars_count?: number;
  forks_count?: number;
  watchers_count?: number;
  default_branch?: string;
}

export interface RepositorySearchResponseDto {
  total_count?: number;
  data?: RepositoryDto[];
  items?: RepositoryDto[];
}
