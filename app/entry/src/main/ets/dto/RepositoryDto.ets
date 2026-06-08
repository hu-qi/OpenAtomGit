export interface RepositoryDto {
  name?: string;
  path?: string;
  full_name?: string;
  description?: string;
  namespace?: string;
}

export interface RepositorySearchResponseDto {
  total_count?: number;
  data?: RepositoryDto[];
  items?: RepositoryDto[];
}
