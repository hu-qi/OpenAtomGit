import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitSearchService } from '../service/AtomGitSearchService';

export class SearchStore {
  keyword: string = '';
  activeType: string = 'repository';
  errorMessage: string = '';
  repositories: RepositoryModel[] = [];

  setKeyword(value: string): void {
    this.keyword = value.trim();
    this.errorMessage = '';
  }

  setActiveType(value: string): void {
    this.activeType = value;
  }

  async searchRepositories(): Promise<RepositoryModel[]> {
    if (this.keyword.length === 0) {
      this.errorMessage = 'Keyword is required';
      this.repositories = [];
      return [];
    }

    const result = await AtomGitSearchService.searchRepositories(this.keyword);
    this.repositories = result;
    if (result.length === 0) {
      this.errorMessage = 'No repositories found';
    } else {
      this.errorMessage = '';
    }
    return result;
  }
}
