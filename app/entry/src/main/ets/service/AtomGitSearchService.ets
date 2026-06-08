import { TokenManager } from '../auth/TokenManager';
import { RepositoryDto, RepositorySearchResponseDto } from '../dto/RepositoryDto';
import { RepositoryMapper } from '../mapper/RepositoryMapper';
import { RepositoryModel } from '../model/RepositoryModel';
import { AtomGitHttpClient } from './AtomGitHttpClient';

export class AtomGitSearchService {
  static async searchRepositories(keyword: string): Promise<RepositoryModel[]> {
    const token = TokenManager.getToken();
    if (token.length === 0 || keyword.trim().length === 0) {
      return [];
    }

    const body = await AtomGitHttpClient.get('/search/repositories', token, {
      q: keyword.trim(),
      page: '1',
      per_page: '20'
    });

    if (body.length === 0) {
      return [];
    }

    try {
      const parsed = JSON.parse(body) as RepositorySearchResponseDto;
      const list: RepositoryDto[] = parsed.data || parsed.items || [];
      return RepositoryMapper.fromDtoList(list);
    } catch (error) {
      return [];
    }
  }
}
